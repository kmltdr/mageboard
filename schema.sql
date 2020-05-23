CREATE TABLE IF NOT EXISTS Posts (
    Number          INTEGER     NOT NULL,
    Date            INTEGER     NOT NULL    DEFAULT 0,
    Name            TEXT        NOT NULL    DEFAULT 'Nameless'  CHECK(length(Name)    <= 64),
    Email           TEXT        NOT NULL    DEFAULT ''          CHECK(length(Email)   <= 320),
    Subject         TEXT        NOT NULL    DEFAULT ''          CHECK(length(Subject) <= 128),
    Text            TEXT        NOT NULL    DEFAULT ''          CHECK(length(Text)    <= 32768),

    PRIMARY KEY (Number)
);

CREATE TABLE IF NOT EXISTS FileRefs (
    Number          INTEGER     NOT NULL,
    File            TEXT        NOT NULL,

    PRIMARY KEY (Number),
    FOREIGN KEY (Number) REFERENCES Posts (Number),
    FOREIGN KEY (File) REFERENCES Files (Name)
) WITHOUT ROWID;

CREATE TABLE IF NOT EXISTS Files (
    Name            TEXT        NOT NULL    UNIQUE              CHECK(length(Name) between 130 and 133),
    Size            INTEGER     NOT NULL                        CHECK(Size between 1 and 16777216),
    Width           INTEGER                 DEFAULT NULL,
    Height          INTEGER                 DEFAULT NULL,

    PRIMARY KEY (Name),
    CHECK(Width IS NULL == Height IS NULL)
) WITHOUT ROWID;


CREATE TRIGGER IF NOT EXISTS set_post_date AFTER INSERT ON Posts
BEGIN
    UPDATE Posts SET Date = strftime('%s','now') WHERE ROWID = NEW.ROWID;
END;

CREATE TRIGGER IF NOT EXISTS remove_old_refs BEFORE DELETE ON Posts
BEGIN
  DELETE FROM FileRefs WHERE Number = OLD.Number;
END;

CREATE TRIGGER IF NOT EXISTS remove_file_refs BEFORE DELETE ON Files
BEGIN
  DELETE FROM FileRefs WHERE File = OLD.Name;
END;

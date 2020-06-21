{-# LANGUAGE OverloadedStrings, RecordWildCards #-}
module Imageboard.Config (
    cssFile,
    cssStyles,
    postsDb,
    schemaFile,
    uploadDir,
    thumbnailDir,
    timezone
) where
import Data.String (IsString)
import Data.Time (TimeZone(..))

-- Absolute path to main CSS file, with @static@ directory as root.
cssFile :: IsString a => a
cssFile = "/styles/global.css"

-- List of CSS styles with titles. First style is default.
cssStyles :: IsString a => [(a,a)]
cssStyles = [("/styles/roller.css",     "Roller")
            ,("/styles/jungle.css",     "Jungle")]

-- | Path to database file.
postsDb :: IsString a => a
postsDb = "posts.db" 

-- | Path to schema file.
schemaFile :: IsString a => a
schemaFile = "schema.sql"

-- | Path to media directory.
uploadDir :: IsString a => a
uploadDir = "static/media/"

-- | Path to media thumbnails directory.
thumbnailDir :: IsString a => a
thumbnailDir = "static/media/thumb/"

-- | Timezone used in date and time formatting.
timezone :: TimeZone
timezone = TimeZone (2*60) True "CEST"
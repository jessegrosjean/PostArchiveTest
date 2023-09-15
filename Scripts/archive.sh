#!/bin/sh

# Do all of the work in a subdirectory of /tmp, and use a
# unique ID so that there's no collision with previous builds.
EXPORT_UUID=`uuidgen`
EXPORT_PATH="/tmp/$PRODUCT_NAME-$EXPORT_UUID"
APP_PATH="$EXPORT_PATH/$PRODUCT_NAME.app"
DMG_PATH="$EXPORT_PATH/$PRODUCT_NAME.dmg"

mkdir -p "$EXPORT_PATH"

open "$EXPORT_PATH"

# Xcode doesn't show run script errors in build log.
exec > "$EXPORT_PATH/Xcode run script.log" 2>&1

# Use osascript(1) to present notification banners; otherwise
# there's no progress indication until the script finishes.
/usr/bin/osascript -e 'display notification "Exporting application archive…" with title "Post Archive Script"'

# Ask xcodebuild(1) to export the app. Use the export options
# from a previous manual export that used a Developer ID.
/usr/bin/xcodebuild -exportArchive -archivePath "$ARCHIVE_PATH" -exportOptionsPlist "$SRCROOT/ExportOptions.plist" -exportPath "$EXPORT_PATH"

osascript -e 'display notification "Creating UDIF Disk Image…" with title "Post Archive Script"'

# Create a UDIF bzip2-compressed disk image.
cd "$EXPORT_PATH"
mkdir "$PRODUCT_NAME"
mv -v "$APP_PATH" "$PRODUCT_NAME"

echo "Begin hdiutil create"
/usr/bin/hdiutil create -verbose -srcfolder "$PRODUCT_NAME" -format UDBZ "$DMG_PATH"
echo "End hdiutil create"

# Open the folder that was created, which also signals completion.
open "$EXPORT_PATH"

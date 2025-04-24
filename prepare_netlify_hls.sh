#!/bin/bash

SOURCE_DIR="/Users/kendramoran/git/hls"
NETLIFY_DIR="/Users/kendramoran/git/netlify_hls"

echo "📁 Creating Netlify HLS folder: $NETLIFY_DIR"
mkdir -p "$NETLIFY_DIR"

echo "📦 Copying files from: $SOURCE_DIR"
cp "$SOURCE_DIR"/* "$NETLIFY_DIR"/

cd "$NETLIFY_DIR" || exit

echo "🔄 Renaming .m3u8 to .txt..."
for f in *.m3u8; do
  mv "$f" "${f%.m3u8}.txt"
done

echo "🔄 Renaming .ts to .mp2t..."
for f in *.ts; do
  mv "$f" "${f%.ts}.mp2t"
done

echo "📝 Updating playlist references..."
for f in *.txt; do
  sed -i '' 's/\\.ts/.mp2t/g' "$f"
  sed -i '' 's/\\.m3u8/.txt/g' "$f"
done

echo "✅ Netlify-ready folder is clean and ready to upload!"

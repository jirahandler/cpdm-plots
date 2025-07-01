#!/usr/bin/env bash
#
# generate_index.sh — regenerate index.html from your *_merged_plots folders

OUT=index.html

# Write the HTML header
cat > "$OUT" <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>CPDM Overlay Gallery</title>
  <style>
    body { font-family: sans-serif; margin: 20px; }
    h1, h2 { margin-bottom: 0.5em; }
    .grid { display: flex; flex-wrap: wrap; }
    .item {
      flex: 0 0 calc(33.33% - 20px);
      margin: 10px;
      text-align: center;
    }
    .thumb {
      width: 100%;
      height: auto;
      border: 1px solid #ccc;
    }
    .caption { font-size: 0.9em; margin-top: 0.3em; }
  </style>
</head>
<body>
  <h1>CPDM Overlay Gallery</h1>
EOF

# Loop categories
for CAT in xx xy yy; do
  DIR="${CAT}_merged_plots"
  if [ ! -d "$DIR" ]; then
    echo "  <!-- skipping missing directory $DIR -->" >> "$OUT"
    continue
  fi

  echo "  <h2>Category: ${CAT^^}</h2>" >> "$OUT"
  echo '  <div class="grid">' >> "$OUT"

  # Find each overlay PNG
  shopt -s nullglob
  for IMG in "$DIR"/overlay_*.png; do
    BASENAME=$(basename "$IMG" .png)
    cat >> "$OUT" <<HTML
    <div class="item">
      <a href="$IMG" target="_blank">
        <img class="thumb" src="$IMG" alt="$BASENAME">
      </a>
      <div class="caption">$BASENAME</div>
    </div>
HTML
  done
  shopt -u nullglob

  echo "  </div>" >> "$OUT"
done

# Close HTML
cat >> "$OUT" <<'EOF'
</body>
</html>
EOF

echo "✅ Generated $OUT"


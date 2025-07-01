#!/usr/bin/env bash
# generate_index.sh ? generate a static index.html for your merged_plots

OUT=index.html

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
    .item { margin: 10px; text-align: center; width: 220px; }
    .thumb { width: 200px; height: auto; border: 1px solid #ccc; }
    .caption { font-size: 0.9em; margin-top: 0.3em; }
  </style>
</head>
<body>
  <h1>CPDM Overlay Gallery</h1>
EOF

for CAT in xx xy yy; do
  DIR="${CAT}_merged_plots"
  if [ -d "$DIR" ]; then
    echo "  <h2>Category: ${CAT^^}</h2>" >> "$OUT"
    echo '  <div class="grid">' >> "$OUT"

    # loop over your overlay PNGs
    for IMG in "$DIR"/overlay_*.png; do
      [ -f "$IMG" ] || continue
      BASENAME="$(basename "$IMG" .png)"
      echo "    <div class=\"item\">" >> "$OUT"
      echo "      <a href=\"$IMG\" target=\"_blank\">" >> "$OUT"
      echo "        <img class=\"thumb\" src=\"$IMG\" alt=\"$BASENAME\">" >> "$OUT"
      echo "      </a>" >> "$OUT"
      echo "      <div class=\"caption\">$BASENAME</div>" >> "$OUT"
      echo "    </div>" >> "$OUT"
    done

    echo "  </div>" >> "$OUT"
  else
    echo "  <!-- skipping missing directory $DIR -->" >> "$OUT"
  fi
done

cat >> "$OUT" <<'EOF'
</body>
</html>
EOF

echo "Generated $OUT"


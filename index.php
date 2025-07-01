<?php
// index.php ? put in /home/sgoswami/cpdm-evgen (or your web root)

// List of categories
$cats = ['xx','xy','yy'];

// Base URL path (adjust if you host this under a subpath)
$base_url = '.';
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>CPDM Overlay Gallery</title>
  <style>
    body { font-family: sans-serif; margin: 20px; }
    h2 { margin-top: 40px; }
    .thumb { width: 200px; margin: 5px; border: 1px solid #ccc; }
    .grid { display: flex; flex-wrap: wrap; }
    .item { margin: 10px; text-align: center; }
  </style>
</head>
<body>
  <h1>CPDM Overlay Gallery</h1>
  <?php foreach ($cats as $cat): ?>
    <?php 
      $dir = __DIR__ . "/run_$cat/{$cat}_merged_plots";
      $url = "$base_url/run_$cat/{$cat}_merged_plots";
      $images = is_dir($dir)
                ? scandir($dir)
                : [];
    ?>
    <h2><?php echo strtoupper($cat); ?> category</h2>
    <?php if (empty($images)): ?>
      <p><em>No plots found in <code>run_<?php echo $cat ?>/<?php echo $cat ?>_merged_plots</code></em></p>
    <?php else: ?>
      <div class="grid">
      <?php foreach ($images as $img): 
              if (!preg_match('/\.png$/i',$img)) continue;
      ?>
        <div class="item">
          <a href="<?php echo "$url/$img"; ?>" target="_blank">
            <img src="<?php echo "$url/$img"; ?>" class="thumb" alt="<?php echo $img; ?>">
          </a>
          <div><?php echo htmlspecialchars(basename($img, '.png')); ?></div>
        </div>
      <?php endforeach; ?>
      </div>
    <?php endif; ?>
  <?php endforeach; ?>
</body>
</html>


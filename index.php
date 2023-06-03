<!DOCTYPE html>
<html lang="de">
  <head>
    <meta charset="UTF-8">
    <meta name="keywords" content="Playlists", "Wiedergabelisten", "Lockdown", "Musik", "YouTube", "Ablenkung">
    <meta name="desciption" content="Wild gemischte Musik-Playlists auf YouTube">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>THE BIG LISTEN :: Wild gemischte Playlists</title>
    <link rel='icon' type='image/x-icon' href='favicon.ico'>
    <link rel="stylesheet" type="text/css" href="style.css">
  </head>
  <body>
	<?php
		function printplaylist($path) {
			$file = fopen($path, "r");
			echo "<table class=\"playlist\">\n";
			$number = 1;
			while ($line = fgetcsv($file)) {
				echo '	<tr>';
				echo '      <td class="tnr">'.$number.'</td>';
				echo '		<td class="artist">'.$line[0].'</td>';
				echo '		<td class="track">'.$line[1].'</td>';
				echo "	</tr>\n";
				$number++;
			}
			echo '</table>';
			fclose($file);
		}
		function printall($path) {
			$file = fopen($path, "r");
			while ($line = fgetcsv($file)) {
				echo '    <div id="'.$line[0].'"><h3>Vol. '.$line[1].' ('.$line[2].substr($line[4],-2).') (<a href="'.$line[5].'">&#9658; Link</a>) (<a href="#">Nach oben</a>)</h3>';
				printplaylist("lists/".$line[0].".csv");
				echo "    </div>\n";
			}
			fclose($file);
		}
		function printoverviewlist($path) {
			$file = fopen($path, "r");
			while ($line = fgetcsv($file)) {
				echo '    <li><a href="#'.$line[0].'">Vol. '.$line[1].' ('.	$line[2].substr($line[4],-2).")</a></li>\n";
			}
			fclose($file);
		}
		function printstatslist($path) {
			$file = fopen($path, "r");
			while ($line = fgetcsv($file)) {
				echo '    <li value="'.$line[0].'">'.$line[1].' ('.$line[2]."x)</li>\n";
			}
			fclose($file);
		}
	?>
	<div id="wrapper">
	<?php echo file_get_contents("lists/ld.html"); ?>
	<div id="toc">
		<h3>Inhalt</h3>
		<ul>
			<?php printoverviewlist("lists/ld.csv"); ?>
			<li><a href="#stats">Statistiken</a></li>
		</ul>
	</div>
	<?php printall("lists/ld.csv"); ?>
	<div><a href="#">Nach oben</a></div>
	<div id="stats"><h3>Statistiken</h3>
		<div id="stat">Häufigste Künstler
			<ol>
				<?php printstatslist("stats/ld_topartists.csv"); ?>
			</ol>
		</div>
	</div>
	<div>
		<a href="#">
			Nach oben
		</a>
	</div>
	</div>
	<div class="right">
		<a href="https://github.com/dettbarn/thebiglisten">
			<img src="./github-mark.svg" alt="link to GitHub repository"/>
		</a>
	</div>
	</body>
</html>

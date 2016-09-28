<?php

echo "--------------------------Packaging--------------------------";

//Finding and storing all the file and its path
$ignoreFiles = array(".DS_Store");
$copyDef = array();
$di = new RecursiveDirectoryIterator("html");
foreach (new RecursiveIteratorIterator($di) as $filename => $file) {
	$pathFileName = $file->getPathname();
	if(!is_dir($pathFileName))
	{
		if(strpos($pathFileName,".DS_Store") === false)
		{
			$customPath = preg_replace("/html\//", "", $pathFileName, 1);
			$copyDef[] = array (
				      "from" => "<basepath>/$pathFileName",
				      "to" => "$customPath",
				    );
		}
	}
}
//Preparing manifest.php
date_default_timezone_set("UTC");
$manifestfile =
'<?php

$manifest = array (
  "built_in_version" =>
  array (
  ),
  "acceptable_sugar_versions" =>
  array (
     "regex_matches" => array(
                "7\.5\.*",
                "7\.6\.*",
		"7\.7\.*",
		"6\.5\.*",
        ),
  ),
  "acceptable_sugar_flavors" =>
  array (
    0 => "PRO",
    1 => "CORP",
    2 => "ENT",
    3 => "ULT",
  ),
  "author" => "Squiz",
  "description" => "corecustomisation",
  "icon" => "",
  "is_uninstallable" => true,
  "name" => "corecustomisation",
  "published_date" => "'.date('Y-m-d').'",
  "type" => "module",
    "version" => '.time().',
  );
  $installdefs = array (
    "id" => "corecustomisation",
  "copy" => '.var_export( $copyDef,true) .',
);
';

//Writing manifest.php
$mf = fopen("manifest.php", "w");
fwrite($mf, $manifestfile);
fclose($mf);

//Zipping the directory
system("zip -r corecustomisation html manifest.php -x '.*' -x '*/.*'");

//Deleting the existing manifest.php
unlink("manifest.php");

//Deleting the existing package and moving newely created package
if(file_exists("packages/corecustomisation.zip"))
{
	unlink("packages/corecustomisation.zip");
}
if(is_dir("packages") && file_exists("corecustomisation.zip"))
{
	system("mv corecustomisation.zip packages");
}
else if(file_exists("corecustomisation.zip"))
{

	mkdir("packages");
	system("mv corecustomisation.zip packages");
}

//To add the zip file before the commit
system("git add .");


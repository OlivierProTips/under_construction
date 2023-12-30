<html>
    <head>
    <link rel="stylesheet" type="text/css" href="../main.css">
    </head>
    <body>
        <div class="container">
        <h1>Here are the available files</h1>
        <?php

        $files = array_diff(scandir("files"), array('..', '.'));

        echo "<div class=\"files\">";
        foreach ($files as $file) {
            echo "<a href=\"?file=".$file."\">$file</a>";
        }
        echo "</div>";


        if (isset($_GET['file'])) {
            ?>
            <div class="file-content">
            <?php
            $output=null;
            $retval=null;

            exec("cat files/".$_GET['file'], $output, $retval); // Linux
            
            if ($retval == 0) {
                foreach ($output as $line) {
                    echo "$line<br>";
                }
            }
            else {
                echo "This file does not exist!!!";
            }
        }

        ?>
        </div>
        </div>
    </body>
</html>

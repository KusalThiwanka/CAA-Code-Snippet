<?php
# Get the instance ID from meta-data and print to the screen
$instance_id = shell_exec('ec2-metadata --instance-id 2> /dev/null | cut -d " " -f 2');
if (empty($instance_id)) { $instance_id = "Sorry, Instance ID not available at this moment"; }
?>
<!DOCTYPE html>
<html>
  <head>
    <title>Kusal's Webpage</title>
  </head>
  <body>
    <h1>Welcome to Kusal Thiwanka's website</h1>
    <h1>Instance ID: <?php echo $instance_id ?></h1>
  </body>
</html>
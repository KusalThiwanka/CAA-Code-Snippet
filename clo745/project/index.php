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


<!-- <?php

  echo "<table class='table table-bordered'>";
  echo "<tr><th>Meta-Data</th><th>Value</th></tr>";

  # Get the instance ID from meta-data and print to the screen
  $instance_id = shell_exec('ec2-metadata --instance-id 2> /dev/null | cut -d " " -f 2');
  # if its not set make it 0
  if (empty($instance_id)) {
      $instance_id = 0;
  }
  echo "<tr><td>InstanceId</td><td><i>";
  echo $instance_id;
  "</i></td><tr>";

  # Availability Zone
  $az = shell_exec('ec2-metadata -z 2> /dev/null | cut -d " " -f 2');
  # if its not set make it 0
     if (empty($az)) {
         $az = 0;
  }
  echo "<tr><td>Availability Zone</td><td><i>";
  echo  $az;
  "</i></td><tr>";

  echo "</table>";

?> -->


<?php
  # This code performs a simple vmstat and grabs the current CPU idle time
  $idleCpu = exec('vmstat 1 2 | awk \'{ for (i=1; i<=NF; i++) if ($i=="id") { getline; getline; print $i }}\'');

  # Print out the idle time, subtracted from 100 to get the current CPU utilization
  echo "<br /><p>Current CPU Load: <b>"; 
  echo 100-$idleCpu;
  echo "%</b></p>";
  
?>
<?php
$ToEmail = $_POST["email"];
$EmailSubject = 'Thank you for subscription';
$mailheader = "From: demo123@gmail.com\r\n";
$mailheader .= "Reply-To: demo123@gmail.com\r\n";
$mailheader .= "Content-type: text/html; charset=iso-8859-1\r\n";
$MESSAGE_BODY = "<p>Thank you for subscribed our web site.</p>";
mail($ToEmail, $EmailSubject, $MESSAGE_BODY, $mailheader) or die ("Failure");
?>
<?php
 
/* Задаем переменные */
$email = htmlspecialchars($_POST["email"]);
$message = htmlspecialchars($_POST["message"]);
 
/* Ваш адрес и тема сообщения */
$address = "decor-svadby@mail.ru";
$sub = "Сообщение с сайта decor-svadby.ru";
 
/* Формат письма */
$mes = "Сообщение с сайта decor-svadby.ru.\n
Электронный адрес отправителя: $email
Текст сообщения:
$message";
 
 
/* Отправляем сообщение, используя mail() функцию */
$from  = "From: <$email> \r\n Reply-To: $email \r\n";
if (mail($address, $sub, $mes, $from)) {
	header('Refresh: 5; URL=http://decor-svadby.ru');
	echo '<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>
    <body>Письмо отправлено, через 5 секунд вы вернетесь на страницу decor-svadby.ru</body>';}
else {
	header('Refresh: 5; URL=http://decor-svadby.ru/contact');
	echo '<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>
    <body>Письмо не отправлено, через 5 секунд вы вернетесь на страницу decor-svadby.ru</body>';}

?>

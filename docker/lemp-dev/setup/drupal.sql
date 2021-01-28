# Creating the MySQL database
CREATE DATABASE IF NOT EXISTS `drupal`;

# Creating the MySQL user (replace the user and password with your own values)
CREATE USER 'drupal_user'@'%' IDENTIFIED WITH mysql_native_password BY 'password';
GRANT ALL ON `drupal`.* TO 'drupal_user'@'%';

USE `drupal`;
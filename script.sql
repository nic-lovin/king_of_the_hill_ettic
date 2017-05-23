START TRANSACTION;
USE king_of_the_hill;
CREATE TABLE table_images (
    id INT NOT NULL AUTO_INCREMENT,
    link VARCHAR(100) NOT NULL,
    PRIMARY KEY(id)
);
INSERT INTO table_images
(id, link)
VALUES
(1, "img/logo.png");
UPDATE mysql.user
    SET authentication_string = PASSWORD('Ndf2roF6TT1nN32pzgxvQbabPdHF1Rg3XK5QNUIEIgC6hXwkuV'), password_expired = 'N'
    WHERE User = 'root' AND Host = 'localhost';
FLUSH PRIVILEGES;
COMMIT;

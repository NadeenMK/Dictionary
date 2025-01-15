CREATE DATABASE IF NOT EXISTS dictionary;
USE dictionary;
CREATE TABLE IF NOT EXISTS words(
    id INT AUTO_INCREMENT PRIMARY KEY,
    word VARCHAR(255) NOT NULL,
    definition TEXT NOT NULL
);
INSERT INTO words (word, definition) VALUES
('summer','Hot'),
('winter','Cold'),
('Happy','Joyful'),
('Brave','Courageous'),
('Quick','Fast'),
('Sad','Unhappy'),
('Big','Large'),
('Cold','Chilly'),
('Bright','Shiny'),
('Smart','Clever');
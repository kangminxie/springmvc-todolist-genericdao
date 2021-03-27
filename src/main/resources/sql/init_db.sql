-- CREATE DATABASE db_todolist_generic CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

INSERT INTO authority(id, name) VALUES(1, 'ROLE_NORMAL');
INSERT INTO authority(id, name) VALUES(2, 'ROLE_ADMIN');

INSERT INTO user_to_authority(uid, aid) VALUES(1, 1);
INSERT INTO user_to_authority(uid, aid) VALUES(1, 2);

INSERT INTO account
(id, email, firstName, lastName, username, role, password, createdDay)
VALUES
(1, 'mountkingx@gmail.com', 'Super', 'Admin', 'sa', 'ADMIN', '$2a$10$2RvrPXfAdHQhSvYouhdNz.AWsrWlSXgQ1zqIBehFUh6hL0LSYv8fG', NOW());

-- UPDATE account SET role='ADMIN' WHERE id=1;

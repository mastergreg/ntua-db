CREATE TABLE checks (
    checkid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    checktypeid UNSIGNED INT NOT NULL,
    pid UNSIGNED INT NOT NULL,
    umn UNSIGNED INT,
    created DATETIME,
    duration UNSIGNED INT NOT NULL,
    score UNSIGNED INT NOT NULL,
    FOREIGN KEY ( checktypeid ) REFERENCES checktypes( checktypeid ) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ( pid ) REFERENCES planes( pid ) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ( umn ) REFERENCES techs( umn ) ON DELETE SET NULL ON UPDATE CASCADE, -- would prefer ON DELETE SET NULL ON UPDATE CASCADE here
    CONSTRAINT chk_checks CHECK (score > ( SELECT maxscore FROM checktypes t WHERE checktypeid = t.checktypeid ) AND duration > 0 )
) ENGINE=InnoDB;
CREATE TABLE checktypes (
    checktypeid UNSIGNED INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name TEXT,
    maxscore UNSIGNED INT NOT NULL
) ENGINE=InnoDB;
CREATE TABLE employees (
    umn UNSIGNED INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ssn UNSIGNED INT UNIQUE,
    name TEXT NOT NULL,
    imageid INT DEFAULT NULL,
    phone VARCHAR( 32 ),
    addr TEXT,
    salary UNSIGNED INT
    FOREIGN KEY ( imageid ) REFERENCES images( imageid ) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;
CREATE TABLE planes (
    pid UNSIGNED INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tid UNSIGNED INT NOT NULL,
    FOREIGN KEY ( tid ) REFERENCES planetypes( tid ) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;
CREATE TABLE regulators (
    umn UNSIGNED INT NOT NULL PRIMARY KEY,
    checked DATE NOT NULL,
    FOREIGN KEY ( umn ) REFERENCES employees( umn ) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;
CREATE TABLE specializations (
    umn UNSIGNED INT NOT NULL,
    tid UNSIGNED INT NOT NULL,
    PRIMARY KEY ( umn, tid ),
    FOREIGN KEY ( umn ) REFERENCES techs( umn ) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ( tid ) REFERENCES planetypes( tid ) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;
CREATE TABLE techs (
    umn UNSIGNED INT NOT NULL PRIMARY KEY,
    FOREIGN KEY ( umn ) REFERENCES employees( umn ) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;
CREATE TABLE planetypes (
    tid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR( 32 ) NOT NULL,
    capacity UNSIGNED INT DEFAULT NULL,
    weight UNSIGNED INT DEFAULT NULL,
    imageid INT DEFAULT NULL,
    FOREIGN KEY ( imageid ) REFERENCES images( imageid ) ON DELETE SET NULL ON UPDATE CASCADE
	CONSTRAINT chk_planetypes CHECK ( capacity > 0 AND weight > 0 )
) ENGINE=InnoDB;
CREATE TABLE users (
    uid UNSIGNED INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(32),
    password CHAR(64),
    passwordsalt CHAR(8),
    email VARCHAR(64)
) ENGINE=InnoDB;
CREATE TABLE images (
    imageid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    size UNSIGNED INT DEFAULT NULL,
    width UNSIGNED INT DEFAULT NULL,
    height UNSIGNED INT DEFAULT NULL
) ENGINE=InnoDB;
CREATE VIEW workers AS
    SELECT
        e.*,
        ( CASE WHEN t.umn IS NOT NULL THEN 'tech'
               WHEN r.umn IS NOT NULL THEN 'regulator'
               ELSE '' END ) AS occ
    FROM
        employees e
        LEFT JOIN
            techs t ON t.umn = e.umn
        LEFT JOIN
            regulators r ON r.umn = e.umn;

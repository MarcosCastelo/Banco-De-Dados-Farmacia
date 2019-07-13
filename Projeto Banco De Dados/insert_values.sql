DELETE FROM CLIENTE;
DELETE FROM ESTOQUE;

INSERT INTO CLIENTE VALUES
(default, '07069895380', 'MARCOS CASTELO', 'marcos@gmail.com', '86995441377', '02-07-2000', TRUE),
(default, '07312341233', 'GUILHERME NONATO', 'whisperman@gmail.com', '86988745298', '12-08-2000', TRUE),
(default, '06071964326', 'ELCY JAMES NOGUEIRA CARDOSO', 'cyzinha653@gmail.com', '86998170304', '29-01-1999', TRUE),
(default, '08232302335', 'MARAH CHRISITNI RODRIGUES DE SOUSA', 'mchristini@gmail.com', '86981650527', '04-05-2001', FALSE),
(default, '06532134365', 'LUIS ALVES DE SOUSA', 'ghjjj@gmail.com', '86995273273', '19-12-1999', FALSE);

INSERT INTO CATEGORIA VALUES
(default,'PRETA'),
(default, 'VERMELHA'),
(default, 'SEM TARJA');

INSERT INTO FORNECEDOR VALUES(default, 'FARMAVILLE'),(default, 'ULTRAPHARMA'),(default, 'FARMATOP'),(default, 'MEDFARMA'),(default, 'SUPERPHARMA');

INSERT INTO MARCA VALUES (default, 'SALCOMP'),(default, 'ARNO'),(default, 'GENERICO');

INSERT INTO PRODUTO VALUES
(default, 'HISTAMIN', 1, 4),
(default, 'ALLEGRA-D', 3, 4),
(default, 'RIVOTRIL', 1, 1),
(default, 'PSICOTRIL', 3, 1),
(default, 'AMOXILINA', 2, 2),
(default, 'ANTIBIO', 3, 2);

INSERT INTO LOJA VALUES 
(default, 'DROGA+ - CENTRO', 'RUA QUINTINO BOCAIUVA 2354, CENTRO'),
(default, 'DROGA+ - NORTE', 'RUA PEDRO BRITO 1365, PARQUE ALVORADA'),
(default, 'DROGA+ - SACI', 'RUA ARLINDO NOGUEIRA 3212, SACI'),
(default, 'DROGA+ - LESTE', 'AVENIDA N SRA DE FATIMA, 4123, JOCKEY'),
(default, 'DROGA+ - TIMON', 'RUA 100 2312, EMBAIXADA');

INSERT INTO LOCAL VALUES
(default, 'RUA QUINTINO BOCAIUVA 2354, CENTRO', 0.00),
(default, 'RUA PEDRO BRITO 1365, PARQUE ALVORADA', 0.00),
(default, 'RUA ARLINDO NOGUEIRA 3212, SACI', 0.00),
(default, 'AVENIDA N SRA DE FATIMA, 4123, JOCKEY', 0.00),
(default, 'RUA 100 2312, EMBAIXADA', 0.00),
(default, 'PORTO ALEGRE', 20.00),
(default, 'MATADOURO', 6.00),
(default, 'MOCAMBINHO', 8.00);

INSERT INTO PRECO VALUES
(1,10.00,1,1),(2,12.00,2,1),(3,11.50,3,1),(4,19.60,4,1),(5,10.00,5,1),
(6,20.00,1,2),(7,22.00,2,2),(8,21.50,3,2),(9,29.60,4,2),(10,20.00,5,2),
(11,60.00,1,3),(12,62.00,2,3),(13,61.50,3,3),(14,59.60,4,3),(15,60.00,5,3),
(16,40.00,1,4),(17,42.00,2,4),(18,41.50,3,4),(19,39.60,4,4),(20,40.00,5,4),
(21,25.00,1,5),(22,23.00,2,5),(23,26.00,3,5),(24,28.00,4,5),(25,26.00,5,5),
(26,15.00,1,6),(27,11.00,2,6),(28,16.00,3,6),(29,12.00,4,6),(30,13.00,5,6);


INSERT INTO ESTOQUE VALUES
(default,1,1,20),(default,1,2,20),(default,1,3,20),(default,1,4,20),(default,1,5,20),(default,1,6,20),
(default,2,1,20),(default,2,2,20),(default,2,3,20),(default,2,4,20),(default,2,5,20),(default,2,6,20),
(default,3,1,20),(default,3,2,20),(default,3,3,20),(default,3,4,20),(default,3,5,20),(default,3,6,20),
(default,4,1,20),(default,4,2,20),(default,4,3,20),(default,4,4,20),(default,4,5,20),(default,4,6,20),
(default,5,1,20),(default,5,2,20),(default,5,3,20),(default,5,4,20),(default,5,5,20),(default,5,6,20);



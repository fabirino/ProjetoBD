SELECT * FROM utilizadores;
SELECT * FROM compradores;
SELECT * FROM vendedores;
SELECT * FROM admins;

SELECT * FROM produtos;
SELECT * FROM computadores;

SELECT id FROM produtos
WHERE produtos.nome like 'Computador1';

SELECT LOGIN_VERIFY('edini','password01');
SELECT u.id  FROM utilizadores u, admins c WHERE  u.id = c.utilizador_id and u.username like 'edini' and u.password like 'password01' ;

SELECT id FROM produtos
    WHERE produtos.nome like 'Computador1' and produtos.vendedor_id = ID_VENDEDOR('infortech'); 

SELECT  MAX(versao) FROM produtos  WHERE id = 1 ;



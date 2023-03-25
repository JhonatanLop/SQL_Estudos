-- Modificando tabelas
    -- Renomeando tabela
    alter table nome_tabela RENAME to nome_tabela_novo;

-- Inserindo dados

    -- Inserir dados numa tabela
    INSERT INTO public.app_perfil
        (campo1, campo2)
        VALUES(valor1, 'valor2 (caso seja texto)');

    --copia dados de uma tabela para outra criada na hora. NÃO é bkup, só uma cópia de dados
    select * into nome_da_tabela_bkup from nome_da_tabela;

-- Inserindo/Modificando colunas campos
    --deletar coluna
    ALTER TABLE public.nome_tabela DROP COLUMN nome_coluna;

    --alterar nome de um atributo na tabela
    -- alter t  schema.nome_da_tabela_edif RENAME COLUMN nome_antigo TO nome_novo
    ALTER TABLE public.nome_tabela RENAME COLUMN nome_antigo TO nome_novo;

    --add nova coluna (nome da tabela) add (nome do campo) (tipo);
    Alter table nome_da_tabela add campo varchar null;

    -- Como fazer um update
    UPDATE nome_da_tabela
    SET nome_da_coluna = 'novo_valor'
    WHERE condicao;

    -- #########
    -- Número de protocolo
    -- neste caso, "número de protocolo" não é uma sequence mas é um número que nunca se repete.
    -- alterar uma função de uma coluna na tabela
    alter table nome_da_tabela alter column nome_da_coluna set default to_char(tipo_da_função, 'formatação');
    -- exemplo
    alter table nome_tabela alter column nome_coluna set default to_char(CURRENT_TIMESTAMP, 'DDMMHH24MISSMS/YYYY');
    -- alterando uma coluna do tipo "timestamp" para pegar o tempo exato em que o registro novo é criado.
    ALTER TABLE TABELA ADD ATRIBUTO VARCHAR NOT NULL DEFAULT to_char(CURRENT_TIMESTAMP, 'DDMMYYHH24MISSMS');
    -- #########

    --########
    ALTER TABLE public.nome_da_tabela ALTER COLUMN nome_da_coluna TYPE tipo_desejado USING nome_da_coluna::tipo_desejado;
    -- quando você usa os caracteras "::" consecutivos, você esta transformando eles em outro tipo de dado
    -- exemplo:
    SELECT * from nome_tabela where documento::numeric = 123456;
    -- neste exemplo, estou fazendo uma pesquisa num documento. o tipo da coluna é texto.
    -- para comparar ela com outro número, eu faço uma conversão de tipo de dado usando "::"
    -- Mas essa conversão só é mantida enquanto a query é executada.
    --########

    -- alterando nome com replace
    update tabela 
    set nome_campo = replace (nome_campo,'texto antigo','texto novo' )
    where condição;

-- Tratamento de Dados
    --Atualização dos dados
    UPDATE nome_da_tabela SET campo = valor WHERE campo_de_referencia_pra_pesquisa = valor_pra_pesquisa;
    -- exemplo
    -- muda o valor de TODOS OS CAMPOS onde o valor é diferente de 0
    update tabela set meu_campo = 'valor que eu quero' where nome_coluna <> '0';

    -- muda o valor de TODOS OS CAMPOS onde o valor é igual a 0
    update tabela set meu_campo = 'valor que eu quero' where nome_coluna = '0';


-- Sequence
    -- atualiza o valor da sequence
    select setval ('nome_da_sequence',(select max (pk) from nome_da_tabela));

    -- seta default como uma sequence (usado no id)
    alter table public.nome_da_tabela alter column nome_da_coluna set default nextval('nome_da_sequence'::regclass);

    -- como criar uma sequence
    create sequence sua_sequence increment 1 minvalue 1 maxvalue 28452039485 start 1 cache 1;

    -- como adicionar uma sequence à um atributo
    alter table teste_trigger alter column atributo set default nextval('sua_sequence');


-- Substring
    -- cria uma substring
    select substring(ATRIBUTO from 2 /* posição inicial da substring */ for 66 /* posição final da substring*/) from  TABELA
    -- ou
    select substring(ATRIBUTO, 1 /* posição inicial da substring */ , 5 /* posição final da substring*/) from  TABELA
    -- onde o atributo do tipo string será "picotado" do caractere inicial, no caso 1, até o final, no caso 5
    -- exemplo: se a srting for "klaton e mateus", a substring de 1 a 8 será: "klaton e"


-- Pesquisa de dados
    select * from app_tema 
    where
    nome_campo1 in ('opção1', 'opção2', 'opção3')
    or 
    nome_campo2 in ('opção3', 'opção4', 'opção5')
    -- irá mostrar o registro todo onde o campo 1 ou campo2 tiverem as opções
    -- a cláusua "in", aplica uma verificação em todas as opções
    -- equivalente a ```campo 1 = a or campo1 = b or campo1 = c```

    -- pesquisar por "like" ou "parecido com..." 
    SELECT * from tabela WHERE
        nome like 'pedro%';

    -- se quiser pesquiser um atributo que seja número
    SELECT * FROM tabel WHERE
        prf_id::text like '9%';
    -- aqui estou transformano em texto para fazer a pesquisa

    -- Como fazer um select em duas tabelas usando join
    -- esolhe as colunas a puxar das DUAS tabelas
    SELECT tabela1.coluna1, tabela1.coluna2, tabela2.coluna3, tabela2.coluna4
    FROM tabela1
    INNER JOIN tabela2
    -- faz o inner join e esolhe um campo de ligação onde os valores sejam iguais
    -- a clausula "on" é equivalente a "where", é onde será imposta a condição
    ON tabela1.coluna_chave = tabela2.coluna_chave;

    -- Para usar apelidos
    -- o apelido é utilizado no select
    SELECT tabela1.coluna1 AS nome_a, tabela2.coluna2 AS Nome_B
    FROM tabela1
    INNER JOIN tabela2
    ON tabela1.coluna_chave = tabela2.coluna_chave;
    -- dessa forma, o nome das colunas serão alterados para "nome_a" e "nome_b"


-- Functions/trigger
    -- como dropar uma function
    drop FUNCTION nome_da_função;

    -- como dropar uma trigger
    drop trigger nome_da_trigger on nome_tabela;
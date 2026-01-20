# cadastro-jogo
Página de Cadastro para Jogo online, permitindo uso de chat de voz apenas por maiores de 18 anos comprovados via documentação.

# Jogo Online – Banco de Dados (Estudo)

Esse projeto foi criado como forma de aprendizado em **SQL e banco de dados relacional**,
usando MariaDB.

A ideia aqui não é criar um sistema completo, mas praticar:
- criação de tabelas
- regras de negócio no banco
- validações de dados
- uso de trigger
- constraints como PRIMARY KEY e UNIQUE

Durante o desenvolvimento, usei o que fui aprendendo e também contei com apoio de ferramentas de IA,
sempre entendendo e adaptando o código para o que eu precisava.

---

## O que esse banco simula

Um cadastro de usuários de um jogo online, com algumas regras básicas:

- Cada usuário tem um login único
- Email, CPF e nome dentro do jogo não podem se repetir
- Usuários menores de 18 anos não podem usar chat de voz
- Para usar chat de voz, é obrigatório enviar um documento com foto

Essas regras são validadas direto no banco, usando um trigger, para evitar dados inválidos.

---

## Observações importantes

- A coluna `senha` foi pensada para armazenar o **hash da senha**, gerado pela aplicação
- Não há dados reais neste projeto, apenas estrutura para estudo
- O foco é aprendizado, não produção

---

## Tecnologias usadas

- MariaDB
- SQL
- phpMyAdmin (ambiente online)

---

## Objetivo do projeto

Aprender na prática como o banco de dados pode ajudar a garantir regras e integridade,
e não servir apenas como “lugar para guardar dados”.

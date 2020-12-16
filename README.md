 

# Multiplier Full Stack Test

Aplicação simples desenvolvida para tentar fazer parte do time de desenvolvimento da empres [Multiplier](https://www.multiplier.com.br)



[TOC]

## Tecnologia e Estrutura

- Back-end
  - Laravel Lumen - v. 8 
  - PostgreSQL  - v. 13
- Front-end
  - Vue.js com Quasar Framework - v. 1.14.7
- Imagens do Docker para desenvolvimento
  - Nginx 1.17
  - PHP 7.4
  - PostgreSQL 13





O Back-end do projeto serve de API para o Front-end tornando os projetos mais independentes e de facil distribuição para o desenvolvimento de times especificos para cada tecnologia.

Os produtos dos pedidos são salvos em JSONB no banco, o motivo é ter uma cópia exata dos produtos dentro do pedido, caso o produto sofra alterações, no pedido permanecerá o mesmo de quanto foi efetuado.

Todos os dados são excluidos virtualmente do banco para evitar perda de dados.



## Funcionalidades

- Autenticação
- Categorias (CRUD)
- Produtos (CRUD)
- Pedidos (CRD)
- Usuários (CRUD)



## O que falta

- [ ] Disparo de email ao realizar um pedido
- [ ] Logs de alterações no banco
- [ ] Docker para o Front-end
- [ ] Testes



## Desenvolvimento

Acesse a pasta do projeto após clonar.

### 1. Docker

Inicie os containers.

> docker-compose up -d

### 2. Back-end

Acesse o terminal do container **multiplier-app**:

> docker-compose exec app bash

Instale as dependencias do projeto com o **Composer**:

> composer install

Configure o arquivo do ambiente ou utilize o de desenvolvimento:

> cp .env.local .env

Execute o comando para gerar os dados no banco de dados:

> php artisan migrate:fresh --seed

Pode sair do container utilizando o comando:

> exit

Pronto a API está disponivel na porta **9090**.

### 3. Front-end

Acesse a pasta do **Front-end** e instale as dependencias com o **Yarn**:

> cd front && yarn install

Execute o projeto:

> yarn dev

Pronto o projeto estará disponível na porta **8080**.





Para acessar utilize o usuário de exemplo:

Email: exemplo@multiplier.com.br

Senha:  teste123






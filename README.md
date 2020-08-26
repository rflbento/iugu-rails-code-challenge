# iugu-rails-code-challenge
Este repositório foi criado para propor a solução do seguinte desafio: [Desafio Rails - IUGU](https://github.com/iugu/account_movement_challenge).

## <a name="tech_info"></a>Informações técnicas
- Linguagem: Ruby (v 2.7.0)
- Framework: Rails (v 6.0.3.2)
- Banco de Dados: MySQL (v 14.14 Distrib 5.7.31)
---
## Para conseguir executar este projeto, você deve:
1. Possuir o Ruby instalado na sua máquina (versão utilizada neste projeto, de preferência), assim como as outras dependências citadas em [Informações técnicas](https://github.com/bentinhorafa/iugu-rails-code-challenge#tech_info);
2. Baixar este repositório com o comando abaixo:
- `git clone git@github.com:bentinhorafa/iugu-rails-code-challenge.git`
3. Na pasta raiz do projeto há o arquivo `.env.yml.sample`. Este sample é um modelo das variáveis de ambiente que você usará em seu projeto, portanto você deve:
- Copiar este arquivo e colar no mesmo local onde o sample está (`iugu-rails-code-challenge/.env.yml.sample` - raiz do projeto);
- Na cópia criada, renomeá-la para `.env.yml`;
- Dentro de `.env.yml`, alterar as informações de USERNAME e PASSWORD para as de seu MySQL local.
4. Executar `bundle install` em seu terminal para que as dependências do projeto sejam instaladas;
5. Executar `bundle exec rails db:create` em seu terminal para que o banco de desenvolvimento seja criado.

### Extra (caso deseje rodar a suite de testes do projeto)
6. Executar `bundle exec rails db:create RAILS_ENV=test` em seu terminal para que o banco de teste seja criado;
7. Executar `bundle exec rspec` em seu terminal para que os testes sejam executados e você veja seu retorno.
---
## Como testar as features localmente
**Antes de executar os passos a seguir, após fazer o mencionado acima, deve entrar na rails do projeto e executar o seguinte comando:** `rails server`

No seu terminal você deve executar o comando `curl` passando pos parâmetros necessários para que o seu computador faça uma requisição em uma URI que você vai informar também como parâmetro da do `curl`. Abaixo, exemplos para que todas as features sejam testadas.

1. Criar uma conta informando um ID:
```
curl --location --request POST 'http://localhost:3000/api/v1/accounts' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
  "account_number": 46623,
  "account_name": "John Doe",
  "initial_balance": 200035
}'
```

2. Criar uma conta sem informar ID:
```
curl --location --request POST 'http://localhost:3000/api/v1/accounts' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
  "account_name": "Bob Marley",
  "initial_balance": 753612
}'
```

3. Informar ID já existente:
```
curl --location --request POST 'http://localhost:3000/api/v1/accounts' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
  "account_number": 46623,
  "account_name": "Beth Carvalho",
  "initial_balance": 182712
}'
```

4. Realizar uma transferência com sucesso:
```
curl --location --request POST 'http://localhost:3000/api/v1/transfers' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
  "source_id": 46623,
  "destiny_id": 46624,
  "amount": 50000
}'
```

5. Transferência rejeitada:
```
curl --location --request POST 'http://localhost:3000/api/v1/transfers' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
  "source_id": 46623,
  "destiny_id": 46624,
  "amount": 150036
}'
```

6. Consulta de saldo (o ID da conta que o usuário escolheu deve estar na URI):
```
curl --location --request GET 'http://localhost:3000/api/v1/accounts/46623/balance' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json'
```

7. Conta não encontrada (o ID da conta que o usuário escolheu deve estar na URI):
```
curl --location --request GET 'http://localhost:3000/api/v1/accounts/123/balance' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json'
```
---
## Gems
No arquivo `Gemfile` você consegue visualizar as gems utilizadas para o projeto.
Nenhuma destas gems está relacionada à performance ou segurança, que são atributos essenciais para qualquer sistema de transações monetárias ou similares.

Por ser um projeto de teste de funcionalidades, não foquei na segurança destes dados, como, por exemplo, encriptação do Token, um login mais seguro para o usuário, com uma senha também encriptada (creio que o Devise seria a melhor opção, pois tem inclusive gems de token vinculadas).

As gems utilizadas são especificamente para melhoria do desenvolvimento em si, sendo elas:
- Factory Bot (gerar objetos para os testes automatizados de forma pré-definida, alterando uma informação do obejto somente se necessário);
- RSpec (um dos métodos possíveis dentro do Ruby/Rails para desenvolver as classes de testes. Gosto muito do padrão do RSpec);
- Rubocop (responsável por checar se o desenvolvedor está seguindo boas práticas de desenvolvimento em identação, atribuição de variáveis, definição de métodos, entre outros. Possui um arquivo onde o desenvolvedor pode escolher o que será checado pela gem, no meu caso configurei para que não visualizasse em aluns pontos de todo o projeto);
- Shoulda-Matchers (creio que seja a melhor opção para testar Models! Tem uma sintaxe extramemente simples e deixa o código do teste bem enxuto);
- Simplecov (indica o percentual de cobertura de testes do seu projeto. Usei para conseguir atingir os 100% de cobertura).

### Sobre o Simplecov
Por este ser um projeto de desafio da Iugu, optei por subir o HTML gerado pelo simplecov para que todos possam visualizar a cobertura 100%.
Normalmente, adicionamos ele ao `.gitignore` para que não suba arquivo desncessário do projeto ao seu repositório.

## Docker
Assim como no outro desafio (Ruby), não utilizei o Docker por possuir um conhecimento muito raso sobre o assunto.
Poderia, sim, ter pesquisado para aplicar, mas optei por demonstrar o meu conhecimento já adquirido em desenvolvimento, não deixando de reconhecer o Docker como uma ferramenta extremamente poderosa e que facilita a vida da equipe de desenvolvimento como um todo.

## Falta desenvolver
Ainda falta informar o Token do usuário nas solicitações de transferência e verificação de saldo da conta (nos exemplos mencionados acima, nenhum deles exige o token do usuário).
Creio eu que, concluindo esta etapa, o projeto estará finalizado.

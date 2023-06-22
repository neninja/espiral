# Introdução ao desenvolvimento web com Laravel

Criaremos um sistema de agendamento chamado [*Reiserva*](http://github.com/nenitf/reiserva2) onde que:

- Teremos 3 tipos de usuários, sendo 1) administrador 2) moderadores 3) cliente
- Teremos ambientes que podem ser reservados
- Dependendo do ambiente as reservas podem:
    - ser por dia, horários específicos ou horário livre
    - restrita a 1 ou mais clientes

Trabalharemos com *TDD*, primeiro criamos um teste falho, fazemos ele passar, melhoramos e repetimos. O foco será sempre utilizar o teste, não necessariamente validar em tela algum fluxo, mas sinta-se livre para fazê-lo.

Algumas vezes nos testes utilizaremos os seguintes termos para comentar a intenção estrutural do bloco de código dentro do teste:

- *arrange*: criação do contexto do teste

> Qual usuário? Qual contexto do banco?

- *act*: execução do que está sendo efetivamente testado

> Qual o método que vai ser chamado?

- *assert*: confirmação das expectativas criadas no teste

> Quais as consequências? Elas correspondem ao esperado? Valor persistido? Evento emitido? E-mail enviado?

## Syntax php

Breve explicação da syntax do PHP com o arquivo final da primeira versão de uma classe que criaremos.

```php
<?php // tag obrigatória para escrever script php
 
/*
 * Pacote/"Sobrenome" do arquivo, normalmente segue o padrão de pasta.
 * Arquivos com App\Services está na pasta app/services
 */
namespace App\Services;

// Importação de outras classes através de seu Namespace + nome da classe
use App\Models\Ambiente;
use App\Models\Reserva;
use App\Models\User;

/* 
 * Classe é como uma "gaveta" cujo possui:
 * propriedades: semelhantes a variáveis
 * métodos: semelhantes a funções
 */
class ReservaService
{
    // método
    public function criar(Ambiente $ambiente, User $usuario)
    {
        // variável com $
        // propriedade acessada através de ->
        $reserva = new Reserva();
        $reserva->id_ambiente = $ambiente->id;
        $reserva->id_usuario = $usuario->id;
        $reserva->save();
    }
}
```

## Organização proposta

Mesmo utilizando laravel, cujo é um framework que estipula padrões para nós, podemos complementá-lo com nossas próprias definições, cujo serão:

- Toda regra de negócio envolverá passar por uma classe específica com o sufixo `Service` 
- Todo provedor de serviço externo, seja um *web service* ou biblioteca terá uma classe com o sufixo `Provider`, cujo implementará uma interface

Cada um desses pontos vai ser abordado e aprofundado no decorrer do desenvolvimento do projeto.

## Configuração inicial

- [Baixe o PHP](https://www.php.net/downloads.php), e habilite as extensões `BCMath` `Ctype` `Fileinfo` `JSON` `Mbstring` `OpenSSL` `PDO` `Tokenizer` `XML`
- [Baixe o Composer](https://getcomposer.org/download/)

## Criação do projeto

Acesse a pasta onde guarda seus projetos, abra um terminal e execute

```sh
composer create-project laravel/laravel reiserva
```

## Criando a reserva simplificada

Vamos validar que dado um usuário (`User`) e um ambiente, podemos criar uma reserva através da classe `ReservaService`.

1. Crie o arquivo que vai possuir os testes com `php artisan make:test ReservaServiceTest` no terminal dentro do projeto

> Esse comando (scaffold) é uma facilidade do Laravel, cujo vai criar o arquivo de teste no local correto. Durante o andamento do projeto utilizaremos outros semelhantes a esse

2. Crie o teste `testReservaAmbiente` como abaixo

> A nomenclatura de testes utilizada é a do [Spotify](https://github.com/spotify/should-up)

> *SUT* significa *System Under Test*

```php
<?php

namespace Tests\Unit;

use App\Models\User;
use App\Models\Ambiente;
use App\Models\Reserva;
use App\Services\ReservaService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ReservaServiceTest extends TestCase
{
    use RefreshDatabase;
    
    public function testReservaAmbiente(): void
    {
        // Arrange: usuário existente
        $usuario = new User([
            'name' => 'Fulano de tal',
            'email' =>'fulano@tal.com',
            'password'=> '123',
        ]);
        $usuario->save();

        // Arrange: ambiente existente
        $ambiente = new Ambiente();
        $ambiente->nome = 'Salão de festas';
        $ambiente->save();

        // Act: criação da reserva
        $sut = new ReservaService();
        $sut->criar($ambiente, $usuario);

        // Assert: existência da reserva no banco de dados
        $this->assertDatabaseHas(Reserva::class, [
            'id_ambiente'=> $ambiente->id,
            'id_usuario'=> $usuario->id
        ]);
    }
}
```

3. Execute o teste com `php artisan test --filter testReservaAmbiente` e perceba que falhou por faltar algumas dessas classes

```txt
FAILED  Tests\Unit\ReservaServiceTest > reserva ambiente
Class "Tests\Unit\User" not found
```

4. Crie as classes que faltam:

- As models com `php artisan make:model Reserva` `php artisan make:model Ambiente`
- `ReservaService` como `app/Services/ReservaService.test` (não tem comando pra esse, já que é convenção nossa)

```php
<?php

namespace App\Services;

class ReservaService
{
    public function criar()
    {
        // ...
    }
}
```

5. Reexecute o teste (`php artisan test --filter testReservaAmbiente`) e perceba que o erro mudou. Agora ele está falhando pois não sabe persistir (`->save()`) o ambiente (`User` é uma entidade existente no laravel). Precisamos criar as tabelas nos bancos, porém não de qualquer forma, mas sim com *migrations*.

```txt
FAILED  Tests\Unit\ReservaServiceTest > reserva ambiente   
SQLSTATE[42S02]: Base table or view not found: 1146 Table 'testing.ambientes' doesn't exist (Connection: mysql, SQL: insert into `ambientes` (`nome`, `updated_at`, `created_at`) values (Salão de festas, 2023-06-22 07:07:23, 2023-06-22 07:07:23))
```

> *Migration* é um script que é lido e possui o proposito de alterar a estrutura do banco de dados, seja criando tabelas ou até modificando-as (renomeando campos, mudando seus tipos etc)

6. Crie a migration com `php artisan make:migration cria_ambiente --create=ambientes` e acesse o arquivo criado dentro de `database/migrations`. Adicione nas propriedades o nome do ambiente.

```php
<?php
// ...
        Schema::create('ambientes', function (Blueprint $table) {
            $table->id();
            $table->string('nome');
            $table->timestamps();
        });
// ...
```

7. Reexecute o teste (`php artisan test --filter testReservaAmbiente`) e perceba que ocorreu o mesmo com a tabela de reservas. Crie uma nova migration com `php artisan make:migration cria_ambiente --create=reservas`

```php
<?php
// ...
        Schema::create('reservas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_usuario')->constrained('users');
            $table->foreignId('id_ambiente')->constrained('ambientes');
            $table->timestamps();
        });
// ...
```

8. Reexecute o teste e o erro muda, agora ele está falhando pois não foi encontrada uma reserva persistida com o id do usuário e do ambiente

```txt
FAILED  Tests\Unit\ReservaServiceTest > reserva ambiente                                  
Failed asserting that a row in the table [reservas] matches the attributes {
  "id_ambiente": 1,
  "id_usuario": 1
}.
```

9. Vamos finalizar a funcionalidade persistindo a *Reserva* no *Service*, reexecutar o teste e validar o sucesso

```php
<?php

namespace App\Services;

use App\Models\Ambiente;
use App\Models\Reserva;
use App\Models\User;

class ReservaService
{
    public function criar(Ambiente $ambiente, User $usuario)
    {
        $reserva = new Reserva();
        $reserva->id_ambiente = $ambiente->id;
        $reserva->id_usuario = $usuario->id;
        $reserva->save();
    }
}
```

<!-- diagrama de arquitetura proposta rota -] controller -] service-->

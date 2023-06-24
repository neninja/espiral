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

## Refatoração: *Factories*

Testes devem ser o mais manuteniveis o possível. E para esse fim, uma abordagem interessante é deixá-los o mais simples/objetivos. Ao invés de criar o contexto do banco com save, utilizaremos um recurso do laravel chamado *Factory*

1. Por padrão já exise uma *Factory* para `User` (`UserFactory`), portanto é só utilizá-la


```diff
-        $usuario = new User([
-            'name' => 'Fulano de tal',
-            'email' =>'fulano@tal.com',
-            'password'=> '123',
-        ]);
-        $usuario->save();
+        $usuario = User::factory()->create();
```

2. Crie uma factory para model de ambiente com `sail artisan make:factory AmbienteFactory`
3. Defina as propriedades do ambiente no retorno de `definition`. É interessante utilizar dados aleatorios com fake, para não enviesar nosso teste com sempre os mesmos parametros

```php
<?php

// ...
    public function definition(): array
    {
        return [
            'nome' => fake()->streetName() // na falta de um nome aleatrio para ambientes
        ];
    }
// ...
```

4. Atualize o teste novamente

```diff
-        $ambiente = new Ambiente();
-        $ambiente->nome = 'Salão de festas';
-        $ambiente->save();
+        $ambiente = Ambiente::factory()->create();
```

> O teste deve continuar passando com `php artisan test --filter testReservaAmbiente`

## Refatoração: simplificando a parametrização da `Service`

Existem vários métodos que dizem respeito a regras de negócio que podemos colocar na `Service`, e a grande maioria vai envolver usuário, ambiente e a própria reserva. Portanto não faz muito sentido cada um sempre receber alguns desses como parametros, seria um código repetitivo e, pior ainda, extenso. Muitos parametros numa função dificultam seu entendimento e utilização, e uma abordagem para isso são métodos auxiliares para criar um estado na service.

1. Crie as propriedades *readonly* `$usuario`, `$ambiente` e `$reserva` métodos publicos `setUsuario`, `setAmbiente` e `getReserva` na `ReservaService`

```diff
<?php

// ...

class ReservaService
{
    public readonly User $usuario;
    public readonly Ambiente $ambiente;
    public readonly Reserva $reserva;

    public function setUsuario(User $usuario): self
    {
        $this->usuario = $usuario;
        return $this;
    }

    public function setAmbiente(Ambiente $ambiente): self
    {
        $this->ambiente = $ambiente;
        return $this;
    }

    public function getReserva(): Reserva
    {
        return $this->reserva;
    }
// ...
```

2. Atualize o método `criar` para deixar de receber esses parametros

```diff
-    public function criar(Ambiente $ambiente, User $usuario)
+    public function criar(): self
```

3. Atualize o teste, pois a assinatura do método além de ter mudado agora precisamos parametrizar usuario e ambiente de maneira diferente

```diff
-        $sut->criar($ambiente, $usuario);
+        $sut->setUsuario($usuario);
+        $sut->setAmbiente($ambiente);
+        $sut->criar();
```

4. Aproveitando o ensejo, vamos deixar de repetir a utilização de `$sut`, pois os métodos são fluentes e podemos encadear as chamadas já que retornam `self` (o próprio objeto de `ReservaService`)

```php
<?php

// ...
        // Act: criação da reserva
        $sut = new ReservaService();
        $sut->setUsuario($usuario)
            ->setAmbiente($ambiente)
            ->criar();
// ...
```

> O teste deve continuar passando com `php artisan test --filter testReservaAmbiente`

## Refatoração: utilizando injeção de dependência

Vamos utilizar injeção de dependência para não precisar instanciar a `ReservaService` no teste

```php
<?php

// ...
        // Act: criação da reserva
        app(ReservaService::class)
            ->setUsuario($usuario)
            ->setAmbiente($ambiente)
            ->criar();
// ...
```

Com `app()` o Laravel resolve a dependência e nos retorna uma instancia de `ReservaService`

> O teste deve continuar passando com `php artisan test --filter testReservaAmbiente`

## Restringindo horário de reserva

Vamos fazer algumas validações com as datas:

- Toda reserva possui um dia/hora de inicio e fim
- A data de inicio deve ser anterior (menor) que a data final
- A data inicio deve ser sempre futura (não permitiremos agendamento "retroativo")

1. Atualize o teste existente (`testCriaReserva`) exigindo horário

```php
<?php
// ...
use Illuminate\Support\Carbon;
// ...
class ReservaServiceTest extends TestCase
{
    use RefreshDatabase;
    
    public function testReservaAmbiente(): void
    {
        // Arrange: usuário existente
        $usuario = User::factory()->create();

        // Arrange: ambiente existente
        $ambiente = Ambiente::factory()->create();

        // Act: criação da reserva
        $dataInicio = Carbon::create(2023, 2, 22, 5, 10, 10);   // 22/02/2023
        $dataFim = Carbon::create(2023, 2, 23, 5, 10, 10);      // 23/02/2023
        app(ReservaService::class)
            ->setUsuario($usuario)
            ->setAmbiente($ambiente)
            ->criar($dataInicio, $dataFim);

        // Assert: existência da reserva no banco de dados
        $this->assertDatabaseHas(Reserva::class, [
            'id_ambiente'=> $ambiente->id,
            'id_usuario'=> $usuario->id,
            'data_inicio'=>$dataInicio->toDatetimeString(),
            'data_fim'=>$dataFim->toDateTimeString(),
        ]);
    }
}
```

2. Deve falhar por faltar as colunas no banco, no momento da persistencia
```txt
FAILED  Tests\Feature\ReservaServiceTest > reserva ambiente                         QueryException   
SQLSTATE[42S22]: Column not found: 1054 Unknown column 'data_inicio' in 'where clause' (Connection: mysql, SQL: select count(*) as aggregate from `reservas` where (`id_ambiente` = 1 and `id_usuario` = 1 and `data_inicio` = 2023-02-22 05:10:10 and `data_fim` = 2023-02-23 05:10:10))
```

3. Como já vimos, bora criar a migration com nosso scaffold `php artisan make:migration add_inicio_e_fim_na_reserva --table=reservas`

> Lembre que podemos sempre perguntar para o próprio cli como podemos utilizá-lo. Com `php artisan make:migration --help` posso ver que aceita `--create` (ja usamos para criar tabelas) ou `--table` para alterar uma tabela existente (nosso caso)

4. Adicione a criação das colunas na tabela de reservas

```php
<?php

// ...
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('reservas', function (Blueprint $table) {
            $table->timestamp('data_inicio');
            $table->timestamp('data_fim');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('reservas', function (Blueprint $table) {
            $table->dropColumn('data_inicio');
            $table->dropColumn('data_fim');
        });
    }
// ...
```

5. Atualize a assinatura do método esperando os parametros de data e teste novamente

```php
<?php
// ...
use Carbon\CarbonInterface;
// ...
    public function criar(CarbonInterface $dataInicio, CarbonInterface $dataFim): self
    {
        $reserva = new Reserva();
        $reserva->id_ambiente = $this->ambiente->id;
        $reserva->id_usuario = $this->usuario->id;
        $reserva->data_inicio = $dataInicio;
        $reserva->data_fim = $dataFim;

        $reserva->save();
        return $this;
    }
// ...
```

6. Rodando os testes novamente vai ter outro erro, pois agora a data inicio e fim são obrigatórias e não estamos salvando na nossa *service*

7. Adicione um teste validando uma exception quando a data final sendo maior que a inicial

```php
<?php
// ...
    public function testNaoReservaComDataInicialMaiorQueFinal(): void
    {
        $usuario = User::factory()->create();
        $ambiente = Ambiente::factory()->create();

        $dataInicio = Carbon::create(2023, 2, 23, 5, 10, 10);   // 23/02/2023
        $dataFim = Carbon::create(2023, 2, 22, 5, 10, 10);      // 22/02/2023

        $this->expectException(\App\Exceptions\DatasImpossiveisException::class);
        app(ReservaService::class)
            ->setUsuario($usuario)
            ->setAmbiente($ambiente)
            ->criar($dataInicio, $dataFim);
    }
// ...
```

8. Testando com `php artisan test --fitler testNaoReservaComDataInicialMaiorQueFinal` vai falhar pois não estamos fazendo a validação. Crie a condicional no método da *service*
```php
<?php
// ...
use App\Exceptions\DatasImpossiveisException;
// ...
    public function criar(CarbonInterface $dataInicio, CarbonInterface $dataFim): self
    {
        // valida se $dataInicio é maior ou igual (Greather Than Equal)
        // Se sim: erro
        // se não: prossegue normalmente
        if ($dataInicio->gte($dataFim)) {
            throw new DatasImpossiveisException();
        }
// ...
```

9. Crie a *exception* com o *scaffold* `sail artisan make:exception DatasImpossiveisException`
10. Reexecute o teste e veja-o passar com sucesso
11. Vamos criar o último teste: Data inicio deve ser sempre futura

```php
<?php
// ...
    public function testImpedeDataInicioMenorQueAgora(): void
    {
        $usuario = User::factory()->create();
        $ambiente = Ambiente::factory()->create();

        $dataInicio = now()->yesterday();
        $dataFim = now()->tomorrow();

        $this->expectException(\App\Exceptions\DatasImpossiveisException::class);
        app(ReservaService::class)
            ->setUsuario($usuario)
            ->setAmbiente($ambiente)
            ->criar($dataInicio, $dataFim);
    }
// ...
```

12. Execute o teste com `php artisan test --filter testImpedeDataInicioMenorQueAgora` e confirme a falha por não haver sido lançada a exception. Novamente: crie a exception `sail artisan make:exception DataInicioPassadaException` e a coloque no teste com a condicional adequada

```php
<?php
// ...
use App\Exceptions\DatasImpossiveisException;
// ...
    public function criar(CarbonInterface $dataInicio, CarbonInterface $dataFim): self
    {
        if ($dataInicio->gte($dataFim)) {
            throw new DatasImpossiveisException();
        }
        
        if ($dataInicio->isPast()) {
            throw new DataInicioPassadaException();
        }
// ...
```

13. Perceba que se executar o teste com `php artisan test --filter testImpedeDataInicioMenorQueAgora` passa, porém com `php artisan test --filter ReservaServiceTest` o teste `testReservaAmbiente` falha. E digo mais: por pouco o `testNaoReservaComDataInicialMaiorQueFinal` também não falha, isso ocorre pois sua condicional é logo a primeira do teste. E por que falharam/falhariam? Pois estamos utilizando datas fixas, e as colocadas anteriormente ja passaram! Temos 3 opções: 1) Configurar elas para bem no futuro (ano de 2099) 2) utilizar um helper `Carbon::setTestNow` no inicio de cada teste para configurar quando é o "hoje" do teste ou 3) utilizar helper do laravel mantendo a operação com datas relativas. Utilizaremos esse ultimo
14. Em `testReservaAmbiente`

```diff
-       $dataInicio = Carbon::create(2023, 2, 22, 5, 10, 10);
-       $dataFim = Carbon::create(2023, 2, 23, 5, 10, 10);
+       $dataInicio = now()->tomorrow();
+       $dataFim = now()->tomorrow()->addHour();
```

15. Em `testReservaAmbiente`
```diff
-       $dataInicio = Carbon::create(2023, 2, 22, 5, 10, 10);
-       $dataFim = Carbon::create(2023, 2, 23, 5, 10, 10);
+       $dataInicio = now()->tomorrow()->addHours(2);
+       $dataFim = now()->tomorrow()->addHour();
```

> Todos testes devem passar com `php artisan test --filter ReservaServiceTest`

<!-- diagrama de arquitetura proposta rota -] controller -] service-->

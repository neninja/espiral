# Introdução ao desenvolvimento web com Laravel

Criaremos um sistema de agendamento chamado Reiserva onde que:

- Teremos 3 tipos de usuários, sendo 1) administrador 2) moderadores 3) cliente
- Teremos ambientes que podem ser reservados
- Dependendo do ambiente as reservas podem:
    - ser por dia, horários específicos ou horário livre
    - restrita a 1 ou mais clientes

## Configuração inicial

- [Baixe o PHP](https://www.php.net/downloads.php), e habilite as extensões `BCMath` `Ctype` `Fileinfo` `JSON` `Mbstring` `OpenSSL` `PDO` `Tokenizer` `XML`
- [Baixe o Composer](https://getcomposer.org/download/)

## Criação do projeto

Acesse a pasta onde guarda seus projetos, abra um terminal e execute

```sh
composer create-project laravel/laravel reiserva
```

## Criando a reserva simplificada

Trabalharemos com *TDD*, primeiro criamos um teste falho, fazemos ele passar, melhoramos e repetimos.

Crie o teste com `php artisan make:test ReservaServiceTest`, edite o arquivo alterando o nome da função para `testReservaAmbiente`. Vamos testar que dado um usuário (`User`) e um ambiente, podemos criar uma reserva através da classe `ReservaService`.

Crie as outras classes que usaremos:

- `ReservaService` como `app/Services/ReservaService.test`
- As models com `php arisan make:model Reserva` `php arisan make:model Ambiente`

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

<!-- migration -->
<!-- explicar centralização de regra de negocio na service -->
<!-- diagrama de arquitetura proposta rota -] controller -] service-->

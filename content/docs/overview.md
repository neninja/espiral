# Arquitetura de dependências

Explicando como será o fluxo de dependência, de onde sai a informação e até onde ela chega e como retorna. No decorrer do desenvolvimento vai ficar mais claro, mas em resumo as *controllers* (classes específicas) receberão a requisição e vão acionar *services* para fazer executar a regra de negócio. Será feito dessa forma para reaproveitar a partir de outras entradas, como comandos ou *cronjobs*.

{{< mermaid >}}
graph LR
    url[Acessar site] --> Controller --> Service[Classe serviço]
    Cron --> Job --> Service
    Command --> Service
    Service --> Service
    Controller --> View
    Controller --> Json
{{< /mermaid >}}

# Testes

## TDD

Aproveitando essa organização de arquivos, orientaremos o desenvolvimento testes automatizados que o [Laravel auxilia](https://laravel.com/docs/11.x/testing). O fluxo sempre será de 1) *red* para 2) green e, por fim, 3) blue. Caso o teste seja modificado recomeça.

{{< mermaid >}}
graph TD
    style RED fill:LightCoral
    style GREEN fill:LightGreen
    style BLUE fill:LightSkyBlue

    subgraph RED
        r1[Criar teste]
        r2[Escrever asserts]
        r3[Rodar o teste]
        r4[Confirmar a falha]
        r1 --> r2 --> r3 --> r4
    end

    subgraph GREEN
        g1[Criar classe/método\nse necessário]
        g2[Retornar literalmente\no esperado pelo teste]
        g3[Rodar o teste]
        g4[Confirmar o sucesso]
        g1 --> g2 --> g3 --> g4
    end

    subgraph BLUE
        b1[Refatorar o método\ntestado para funcionar\ncomo deve ser implementado]
        b2[Rodar o teste]
        b3[Confirmar o sucesso]
        b1 --> b2 --> b3
    end

    r4 --> g1
    g4 --> b1
{{< /mermaid >}}

# Casos de uso

- Usuários devem poder logar/deslogar
- Usuário administrador deve poder cadastrar outros usuários como funcionários
- Administrador e funcionário devem poder cadastrar usuários como clientes
- Administrador e funcionario devem poder cadastrar um ambiente
- Cliente deve poder reservar um ambiente

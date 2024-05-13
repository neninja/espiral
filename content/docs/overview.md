# Arquitetura de dependências
# Testes

## TDD
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
    b3 -- Novo teste --> r1
{{< /mermaid >}}
# Casos de uso

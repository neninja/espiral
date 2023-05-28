# Introdução

## Objetivo e escopo

A ideia do projeto nasceu de dois interesses:

- Trazer pessoas para a área
- Indicar um material livre, gratuito e atualizado

> Caso tenha interesse em contribuir, seja acrescentando/melhorando/removendo assuntos quanto corrigindo erros de português, acesse o [projeto](https://github.com/nenitf/intro-dev-web)

Mantido com uma linguagem informal, o conteúdo a seguir pretende ensinar de maneira simples assuntos introdutórios para entrar na área de desenvolvimento web. Abordaremos:

- HTML, CSS e Javascript
- Algoritmos com Javascript
- Git
- React
- Laravel
- SQL

Os assuntos serão pouco aprofundados, a proposta desse material é explicar o essencial para que você (leitor) estude tópicos mais avançados por conta própria ou saiba reconhecer cursos/livros interessantes. Não prometo que ao final da leitura você estará apto para a primeira vaga, pois acredito que o ideal é desenvolver e expor projetos pequenos no [Github](https://github.com) e [Linkedin](https://www.linkedin.com).

**Após** dominar os assuntos presentes nesse material, recomendo o estudo de:

- Testes automatizados com *TDD*
- Docker

## Dicas iniciais

- Nunca é tarde para começar
- Desenvolvimento web não é fácil, mas também não é tão dificil para conseguir entrar na área e ser um profissional mediano
- Mantenha a paciência, é muita ferramenta e conceito para aprender, não exija tanto de si
- O mais importante é ter um progresso gradual, assim como um quebra cabeça, aos poucos tudo vai fazer mais sentido
- Acredito que a única qualidade essencial para se tornar um desenvolvedor seja a resiliência: corriqueiramente haverá frustração com código, porém não deve deixar isso te desestabilizar
- Dúvidas e sugestões são muito bem vindas em formato de [issue](https://github.com/nenitf/intro-dev-web/issues)

## FAQ

1. Preciso fazer faculdade?

> Não, algumas empresas maiores podem exigir, porém é muito fácil de encontrar vagas que não **se importam** com isso. Vale mais a pena focar em conseguir a primeira oportunidade e depois cogitar ir para uma faculdade.

1. Preciso estudar inglês?

> Não, mas certamente ajudaria para pesquisar mais tópicos e conteúdos mais especializados.

1. Como devo ler o material?

> Recomendo ler 3 vezes: 1) uma primeira leitura rápida para alinhar a expectativa do que será abordado, 2) mais calma fazendo anotações e praticando quando fizer sentido e 3) rápida para entender os conceitos abordados e praticados.

1. Como deve ser o computador?

> Acredito que no mínimo um processador i3 e 4gb de RAM.

1. Qual editor de texto usar?

> [Visual Studio Code](https://code.visualstudio.com/), não confundir com Visual Studio. Vai ser a ferramenta que usaremos para escrever nos arquivos.

## O que é a web

O desenvolvimento web é uma área específica dentro da área de desenvolvimento de *software* (programa). De maneira simplificada, a web é o acesso a sites/sistemas online utilizando o protocolo *HTTP*, onde que é feita uma requisição a um servidor e é retornada uma resposta (podendo ser em HTML, JSON ou outros formatos).

![Fluxo de web](content/livro1_nivelamento/1_introducao/workflow-web.gv.svg ){ width=50% }\

Se tratando de desenvolvimento web existem duas ramificações:

- ***front-end***: foca no lado cliente, podendo ser um aplicativo ou um site que faz a requisição para outro site. Se responsabiliza com a interface e definição de acesso às funcionalidades para o usuário final;
- ***back-end***: foca no lado do servidor. Se responsabiliza com a regras de negócio e acesso ao banco de dados;

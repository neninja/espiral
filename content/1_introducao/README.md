# Introdução

## Objetivo e escopo

A ideia do projeto nasceu de dois interesses:

- Trazer pessoas para a área
- Indicar um material livre, gratuito e atualizado

> Caso tenha interesse em contribuir, seja acrescentando/melhorando/removendo assuntos quanto corrigindo erros de português, acesse o [projeto](https://github.com/nenitf/intro-dev-web)

Mantido com uma linguagem informal, o conteúdo a seguir pretende ensinar de maneira simples assuntos introdutórios para entrar na área de desenvolvimento web. Para facilitar o roteiro de estudos é preciso delimitar o escopo, pois, dado o objetivo, quanto mais amplo menos específico. Assuntos que serão abordados:

- HTML, CSS e Javascript
- Algoritmos com Javascript
- Git
- React
- Lumen
- SQL

Os assuntos serão pouco aprofundados, a proposta desse material é explicar o essencial para que você (leitor) estude tópicos mais avançados por conta própria ou saiba reconhecer cursos/livros interessantes. Não prometo que ao final do material você estará apto para a primeira vaga, pois acredito que após a leitura o ideal é desenvolver e expor projetos pequenos no [Github](https://github.com) e [Linkedin](https://www.linkedin.com).

**Após** dominar os assuntos presentes nesse material, recomendo o estudo de:

- Testes automatizados com *TDD*
- Docker

## Dicas iniciais

- Desenvolvimento web não é fácil, mas também não é um absurdo de dificil para conseguir entrar na área e ser um profissional mediano;
- Mantenha a paciência e não entre em crise, é muita ferramenta e conceito para aprender, não exija tanto de si;
- O mais importante é ter um progresso gradual, assim como um quebra cabeça, aos poucos tudo vai fazer mais sentido;
- Acredito que a única qualidade essencial para se tornar um desenvolvedor seja a resiliência: corriqueiramente haverá frustração com código, porém não deve deixar isso te desestabilizar;
- Dúvidas e sugestões são muito bem vindas em formato de [issue](https://github.com/nenitf/intro-dev-web/issues);

## O que é a web

O desenvolvimento web é uma área específica dentro da área de desenvolvimento de *software* (programa). De maneira simplificada, a web é o acesso a sites/sistemas online utilizando o protocolo *HTTP*, onde que é feita uma requisição a um servidor e é retornada uma resposta (podendo ser em HTML, JSON ou outros formatos).

![Fluxo de web](content/1_introducao/workflow-web.gv.svg ){ width=50% }\

Se tratando de desenvolvimento web existem duas ramificações:

- ***front-end***: foca no lado cliente, podendo ser um aplicativo ou um site que faz a requisição para outro site. Se responsabiliza com a interface e definição de acesso às funcionalidades para o usuário final;
- ***back-end***: foca no lado do servidor. Se responsabiliza com a regras de negócio e acesso ao banco de dados;

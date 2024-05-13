# O que é a web

O desenvolvimento web é uma área específica dentro da área de desenvolvimento de *software* (programa). De maneira simplificada, a web é o acesso a sites/sistemas online utilizando o protocolo *HTTP*, onde que é feita uma requisição a um servidor e é retornada uma resposta (podendo ser em HTML, JSON ou outros formatos).

Se tratando de desenvolvimento web existem duas ramificações:

{{< mermaid >}}
graph LR
    Cliente -- 1) requisição --> Servidor;
    Servidor -- 2) resposta --> Cliente;
{{< /mermaid >}}

- ***front-end***: foca no lado cliente, podendo ser um aplicativo ou um site que faz a requisição para outro site. Se responsabiliza com a interface e definição de acesso às funcionalidades para o usuário final;
- ***back-end***: foca no lado do servidor. Se responsabiliza com a regras de negócio e acesso ao banco de dados;

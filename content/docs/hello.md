# Criando o projeto

Trabalharemos com a linguagem de programação [PHP](https://www.php.net/) com o framework [Laravel](https://laravel.com/docs/11.x#meet-laravel), usado para nos dar todo um arcabouço para trabalhar com o desenvolvimento web.

Como instruído pela [documentação oficial do Laravel](https://laravel.com/docs/11.x#docker-installation-using-sail), abra um terminal acesse a pasta raiz onde pretende salvar seus projetos no computador e execute `curl -s https://laravel.build/quartas?with=pgsql,redis,mailpit | bash`. Quando finalizar o processo de instalação dentro do Docker, acesse com `cd quartas && ./vendor/bin/sail up`. Abra um outro terminal e acesse o projeto para rodar o comando `./vendor/bin/sail artisan migrate`, isso irá popular banco de dados com as tabelas iniciais necessárias. Acesse no navegador [`localhost`](http://localhost) para ver a tela inicial do projeto.

{{< hint info >}}
**Comandos artisan**  
- Contextualizando: artisan é um executável que vem junto ocm o laravel como ferramenta para auxiliar duanre o desenvolvimento. Porém como não instalamos nada diretamente (estamos usando Sail, que é uma camada para o Docker), precisamos invocar dentro do container.
- Para Ver comandos disponíveis, execute `./vendor/bin/sail artisan help` e `./vendor/bin/sail artisan list`.
- Junto com o Sail vem um atalho do artisan como *art*, simplificando comandos para por exemplo: `,/vendor/bin/sail art list`
- Caso saiba configurar um atalho, faça para não precisar ficar digitando "*./vendor/bin/...*". No decorrer do material utilizarei somente `sail` por já tenho um atalho/alias no terminal.
{{< /hint >}}

# Utilizando Git

Simplificando a utilização de Git, ele é basicamente um gerenciador de versões do seu projeto. Com ele iremos especificar "momentos" e daremos nome as alterações em "commites" e depois enviaremos esse historico para o Github, cujo irá servir como "backup online" do projeto com todos os arquivos versionados pelo git.

O Laravel não inicia o git, portanto acesse a pasta e execute `git init`. Em seguida `git add .` para adicionar todos os arquivos para um commit e, por fim, `git commit -m "primeiro commit"`. Agora [crie um repositório](https://github.com/new), dê um nome e confirme. Copie o comando `git remote add origin <url-do-projeto>` sugerido e cole no terminal aberto na pasta. Envie para o repositório com `git push origin HEAD`.

# Hello

Abra o editor de texto no projeto e edite o arquivo `routes/web.php` para adicionar um `return hello;` logo abaixo da definição da rota `/`, como o *diff* abaixo sugere:

```diff
@@ -3,5 +3,6 @@
 use Illuminate\Support\Facades\Route;
 
 Route::get('/', function () {
+    return 'hello';
     return view('welcome');
 });
```

{{< expand "routes/web.php" >}}
O arquivo ficará dessa maneira:

```php
<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return 'hello';
    return view('welcome');
});
```
{{< /expand >}}

Atualize o navegador e confirme a exibição para qualquer coisa retornada.

{{< hint info >}}
**O que é diff?**  
Diff é uma forma de exibir a diferença entre dois arquivos, com adições `+` e remoções `-` de linhas. Durante o material será usado constantemente quando for sugerida alguma mudança, para facilitar o entendimento e dispensar a utilização inteira do arquivo
{{< /hint >}}

{{< hint info >}}
**Tema de casa**  
Leia a documentação inicial do *Getting started* do Laravel
{{< /hint >}}

{{< hint info >}}
**Lembrete de Commit**  
```sh
git add .
git commit -m "retorna hello world"
```
{{< /hint >}}

# HTML + CSS + Javascript

Uma página web normalmente vai ter um conteúdo, estilização e interação (respectivamente: *HTML*,  *CSS* e *Javascript*). O navegador/browser lê os arquivos recebidos do back-end (`.html`, `.css` e `.js`) e renderiza de acordo. Porém com <kbd>ctrl</kbd><kbd>shift</kbd><kbd>i</kbd> podemos ver como eles realmente são: texto!

## HTML

### Propósito

Imagine o seuginte cenário: O navegador recebe um arquivo contendo todo o conteúdo do site, como ele sabe o que é título, link, lista e etc? Afinal, é uma informação necessária para delimitar a informação, exemplo:

```txt
Lista de compras
Mercado
Farinha
Leite
Ovos
```

Pode ser lido como

```txt
Lista de compras <- titulo
Mercado          <- item da lista
Farinha          <- item da lista
Leite            <- item da lista
Ovos             <- item da lista
```

ou

```txt
Lista de compras <- titulo
Mercado          <- subtitulo
Farinha          <- item da lista
Leite            <- item da lista
Ovos             <- item da lista
```

### Tags

Para isso existem as tags, cujo explicitam a intenção de um grupo de texto. O exemplo anterior ficaria da seguinte forma:

```html
<h1>Lista de compras</h1>
<h2>Mercado</h2>
<ul>
<li>Farinha</li>
<li>Leite</li>
<li>Ovos</li>
</ul>
```

Tags abrem, envolvem e fecham da seguinte maneira: `<nome>conteudo</nome>`

> **Sua vez**: Crie um arquivo chamado `teste.html`, e abra de duas maneiras diferentes: 1) com seu editor de texto e 2) com o navegador. Escreva a lista de compras pelo editor de texto e visualize as alterações no navegador! Lembre de atualizar a página do navegador com <kbd>F5</kbd> a cada mudança.

Todas tags podem possuir classes e **um** id. Esses artíficios não são visuais, eles servem para registrar de alguma forma essa tag para poder ser utilizada mais facilmente pelo CSS e Javascript.

```html
<h1 class="titulo">Lista de compras</h1>
<h2 id="subtitulo">Mercado</h2>
<ul>
<li class="item-novo importante">Farinha</li>
<li class="">Leite</li>
<li class="importante">Ovos</li>
</ul>
```

## CSS

Não basta especificar um título, link etc, precisamos estilizá-lo também. Tamanho da fonte, cor, alinhamento e outras propriedades são configuráveis.

Essas estilizações são feitas com um arquivo `.css`, para mudar a cor do título podemos fazer o seguinte:

```css
h1 {
    color: blue;
}
```

Especificamos com um *seletor* e em seguida atribuimos alguma de suas propriedades. Os seletores mais comuns são: nome da tag, classe ou id.

```css
.titulo { /* classe */
    color: blue;
}
```

```css
#subtitulo { /* id */
    color: blue;
}
```

Para utilizar as definições feitas pelo CSS precisamos importar elas no nosso HTML precisamos alterá-lo com:

```html
 <head>
  <link rel="stylesheet" href="./nome-do-arquivo.css">
</head> 
```

## Javascript

Com conteúdo estruturado e estilizado falta adicionar interação ao site.

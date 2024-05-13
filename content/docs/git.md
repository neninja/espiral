# Fluxo básico

{{< mermaid >}}
graph TB
    dev[cria/modifica/deleta arquivos]

    init[git init]
    clone[git clone url]
    add[git add]
    commit[git commit -m Mensagem de commit]
    push[git push origin HEAD]

    init --> dev
    clone --> dev

    dev --> add --> commit

    commit --> dev
    commit --> push --> dev
{{< /mermaid >}}

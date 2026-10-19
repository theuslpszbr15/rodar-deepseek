# rodar-deepseek

Rode o [DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness) no Windows com um único comando:

```
rodar deepseek
```

## Instalação (1 passo)

Abra o **Prompt de Comando** ou o **PowerShell**, cole a linha abaixo e tecle Enter:

```
powershell -NoProfile -Command "irm https://raw.githubusercontent.com/theuslpszbr15/rodar-deepseek/main/install.ps1 | iex"
```

Ele instala o Node.js se faltar (via `winget`) e registra o comando `rodar`.

## Uso

1. Abra um **novo** terminal e digite `rodar deepseek`.
2. O navegador abre sozinho em `http://127.0.0.1:3080`.
3. Em **Settings > Models**, cole sua chave de API (ex.: criada em [platform.deepseek.com](https://platform.deepseek.com)).

Para parar, use `Ctrl+C` no terminal. Opções do `dsh web` passam direto: `rodar deepseek --no-open`.

## Abrir no celular

Com o celular no **mesmo Wi-Fi** do PC:

```
rodar deepseek --celular
```

Abra no celular a URL com `?token=...` impressa no terminal. Se o Windows perguntar sobre o firewall, permita em redes privadas. A conexão é HTTP sem criptografia: use só em Wi-Fi de confiança e nunca exponha a porta na internet.

## O que o script faz

- Usa o pacote oficial `@deepseek-ai/dsh` via `npx`, sem copiar nem alterar o código do projeto.
- Detecta o proxy do sistema e o repassa ao Node, que não o usa sozinho. Para forçar um, defina `HTTPS_PROXY` antes.
- Usa `npx.cmd`, evitando o bloqueio de scripts do PowerShell.
- Avisa se a porta 3080 já estiver em uso.

## Atualizar

Rode de novo a linha de instalação.

## Licença

[MIT](LICENSE)

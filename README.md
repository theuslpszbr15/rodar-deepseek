# rodar-deepseek

Atalho para subir o [DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness) (`dsh`, licença MIT) com um comando:

```
rodar deepseek
```

Não copia nem modifica o código do projeto: usa o pacote oficial `@deepseek-ai/dsh` via `npx`, então sempre pega a versão publicada.

## Requisitos
- Windows e Node.js 22.19+ ou 24+. Nada mais para instalar.

## Instalação
```
git clone <url-deste-repo>
cd rodar-deepseek
install.cmd
```
Abra um novo terminal e rode `rodar deepseek`. O navegador abre sozinho em `http://127.0.0.1:3080`.

## O que o script faz
- Detecta o proxy do sistema (PAC/WinHTTP) e o repassa ao Node, que não o usa sozinho. Para forçar um, defina `HTTPS_PROXY` antes.
- Roda a partir da pasta do usuário e usa `npx.cmd`, evitando o bloqueio de scripts do PowerShell.
- Repassa opções ao `dsh web`, por exemplo `rodar deepseek --no-open`.

## Dicas
- Porta 3080 em uso: já há uma instância rodando. Feche-a ou use a URL com token que ela imprimiu.
- A chave de API (ex.: `platform.deepseek.com`) é configurada na interface, em Settings > Models. Ela não fica neste repositório.

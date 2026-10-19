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

Use o Harness no celular, sem instalar nada extra.

**Antes de começar:** o PC e o celular precisam estar no **mesmo Wi-Fi** (de casa, por exemplo), e o PC deve ficar ligado.

1. No PC, feche o Harness se ele já estiver aberto (`Ctrl+C` no terminal).
2. Abra um terminal e digite:
   ```
   rodar deepseek --celular
   ```
3. Se o Windows perguntar sobre o **firewall**, clique em **Permitir acesso** (em redes privadas).
4. Espere aparecer um **QR code** no terminal (na primeira vez pode levar alguns segundos a mais).
5. No celular, abra a **câmera**, aponte para o QR code e toque no link que aparecer.
6. Pronto. Para encerrar, use `Ctrl+C` no terminal do PC.

O QR code já leva o endereço com o token, então não precisa digitar nada. Se a câmera não ler, o endereço também aparece escrito no terminal (`http://...?token=...`) e dá para digitá-lo no navegador do celular.

**Não abre no celular?**
- Confira se os dois estão no mesmo Wi-Fi (não use dados móveis nem Wi-Fi de visitantes).
- Redes de empresa e de visitantes costumam bloquear a comunicação entre aparelhos. Nesse caso, teste numa rede doméstica.
- O token muda toda vez que você inicia. Use sempre o endereço novo.

**Segurança:** a conexão é HTTP, sem criptografia. Use só em Wi-Fi de confiança e nunca libere a porta 3080 no roteador nem na internet: o Harness executa comandos no seu computador.

## O que o script faz

- Usa o pacote oficial `@deepseek-ai/dsh` via `npx`, sem copiar nem alterar o código do projeto.
- Detecta o proxy do sistema e o repassa ao Node, que não o usa sozinho. Para forçar um, defina `HTTPS_PROXY` antes.
- Usa `npx.cmd`, evitando o bloqueio de scripts do PowerShell.
- Avisa se a porta 3080 já estiver em uso.

## Atualizar

Rode de novo a linha de instalação.

## Licença

[MIT](LICENSE)

# Docker Developer Environment bootstrapper

Este é um repositório modelo para você criar seus ambientes de desenvolvimento
totalmente baseados em Docker.

A ideia é que, uma vez que você tenha o código fonte do projeto, não precise
de nada mais além do _Docker_ e _Docker Compose_ no seu ambiente para começar
a desenvolver.

## Características

* Todos os scripts de bootstrap também são executados no próprio Docker
* O script `boostrap.[cmd|sh]` se encarrega de criar e executar o container
* O script `boostrap.[cmd|sh]` também encarrega de limpar sua bagunça

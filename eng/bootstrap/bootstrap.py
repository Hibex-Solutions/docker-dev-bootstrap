# Copyright (c) Erlimar Silva Campos. All rights reserved.
# This file is a part of TheCleanArch.
# Licensed under the Apache version 2.0: LICENSE file.

import click
from pathlib import Path


@click.command()
@click.option('--cleanup-bootstrap',
              help='Limpa recursos bootstrap do ambiente de desenvolvimento',
              default=False)
def hello(cleanup_bootstrap):
    """Utilitário de projeto"""

    if (cleanup_bootstrap):
        click.echo(
            'Essa ação nunca deve ser executada diretamente pelo container,')
        click.echo(
            'pois será interceptada pelos scripts de proxy antes da execução.')

    home_path = Path.home()

    click.echo(f"HOME: {home_path}")

    f = open(f"{home_path}/bootstrap.txt", "w")
    f.write("Este conteúdo foi gravado de dentro do container")
    f.write("porém é exibido na raiz do projeto.")
    f.close()


if __name__ == '__main__':
    hello()

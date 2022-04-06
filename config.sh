#!/bin/sh

pushd bundle/LanguageClient
bash install.sh
popd

# Install https://github.com/python-lsp/python-lsp-server and add to the PATH
# Install https://github.com/OmniSharp/omnisharp-roslyn and add to the PATH

cd bundle/LanguageClient

& ./install.ps1
pip install "python-lsp-server[all]"
cinst -y omnisharp

cd ../../


# Install https://github.com/python-lsp/python-lsp-server and add to the PATH
# Install https://github.com/OmniSharp/omnisharp-roslyn and add to the PATH

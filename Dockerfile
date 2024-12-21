{
  "name": "Ubuntu with Chrome Remote Desktop",
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu-22.04",
  "build": {
    "dockerfile": "../Dockerfile"
  },
    "customizations": {
    "vscode": {
      "extensions": [
        "ms-vscode-remote.remote-containers"
      ]
    }
  }
}

#!/bin/bash

# Definindo variáveis
BACKUP_DIR="/home/ubuntu/minecraft_backups"  # Pasta de backup
MINECRAFT_DIR="/home/ubuntu/CGC_SERVER"  # Pasta onde o servidor Minecraft está localizado
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')  # Data e hora para o nome do backup
BACKUP_FILE="minecraft_backup_$TIMESTAMP.tar.gz"  # Nome do arquivo de backup

# Configurar usuário do Git (caso não esteja configurado globalmente)
GIT_USER_NAME="pedrooaj"  # Substitua com seu nome
GIT_USER_EMAIL="pedroantonio5735@gmail.com"  # Substitua com seu e-mail

git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

# Criar a pasta de backup se não existir
mkdir -p "$BACKUP_DIR"

# Criar o backup do servidor Minecraft
echo "Criando backup do servidor Minecraft..."
tar -czf "$BACKUP_DIR/$BACKUP_FILE" -C "$MINECRAFT_DIR" .

# Verificar se o backup foi criado com sucesso
if [ $? -eq 0 ]; then
  echo "Backup criado com sucesso em $BACKUP_DIR/$BACKUP_FILE"
else
  echo "Erro ao criar o backup."
  exit 1
fi

# Navegar para a pasta de backup
cd "$BACKUP_DIR" || exit

# Inicializar o repositório Git (se não existir)
if [ ! -d ".git" ]; then
  echo "Inicializando repositório Git..."
  git init
  git remote add origin git@github.com:Pedrooaj/CGC_SERVER.git  # Substitua com o URL do seu repositório
  git branch -M main
fi

# Adicionar o novo backup ao repositório
git add "$BACKUP_FILE"

# Commit e push do novo backup
echo "Realizando commit e push para o GitHub..."
git commit -m "Backup automático do Minecraft - $TIMESTAMP"
git push 

# Verificar se o push foi

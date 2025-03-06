
MINECRAFT_DIR="/home/ubuntu/CGC_SERVER"  # Pasta onde o servidor Minecraft está localizado
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')  # Data e hora para o nome do backup
# Configurar usuário do Git (caso não esteja configurado globalmente)
GIT_USER_NAME="pedrooaj"  # Substitua com seu nome
GIT_USER_EMAIL="pedroantonio5735@gmail.com"  # Substitua com seu e-mail

git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

# Commit e push do novo backup
echo "Realizando commit e push para o GitHub..."
git add "$MINECRAFT_DIR/."
git commit -m "Backup automático do Minecraft - $TIMESTAMP"
git push -f

# Verificar se o push foi bem-sucedido
if [ $? -eq 0 ]; then
  echo "Backup enviado para o GitHub com sucesso!"
else
  echo "Erro ao enviar o backup para o GitHub."
  exit 1
fi

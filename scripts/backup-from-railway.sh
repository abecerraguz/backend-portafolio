#!/bin/bash

# ================================
# 📦 Script: backup-from-railway.sh
# Descripción: Exporta la base de datos de producción (Railway) a un archivo local
# ================================

# 🎯 Configura tus datos de Railway
RAILWAY_DB_HOST="turntable.proxy.rlwy.net"
RAILWAY_DB_PORT="13153"
RAILWAY_DB_NAME="railway"
RAILWAY_DB_USER="postgres"
RAILWAY_DB_PASSWORD="ntflkiGoEPBJUFQBacZsAAXsjNgCzTxw"


# 📁 Carpeta y nombre de archivo
BACKUP_DIR="./backups"
BACKUP_FILE="$BACKUP_DIR/railway_backup_$(date +'%Y-%m-%d_%H-%M-%S').sql"

# Crear carpeta si no existe
mkdir -p "$BACKUP_DIR"

# Exportar la variable para no pedir password
export PGPASSWORD=$RAILWAY_DB_PASSWORD

echo "📦 Iniciando backup de la base de datos Railway..."
pg_dump -h $RAILWAY_DB_HOST -U $RAILWAY_DB_USER -p $RAILWAY_DB_PORT -d $RAILWAY_DB_NAME -F p -f "$BACKUP_FILE"

if [ $? -eq 0 ]; then
  echo "✅ Backup realizado con éxito: $BACKUP_FILE"
else
  echo "❌ Ocurrió un error durante el backup"
fi

# Limpiar variable sensible
unset PGPASSWORD

#!/bin/bash

# ================================
# 🚀 Script: deploy-db-to-railway.sh
# Descripción: Exporta la base local y la importa en Railway
# ================================

# 🛠️ Configura tus datos locales
LOCAL_DB_NAME="railway"
LOCAL_DB_USER="postgres"
LOCAL_DB_HOST="localhost"
LOCAL_DB_PORT="5432"

# 🛠️ Configura tus datos de Railway
RAILWAY_DB_HOST="turntable.proxy.rlwy.net"
RAILWAY_DB_PORT="13153"
RAILWAY_DB_NAME="railway"
RAILWAY_DB_USER="postgres"
RAILWAY_DB_PASSWORD="ntflkiGoEPBJUFQBacZsAAXsjNgCzTxw"
DUMP_FILE="strapi_backup.sql"

# ================================
echo "📦 1. Generando backup desde base de datos local..."

# Dump de estructura + datos
pg_dump -h $LOCAL_DB_HOST -U $LOCAL_DB_USER -p $LOCAL_DB_PORT -d $LOCAL_DB_NAME -F p -f $DUMP_FILE

if [ $? -ne 0 ]; then
  echo "❌ Error al generar el dump. Abortando."
  exit 1
fi

# Verificar si hay contenido (al menos un INSERT)
if grep -q "INSERT INTO" "$DUMP_FILE"; then
  echo "✅ Dump contiene datos. Continuamos..."
else
  echo "⚠️ El dump no contiene datos. Solo estructura. Aborting para evitar restauración vacía."
  exit 1
fi

echo "🚀 2. Restaurando base de datos en Railway..."

export PGPASSWORD=$RAILWAY_DB_PASSWORD

psql -h $RAILWAY_DB_HOST -U $RAILWAY_DB_USER -p $RAILWAY_DB_PORT -d $RAILWAY_DB_NAME -f $DUMP_FILE

if [ $? -ne 0 ]; then
  echo "❌ Error al importar en Railway. Verifica credenciales o el archivo dump."
  exit 1
fi

echo "🔍 3. Verificando contenido en tabla 'posts'..."

# Consulta para contar la cantidad de posts
POST_COUNT=$(psql -h $RAILWAY_DB_HOST -U $RAILWAY_DB_USER -p $RAILWAY_DB_PORT -d $RAILWAY_DB_NAME -t -c "SELECT COUNT(*) FROM posts;" | xargs)

echo "📊 Resultado: Se encontraron $POST_COUNT posts en la base Railway"

# Limpieza
unset PGPASSWORD
# Opcional: eliminar archivo dump
# rm $DUMP_FILE

echo "🎉 ¡Sincronización completada!"

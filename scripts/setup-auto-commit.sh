#!/bin/bash

# ¿QUÉ? Script para configurar commits automáticos cada 5 minutos via crontab
# ¿POR QUÉ? Los aprendices necesitan automatizar el guardado en Codespaces
# ¿PARA QUÉ? Optimizar el uso del Free Tier y prevenir pérdida de trabajo

# ¿QUÉ? Definimos variables de configuración
# ¿POR QUÉ? Necesitamos paths absolutos y configuración clara
# ¿PARA QUÉ? Asegurar que el crontab funcione correctamente
SCRIPT_DIR="/workspaces/bc-codespaces/scripts"
AUTO_COMMIT_SCRIPT="$SCRIPT_DIR/auto-commit.sh"
LOG_FILE="/workspaces/bc-codespaces/logs/auto-commit.log"

echo "🚀 Configurando commits automáticos para GitHub Codespaces..."

# ¿QUÉ? Verificamos que el script de auto-commit existe
# ¿POR QUÉ? No podemos configurar crontab sin el script principal
# ¿PARA QUÉ? Evitar errores de configuración
if [ ! -f "$AUTO_COMMIT_SCRIPT" ]; then
    echo "❌ Error: Script auto-commit.sh no encontrado en $AUTO_COMMIT_SCRIPT"
    exit 1
fi

# ¿QUÉ? Creamos el directorio de logs si no existe
# ¿POR QUÉ? Necesitamos un lugar para almacenar los logs del cron
# ¿PARA QUÉ? Facilitar el debugging y monitoreo
mkdir -p "$(dirname "$LOG_FILE")"

# ¿QUÉ? Verificamos si ya existe una tarea de auto-commit
# ¿POR QUÉ? Evitamos duplicar entradas en el crontab
# ¿PARA QUÉ? Mantener un crontab limpio y funcional
if crontab -l 2>/dev/null | grep -q "auto-commit.sh"; then
    echo "⚠️  Auto-commit ya configurado. Removiendo configuración anterior..."
    crontab -l 2>/dev/null | grep -v "auto-commit.sh" | crontab -
fi

# ¿QUÉ? Agregamos la nueva tarea de cron para commits cada 5 minutos
# ¿POR QUÉ? Necesitamos persistir el trabajo regularmente
# ¿PARA QUÉ? Optimizar el uso de Codespaces y evitar pérdida de datos
echo "📝 Agregando tarea de cron para commits cada 5 minutos..."

# ¿QUÉ? Creamos la entrada de crontab con logging
# ¿POR QUÉ? Necesitamos monitorear que los commits funcionen correctamente
# ¿PARA QUÉ? Facilitar troubleshooting y verificar funcionamiento
CRON_ENTRY="*/5 * * * * /bin/bash $AUTO_COMMIT_SCRIPT >> $LOG_FILE 2>&1"

# ¿QUÉ? Agregamos la entrada al crontab existente
# ¿POR QUÉ? Cron requiere que agreguemos la tarea al sistema
# ¿PARA QUÉ? Automatizar los commits cada 5 minutos
(crontab -l 2>/dev/null; echo "$CRON_ENTRY") | crontab -

# ¿QUÉ? Verificamos que el crontab se configuró correctamente
# ¿POR QUÉ? Necesitamos confirmar que la tarea está activa
# ¿PARA QUÉ? Asegurar que los commits automáticos funcionarán
if crontab -l 2>/dev/null | grep -q "auto-commit.sh"; then
    echo "✅ Auto-commit configurado exitosamente!"
    echo ""
    echo "📋 Configuración actual del crontab:"
    crontab -l | grep "auto-commit.sh"
    echo ""
    echo "📍 Detalles:"
    echo "   • Frecuencia: Cada 5 minutos"
    echo "   • Script: $AUTO_COMMIT_SCRIPT"
    echo "   • Logs: $LOG_FILE"
    echo ""
    echo "🔍 Para monitorear los commits automáticos:"
    echo "   tail -f $LOG_FILE"
    echo ""
    echo "🛑 Para detener los commits automáticos:"
    echo "   $SCRIPT_DIR/stop-auto-commit.sh"
else
    echo "❌ Error: No se pudo configurar el auto-commit"
    exit 1
fi

# ¿QUÉ? Creamos una entrada inicial en el log
# ¿POR QUÉ? Necesitamos documentar cuándo se activó el sistema
# ¿PARA QUÉ? Facilitar el seguimiento y debugging
echo "$(date): Auto-commit system started - commits every 5 minutes" >> "$LOG_FILE"

echo "🎉 ¡Configuración completada! Los commits automáticos están activos."

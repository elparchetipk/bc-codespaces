#!/bin/bash

# ¿QUÉ? Script para detener los commits automáticos
# ¿POR QUÉ? Los aprendices necesitan poder desactivar los commits automáticos
# ¿PARA QUÉ? Dar control sobre cuándo usar o no la funcionalidad

echo "🛑 Deteniendo commits automáticos..."

# ¿QUÉ? Verificamos si existe configuración de auto-commit
# ¿POR QUÉ? No podemos remover algo que no existe
# ¿PARA QUÉ? Evitar errores y dar feedback claro al usuario
if ! crontab -l 2>/dev/null | grep -q "auto-commit.sh"; then
    echo "ℹ️  No hay commits automáticos configurados."
    exit 0
fi

# ¿QUÉ? Removemos la entrada de auto-commit del crontab
# ¿POR QUÉ? Necesitamos desactivar la tarea programada
# ¿PARA QUÉ? Detener los commits automáticos completamente
crontab -l 2>/dev/null | grep -v "auto-commit.sh" | crontab -

# ¿QUÉ? Verificamos que la tarea fue removida exitosamente
# ¿POR QUÉ? Necesitamos confirmar que los commits se detuvieron
# ¿PARA QUÉ? Dar feedback claro sobre el estado del sistema
if ! crontab -l 2>/dev/null | grep -q "auto-commit.sh"; then
    echo "✅ Commits automáticos detenidos exitosamente!"
    echo ""
    echo "📍 Para reactivar los commits automáticos:"
    echo "   ./scripts/setup-auto-commit.sh"
else
    echo "❌ Error: No se pudo detener los commits automáticos"
    exit 1
fi

# ¿QUÉ? Agregamos una entrada final al log
# ¿POR QUÉ? Necesitamos documentar cuándo se desactivó el sistema
# ¿PARA QUÉ? Mantener un registro completo de la actividad
LOG_FILE="/workspaces/bc-codespaces/logs/auto-commit.log"
if [ -f "$LOG_FILE" ]; then
    echo "$(date): Auto-commit system stopped by user" >> "$LOG_FILE"
fi

echo "🎉 ¡Sistema de commits automáticos desactivado!"

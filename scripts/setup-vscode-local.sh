#!/bin/bash

# ¿QUÉ? Script para aplicar configuraciones de VS Code local optimizadas
# ¿POR QUÉ? Automatizar la configuración para una sola pestaña activa
# ¿PARA QUÉ? Replicar el ambiente optimizado de Codespaces en VS Code local

echo "🔧 Aplicando configuraciones optimizadas de VS Code..."

# ¿QUÉ? Verificar si VS Code está instalado
# ¿POR QUÉ? Necesitamos VS Code para aplicar las configuraciones
# ¿PARA QUÉ? Evitar errores si no está instalado
if ! command -v code &> /dev/null; then
    echo "❌ VS Code no está instalado o no está en el PATH"
    echo "💡 Instala VS Code desde: https://code.visualstudio.com/"
    exit 1
fi

# ¿QUÉ? Recargar la ventana de VS Code para aplicar configuraciones
# ¿POR QUÉ? Las configuraciones del workspace necesitan recarga para aplicarse
# ¿PARA QUÉ? Activar inmediatamente las configuraciones de una sola pestaña
echo "🔄 Recargando VS Code para aplicar configuraciones..."

# Recargar la ventana actual de VS Code
code --command "workbench.action.reloadWindow"

echo "✅ Configuraciones aplicadas:"
echo "   - Una sola pestaña activa habilitada"
echo "   - Optimizaciones de rendimiento aplicadas"
echo "   - Configuraciones de Python establecidas"
echo "   - Extensiones recomendadas disponibles"

echo ""
echo "📝 IMPORTANTE:"
echo "   - Reinicia VS Code si las pestañas múltiples persisten"
echo "   - Las configuraciones están en .vscode/settings.json"
echo "   - Instala las extensiones recomendadas cuando se solicite"

echo ""
echo "🎯 Para verificar que funciona:"
echo "   1. Abre varios archivos"
echo "   2. Solo debería estar visible una pestaña"
echo "   3. Al cambiar de archivo, se cierra el anterior automáticamente"

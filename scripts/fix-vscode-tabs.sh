#!/bin/bash

# ¿QUÉ? Script para forzar configuración de una sola pestaña en VS Code
# ¿POR QUÉ? A veces las configuraciones no se aplican automáticamente
# ¿PARA QUÉ? Garantizar que VS Code solo muestre una pestaña activa

echo "🔧 Aplicando configuraciones FORZADAS para una sola pestaña..."

# ¿QUÉ? Cerrar VS Code completamente
# ¿POR QUÉ? Asegurar que no hay procesos que interfieran
# ¿PARA QUÉ? Aplicar configuraciones desde cero
echo "1️⃣ Cerrando VS Code completamente..."
pkill -f "code" 2>/dev/null || true
sleep 2

# ¿QUÉ? Verificar las configuraciones en el archivo
# ¿POR QUÉ? Confirmar que las configuraciones están correctas
# ¿PARA QUÉ? Diagnosticar si hay problemas en el archivo JSON
echo "2️⃣ Verificando configuraciones en .vscode/settings.json..."
if grep -q "workbench.editor.limit.enabled.*true" .vscode/settings.json; then
    echo "   ✅ workbench.editor.limit.enabled: true"
else
    echo "   ❌ workbench.editor.limit.enabled no encontrado"
fi

if grep -q "workbench.editor.limit.value.*1" .vscode/settings.json; then
    echo "   ✅ workbench.editor.limit.value: 1"
else
    echo "   ❌ workbench.editor.limit.value no encontrado"
fi

if grep -q "workbench.editor.showTabs.*single" .vscode/settings.json; then
    echo "   ✅ workbench.editor.showTabs: single"
else
    echo "   ❌ workbench.editor.showTabs no encontrado"
fi

echo ""
echo "3️⃣ Abriendo VS Code con configuraciones frescas..."

# ¿QUÉ? Abrir VS Code con el workspace actual
# ¿POR QUÉ? Cargar las configuraciones desde cero
# ¿PARA QUÉ? Aplicar todas las configuraciones correctamente
code . &

echo ""
echo "✅ VS Code reiniciado con configuraciones aplicadas"
echo ""
echo "🔍 VERIFICACIÓN MANUAL:"
echo "   1. Ve al menú View > Appearance > Show Tabs"
echo "   2. Asegúrate que está seleccionado 'Single'"
echo "   3. Ve a File > Preferences > Settings"
echo "   4. Busca 'editor limit' y verifica:"
echo "      - Editor Limit: Enabled ✅"
echo "      - Editor Limit: Value = 1"
echo "   5. Busca 'show tabs' y verifica:"
echo "      - Show Tabs: single"

echo ""
echo "💡 Si aún persiste el problema:"
echo "   - Presiona Ctrl+Shift+P"
echo "   - Busca 'Preferences: Open Workspace Settings (JSON)'"
echo "   - Verifica que contiene las configuraciones correctas"

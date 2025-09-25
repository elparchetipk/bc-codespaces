#!/bin/bash

# ¿QUÉ? Script para commits automáticos cada 5 minutos
# ¿POR QUÉ? Los aprendices necesitan guardar progreso constantemente en Codespaces
# ¿PARA QUÉ? Optimizar el uso del Free Tier y evitar pérdida de trabajo

# ¿QUÉ? Configuramos el directorio de trabajo
# ¿POR QUÉ? Necesitamos asegurar que estamos en el directorio correcto del proyecto
# ¿PARA QUÉ? Evitar errores de ejecución del script
REPO_DIR="/workspaces/bc-codespaces"
cd "$REPO_DIR" || exit 1

# ¿QUÉ? Configuramos información del commit si no existe
# ¿POR QUÉ? Git requiere nombre y email para hacer commits
# ¿PARA QUÉ? Asegurar que los commits automáticos funcionen correctamente
if ! git config user.name > /dev/null 2>&1; then
    git config user.name "Codespaces Auto-commit"
fi

if ! git config user.email > /dev/null 2>&1; then
    git config user.email "codespaces@bootcamp.local"
fi

# ¿QUÉ? Verificamos si hay cambios en el repositorio
# ¿POR QUÉ? No queremos hacer commits vacíos innecesariamente
# ¿PARA QUÉ? Mantener un historial limpio y significativo
if [ -z "$(git status --porcelain)" ]; then
    echo "$(date): No changes to commit"
    exit 0
fi

# ¿QUÉ? Agregamos todos los archivos modificados al staging area
# ¿POR QUÉ? Los commits automáticos deben capturar todo el progreso
# ¿PARA QUÉ? Asegurar que no se pierda ningún cambio
git add .

# ¿QUÉ? Generamos un mensaje de commit automático con timestamp
# ¿POR QUÉ? Necesitamos identificar fácilmente los commits automáticos
# ¿PARA QUÉ? Facilitar el seguimiento del progreso temporal
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
COMMIT_MSG="chore(auto): automatic save at ${TIMESTAMP}

Why: Preserve work progress and optimize Codespaces Free Tier usage
What: Auto-saved all modified files and project state
Impact: Ensures no work is lost and enables efficient codespace management

Auto-commit: true
Timestamp: ${TIMESTAMP}"

# ¿QUÉ? Ejecutamos el commit con el mensaje generado
# ¿POR QUÉ? Necesitamos persistir los cambios en el repositorio
# ¿PARA QUÉ? Mantener el progreso seguro y accesible
git commit -m "$COMMIT_MSG"

# ¿QUÉ? Intentamos hacer push al repositorio remoto si existe
# ¿POR QUÉ? Los cambios deben estar disponibles en GitHub
# ¿PARA QUÉ? Sincronizar el trabajo con el repositorio central
if git remote get-url origin > /dev/null 2>&1; then
    echo "$(date): Pushing changes to remote repository..."
    git push origin main 2>/dev/null || git push origin master 2>/dev/null || {
        echo "$(date): Warning - Could not push to remote. Changes saved locally."
    }
else
    echo "$(date): No remote repository configured. Changes saved locally."
fi

echo "$(date): Auto-commit completed successfully"

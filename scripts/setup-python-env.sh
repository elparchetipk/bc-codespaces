#!/bin/bash

# ¿QUÉ? Script de configuración inicial para entorno Python con Alpine Linux
# ¿POR QUÉ? Alpine requiere configuración específica para desarrollo Python
# ¿PARA QUÉ? Optimizar recursos en GitHub Codespaces Free Tier

set -e  # ¿QUÉ? Detener ejecución si hay errores
        # ¿POR QUÉ? Evitar configuraciones parciales o corruptas
        # ¿PARA QUÉ? Asegurar setup completo y funcional

echo "🐍 Configurando entorno Python optimizado para Codespaces Free Tier..."

# ¿QUÉ? Verificamos que estamos en una imagen Alpine
# ¿POR QUÉ? Los comandos de instalación son específicos para Alpine
# ¿PARA QUÉ? Evitar errores de ejecución en sistemas diferentes
if ! command -v apk &> /dev/null; then
    echo "❌ Error: Este script está diseñado para Alpine Linux"
    echo "   Actual sistema: $(cat /etc/os-release | grep '^ID=' | cut -d= -f2)"
    exit 1
fi

echo "✅ Sistema Alpine detectado correctamente"

# ¿QUÉ? Instalamos dependencias de compilación necesarias
# ¿POR QUÉ? Python packages como psycopg2, cryptography requieren compilación
# ¿PARA QUÉ? Permitir instalación de todas las dependencias del proyecto
echo "📦 Instalando dependencias de sistema..."

apk update
apk add --no-cache \
    build-base \
    libffi-dev \
    openssl-dev \
    postgresql-dev \
    gcc \
    musl-dev \
    python3-dev

echo "✅ Dependencias de sistema instaladas"

# ¿QUÉ? Configuramos el directorio de trabajo
# ¿POR QUÉ? Necesitamos trabajar desde el directorio del proyecto
# ¿PARA QUÉ? Asegurar que el entorno virtual se cree en el lugar correcto

# Detectar si estamos en Codespaces o local
if [ -d "/workspaces/bc-codespaces" ]; then
    # Estamos en GitHub Codespaces
    WORKSPACE_DIR="/workspaces/bc-codespaces"
    echo "🐳 GitHub Codespaces detectado"
elif [ -f "$(dirname "$0")/../README.md" ]; then
    # Estamos en el directorio del proyecto (local o script ejecutado desde scripts/)
    WORKSPACE_DIR="$(dirname "$0")/.."
    WORKSPACE_DIR="$(realpath "$WORKSPACE_DIR")"
    echo "� Entorno local detectado"
else
    # Usar directorio actual como fallback
    WORKSPACE_DIR="$(pwd)"
    echo "⚠️  Usando directorio actual como workspace"
fi

cd "$WORKSPACE_DIR"
echo "📁 Directorio de trabajo: $WORKSPACE_DIR"

# ¿QUÉ? Creamos entorno virtual Python con venv
# ¿POR QUÉ? Aislamiento de dependencias es fundamental para desarrollo
# ¿PARA QUÉ? Evitar conflictos entre proyectos y mantener limpio el sistema
echo "🔧 Creando entorno virtual Python..."

if [ -d "venv" ]; then
    echo "⚠️  Entorno virtual existente detectado. Removiendo..."
    rm -rf venv
fi

python3 -m venv venv

echo "✅ Entorno virtual creado: venv/"

# ¿QUÉ? Activamos el entorno virtual
# ¿POR QUÉ? Necesitamos instalar paquetes en el entorno aislado
# ¿PARA QUÉ? Preparar el entorno para instalación de dependencias
source venv/bin/activate

echo "🚀 Entorno virtual activado"

# ¿QUÉ? Actualizamos pip a la última versión
# ¿POR QUÉ? Versiones antiguas pueden tener problemas de instalación
# ¿PARA QUÉ? Asegurar compatibilidad con paquetes modernos
echo "⬆️  Actualizando pip..."
pip install --upgrade pip

echo "✅ pip actualizado a versión: $(pip --version)"

# ¿QUÉ? Instalamos wheel para optimizar instalaciones
# ¿POR QUÉ? Acelera la instalación de paquetes que requieren compilación
# ¿PARA QUÉ? Reducir tiempo de setup y consumo de recursos
echo "⚡ Instalando wheel para optimización..."
pip install wheel

# ¿QUÉ? Verificamos si existe requirements.txt
# ¿POR QUÉ? Solo instalamos dependencias si están definidas
# ¿PARA QUÉ? Configurar completamente el entorno del proyecto
if [ -f "requirements.txt" ]; then
    echo "📋 Instalando dependencias del proyecto..."
    pip install -r requirements.txt
    echo "✅ Dependencias instaladas desde requirements.txt"
else
    echo "📋 Instalando dependencias básicas para FastAPI..."
    # ¿QUÉ? Instalamos dependencias esenciales para el bootcamp
    # ¿POR QUÉ? El proyecto necesita estas librerías específicas
    # ¿PARA QUÉ? Tener un entorno funcional para desarrollo FastAPI
    pip install \
        fastapi \
        uvicorn[standard] \
        sqlalchemy \
        aiosqlite \
        alembic \
        pydantic \
        python-multipart \
        python-jose[cryptography] \
        passlib[bcrypt] \
        pytest \
        pytest-asyncio \
        httpx \
        black \
        isort \
        ruff
    
    echo "✅ Dependencias básicas de FastAPI instaladas"
fi

# ¿QUÉ? Creamos archivo de activación automática para el shell
# ¿POR QUÉ? Los usuarios necesitan activar el venv automáticamente
# ¿PARA QUÉ? Facilitar el flujo de trabajo en Codespaces
echo "🔗 Configurando activación automática del entorno virtual..."

cat > activate_venv.sh << 'EOF'
#!/bin/bash
# ¿QUÉ? Script de activación rápida del entorno virtual
# ¿POR QUÉ? Facilitar la activación del venv en cada sesión
# ¿PARA QUÉ? Mantener el flujo de trabajo consistente

if [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
    echo "🐍 Entorno virtual activado"
    echo "Python: $(python --version)"
    echo "Pip: $(pip --version)"
    echo "Directorio: $(pwd)"
else
    echo "❌ Error: Entorno virtual no encontrado"
    echo "Ejecuta: ./scripts/setup-python-env.sh"
fi
EOF

chmod +x activate_venv.sh

# ¿QUÉ? Agregamos alias útiles al bashrc si existe
# ¿POR QUÉ? Facilitar comandos comunes durante el desarrollo
# ¿PARA QUÉ? Mejorar la productividad del desarrollador
if [ -f "$HOME/.bashrc" ]; then
    echo "⚙️  Agregando aliases útiles..."
    cat >> "$HOME/.bashrc" << 'EOF'

# Aliases para el Bootcamp GitHub Codespaces & FastAPI
alias activate='source venv/bin/activate'
alias dev='source venv/bin/activate && uvicorn main:app --reload --host 0.0.0.0 --port 8000'
alias test='source venv/bin/activate && pytest -v'
alias format='source venv/bin/activate && black . && isort .'
alias lint='source venv/bin/activate && ruff check .'
EOF
fi

# ¿QUÉ? Mostramos información del entorno configurado
# ¿POR QUÉ? El usuario necesita saber cómo usar el entorno
# ¿PARA QUÉ? Facilitar el siguiente paso en el desarrollo
echo ""
echo "🎉 ¡Entorno Python configurado exitosamente!"
echo ""
echo "📋 Resumen de la configuración:"
echo "   • Sistema: Alpine Linux (ultra-ligero)"
echo "   • Python: $(python --version)"
echo "   • Entorno virtual: venv/"
echo "   • Dependencias: $(pip list | wc -l) paquetes instalados"
echo ""
echo "🚀 Para empezar a desarrollar:"
echo "   1. source venv/bin/activate  # Activar entorno"
echo "   2. # O simplemente: ./activate_venv.sh"
echo "   3. uvicorn main:app --reload  # Iniciar servidor FastAPI"
echo ""
echo "⚡ Aliases disponibles:"
echo "   • activate  - Activar entorno virtual"
echo "   • dev      - Iniciar servidor de desarrollo"
echo "   • test     - Ejecutar tests"
echo "   • format   - Formatear código"
echo "   • lint     - Verificar código"
echo ""
echo "💡 Optimizado para GitHub Codespaces Free Tier (120 horas/mes)"

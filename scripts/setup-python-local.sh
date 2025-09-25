#!/bin/bash

# ¿QUÉ? Script de configuración Python para sistemas locales (Fedora, Ubuntu, etc.)
# ¿POR QUÉ? El script principal está optimizado para Alpine en Codespaces
# ¿PARA QUÉ? Permitir desarrollo local con la misma estructura de proyecto

set -e

echo "🐍 Configurando entorno Python para desarrollo local..."

# ¿QUÉ? Detectamos el directorio de trabajo correcto
# ¿POR QUÉ? Necesitamos crear el venv en la raíz del proyecto
# ¿PARA QUÉ? Mantener consistencia entre local y Codespaces

if [ -f "$(dirname "$0")/../README.md" ]; then
    # Estamos ejecutando desde scripts/ hacia la raíz del proyecto
    WORKSPACE_DIR="$(dirname "$0")/.."
    WORKSPACE_DIR="$(realpath "$WORKSPACE_DIR")"
    echo "💻 Proyecto detectado en: $WORKSPACE_DIR"
else
    # Fallback al directorio actual
    WORKSPACE_DIR="$(pwd)"
    echo "⚠️  Usando directorio actual: $WORKSPACE_DIR"
fi

cd "$WORKSPACE_DIR"
echo "📁 Directorio de trabajo: $WORKSPACE_DIR"

# ¿QUÉ? Verificamos que Python 3 esté disponible
# ¿POR QUÉ? Es requisito fundamental para el proyecto
# ¿PARA QUÉ? Evitar errores durante la creación del entorno virtual

if ! command -v python3 &> /dev/null; then
    echo "❌ Error: Python 3 no está instalado"
    echo "   Instala Python 3.9+ antes de continuar"
    exit 1
fi

PYTHON_VERSION=$(python3 --version 2>&1 | cut -d' ' -f2)
echo "✅ Python detectado: $PYTHON_VERSION"

# ¿QUÉ? Creamos entorno virtual Python con venv
# ¿POR QUÉ? Aislamiento de dependencias es fundamental para desarrollo
# ¿PARA QUÉ? Evitar conflictos entre proyectos y mantener limpio el sistema

echo "🔧 Creando entorno virtual Python en: $WORKSPACE_DIR/venv"

if [ -d "venv" ]; then
    echo "⚠️  Entorno virtual existente detectado. Removiendo..."
    rm -rf venv
fi

python3 -m venv venv

echo "✅ Entorno virtual creado: $(pwd)/venv/"

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
# ¿PARA QUÉ? Evitar errores si el archivo no existe aún

if [ -f "requirements.txt" ]; then
    echo "📦 Instalando dependencias desde requirements.txt..."
    pip install -r requirements.txt
    echo "✅ Dependencias instaladas correctamente"
else
    echo "⚠️  Archivo requirements.txt no encontrado"
    echo "   Creando requirements.txt básico para FastAPI..."
    
    cat > requirements.txt << 'EOF'
# ¿QUÉ? Dependencias principales del bootcamp FastAPI
# ¿POR QUÉ? Versiones específicas para garantizar compatibilidad
# ¿PARA QUÉ? Desarrollo consistente y reproducible

# Framework web moderno y rápido
fastapi>=0.104.1

# Servidor ASGI para desarrollo y producción
uvicorn[standard]>=0.24.0

# ORM moderno con soporte async
sqlalchemy>=2.0.23

# Base de datos SQLite con soporte async
aiosqlite>=0.19.0

# Validación y serialización de datos
pydantic>=2.5.0

# Testing framework profesional
pytest>=7.4.3
pytest-asyncio>=0.21.1
httpx>=0.25.2

# Formateo y calidad de código
black>=23.11.0
isort>=5.12.0
flake8>=6.1.0

# Variables de entorno
python-dotenv>=1.0.0

# Autenticación JWT
python-jose[cryptography]>=3.3.0
passlib[bcrypt]>=1.7.4

# Documentación automática
python-multipart>=0.0.6
EOF
    
    echo "📦 Instalando dependencias básicas..."
    pip install -r requirements.txt
    echo "✅ Dependencias básicas instaladas"
fi

# ¿QUÉ? Mostramos resumen del entorno configurado
# ¿POR QUÉ? El usuario necesita saber cómo activar el entorno
# ¿PARA QUÉ? Facilitar el uso del entorno virtual creado

echo ""
echo "🎉 ¡Entorno Python configurado exitosamente!"
echo ""
echo "📍 Ubicación del entorno virtual: $(pwd)/venv"
echo "🐍 Python: $(python --version)"
echo "📦 pip: $(pip --version)"
echo ""
echo "💡 Para activar el entorno virtual en futuras sesiones:"
echo "   cd $(pwd)"
echo "   source venv/bin/activate"
echo ""
echo "🚀 Para iniciar el servidor FastAPI:"
echo "   uvicorn main:app --reload --host 0.0.0.0 --port 8000"
echo ""

# 🚀 Guía de Setup Rápido - GitHub Codespaces

## ✅ **Setup en 3 Pasos (2 minutos)**

### **1. 🌐 Abrir en Codespaces**

```bash
# Opción A: Desde GitHub
1. Ir a: https://github.com/tu-usuario/bc-codespaces
2. Clic en botón verde "Code"
3. Seleccionar pestaña "Codespaces"
4. Clic en "Create codespace on main"
```

**O usar el botón directo:**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/tu-usuario/bc-codespaces?quickstart=1)

### **2. ⚡ Configuración Automática**

El devcontainer se ejecutará automáticamente:

```text
✅ Creando contenedor Python 3.13 + Alpine Linux
✅ Instalando Docker-in-Docker para containerización
✅ Configurando VS Code con extensiones esenciales
✅ Creando entorno virtual en /workspaces/bc-codespaces/venv
✅ Instalando dependencias desde requirements.txt
✅ Configurando una sola pestaña activa en editor
```

### **3. 🎯 Verificación del Entorno**

```bash
# Verificar Python
python --version  # Debe mostrar Python 3.13.x

# Verificar entorno virtual
which python     # Debe mostrar /workspaces/bc-codespaces/venv/bin/python

# Verificar FastAPI
pip list | grep fastapi  # Debe mostrar fastapi 0.104.1+

# Verificar Docker
docker --version  # Debe funcionar sin errores

# Probar API básica
cd /workspaces/bc-codespaces
python -c "from fastapi import FastAPI; print('✅ FastAPI listo!')"
```

## 🔧 **Configuración Automática Incluida**

### **📦 Tecnologías Preinstaladas:**

- ✅ Python 3.13+ con venv automático
- ✅ FastAPI + SQLAlchemy + pytest
- ✅ Docker + Docker Compose
- ✅ Git configurado
- ✅ VS Code con extensiones esenciales

### **🎨 VS Code Optimizado:**

- ✅ Una sola pestaña activa (sin saturación)
- ✅ Python IntelliSense completo
- ✅ Black formatter automático
- ✅ Ruff linter integrado
- ✅ Testing con pytest integrado

### **⚡ Performance Optimizada:**

- ✅ Alpine Linux (50% menos recursos)
- ✅ Configurado para Free Tier (120h/mes)
- ✅ Auto-shutdown después de 30min inactividad
- ✅ Build cache optimizado

## 🚨 **Troubleshooting Común**

### **❓ "No veo el botón de Codespaces"**

```bash
# Solución: Verificar permisos del repo
1. Ir a Settings → Actions → General
2. Permitir "Read and write permissions"
3. Refresh la página
```

### **❓ "El contenedor tarda mucho en construirse"**

```bash
# Normal en primera ejecución (2-3 minutos)
# Siguientes arranques: 30-60 segundos
```

### **❓ "Python no encuentra los paquetes"**

```bash
# Verificar que está en el venv correcto
which python  # Debe mostrar /workspaces/.../venv/bin/python

# Si no, activar manualmente:
source venv/bin/activate
```

## 📊 **Ventajas vs Desarrollo Local**

| Aspecto          | Codespaces        | Local                   |
| ---------------- | ----------------- | ----------------------- |
| **Setup Time**   | 🟢 2 min          | 🟡 15+ min              |
| **Consistencia** | 🟢 100%           | 🟡 Variable             |
| **Docker**       | 🟢 Integrado      | 🔴 Requiere instalación |
| **Colaboración** | 🟢 Real-time      | 🟡 Solo Git             |
| **Recursos**     | 🟢 2-32 cores     | 🟡 Limitado por HW      |
| **Costo**        | 🟢 Free Tier 120h | 🟢 Gratis               |

## 🎓 **Próximo Paso**

Una vez que tengas Codespaces funcionando:

```bash
# Seguir con el Día 1 del bootcamp
cd bootcamp/semana-01/1-teoria
cat README.md
```

¡Tu entorno de desarrollo profesional estará listo! 🚀

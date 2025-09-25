# 🖥️ Configuración de VS Code Local

## ¿Por qué necesito esto?

**¿QUÉ?** Scripts para optimizar VS Code local para el bootcamp  
**¿POR QUÉ?** La configuración de devcontainer solo funciona en GitHub Codespaces  
**¿PARA QUÉ?** Replicar el ambiente optimizado (una sola pestaña) en VS Code local

---

## 📋 Scripts Disponibles

### `setup-vscode-local.sh` ⚡

**Configuración automática inicial**

```bash
./scripts/setup-vscode-local.sh
```

**¿Qué hace?**

- Aplica configuraciones de workspace optimizadas
- Configura límite de una sola pestaña activa
- Establece configuraciones de Python
- Recarga VS Code automáticamente

### `fix-vscode-tabs.sh` 🔧

**Corrección forzada de pestañas múltiples**

```bash
./scripts/fix-vscode-tabs.sh
```

**¿Qué hace?**

- Cierra VS Code completamente
- Verifica configuraciones en settings.json
- Reinicia VS Code con configuraciones frescas
- Proporciona guía de verificación manual

---

## ⚙️ Configuraciones Aplicadas

Las configuraciones se guardan en `.vscode/settings.json`:

```json
{
  // Una sola pestaña activa
  "workbench.editor.limit.enabled": true,
  "workbench.editor.limit.value": 1,
  "workbench.editor.showTabs": "single",
  "workbench.editor.enablePreview": false,

  // Configuraciones Python
  "python.defaultInterpreterPath": "./venv/bin/python",
  "python.terminal.activateEnvironment": true,
  "editor.formatOnSave": true,

  // Optimizaciones de rendimiento
  "files.exclude": {
    "**/__pycache__": true,
    "**/*.pyc": true
  }
}
```

---

## 🚨 Troubleshooting

### Problema: Aún veo múltiples pestañas

**Solución 1:** Reinicio manual

```bash
# Cerrar VS Code completamente
pkill -f code

# Reabrir el proyecto
code .
```

**Solución 2:** Verificación manual

1. Ve a `File > Preferences > Settings`
2. Busca "editor limit"
3. Verifica que esté habilitado y en valor 1
4. Busca "show tabs"
5. Verifica que esté en "single"

**Solución 3:** Reseteo completo

```bash
# Aplicar corrección forzada
./scripts/fix-vscode-tabs.sh

# Si persiste, eliminar y recrear configuraciones
rm -rf .vscode/
./scripts/setup-vscode-local.sh
```

### Problema: Las configuraciones no se aplican

**Causa:** Configuraciones globales de VS Code que anulan las del workspace

**Solución:**

1. Abre VS Code
2. Presiona `Ctrl+Shift+P` (Cmd+Shift+P en Mac)
3. Busca "Preferences: Open Workspace Settings (JSON)"
4. Verifica que el archivo contiene las configuraciones correctas

---

## ✅ Verificación de Éxito

Para confirmar que funciona correctamente:

1. **Abre varios archivos** (README.md, main.py, settings.json)
2. **Verifica que solo una pestaña está visible**
3. **Cambia entre archivos** - el anterior debe cerrarse
4. **En el Explorer** - hacer click en archivos debe reemplazar la pestaña activa

---

## 📚 Recursos Adicionales

- [VS Code Workspace Settings](https://code.visualstudio.com/docs/getstarted/settings#_workspace-settings)
- [Editor Configuration](https://code.visualstudio.com/docs/editor/workbench#_tabs)
- [Python in VS Code](https://code.visualstudio.com/docs/python/python-tutorial)

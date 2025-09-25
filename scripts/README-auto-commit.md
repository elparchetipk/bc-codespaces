# Sistema de Commits Automáticos para GitHub Codespaces

## ¿QUÉ?

Sistema automatizado de commits cada 5 minutos diseñado específicamente para optimizar el uso de GitHub Codespaces Free Tier.

## ¿POR QUÉ?

- **Preservar trabajo**: Evitar pérdida de progreso al pausar/reanudar Codespaces
- **Optimizar Free Tier**: Permitir pausas frecuentes sin perder trabajo
- **Hábitos profesionales**: Desarrollar disciplina de guardado constante
- **Respaldo automático**: Sincronización continua con GitHub

## ¿PARA QUÉ?

- Maximizar las 120 horas mensuales del Free Tier
- Permitir colaboración continua entre aprendices
- Crear historial detallado del progreso de aprendizaje
- Facilitar troubleshooting y rollback cuando sea necesario

## 🚀 Configuración Inicial

### Activar commits automáticos:

```bash
./scripts/setup-auto-commit.sh
```

### Verificar configuración:

```bash
crontab -l
```

### Monitorear actividad:

```bash
tail -f logs/auto-commit.log
```

## 🛑 Control del Sistema

### Detener commits automáticos:

```bash
./scripts/stop-auto-commit.sh
```

### Reactivar sistema:

```bash
./scripts/setup-auto-commit.sh
```

## 📋 Características

### Frecuencia

- **Intervalo**: Cada 5 minutos
- **Formato**: `*/5 * * * *` (cron expression)
- **Horario**: 24/7 mientras el Codespace esté activo

### Commits Inteligentes

- **Detección de cambios**: Solo hace commit si hay modificaciones
- **Mensaje estructurado**: Sigue Conventional Commits
- **Timestamp**: Incluye fecha y hora exacta
- **Metadata**: Información de contexto y propósito

### Ejemplo de commit automático:

```
chore(auto): automatic save at 2024-03-15 14:35:00

Why: Preserve work progress and optimize Codespaces Free Tier usage
What: Auto-saved all modified files and project state
Impact: Ensures no work is lost and enables efficient codespace management

Auto-commit: true
Timestamp: 2024-03-15 14:35:00
```

## 📂 Archivos del Sistema

```
scripts/
├── auto-commit.sh          # Script principal de commits
├── setup-auto-commit.sh    # Configuración inicial
└── stop-auto-commit.sh     # Detener sistema

logs/
└── auto-commit.log         # Registro de actividad
```

## 🔍 Monitoreo y Troubleshooting

### Ver commits recientes:

```bash
git log --oneline -10 | grep "chore(auto)"
```

### Verificar estado del cron:

```bash
systemctl status cron  # En sistemas con systemd
```

### Limpiar historial de commits automáticos:

```bash
# ⚠️ CUIDADO: Esto reescribe la historia
git rebase -i HEAD~20  # Revisar últimos 20 commits
```

## ⚙️ Configuración Avanzada

### Cambiar frecuencia (ejemplo: cada 3 minutos):

```bash
# Editar crontab manualmente
crontab -e

# Cambiar: */5 * * * * por */3 * * * *
```

### Configurar diferentes horarios:

```bash
# Solo durante horario laboral (9 AM - 6 PM)
0 9-18/5 * * * /bin/bash /path/to/auto-commit.sh

# Solo días laborales
*/5 * * * 1-5 /bin/bash /path/to/auto-commit.sh
```

## 🎯 Mejores Prácticas

### Para Aprendices:

1. **Activar al iniciar**: Ejecutar setup al abrir Codespace
2. **Monitorear logs**: Verificar funcionamiento periódicamente
3. **Commits manuales**: Seguir haciendo commits importantes manualmente
4. **Pausar responsablemente**: Usar auto-commits para pausar sin preocupaciones

### Para Instructores:

1. **Revisar progreso**: Los commits automáticos muestran actividad real
2. **Debugging**: Los logs ayudan a identificar problemas
3. **Colaboración**: Facilita revisión de código en tiempo real

## ⚠️ Consideraciones

### Ventajas:

- ✅ Preservación automática del trabajo
- ✅ Optimización del Free Tier
- ✅ Historial detallado de progreso
- ✅ Sincronización continua

### Limitaciones:

- ⚠️ Puede generar muchos commits
- ⚠️ Requiere conexión a internet para push
- ⚠️ Consume ancho de banda regularmente

### Recomendaciones:

- Usar durante desarrollo activo
- Detener durante presentaciones o demos
- Combinar con commits manuales significativos
- Revisar logs periódicamente

## 📚 Comandos Útiles

```bash
# Estado del sistema
./scripts/setup-auto-commit.sh --status

# Ver últimos commits automáticos
git log --grep="chore(auto)" --oneline -5

# Limpiar logs antiguos (mantener últimos 100 líneas)
tail -100 logs/auto-commit.log > logs/auto-commit.log.tmp
mv logs/auto-commit.log.tmp logs/auto-commit.log

# Verificar espacio usado por commits
git count-objects -vH
```

---

**🎓 Parte del Bootcamp GitHub Codespaces & FastAPI**

_Sistema diseñado para maximizar el aprendizaje y optimizar recursos en la nube_

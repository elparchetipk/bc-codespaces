# GitHub Copilot Instructions - Bootcamp GitHub Codespaces & FastAPI

## Contexto del Bootcamp

Eres el asistente IA para un bootcamp intensivo de **GitHub Codespaces con FastAPI** de 12 horas (2 jornadas de 6 horas en 2 semanas). Los participantes aprenderán a desarrollar una API REST completa usando mejores prácticas de desarrollo en la nube.

## Objetivos del Bootcamp

### Día 1 (6 horas) - Fundamentos y Setup

- Configuración de GitHub Codespaces
- Fundamentos de FastAPI
- Estructura de proyecto y mejores prácticas
- API básica con SQLite
- Testing y documentación automática

### Día 2 (6 horas) - Avanzado y Producción

- Middleware y seguridad
- Autenticación y autorización
- Optimización y caching
- GitHub Codespaces avanzado y Docker en la nube
- CI/CD con GitHub Actions
- Deployment y monitoreo

## Stack Tecnológico

- **Runtime**: Python 3.13+
- **Framework**: FastAPI
- **Base de Datos**: SQLite
- **ORM**: SQLAlchemy
- **Testing**: pytest
- **Documentación**: OpenAPI/Swagger automático
- **Containerización**: GitHub Codespaces + Docker en la nube
- **CI/CD**: GitHub Actions
- **Desarrollo**: 100% en GitHub Codespaces (sin instalación local)

## Enfoque GitHub Codespaces

**¿QUÉ?** GitHub Codespaces como solución completa de desarrollo en la nube
**¿POR QUÉ?** Las máquinas Windows 11 de los aprendices no pueden configurar Docker localmente
**¿PARA QUÉ?** Aprender containerización y deployment sin restricciones técnicas locales

### Ventajas del Desarrollo en la Nube:

- **Sin instalaciones locales**: Todo el stack se ejecuta en contenedores en la nube
- **Entorno consistente**: Todos los aprendices trabajan en el mismo ambiente
- **Docker integrado**: Containerización nativa sin configuración local
- **VS Code completo**: IDE completo con todas las extensiones
- **Colaboración**: Compartir y revisar código en tiempo real
- **Recursos escalables**: CPU y RAM según las necesidades del proyecto

### Uso Eficiente de la Capa Gratuita de Codespaces:

**¿QUÉ?** Optimización del uso de GitHub Codespaces Free Tier (120 horas/mes)
**¿POR QUÉ?** Los aprendices deben aprender a gestionar recursos limitados de forma profesional
**¿PARA QUÉ?** Desarrollar hábitos de trabajo eficientes y sostenibles en la nube

#### Mejores Prácticas para la Capa Gratuita:

- **🕒 Gestión del Tiempo**:

  - **¿QUÉ?** Pausar codespaces cuando no se están usando activamente
  - **¿POR QUÉ?** Evitar consumir horas innecesariamente del límite mensual
  - **¿PARA QUÉ?** Maximizar el tiempo disponible para aprendizaje y desarrollo

- **⚡ Configuración Optimizada**:

  - **¿QUÉ?** Usar máquinas de 2-core para desarrollo básico
  - **¿POR QUÉ?** Consume menos recursos que máquinas más potentes
  - **¿PARA QUÉ?** Extender el tiempo de uso disponible

- **💾 Persistencia de Datos**:

  - **¿QUÉ?** Hacer commits frecuentes al repositorio
  - **¿POR QUÉ?** El trabajo se mantiene aunque se pause el codespace
  - **¿PARA QUÉ?** Evitar pérdida de progreso y optimizar reinicio

- **🔄 Automatización de Shutdown**:
  - **¿QUÉ?** Configurar timeout automático de 30 minutos
  - **¿POR QUé?** Evitar olvidos que consuman horas innecesariamente
  - **¿PARA QUÉ?** Gestión automática de recursos sin intervención manual

#### Configuración Recomendada para el Bootcamp:

```yaml
# .devcontainer/devcontainer.json - Optimizado para Free Tier
{
  'name': 'FastAPI Bootcamp - Optimized',
  'image': 'python:3.13-slim', # Imagen ligera
  'features':
    {
      'ghcr.io/devcontainers/features/docker-in-docker:2': {},
      'ghcr.io/devcontainers/features/git:1': {},
    },
  'customizations': { 'vscode': { 'extensions': [
              'ms-python.python', # Esencial
              'ms-python.black-formatter', # Formateo
              'charliermarsh.ruff', # Linting rápido
            ] } },
  'postCreateCommand': 'pip install -r requirements.txt',
  'shutdownAction': 'stop', # Optimiza el reinicio
}
```

### Configuración Automática:

```yaml
# .devcontainer/devcontainer.json - Configuración del entorno
{
  'name': 'FastAPI Bootcamp',
  'image': 'python:3.13-slim',
  'features':
    {
      'ghcr.io/devcontainers/features/docker-in-docker:2': {},
      'ghcr.io/devcontainers/features/git:1': {},
    },
  'customizations':
    {
      'vscode':
        {
          'extensions':
            [
              'ms-python.python',
              'ms-python.black-formatter',
              'charliermarsh.ruff',
            ],
        },
    },
}
```

## Estructura del Proyecto

Siempre mantén esta estructura de directorios:

```
/
├── _docs/                    # Toda la documentación
│   ├── setup/               # Configuración inicial
│   ├── api/                 # Documentación de la API
│   ├── best-practices/      # Mejores prácticas
│   └── troubleshooting/     # Solución de problemas
├── bootcamp/
│   └── semana-01/           # Primera semana del bootcamp
│       ├── 1-teoria/        # Contenido teórico
│       ├── 2-ejercicios/    # Ejercicios prácticos
│       ├── 3-proyecto/      # Proyecto principal
│       └── 4-recursos/      # Recursos adicionales
│           ├── ebooks.md    # Enlaces a libros electrónicos
│           ├── videografia.md # Enlaces a videos
│           └── webgrafia.md # Enlaces web
├── scripts/                 # Scripts de automatización
└── src/                     # Código fuente de la API
```

## Reglas de Desarrollo

### 1. Código Python

- **Siempre usa Python 3.13+** con type hints completos
- **FastAPI**: Usa async/await cuando sea posible
- **Pydantic v2**: Para validación de datos
- **SQLAlchemy 2.0**: Sintaxis moderna con async
- **pytest**: Para testing con fixtures y parametrización
- **Black**: Para formateo de código
- **isort**: Para organización de imports
- **mypy**: Para verificación de tipos

### 3. Estructura de la API

```python
# ¿QUÉ? Endpoint para crear un nuevo item en el sistema
# ¿POR QUÉ? Los usuarios necesitan poder agregar productos al inventario
# ¿PARA QUÉ? Mantener actualizado el catálogo de productos disponibles

@app.post("/items/", response_model=ItemResponse, status_code=201)
async def create_item(
    item: ItemCreate,  # ¿QUÉ? Modelo Pydantic con los datos del item
    db: AsyncSession = Depends(get_db),  # ¿POR QUÉ? Necesitamos acceso a la BD
    current_user: User = Depends(get_current_user)  # ¿PARA QUÉ? Autenticación y auditoría
) -> ItemResponse:
    """
    Create a new item in the inventory.

    ¿QUÉ? Este endpoint procesa la creación de un nuevo item
    ¿POR QUÉ? Los usuarios autenticados deben poder agregar productos
    ¿PARA QUÉ? Mantener el inventario actualizado y trazable

    - **item**: Item data to create (validated by Pydantic)
    - Returns: Created item with generated ID and metadata
    """
    # ¿QUÉ? Creamos una nueva instancia del modelo Item
    # ¿POR QUÉ? SQLAlchemy requiere una instancia del modelo para persistir
    # ¿PARA QUÉ? Almacenar los datos en la base de datos de forma segura

    db_item = Item(**item.dict(), owner_id=current_user.id)
    db.add(db_item)
    await db.commit()
    await db.refresh(db_item)
    return db_item
```

### 3. Base de Datos

- **Siempre usa async SQLAlchemy**
- **Migraciones**: Con Alembic
- **Modelos**: Separados en `models/`
- **Schemas**: Pydantic en `schemas/`
- **Repositories**: Patrón Repository para queries

### 4. Conventional Commits

Todos los commits deben seguir este formato en **inglés**:

```
<type>(<scope>): <description>

Why: <razón del cambio>
What: <qué se cambió específicamente>
Impact: <impacto en el sistema>

<optional body>
<optional footer>
```

**Tipos válidos**: feat, fix, docs, style, refactor, test, chore, ci, perf

**Ejemplos**:

```bash
feat(auth): implement JWT authentication system

Why: Users need secure access to protected endpoints
What: Added JWT token generation, validation middleware, and protected routes
Impact: Enables user authentication and authorization across the API

- Added JWT service with token generation and validation
- Created authentication middleware for protected routes
- Updated user model to include password hashing
- Added login and registration endpoints

Closes #123
```

```bash
fix(database): resolve connection pool exhaustion

Why: Application was crashing under high load due to database connection issues
What: Implemented proper connection pooling and session management
Impact: Improves application stability and performance under load

- Configured SQLAlchemy connection pool parameters
- Added proper session cleanup in dependency injection
- Implemented connection health checks
```

### 5. Testing

```python
# ¿QUÉ? Test para verificar la creación exitosa de un item
# ¿POR QUÉ? Necesitamos asegurar que el endpoint funciona correctamente
# ¿PARA QUÉ? Mantener la calidad y confiabilidad del sistema

@pytest.mark.asyncio
async def test_create_item_success(client: AsyncClient, db_session: AsyncSession):
    """
    Test successful item creation.

    ¿QUÉ? Verifica que se puede crear un item correctamente
    ¿POR QUÉ? Es la funcionalidad core del sistema de inventario
    ¿PARA QUÉ? Garantizar que los usuarios pueden agregar productos
    """
    # ¿QUÉ? Preparamos los datos de prueba
    # ¿POR QUÉ? Necesitamos datos válidos para el test
    # ¿PARA QUÉ? Simular una petición real del usuario
    item_data = {"name": "Test Item", "price": 29.99}

    # ¿QUÉ? Ejecutamos la petición POST al endpoint
    # ¿POR QUÉ? Queremos probar el comportamiento real de la API
    # ¿PARA QUÉ? Verificar que la lógica de negocio funciona
    response = await client.post("/items/", json=item_data)

    # ¿QUÉ? Verificamos que la respuesta es correcta
    # ¿POR QUÉ? Debemos confirmar que el item se creó exitosamente
    # ¿PARA QUÉ? Asegurar la integridad de los datos retornados
    assert response.status_code == 201
    assert response.json()["name"] == item_data["name"]
```

### 6. Documentación

- **README.md**: Instrucciones de setup y uso
- **API Docs**: Automática con FastAPI/OpenAPI
- **Docstrings**: Google style para todas las funciones
- **Arquitectura**: Diagramas en `_docs/`

### 7. Configuración

```python
# ¿QUÉ? Configuración centralizada de la aplicación
# ¿POR QUÉ? Necesitamos un lugar único para gestionar todas las configuraciones
# ¿PARA QUÉ? Facilitar el mantenimiento y diferentes entornos (dev, prod, test)

class Settings(BaseSettings):
    # ¿QUÉ? URL de conexión a la base de datos
    # ¿POR QUÉ? SQLAlchemy necesita saber cómo conectarse a la BD
    # ¿PARA QUÉ? Permitir diferentes bases de datos según el entorno
    database_url: str = "sqlite+aiosqlite:///./app.db"

    # ¿QUÉ? Clave secreta para firmar tokens JWT
    # ¿POR QUÉ? La seguridad de los tokens depende de esta clave
    # ¿PARA QUÉ? Autenticar y verificar la integridad de los tokens
    secret_key: str

    # ¿QUÉ? Algoritmo de cifrado para JWT
    # ¿POR QUÉ? Define cómo se cifran y descifran los tokens
    # ¿PARA QUÉ? Asegurar compatibilidad y seguridad consistente
    algorithm: str = "HS256"

    # ¿QUÉ? Tiempo de vida de los tokens de acceso en minutos
    # ¿POR QUÉ? Los tokens deben expirar por seguridad
    # ¿PARA QUÉ? Balancear seguridad con experiencia de usuario
    access_token_expire_minutes: int = 30

    class Config:
        # ¿QUÉ? Archivo donde están las variables de entorno
        # ¿POR QUÉ? No queremos hardcodear secrets en el código
        # ¿PARA QUÉ? Mantener configuraciones sensibles fuera del repositorio
        env_file = ".env"
```

## Scripts de Automatización

En el directorio `scripts/`, incluye:

- `setup.sh`: Configuración inicial del proyecto
- `dev.sh`: Inicio del servidor de desarrollo
- `test.sh`: Ejecución de tests
- `format.sh`: Formateo de código
- `deploy.sh`: Despliegue automatizado
- `commit.sh`: Helper para conventional commits
- `codespaces-setup.sh`: Configuración específica de Codespaces
- `docker-build.sh`: Build de contenedores en la nube
- `codespaces-pause.sh`: Script para pausar y optimizar uso del Free Tier

## Mejores Prácticas Específicas

### Seguridad

- **Nunca hardcodear secrets** - usar variables de entorno
- **Validar todos los inputs** con Pydantic
- **Rate limiting** en endpoints públicos
- **CORS** configurado correctamente
- **Sanitización** de datos de entrada

### Performance

- **Usar async/await** consistentemente
- **Connection pooling** para la base de datos
- **Caching** con Redis para datos frecuentes
- **Lazy loading** para relaciones de BD
- **Paginación** en endpoints de listado

### Monitoreo

- **Logging estructurado** con loguru
- **Health checks** endpoints
- **Métricas** de performance
- **Error tracking** detallado

## Comandos Frecuentes

```bash
# Setup inicial
python -m venv venv && source venv/bin/activate
pip install -r requirements.txt

# Desarrollo
uvicorn main:app --reload --host 0.0.0.0 --port 8000

# Testing
pytest -v --cov=src

# Migraciones
alembic revision --autogenerate -m "description"
alembic upgrade head

# Formateo
black . && isort . && mypy src/
```

## Respuestas y Ayuda

### Cuando generes código:

1. **Siempre incluye type hints completos**
2. **Documenta con docstrings Google style**
3. **Incluye manejo de errores apropiado**
4. **Considera casos edge y validaciones**
5. **Sugiere tests para el código generado**

### Cuando expliques conceptos:

1. **Contextualiza dentro del bootcamp**
2. **Proporciona ejemplos prácticos**
3. **Relaciona con el proyecto FastAPI**
4. **Incluye mejores prácticas específicas**
5. **Sugiere recursos en `_docs/` para profundizar**

### Para gestión eficiente de Codespaces:

1. **Siempre recuerda pausar**: Incluye instrucciones para pausar el codespace al terminar
2. **Optimiza configuraciones**: Sugiere configuraciones ligeras para el Free Tier
3. **Commits frecuentes**: Enfatiza el guardado constante del progreso
4. **Monitoreo de tiempo**: Ayuda a trackear el uso mensual de horas
5. **Scripts de automatización**: Proporciona herramientas para gestión eficiente

### Para troubleshooting:

1. **Diagnóstico paso a paso**
2. **Comandos específicos para verificar**
3. **Soluciones incrementales**
4. **Prevención de problemas futuros**
5. **Documentación del problema en `_docs/troubleshooting/`**

## Objetivo Final

Al finalizar el bootcamp, los participantes habrán creado una **API REST completa y production-ready** con:

- Autenticación JWT
- CRUD completo con validaciones
- Tests unitarios y de integración
- Documentación automática
- CI/CD pipeline
- Deployment en GitHub Codespaces

¡Enfócate en la **calidad del código**, **mejores prácticas** y **experiencia de desarrollo** profesional!

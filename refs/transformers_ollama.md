# Guía de instalación de dependencias para Transformers de Hugging Face y Ollama en Windows

## Data Mining - Doctorado UDP 2024

**Bastián González-Bustamante**

## Dependencias para Transformers de Hugging Face

### **Paso 1: Instalar Python**

1. Descargar e instalar Python desde la página oficial: https://www.python.org/downloads/.
2. Durante la instalación, asegúrarse de marcar la casilla **"Add Python to PATH"**.

### **Paso 2: Crear un entorno virtual (opcional, pero muy recomendado)**

1. Abrir la terminal (cmd o PowerShell) y crear un nuevo entorno virtual:

```bash
python -m venv nombre_del_entorno
```

*Nota*. Recomiendo encarecidamente un emulador de consola. Yo uso cmder (https://cmder.app/). Tabby (https://tabby.sh) también es una buena opción.

2. Activar el entorno:

```bash
nombre_del_entorno\Scripts\activate
```

### **Paso 3: Instalar Transformers y PyTorch**

1. Asegurarse de tener `pip` actualizado:

```bash
python -m pip install --upgrade pip
```

2. Instalar **PyTorch**. Consultar el comando adecuado para el sistema y versión de Python en https://pytorch.org/get-started/locally/. Por ejemplo:

```bash
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
```

3. Instalar `transformers`:

```bash
pip install transformers
```

### **Paso 4: Instalar dependencias útiles** (opcional)

* Para trabajar con data sets grandes, instalar `datasets` y `tokenizers`:

```bash
pip install datasets tokenizers
```

* Para visualización, `matplotlib` y `seaborn`:

```bash
pip install matplotlib seaborn
```

### **Paso 5: Probar la instalación**

1. Abrir Python y ejecutar:

```python
## Pipeline as a high-level helper
from transformers import pipeline
toxic_classifier = pipeline("text-classification", model="bgonzalezbustamante/bert-spanish-toxicity")

## Non-toxic example
non_toxic = toxic_classifier("Que tengas un excelente día :)")

## Print examples
print(non_toxic)
```

## Instalación de Ollama en Windows

### **Paso 1: Descargar el instalador**

1. Desde la página oficial de Ollama: https://ollama.com/.
2. Descargar el instalador para Windows.

### **Paso 2: Ejecutar el instalador**

1. Abrir el archivo descargado y seguir las instrucciones en pantalla.
2. Aceptar los términos y condiciones y seleccionar la ubicación de instalación.

### **Paso 3: Descargar y ejecutar un modelo**

1. Descargar Llama 3.2 (3B):

```bash
ollama pull llama3.2
```

2. Probar el modelo:

```bash
ollama run llama3.2
```


import os
import subprocess

# Ruta de la carpeta que contiene los archivos MP4
carpeta = r"C:\Jdownloader\Heartstopper\Temporada 1"

# Cambiar al directorio de la carpeta
os.chdir(carpeta)

# Iterar sobre todos los archivos en la carpeta
for archivo in os.listdir(carpeta):
    if archivo.endswith(".mp4"):
        # Construir la ruta completa del archivo
        archivo_mp4 = os.path.join(carpeta, archivo)
        # Construir el nombre del archivo MKV
        archivo_mkv = os.path.splitext(archivo_mp4)[0] + ".mkv"
        
        # Comando para convertir MP4 a MKV
        comando = ['ffmpeg', '-i', archivo_mp4, '-c', 'copy', archivo_mkv]
        
        # Ejecutar el comando
        try:
            subprocess.run(comando, check=True)
            print(f"Convertido: {archivo_mp4} a {archivo_mkv}")
        except subprocess.CalledProcessError:
            print(f"Error al convertir: {archivo_mp4}")

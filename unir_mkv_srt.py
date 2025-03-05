import os
import subprocess

def procesar_carpeta(directorio):
    for nombre_archivo in os.listdir(directorio):
        if nombre_archivo.endswith(('.mkv', '.mp4')):  # Aceptar archivos MKV y MP4
            ruta_video = os.path.join(directorio, nombre_archivo)
            nombre_sin_extension = os.path.splitext(nombre_archivo)[0]

            print(f"Procesando: {ruta_video}")

            # Verificar los flujos de audio y subtítulos disponibles
            ffmpeg_info = subprocess.run(['ffmpeg', '-i', ruta_video], capture_output=True, text=True)
            audio_streams = []
            subtitle_streams = []

            # Procesar la salida para encontrar flujos de audio y subtítulos
            for line in ffmpeg_info.stderr.splitlines():
                if 'Audio:' in line:
                    audio_streams.append(line)
                elif 'Subtitle:' in line:
                    subtitle_streams.append(line)

            # Construir el comando de salida
            comando = ['ffmpeg', '-i', ruta_video]

            # Mapear flujos de audio
            for i, audio in enumerate(audio_streams):
                # Mapeamos solo los flujos de audio que existen
                comando.extend(['-map', f'0:a:{i}'])  # Mapeamos todos los flujos de audio

            # Mapeamos los subtítulos (solo si existen)
            for i, subtitle in enumerate(subtitle_streams):
                comando.extend(['-map', f'0:s:{i}'])  # Mapeamos todos los subtítulos

            # Agregar opciones de codificación
            comando.extend([
                '-c:v', 'copy',  # Copiar video sin recodificar
                '-c:a', 'aac',   # Codificar audio en AAC
                '-c:s', 'mov_text',  # Subtítulos en formato MOV
                os.path.join(directorio, f"{nombre_sin_extension}_final.mp4")  # Salida como MP4
            ])

            # Ejecutar el comando
            resultado = subprocess.run(comando, capture_output=True, text=True)

            if resultado.returncode == 0:
                print(f"El archivo {nombre_sin_extension}_final.mp4 ha sido creado.")
            else:
                print(f"Error al procesar {nombre_sin_extension}: {resultado.stderr}")

def main():
    carpetas = [
        r"C:\Jdownloader\Heartstopper\Temporada 1",
        r"C:\Jdownloader\Heartstopper\Temporada 2"
    ]

    for carpeta in carpetas:
        print(f"Procesando carpeta: {carpeta}")
        procesar_carpeta(carpeta)

if __name__ == "__main__":
    main()

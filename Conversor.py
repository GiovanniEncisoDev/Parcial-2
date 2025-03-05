import os
import rarfile
import tempfile
import cv2

def convertir_cbr_a_pdf(cbr_ruta, pdf_ruta):
    with tempfile.TemporaryDirectory() as temp_dir:
        try:
            # Extraer el contenido del archivo CBR
            with rarfile.RarFile(cbr_ruta) as cbr:
                cbr.extractall(temp_dir)
                print(f"Archivos extraídos de {cbr_ruta}: {os.listdir(temp_dir)}")

            # Obtener todos los archivos de imagen extraídos
            imagenes = [f for f in os.listdir(temp_dir) if f.lower().endswith(('.jpg', '.jpeg', '.png', '.gif', '.bmp'))]
            imagenes.sort()

            # Si no se encontraron imágenes, intenta manejar los archivos sin extensión
            if not imagenes:
                for f in os.listdir(temp_dir):
                    print(f"Archivo sin extensión encontrado: {f}")
                    # Intenta abrirlo como imagen
                    try:
                        img_path = os.path.join(temp_dir, f)
                        img = cv2.imread(img_path)
                        if img is not None:
                            print(f"Imagen encontrada: {f}")
                            imagenes.append(f)  # Agregar a la lista de imágenes encontradas
                    except Exception as e:
                        print(f"No se pudo abrir el archivo {f} como imagen: {e}")

            # Convertir imágenes a PDF
            if imagenes:
                # Guardar imágenes como PDF (utilizando PIL)
                from PIL import Image
                imagenes_pil = [Image.open(os.path.join(temp_dir, img)) for img in imagenes]
                imagenes_pil[0].save(pdf_ruta, save_all=True, append_images=imagenes_pil[1:], resolution=100.0)
                print(f"Convertido {cbr_ruta} a {pdf_ruta}")
            else:
                print(f"No se encontraron imágenes en {cbr_ruta}")
        except Exception as e:
            print(f"Error al convertir {cbr_ruta}: {e}")

# Carpeta que contiene los archivos CBR
carpeta_cbr = r"C:\Jdownloader\Heartstopper\heartstopper"

# Convertir todos los archivos CBR a PDF en la misma carpeta
for archivo in os.listdir(carpeta_cbr):
    if archivo.lower().endswith('.cbr'):
        ruta_cbr = os.path.join(carpeta_cbr, archivo)
        nombre_pdf = os.path.splitext(archivo)[0] + ".pdf"
        ruta_pdf = os.path.join(carpeta_cbr, nombre_pdf)
        convertir_cbr_a_pdf(ruta_cbr, ruta_pdf)

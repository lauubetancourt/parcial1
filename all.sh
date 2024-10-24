# Directorio de las imágenes en Windows accesible desde Ubuntu (WSL)
INPUT_DIR="/mnt/c/Users/laura/Downloads/images"
# Carpeta temporal para archivos binarios
TEMP_DIR="./temp"

# Asegúrate de que el directorio temporal existe
mkdir -p ${TEMP_DIR}

# Procesar cada archivo JPG en el directorio
for INPUT_JPG in ${INPUT_DIR}/*.jpg; do
  echo "Procesando ${INPUT_JPG}..."

  # Convertir JPG a PNG
  PNG_FILE="${TEMP_DIR}/$(basename ${INPUT_JPG} .jpg).png"
  convert "${INPUT_JPG}" "${PNG_FILE}"

  # Crear un nombre temporal basado en el nombre de la imagen PNG
  TEMP_FILE="${TEMP_DIR}/$(basename ${PNG_FILE} .png).bin"

  # Convertir PNG a formato binario
  python3 fromPNG2Bin.py "${PNG_FILE}"

  # Ejecutar el programa C con el archivo binario
  ./main "${TEMP_FILE}"

  # Convertir el archivo binario de salida a PNG
  python3 fromBin2PNG.py "${TEMP_FILE}.new"

  echo "Finalizado ${INPUT_JPG}"
done

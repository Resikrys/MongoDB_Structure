herramienta de línea de comandos mongoimport:

mongoimport --db optica --collection supplier --file supplier.json --jsonArray
mongoimport --db optica --collection glasses --file glasses.json --jsonArray

-- EXEMPLE clients.json:
[
{
  "_id": {
    "$oid": "60c5a2c2f2f7d3a4b5c6d7e8" // Este ID será diferente para cada documento
  },
  "name": "Antonia",
  "surname": "García",
  "phone": "654321098",
  // Añade los campos que faltan:
  "adress": {
    "street": "Avenida Diagonal",
    "number": "200",
    "floor": "1",
    "door": "B",
    "city": "Barcelona",
    "postal_code": "08013",
    "country": "España"
  },
  "fax": "938765432",
  "nif": "87654321B"
}

{
  "_id": {
    "$oid": "685d0d9a7904da4dceba9bf9"
  },
  "name": "Sherlock",
  "surname": "Holmes",
  "adress": {
    "street": "Baker Street",
    "number": "221",
    "floor": "1",
    "door": "B",
    "city": "London",
    "postal_code": "EC1A 1AL",
    "country": "England"
  },
  "phone": "+44 2071234567",
  "fax": "+44931234567",
  "nif": "12345678H"
}
]

-- EJEMPLO SCRIPT POPULATE:
#!/bin/bash

# Este script importa los datos de las colecciones de la óptica a MongoDB.

# Nombre de la base de datos
DB_NAME="optica"

# Directorio donde se encuentran los archivos JSON
DATA_DIR="./data"

echo "Iniciando importación de datos a la base de datos: ${DB_NAME}"
echo "Desde el directorio: ${DATA_DIR}"
echo "--------------------------------------------------"

# Importar la colección 'clients'
echo "Importando clients.json..."
mongoimport --db "$DB_NAME" --collection clients --file "${DATA_DIR}/clients.json" --jsonArray --drop
if [ $? -eq 0 ]; then
    echo "clients.json importado con éxito."
else
    echo "Error al importar clients.json."
fi

# Importar la colección 'supplier'
echo "Importando supplier.json..."
mongoimport --db "$DB_NAME" --collection supplier --file "${DATA_DIR}/supplier.json" --jsonArray --drop
if [ $? -eq 0 ]; then
    echo "supplier.json importado con éxito."
else
    echo "Error al importar supplier.json."
fi

# Importar la colección 'glasses'
echo "Importando glasses.json..."
mongoimport --db "$DB_NAME" --collection glasses --file "${DATA_DIR}/glasses.json" --jsonArray --drop
if [ $? -eq 0 ]; then
    echo "glasses.json importado con éxito."
else
    echo "Error al importar glasses.json."
fi

# Importar la colección 'employee'
echo "Importando employee.json..."
mongoimport --db "$DB_NAME" --collection employee --file "${DATA_DIR}/employee.json" --jsonArray --drop
if [ $? -eq 0 ]; then
    echo "employee.json importado con éxito."
else
    echo "Error al importar employee.json."
fi

# Importar la colección 'sales'
echo "Importando sales.json..."
mongoimport --db "$DB_NAME" --collection sales --file "${DATA_DIR}/sales.json" --jsonArray --drop
if [ $? -eq 0 ]; then
    echo "sales.json importado con éxito."
else
    echo "Error al importar sales.json."
fi

echo "--------------------------------------------------"
echo "Proceso de importación finalizado."
ç
*** NOTAS ***
#!/bin/bash: Esto es el "shebang" y le dice al sistema que el script debe ejecutarse con Bash.

DB_NAME y DATA_DIR: Variables para hacer el script más fácil de modificar.

--jsonArray: Es crucial porque tus archivos JSON exportados de Compass son probablemente un array de documentos, no una serie de documentos separados por líneas.

--drop: Esta opción es muy útil para fines de desarrollo. Elimina la colección existente antes de importar los nuevos datos. Esto asegura que siempre empieces con los datos frescos de tus archivos JSON. Ten mucho cuidado con --drop en entornos de producción, ¡ya que borrará tus datos!

if [ $? -eq 0 ]: Esto comprueba el código de salida del comando anterior. Si es 0, significa que el comando se ejecutó sin errores. Esto es bueno para depuración.

Permisos de ejecución: Antes de ejecutar el script, asegúrate de darle permisos de ejecución:

chmod +x import_data.sh

Ejecución: Para ejecutarlo, navega a la carpeta donde guardaste el script y los datos, y luego:

./import_data.sh

*** FIN NOTAS ***
// db_initialization_script.js

// 1. Seleccionar o crear la base de datos
// Si la base de datos 'BottleButtOptics' no existe, MongoDB la creará al insertar el primer documento
// o al definir una colección/validación.
use BottleButtOptics;

print("--- Inicializando la base de datos BottleButtOptics ---");

// --- 2. Crear o modificar la colección 'clients' ---
// MongoDB crea colecciones automáticamente al insertar el primer documento,
// pero podemos definirlas explícitamente y añadir validaciones si son necesarias.
// Por ahora, solo la creamos si no existe, sin validaciones complejas.
db.createCollection("clients");
print("Colección 'clients' asegurada/creada.");

// --- 3. Crear o modificar la colección 'employees' ---
db.createCollection("employees");
print("Colección 'employees' asegurada/creada.");

// --- 4. Crear o modificar la colección 'suppliers' ---
db.createCollection("suppliers");
print("Colección 'suppliers' asegurada/creada.");


// --- 5. Crear o modificar la colección 'glasses' con validación de esquema ---
// Esta es la parte crucial para la restricción 'enum' en frame_material.
db.runCommand({
  collMod: "glasses", // Si no existe, la creará implícitamente antes de aplicar la validación
  validator: {
    $jsonSchema: {
      bsonType: "object",
      title: "Esquema de Documento de Gafas", // Un título descriptivo
      required: ["brand", "lens_graduation", "color_lens", "frame_material", "frame_color", "price", "supplier_id"], // Campos obligatorios
      properties: {
        _id: {
          bsonType: "objectId",
          description: "Debe ser un ObjectId y es la clave principal."
        },
        brand: {
          bsonType: "string",
          description: "Debe ser una cadena y es obligatorio."
        },
        lens_graduation: {
          bsonType: "object",
          description: "Debe ser un objeto para la graduación de lentes.",
          required: ["right_lens", "left_lens"],
          properties: {
            right_lens: {
              bsonType: ["double", "int"],
              description: "Graduación del ojo derecho (número)."
            },
            left_lens: {
              bsonType: ["double", "int"],
              description: "Graduación del ojo izquierdo (número)."
            }
          }
        },
        color_lens: {
          bsonType: "object",
          description: "Debe ser un objeto para el color de lentes.",
          required: ["right_lens", "left_lens"],
          properties: {
            right_lens: {
              bsonType: "string",
              description: "Color de la lente derecha (cadena)."
            },
            left_lens: {
              bsonType: "string",
              description: "Color de la lente izquierda (cadena)."
            }
          }
        },
        frame_material: {
          bsonType: "string",
          enum: ["Plastic", "Metalic", "Floating"], // La restricción ENUM
          description: "El material de la montura debe ser 'Plastic', 'Metalic' o 'Floating' y es obligatorio."
        },
        frame_color: {
          bsonType: "string",
          description: "El color de la montura debe ser una cadena y es obligatorio."
        },
        price: {
          bsonType: ["double", "int"],
          minimum: 0,
          description: "El precio debe ser un número mayor o igual a 0 y es obligatorio."
        },
        supplier_id: {
          bsonType: "objectId", // Se espera un ObjectId como referencia
          description: "Debe ser un ObjectId de un proveedor y es obligatorio."
        }
      },
      additionalProperties: false // No permite campos que no estén definidos en el esquema
    }
  },
  validationLevel: "strict", // Aplica la validación a todas las inserciones y actualizaciones
  validationAction: "error" // Rechaza los documentos que no cumplan con la validación
});
print("Colección 'glasses' asegurada/creada con validación de esquema.");


// --- 6. Crear o modificar la colección 'sales' ---
db.createCollection("sales");
print("Colección 'sales' asegurada/creada.");


print("--- Proceso de inicialización completado ---");
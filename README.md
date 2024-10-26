# jd_ngu

## Problemas a solucionar (como mínimo)
- Retrasos en la localización
- Errores de gestión
- Sobre carga operativa
## Variables de proceso
- Puede ser para producto terminado o producto por proveedor en espera de ensamble.
- A veces, a mitad de proceso es necesario asignar/cambiar de número de orden/serie.
- La información del producto terminado se encuentra en una hoja impresa pegada al producto (incluye código de barras). Los productos también cuentan con su placa serial.
- Por la naturaleza del proceso, no es posible implementar FIFO.
- Algunas veces las zonas del patio están divididas para mejor gestión, y se debe acomodar el producto dependiendo la zona.

## Nuestra solución
### Generador de estacionamiento

### Gestión de estacionamiento
- Un escaner detectará el ID del vehículo (codigoPais-ModeloBase-Serial)
- Para la entrada de un producto, se obtendrá la información del operador, hora, ID del vehículo, y le dirá qué lugar está disponible (sección/cajón)
- Para la salida de un producto, se escaneará el ID del vehículo, y se verificará que haya entrado en primer lugar. 
- Qué vehículo es, a qué sección, y qué lugares hay

Buenas profesor, la base de datos tambien la subi al repositorio, lo realice en 
Aplicación web, usuando **Java Web (JSP/Servlets)** y **Bootstrap 5**. 
El progrma permite gestionar edificios, unidades, inquilinos, alquileres, 
recibos y movimientos bancarios con control de roles (ADMIN, SECRETARIO, INQUILINO).
Los cuales cada rol tiene sus permimos, aunque el rol de admin y secretario tienen los mismos permisos,
a diferencia del Inquilino que si ya esta mas limitado.

## Este es el login tanto para los admin, secretarios y inquilinos 

<img width="1354" height="1547" alt="image" src="https://github.com/user-attachments/assets/1902d477-3d36-4549-985e-048a5cf5b822" />

## Así seria el inicio de sesion de un inquilino 

<img width="1890" height="1172" alt="image" src="https://github.com/user-attachments/assets/945f7de6-b875-4fdd-ad4e-7f16698a43db" />


## Vamos primero a mostrar todo lo que tiene el inquilino para ver que puede hacer

### 1. Tiene la opcion de Mis recibos, la cual  sirve para ver los recibos que tiene tanto pagados como pendiente tambien tiene la opcion de ver el recibo y descragarlo como pdf 

<img width="1897" height="1139" alt="image" src="https://github.com/user-attachments/assets/b9e1452f-b951-4a5f-a7de-00161454e1af" />

<img width="648" height="1264" alt="image" src="https://github.com/user-attachments/assets/d896b461-13af-4c1d-a247-3aee28eca40b" />

## Este es la opcion de Mi alquiler el cual muestra toda la informacion del contrato

<img width="1867" height="1168" alt="image" src="https://github.com/user-attachments/assets/d564382a-0e23-4fea-8e0f-a5b167710a1b" />

## Este es el perfil de la persona donde se muestra los datos del inquilino

<img width="1843" height="1403" alt="image" src="https://github.com/user-attachments/assets/9f4216c6-8426-4041-a760-77732dcd2d8a" />


## Y así el de un admin y el secretario

<img width="3833" height="1782" alt="image" src="https://github.com/user-attachments/assets/c1032ee0-2e75-427a-b797-7a6a362b3596" />

### Este si tiene muchas opciones la cual mostrare ua por una, comencemos con la gestion de edificios, aqui mostramos los edificos creados y con el boton hacer un nuevo edificio y a su vez de editarlo por su se escribio mal alguna información o deshabilitarlo 

<img width="2501" height="1032" alt="image" src="https://github.com/user-attachments/assets/8b171e66-4862-4a1d-8b8b-62126b15be3f" />

<img width="1232" height="1423" alt="image" src="https://github.com/user-attachments/assets/733e4e56-0090-42bd-a1d3-3819df5485b5" />

### Por ejemplo vamos a crear un nuevo edificio

<img width="1215" height="1175" alt="image" src="https://github.com/user-attachments/assets/d7aac9fe-32a1-4bb5-91f9-5b98f3aa8f5a" />

### Ya se agrego y vamos a mirar que podemos editar
<img width="2500" height="970" alt="image" src="https://github.com/user-attachments/assets/1df667be-3374-43f2-b997-ac634532cb59" />

<img width="1232" height="1290" alt="image" src="https://github.com/user-attachments/assets/98eb9c3c-764f-4570-bc43-bb239b2ba055" />

### Ahora vamos a la gestion de Unidades, que es donde se crean los locales, oficinas o pisos de los edificios que uno haya creado

<img width="2480" height="996" alt="image" src="https://github.com/user-attachments/assets/4bffcec1-5fc4-4eed-b341-4f5ae3023a0c" />

### Vamos crear una unidad en el nuevo edificio que hicimos por ejemplo un piso

<img width="1233" height="1300" alt="image" src="https://github.com/user-attachments/assets/812f3623-edd4-4f86-a807-f992835378fb" />

<img width="2449" height="930" alt="image" src="https://github.com/user-attachments/assets/32337142-4133-45d6-9489-3802d2a5bfda" />

### Ahí creamos el nuevo piso, ahora vamos a la gestion de inquilinos 

<img width="2456" height="1247" alt="image" src="https://github.com/user-attachments/assets/1dac95af-d00b-4bed-a477-6e297696594d" />

### Vamos a crear un nuevo Inquilino

<img width="1474" height="1526" alt="image" src="https://github.com/user-attachments/assets/5c2a361e-2a40-4162-95ad-1bdf5054107d" />

### En el momento de que se crea un nuevo inquilino automaticamente se crea en la base de datos el usuario y contraseña para que pueda entrar al programa como fue mostrado anteriormente 

<img width="1474" height="1526" alt="image" src="https://github.com/user-attachments/assets/58c8dc3b-2a8b-43ed-9313-f7636e16c1ab" />

### Aqui ya se ve en la lista de inquilino 

<img width="2544" height="1426" alt="image" src="https://github.com/user-attachments/assets/9299aea1-691f-4ffb-884c-bf47a938e073" />

### Ahora vamos a los alquileres que es donde los inquilinos pueden arrendar las unidades que fueron creadeas de en los difierentes edificios 

<img width="2478" height="831" alt="image" src="https://github.com/user-attachments/assets/94f7aa2d-a13e-4fb4-87b7-809e19e8dedd" />

### Vamos a crear un nuevo alquiler

<img width="1433" height="1422" alt="image" src="https://github.com/user-attachments/assets/dffda1e0-9ada-4d2f-85c0-0e54022d1c8d" />

### Aqui ya se puede ver en la lista
<img width="2471" height="929" alt="image" src="https://github.com/user-attachments/assets/3f3e1fac-acb3-46f6-b4ba-65f78195a17d" />

### Ahora la gestion de alquileres 

<img width="2229" height="1716" alt="image" src="https://github.com/user-attachments/assets/0b8142d0-c688-4062-8a7b-e6a60f13399c" />

### Tienen la opcion de crear un nuevo recibo y a su vez de clonar recibos, claramente se neceita crear primero un recibo para despues clonarlos y cada piso tiene un N° de recibo unico y que se repite en todos los recibos lo unico que  cambia es la fecha y a la vez tambien tiene filtros por fecha y por pagos pendientes y pagados 

<img width="1333" height="1618" alt="image" src="https://github.com/user-attachments/assets/0fd0a534-a73b-487e-9bd9-6c405dd61112" />

### Aqui esta el recibo 

<img width="916" height="1626" alt="image" src="https://github.com/user-attachments/assets/8dcfb8f5-87ea-4791-9cd7-a339bf1e3d86" />

### Aqui esta la funcion de clonar

<img width="819" height="658" alt="image" src="https://github.com/user-attachments/assets/8d313dad-5337-45e7-97b1-b50683f91c00" />

### Aqui se hizo la clonacion exitosamente 

<img width="2107" height="1437" alt="image" src="https://github.com/user-attachments/assets/09172d8a-86ac-49fd-9233-58fffd8b3dfb" />

### y si aquí se hace la edicion alguna factura se puede agregar adicionales por ejemplo el parqueadero, anteriormente era 141.150 y ahora son 151.150

<img width="1956" height="1650" alt="image" src="https://github.com/user-attachments/assets/45617b11-1343-46ab-a76f-0123783d285e" />

### Tambien se puede ver ahora en la facturala que adicionamos 

<img width="922" height="1695" alt="image" src="https://github.com/user-attachments/assets/3923b444-32ad-4e84-af6b-2d352e627e56" />


### Ahora mostramos los Movimientos Bancarios y tambien se pueden crear nuevo movimiento

<img width="2650" height="832" alt="image" src="https://github.com/user-attachments/assets/c7c3c78a-8510-4448-bd57-e75fa700548e" />


### Aqui mostramos como se crea un nuevo movimiento 
<img width="1573" height="1544" alt="image" src="https://github.com/user-attachments/assets/4a8c0c50-cd64-4600-822a-7a8d034c4cd3" />

### Ahí se ve el movimiento registrado 

<img width="2660" height="805" alt="image" src="https://github.com/user-attachments/assets/245eeaa7-c2b8-44af-9273-a1b89c50e07b" />

### Aqui esta el reporte financiero 

<img width="1237" height="1617" alt="image" src="https://github.com/user-attachments/assets/b7e0cbcd-d783-4abf-9cbc-6172d5af39b5" />

### Aqui estan las cuentas bancarias para añadir las cuentas

<img width="2470" height="801" alt="image" src="https://github.com/user-attachments/assets/06e086d1-39cf-4b7c-bfc5-d283685a9d64" />

### Aqui esta la creacion de la cuenta 

<img width="1260" height="1258" alt="image" src="https://github.com/user-attachments/assets/541b6d25-47d2-4297-b9f8-d29c825bdf0a" />

### Cambios hecho
<img width="2496" height="737" alt="image" src="https://github.com/user-attachments/assets/abe03bae-dee5-4b2b-8c0c-8e30a02be54d" />

### Y como ultimo aqui las ganancias de los edificios

.<img width="2247" height="1687" alt="image" src="https://github.com/user-attachments/assets/d3f6d062-1939-4371-9498-f5b02abdca70" />

package model.dao;


import model.dao.InmuebleDAO;
import model.entity.Inmueble;

public class Test {

    public static void main(String[] args) {

        Inmueble inmueble =
                new Inmueble();

        inmueble.setTipo("PISO");

        inmueble.setDireccion(
                "Calle 45"
        );

        inmueble.setNumero("12A");

        inmueble.setCodigoPostal("080001");

        inmueble.setCiudad("Barranquilla");

        inmueble.setEstado("DISPONIBLE");

        InmuebleDAO dao =
                new InmuebleDAO();

        boolean guardado =
                dao.guardar(inmueble);

        if (guardado) {

            System.out.println(
                    "Inmueble guardado correctamente"
            );

        } else {

            System.out.println(
                    "Error guardando inmueble"
            );
        }
    }
}
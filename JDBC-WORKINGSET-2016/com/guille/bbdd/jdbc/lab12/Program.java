package com.guille.bbdd.jdbc.lab12;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

import com.guille.bbdd.jdbc.bundle.Bundle;
import com.guille.bbdd.jdbc.database.Database;
import com.guille.bbdd.jdbc.database.OracleDatabase;

public class Program {

	private static Database DESA = new OracleDatabase();
	private static ResultSet rs = null;

	public static final String PROTOCOL_JDBC = Bundle.getString("bundle.desa.protocol");
	public static final String VENDOR_ORACLE = Bundle.getString("bundle.desa.vendor");
	public static final String DRIVER_THIN = Bundle.getString("bundle.desa.driver");
	public static final String DEFAULT_SERVER = Bundle.getString("bundle.desa.server");
	public static final String DEFAULT_PORT = Bundle.getString("bundle.desa.port");
	public static final String DEFAULT_DATABASE = Bundle.getString("bundle.desa.database.name");

	private static final String DESA_USER = Bundle.getString("bundle.desa.user");
	private static final String DESA_PASS = Bundle.getString("bundle.desa.pass");

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
	
		// Connecting to the database.
		DESA.connectDatabase(PROTOCOL_JDBC, VENDOR_ORACLE, DRIVER_THIN, DEFAULT_SERVER, DEFAULT_PORT, DEFAULT_DATABASE, DESA_USER, DESA_PASS);
		
		//exercise1_1();
		//exercise1_2();
		//exercise2("rojo");
		exercise3();
		
	}

	/*
	 * 1. Mostrar por pantalla los resultados de las consultas 21 y 32 de la
	 * Pr�ctica 2. 1.1. 21. Obtener el nombre y el apellido de los clientes que
	 * han adquirido un coche en un concesionario de Madrid, el cual dispone de
	 * coches del modelo gti.
	 */
	public static void exercise1_1() throws SQLException {
		String query = ("SELECT DISTINCT clientes.nombre, clientes.apellido " + "FROM clientes, ventas, concesionarios "
				+ "WHERE clientes.dni=ventas.dni " + "AND ventas.cifc=concesionarios.cifc "
				+ "AND concesionarios.cifc IN "
				+ "( SELECT concesionarios.cifc from concesionarios, distribucion, coches "
				+ "WHERE concesionarios.cifc=distribucion.cifc " + "AND distribucion.codcoche=coches.codcoche "
				+ "AND coches.modelo='gti' )");

		rs = DESA.executeSQL(query);

		System.out.println("----- 1-1 -----");
		while (rs.next()) {
			String name = rs.getString(1);
			String surname = rs.getString(2);
			System.out.println(name + " " + surname);
		}


	}

	/*
	 * 1.2. 32. Obtener un listado de los concesionarios cuyo promedio de coches
	 * supera a la cantidad promedio de todos los concesionarios.
	 */
	public static void exercise1_2() throws SQLException {

		String query = "SELECT distribucion.cifc cif, nombrec nombre, ciudadc ciudad, AVG(cantidad) cantidad " 
				+ "FROM distribucion, concesionarios " + "WHERE concesionarios.cifc=distribucion.cifc "  //$NON-NLS-2$
				+ "GROUP BY distribucion.cifc, concesionarios.nombrec, concesionarios.ciudadc " 
				+ "HAVING AVG(cantidad) > (SELECT AVG(cantidad) FROM distribucion)"; 

		rs = DESA.executeSQL(query);

		System.out.println("----- 1-2 -----"); 
		while (rs.next()) {
			String cif = rs.getString("cif"); 
			String nombre = rs.getString("nombre"); 
			String ciudad = rs.getString("ciudad"); 
			String cantidad = rs.getString("cantidad"); 

			System.out.println(cif + " " + nombre + " " + ciudad + " " + cantidad + " ");  //$NON-NLS-2$ //$NON-NLS-3$ //$NON-NLS-4$
		}
	}

	/*
	 * 2. Mostrar por pantalla el resultado de la consulta 6 de la Pr�ctica 2 de
	 * forma el color de la b�squeda sea introducido por el usuario. 6. Obtener
	 * el nombre de las marcas de las que se han vendido coches de un color
	 * introducido por el usuario.
	 */
	public static void exercise2(String color) throws SQLException {
		String query = "SELECT DISTINCT nombrem " + "FROM marcas, marco, coches, ventas "  //$NON-NLS-2$
				+ "WHERE marcas.cifm=marco.cifm " + "AND marco.codcoche=coches.codcoche "  //$NON-NLS-2$
				+ "AND coches.codcoche=ventas.codcoche " + "AND ventas.color = ?";  //$NON-NLS-2$
		String[] parameters = new String[1];
		parameters[0] = color;
		rs = DESA.executePreparedSQL(query, parameters);
		System.out.println("----- 2 -----"); 
		while (rs.next()) {
			String nombre = rs.getString(1);
			System.out.println(nombre);
		}

	}

	/*
	 * 3. Realizar una aplicaci�n en Java para ejecutar la consulta 27 de la
	 * Pr�ctica 2 de forma que los l�mites la cantidad de coches sean
	 * introducidos por el usuario. 27. Obtener el cifc de los concesionarios
	 * que disponen de una cantidad de coches comprendida entre dos cantidades
	 * introducidas por el usuario, ambas inclusive.
	 */
	public static void exercise3() throws SQLException {
		String sql = "SELECT DISTINCT concesionarios.cifc, SUM(distribucion.cantidad) stock " 
				+ "FROM distribucion, concesionarios " 
				+ "WHERE distribucion.cifc=concesionarios.cifc " 
				+ "GROUP BY concesionarios.cifc " 
				+ "HAVING SUM(distribucion.cantidad) >=? " 
				+ "AND SUM(distribucion.cantidad) <=?"; 
		System.out.print("Enter the lower ammount: "); 
		int lower = ReadInt();
		System.out.print("Enter the higer ammount: "); 
		int higher = ReadInt();
		
		Integer[] parameters = new Integer[2];
		parameters[0] = lower;
		parameters[1] = higher;
		
		rs = DESA.executePreparedSQL(sql, parameters);
		
		while(rs.next()) {
			String cifc = rs.getString(1);
			int stock = rs.getInt(2);
			
			System.out.println(cifc + " : " + stock); 
		}
	}

	/*
	 * 4. Realizar una aplicaci�n en Java para ejecutar la consulta 24 de la
	 * Pr�ctica 2 de forma que tanto la ciudad del concesionario como el color
	 * sean introducidos por el usuario. 24. Obtener los nombres de los clientes
	 * que no han comprado coches de un color introducido por el usuario en
	 * concesionarios de una ciudad introducida por el usuario.
	 */
	public static void exercise4() throws SQLException {
		String sql = "SELECT  clientes.nombre FROM clientes " 
				+ "WHERE dni NOT IN " 
				+ "(SELECT clientes.dni FROM clientes, ventas, concesionarios " 
				+ "WHERE clientes.dni=ventas.dni " 
				+ "AND ventas.cifc=concesionarios.cifc " 
				+ "AND concesionarios.ciudadc = ?" 
				+ "AND ventas.color = ?)"; 
		
		System.out.print("Enter the city of the dealer: "); 
		String city = ReadString();
		System.out.print("Enter the color of the car: "); 
		String color = ReadString();
		
		String[] parameters = new String[2];
		parameters[0] = city;
		parameters[1] = color;
		
		rs = DESA.executePreparedSQL(sql, parameters);
		
		while(rs.next()) {
			String nombre = rs.getString(1);
			System.out.println(nombre);
		}

	}

	/*
	 * 5. Realizar una aplicaci�n en Java que haciendo uso de la instrucci�n SQL
	 * adecuada: 5.1. Introduzca datos en la tabla coches cuyos datos son
	 * introducidos por el usuario
	 */
	public static void exercise5_1() {

	}

	/*
	 * 5.2. Borre un determinado coche cuyo c�digo es introducido por el
	 * usuario.
	 */
	public static void exercise5_2() {

	}

	/*
	 * 5.3. Actualice el nombre y el modelo para un determinado coche cuyo
	 * c�digo es introducido por el usuario.
	 */
	public static void exercise5_3() {

	}

	/*
	 * 6. Invocar la funci�n y el procedimiento del ejercicio 10 de la Pr�ctica
	 * 10 desde una aplicaci�n Java. 10. Realizar un procedimiento y una funci�n
	 * que dado un c�digo de concesionario devuelve el n�mero ventas que se han
	 * realizado en el mismo. 6.1. Funcion
	 */
	public static void exercise6_1() {

	}

	/*
	 * 6.1. Procedimiento
	 */
	public static void exercise6_2() {

	}

	/*
	 * 7. Invocar la funci�n y el procedimiento del ejercicio 11 de la Pr�ctica
	 * 10 desde una aplicaci�n Java. 11. Realizar un procedimiento y una funci�n
	 * que dada una ciudad que se le pasa como par�metro devuelve el n�mero de
	 * clientes de dicha ciudad. 7.1. Funcion
	 */
	public static void exercise7_1() {

	}

	/*
	 * 7.2. Procedimiento
	 */
	public static void exercise7_2() {

	}

	/**
	 * Reads an string from the console.
	 * 
	 * @return the input as an string.
	 */
	@SuppressWarnings("resource")
	private static String ReadString() {
		return new Scanner(System.in).nextLine();
	}

	/**
	 * Reads an integer from the console.
	 * 
	 * @return the input as an integer.
	 */
	@SuppressWarnings("resource")
	private static int ReadInt() {
		return new Scanner(System.in).nextInt();
	}

}
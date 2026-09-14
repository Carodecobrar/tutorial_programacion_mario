function scr_MovimientoJugador(){
	//Izquierda
	if (flechaIzquierda) {
		direccion = -1;
	}
	//Derecha
	if (flechaDerecha) {
		direccion = 1;
	}
	//Ninguna de las flechas de direccion
	if (!flechaIzquierda && !flechaDerecha) {
		direccion = 0;
	}
	//Gravedad
	velocidadVertical += gravedad;
	//Colisiones
	//Vertical
	jugadorTocandoElSuelo = false;
	//funciones predefinidas en Game Maker para detectar colisiones
	//jugadorTocandoElSuelo = place_meeting(x, y, obj_suelo);
	jugadorTocandoElSuelo = instance_place(x, y+velocidadVertical, obj_suelo);
	if (jugadorTocandoElSuelo != -4) {
		velocidadVertical = 0;
	}
	//Horizontal
	jugadorEstaTocandoUnaPared = place_meeting(x+(aceleracion*direccion), y, obj_suelo);
	if (!jugadorEstaTocandoUnaPared) {
		velocidadHorizontal = aceleracion * direccion;
	} else {
		velocidadHorizontal = 0;
	}
	//Salto
	if (teclaSalto && jugadorTocandoElSuelo) {
		velocidadVertical -= velocidadSalto;
	}
}
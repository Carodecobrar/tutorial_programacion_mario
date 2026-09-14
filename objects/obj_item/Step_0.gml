switch(nombre) {
	case Nombres.Hongo:
		if (direccion == 0) {
			direccion = -1;
		}
		aceleracion = .8;
		sprite = spr_Hongo;
		puedeMoverse = true;
		puedeTocarParedes = true;
		break;
	case Nombres.Flor:
		sprite = spr_Flor;
		puedeTocarParedes = true;
		puedeMoverse = true;
		break;
}
if (sprite != noone) {
	sprite_index = sprite;
}
if (puedeTocarParedes) {
	//Vertical
	velocidadVertical += gravedad;
	//funciones predefinidas en Game Maker para detectar colisiones
	//jugadorTocandoElSuelo = place_meeting(x, y, obj_suelo);
	itemTocandoElSuelo = instance_place(x, y+velocidadVertical, obj_suelo);
	if (itemTocandoElSuelo != -4) {
		velocidadVertical = 0;
	}
	//Horizontal
	itemEstaTocandoUnaPared = place_meeting(x+(aceleracion*direccion), y, obj_suelo);
	if (!itemEstaTocandoUnaPared) {
		velocidadHorizontal = aceleracion * direccion;
	} else {
		direccion = direccion * -1;
	}
}
if (puedeMoverse) {
	x += velocidadHorizontal;
	y += velocidadVertical;
}
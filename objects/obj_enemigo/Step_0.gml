switch(nombre) {
	case Nombres.Goomba:
		if (direccion == 0) {
			direccion = -1;
		}
		aceleracion = .5;
		sprite = spr_Goomba;
		puedeMoverse = true;
		puedeTocarParedes = true;
		puedeRebotarEnParedes = true;
		image_speed = .05;
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
		if (puedeRebotarEnParedes == true) {
			direccion = direccion * -1;
		} else {
			velocidadHorizontal = 0;
		}
	}
}
if (puedeMoverse) {
	x += velocidadHorizontal;
	y += velocidadVertical;
}
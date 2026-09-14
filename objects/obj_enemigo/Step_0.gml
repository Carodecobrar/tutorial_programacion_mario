switch(nombre) {
	case Nombres.Goomba:
		if (direccion == 0) {
			direccion = -1;
		}
		aceleracion = .5;
		sprite = spr_Goomba;
		spriteAplastado = spr_Goomba_Aplastado;
		puedeMoverse = true;
		puedeTocarParedes = true;
		puedeRebotarEnParedes = true;
		image_speed = .05;
		maxContadorAplastado = 60;
		break;
}
switch(estado) {
	case Estados.Moverse:
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
		break;
	case Estados.Muerto:
		switch(tipoDeMuerte) {
			case TiposDeMuerte.Aplastado:
				sprite = spriteAplastado;
				if (contadorAplastado < maxContadorAplastado) {
					contadorAplastado++;
				} else {
					instance_destroy();
				}
				break;
		}
		break;
}
if (sprite != noone) {
	sprite_index = sprite;
}
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
	case Nombres.KoopaTroopa:
		if (direccion == 0) {
			direccion = -1;
		}
		aceleracion = .7;
		sprite = spr_KoopaTroopa;
		spriteAplastado = spr_KoopaTroopa_Aplastado;
		if (estado != Estados.Aplastado) {
			puedeMoverse = true;
			puedeTocarParedes = true;
			puedeRebotarEnParedes = true;
		}
		image_speed = .08;
		maxContadorAplastado = 240;
		aceleracionMientrasAplastado = 3;
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
					direccion *= -1;
					image_xscale *= -1;
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
	case Estados.Aplastado:
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
			itemEstaTocandoUnaPared = place_meeting(x+(aceleracionMientrasAplastado*direccion), y, obj_suelo);
			if (!itemEstaTocandoUnaPared) {
				velocidadHorizontal = aceleracionMientrasAplastado * direccion;
			} else {
				if (puedeRebotarEnParedes == true) {
					direccion *= -1;
					image_xscale *= -1;
				} else {
					velocidadHorizontal = 0;
				}
			}
		}
		if (puedeMoverse) {
			x += velocidadHorizontal;
			y += velocidadVertical;
		}
		sprite = spriteAplastado;
		image_index = 0;
		image_speed = 0;
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
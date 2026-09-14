switch(nombre) {
	case Nombres.BolaDeFuego:
		if (direccion == 0) {
			direccion = 1;
		}
		if (aceleracion == 0) {
			aceleracion = 3;
		}
		sprite = spr_BolaDeFuego;
		puedeMoverse = true;
		puedeTocarParedes = true;
		destruirseAlTocarParedes = true;
		destruirseAlTocarEnemigos = true;
		saltarAlTocarElSuelo = true;
		velocidadSalto = 2.5;
		break;
	case Nombres.Explosion:
		sprite = spr_Explosion;
		var limite = sprite_get_number(sprite)-1;
		if (round(image_index) == limite) {
			destruirse = true;
		} else if (destruirse == true) {
			instance_destroy();
		}
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
		if (saltarAlTocarElSuelo) {
			aceleracion = 4.5;
			velocidadVertical -= velocidadSalto;
		}
	}
	//Horizontal
	itemEstaTocandoUnaPared = place_meeting(x+(aceleracion*direccion), y, obj_suelo);
	if (!itemEstaTocandoUnaPared) {
		velocidadHorizontal = aceleracion * direccion;
	} else {
		direccion = direccion * -1;
		if (destruirseAlTocarParedes) {
			switch(nombre) {
				case Nombres.BolaDeFuego:
					var explosion = instance_create_layer(x, y, "Personajes" ,obj_efecto);
					explosion.nombre = Nombres.Explosion;
					explosion.image_index = 0;
					explosion.image_speed = 0.7;
					instance_destroy();
					break;
			}
		}
	}
	var enemigoTocado = instance_place(x, y, obj_enemigo);
	if (enemigoTocado != noone && destruirseAlTocarEnemigos) {
		switch(nombre) {
			case Nombres.BolaDeFuego:
				//Explosion
				var explosion = instance_create_layer(x, y, "Explosiones" ,obj_efecto);
				explosion.nombre = Nombres.Explosion;
				explosion.image_index = 0;
				explosion.image_speed = 0.7;
				//Herir enemigo
				with(enemigoTocado) {
					salud--;
					if (salud <=0) {
						estado = Estados.Muerto;
						tipoDeMuerte = TiposDeMuerte.Arrojado;
						direccion = other.image_xscale;
						velocidadVertical = 0;
						velocidadVertical -= velocidadArrojado;
					}
				}
				instance_destroy();
				break;
		}
	}
}
if (puedeMoverse) {
	x += velocidadHorizontal;
	y += velocidadVertical;
}
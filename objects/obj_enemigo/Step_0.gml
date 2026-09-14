switch(nombre) {
	case Nombres.Goomba:
		if (direccion == 0) {
			direccion = -1;
		}
		if (estado != Estados.Muerto) {
			aceleracion = .5;
		}
		sprite = spr_Goomba;
		spriteAplastado = spr_Goomba_Aplastado;
		spriteArrojado = spr_Goomba;
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
		if (estado != Estados.Muerto) {
			aceleracion = .7;
		}
		sprite = spr_KoopaTroopa;
		spriteAplastado = spr_KoopaTroopa_Aplastado;
		spriteArrojado = spr_KoopaTroopa_Aplastado;
		if (estado != Estados.Aplastado) {
			puedeMoverse = true;
			puedeTocarParedes = true;
			puedeRebotarEnParedes = true;
		}
		image_speed = .08;
		maxContadorAplastado = 240;
		aceleracionMientrasAplastado = 3;
		puedeHerirEnemigosAlEstarAplastado = true;
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
			var enemigoTocado = instance_place(x, y, obj_enemigo),
				tocandoEnemigo = enemigoTocado != noone && enemigoTocado != id;
			if (!itemEstaTocandoUnaPared) {
				velocidadHorizontal = aceleracion * direccion;
				if (tocandoEnemigo && checkColisionEnemigos == false && contadorColisionConEnemigos == 0) {
					var enemigosEncontrandose = direccion != enemigoTocado.direccion && enemigoTocado.checkColisionEnemigos == false,
						enemigoMismaDireccionPeroMiVelocidadEsMayor = direccion == enemigoTocado.direccion && aceleracion > enemigoTocado.aceleracion,
						puedeCambiarDeDireccion = enemigosEncontrandose || enemigoMismaDireccionPeroMiVelocidadEsMayor;
					if (puedeCambiarDeDireccion && enemigoTocado.estado == Estados.Moverse) {
						direccion *= -1;
						image_xscale *= -1;
						checkColisionEnemigos = true;
					}
				}
			} else {
				if (puedeRebotarEnParedes == true || tocandoEnemigo) {
					direccion *= -1;
					image_xscale *= -1;
				} else {
					velocidadHorizontal = 0;
				}
			}
		}
		if (checkColisionEnemigos == true) {
			if (contadorColisionConEnemigos < maxContadorColisionConEnemigos) {
				contadorColisionConEnemigos++;
			} else {
				checkColisionEnemigos = false;
				contadorColisionConEnemigos = 0;
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
			if (puedeHerirEnemigosAlEstarAplastado && velocidadHorizontal != 0) {
				var enemigoHerido = instance_place(x, y, obj_enemigo);
				if (enemigoHerido != noone && enemigoHerido.estado == Estados.Moverse && enemigoHerido.salud > 0) {
					enemigoHerido.salud--;
					//Herir enemigo
					with(enemigoHerido) {
						salud--;
						if (salud <=0) {
							estado = Estados.Muerto;
							tipoDeMuerte = TiposDeMuerte.Arrojado;
							direccion = other.direccion;
							velocidadVertical = 0;
							velocidadVertical -= velocidadArrojado;
						}
					}
				}
			}
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
			case TiposDeMuerte.Arrojado:
				sprite = spriteArrojado;
				image_index = 0;
				image_speed = 0;
				image_yscale = -1;
				aceleracion = 1;
				//Gravedad
				velocidadVertical += gravedad;
				//Movimiento horizontal
				velocidadHorizontal = aceleracion * direccion;
				x += velocidadHorizontal;
				y += velocidadVertical;
				break;
		}
		break;
}
if (sprite != noone) {
	sprite_index = sprite;
}
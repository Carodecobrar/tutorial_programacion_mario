function scr_EstadosJugador(){
	switch(estado){
		case Estados.Moverse:
			scr_MovimientoJugador();
			//Transformarse segun items
			var itemQueEstaTocando = instance_place(x, y, obj_item),
				enemigoQueEstaTocando = instance_place(x+(aceleracion*direccion), y, obj_enemigo);
			if (itemQueEstaTocando != noone) {
				switch(itemQueEstaTocando.nombre) {
					case Nombres.Hongo:
						//De chiquito a grande
						if (faseMario == FasesMario.Mario) {
							sprite = spr_Mario;
							maxContadorTransformacion = 7;
							estadoTemporalMario = FasesMario.SuperMario;
							velocidadVerticalTemporal = velocidadVertical;
							with (itemQueEstaTocando) {
								instance_destroy();
							}
							estado = Estados.Transformar;
						}
						break;
					case Nombres.Flor:
						//De grande a fuego
						if (faseMario == FasesMario.SuperMario) {
							sprite = spr_Mario;
							estadoTemporalMario = FasesMario.FuegoMario;
							velocidadVerticalTemporal = velocidadVertical;
							with (itemQueEstaTocando) {
								instance_destroy();
							}
							estado = Estados.Transformar;
						}
						break;
				}
			} else if (enemigoQueEstaTocando != noone) {
				switch(enemigoQueEstaTocando.nombre) {
					case Nombres.Goomba:
						//De grande a chiquito
						if (faseMario == FasesMario.SuperMario) {
							faseMario = FasesMario.Mario;
							sprite = spr_Mario;
							maxContadorTransformacion = 7;
							estadoTemporalMario = FasesMario.Mario;
							velocidadVerticalTemporal = velocidadVertical;
							estado = Estados.Transformar;
						}
						break;
				}
			}
			scr_AnimacionesJugador();
			break;
		case Estados.Transformar:
			velocidadHorizontal = 0;
			velocidadVertical = 0;
			switch(faseMario) {
				case FasesMario.Mario:
					//Frames de transformacion
					if (contadorTransformacion < maxContadorTransformacion) {
						contadorTransformacion++;
					} else {
						//Cuando termine la fase
						switch(faseTransformacion) {
							case 0:
								//Asignar sprite
								sprite = spr_MarioMediano;
								maxContadorTransformacion = 1;
								faseTransformacion++;
								break;
							case 1:
								//Asignar sprite
								sprite = spr_Mario;
								maxContadorTransformacion = 4;
								faseTransformacion++;
								break;
							case 2:
								//Asignar sprite
								sprite = spr_MarioMediano;
								maxContadorTransformacion = 4;
								faseTransformacion++;
								break;
							case 3:
								//Asignar sprite
								sprite = spr_Mario;
								maxContadorTransformacion = 4;
								faseTransformacion++;
								break;
							case 4:
								//Asignar sprite
								sprite = spr_MarioMediano;
								maxContadorTransformacion = 4;
								faseTransformacion++;
								break;
							case 5:
								//Asignar sprite
								sprite = spr_SuperMario;
								maxContadorTransformacion = 4;
								faseTransformacion++;
								break;
							case 6:
								//Asignar sprite
								sprite = spr_Mario;
								maxContadorTransformacion = 4;
								faseTransformacion++;
								break;
							case 7:
								//Asignar sprite
								sprite = spr_MarioMediano;
								maxContadorTransformacion = 4;
								faseTransformacion++;
								break;
							case 8:
								//Asignar sprite
								sprite = spr_SuperMario;
								maxContadorTransformacion = 4;
								faseTransformacion++;
								break;
							case 9:
								//Asignar sprite
								sprite = spr_Mario;
								maxContadorTransformacion = 4;
								faseTransformacion++;
								break;
							case 10:
								//Asignar sprite
								sprite = spr_Mario;
								maxContadorTransformacion = 1;
								faseTransformacion++;
								break;
							case 11:
								contadorTransformacion = 0;
								maxContadorTransformacion = 0;
								faseTransformacion = 0;
								faseMario = estadoTemporalMario;
								velocidadVertical = velocidadVerticalTemporal;
								velocidadVerticalTemporal = 0;
								estado = Estados.Moverse;
								break;
						}
						contadorTransformacion = 0;
					}
					break;
				case FasesMario.SuperMario:
					contadorTransformacion = 0;
					maxContadorTransformacion = 0;
					faseTransformacion = 0;
					faseMario = estadoTemporalMario;
					velocidadVertical = velocidadVerticalTemporal;
					velocidadVerticalTemporal = 0;
					estado = Estados.Moverse;
					break;
			}
			break;
	}
}
function scr_EstadosJugador(){
	switch(estado){
		case Estados.Moverse:
			scr_MovimientoJugador();
			//Transformarse segun las teclas
			if (flechaArriba || flechaAbajo) {
				if (faseMario == FasesMario.Mario) {
					//Aqui deberia ser -1
					sprite = spr_Mario;
					maxContadorTransformacion = 7;
				}
				if (faseMario <= FasesMario.EstrellaMario && faseMario >= FasesMario.Mario) {
					if (flechaArriba) {
						estadoTemporalMario = faseMario + 1;
					}
					if (flechaAbajo) {
						estadoTemporalMario = faseMario - 1;
					}
				}
				velocidadVerticalTemporal = velocidadVertical;
				estado = Estados.Transformar;
			}
			scr_AnimacionesJugador();
			break;
		case Estados.Transformar:
			velocidadHorizontal = 0;
			velocidadVertical = 0;
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
	}
}
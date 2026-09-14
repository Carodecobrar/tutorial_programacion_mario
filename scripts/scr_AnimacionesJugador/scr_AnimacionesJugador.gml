function scr_AnimacionesJugador() {
	var spriteQuieto = spr_Mario,
		spriteCaminando = spr_Mario_Caminando,
		spriteSaltando = spr_Mario_Saltando;
	switch(faseMario) {
		case FasesMario.SuperMario:
			spriteQuieto = spr_SuperMario;
			spriteCaminando = spr_SuperMario_Caminando;
			spriteSaltando = spr_SuperMario_Saltando;
			break;
		case FasesMario.FuegoMario:
			spriteQuieto = spr_SuperMarioFuego;
			spriteCaminando = spr_SuperMarioFuego_Caminando;
			spriteSaltando = spr_SuperMarioFuego_Saltando;
			break;
	}
	if (direccion == 0) {
		sprite = spriteQuieto;
	} else {
		image_xscale = direccion;
		sprite = spriteCaminando;
	}
	if (!jugadorTocandoElSuelo) {
		sprite = spriteSaltando;
	}
	if (estado == Estados.Moverse && disparando) {
		sprite = spr_SuperMarioFuego_Disparando;
		image_speed = 0;
		if (contadorDisparando < maxContadorDisparando) {
			contadorDisparando++;
		} else {
			image_speed = .25;
			disparando = false;
			contadorDisparando = 0;
		}
	}
}
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
}
function scr_ColisionarConEnemigos(enemigoQueEstaTocando){
	var jugadorY = round(y),
		enemigoY = round(enemigoQueEstaTocando.y),
		colisionDeLado = jugadorY == enemigoY,
		colisionPorArriba = jugadorY < enemigoY,
		colisionPorAbajo = jugadorY > enemigoY;
	switch(enemigoQueEstaTocando.nombre) {
		case Nombres.Goomba:
			//De grande a chiquito
			if ((colisionDeLado || colisionPorAbajo) && faseMario == FasesMario.SuperMario) {
				AchiquitarJugador();
			}
			//Aplastar
			else if (colisionPorArriba) {
				//Aplastar hongo
				with (enemigoQueEstaTocando) {
					estado = Estados.Muerto;
					tipoDeMuerte = TiposDeMuerte.Aplastado;
				}
				SaltarAlAplastar(enemigoQueEstaTocando);
			}
			//Muerte porque es chiquito
			else if ((colisionDeLado || colisionPorAbajo) && faseMario == FasesMario.Mario) {
				estado = Estados.Muerto;
			}
			break;
		case Nombres.KoopaTroopa:
			//De grande a chiquito
			if ((colisionDeLado || colisionPorAbajo)) {
				var enemigoSePuedePatear = enemigoQueEstaTocando.estado == Estados.Aplastado && enemigoQueEstaTocando.puedeMoverse == false;
				if (colisionDeLado && enemigoSePuedePatear && jugadorTocandoElSuelo) {
					//Patear tortuga
					PatearEnemigo(enemigoQueEstaTocando);
				} else {
					if (faseMario > FasesMario.Mario) {
						AchiquitarJugador();
					} else {
						estado = Estados.Muerto;
					}
				}
			}
			//Aplastar
			else if (colisionPorArriba) {
				//Aplastar tortuga
				with (enemigoQueEstaTocando) {
					estado = Estados.Aplastado;
				}
				SaltarAlAplastar(enemigoQueEstaTocando);
			}
			break;
	}
}
function AchiquitarJugador() {
	faseMario = FasesMario.Mario;
	sprite = spr_Mario;
	maxContadorTransformacion = 7;
	estadoTemporalMario = FasesMario.Mario;
	velocidadVerticalTemporal = velocidadVertical;
	estado = Estados.Transformar;
}
function SaltarAlAplastar(enemigo) {
	velocidadVertical = 0;
	velocidadVertical -= velocidadSaltoAlAplastar;
	with(enemigo) {
		puedeTocarParedes = false;
		puedeMoverse = false;
	}
}
function PatearEnemigo(enemigo) {
	with(enemigo) {
		direccion = other.image_xscale;
		puedeTocarParedes = true;
		puedeMoverse = true;
	}
}
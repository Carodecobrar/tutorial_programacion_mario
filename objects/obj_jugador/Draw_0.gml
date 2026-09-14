//draw_sprite(spr_Mario, 0, x, y);
draw_self();
//draw_sprite(mask_index, 0, x, y);
var alturaTexto = sprite_height;
var espacioEntreTextos = alturaTexto / 4;
var diferenciaY = (alturaTexto + espacioEntreTextos) + 50;
var anchoTexto = sprite_width;
draw_text(x - anchoTexto, y - diferenciaY, "x: " + string(x) + ", y: " + string(y) + "\nc: " + string(contadorTransformacion));
//draw_circle(x, y, 5, false);
flechaIzquierda = keyboard_check(vk_left);
flechaDerecha = keyboard_check(vk_right);
flechaArriba = keyboard_check(vk_up);
flechaAbajo = keyboard_check(vk_down);
teclaSalto = keyboard_check_pressed(vk_space);
scr_EstadosJugador();
sprite_index = sprite;
x += velocidadHorizontal;
y += velocidadVertical;
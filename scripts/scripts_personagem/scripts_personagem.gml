// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_personagem_andando(){
	// MOVIMENTAÇÃO
	dir = keyboard_check(ord("D"));
	esq = keyboard_check(ord("A"));
	baixo = keyboard_check(ord("S"));
	cima = keyboard_check(ord("W"));

	hvel = (dir - esq) * vel;

	if place_meeting(x + hvel, y, obj_parede){
		while !place_meeting(x + sign(hvel), y, obj_parede){
			x += sign(hvel);
		}
	
		hvel = 0;
	}

	x += hvel;

	vvel = (baixo - cima) * vel;

	if place_meeting(x, y + vvel, obj_parede){
		while !place_meeting(x, y + sign(vvel), obj_parede){
			x += sign(vvel);
		}
	
		vvel = 0;
	}

	y += vvel;

	// SPRITES
	direcao = floor((point_direction(x, y, mouse_x, mouse_y)+45)/90);

	if hvel == 0 and vvel == 0{
		switch direcao{
			default:
				sprite_index = spr_personagem_parado_direita;
			break;
			case 1:
				sprite_index = spr_personagem_parado_cima;
			break;
			case 2:
				sprite_index = spr_personagem_parado_esquerda;
			break;
			case 3:
				sprite_index = spr_personagem_parado_baixo;
			break;
		}
	}
	else{
		switch direcao{
			default:
				sprite_index = spr_personagem_correndo_direita;
			break;
			case 1:
				sprite_index = spr_personagem_correndo_cima;
			break;
			case 2:
				sprite_index = spr_personagem_correndo_esquerda;
			break;
			case 3:
				sprite_index = spr_personagem_correndo_baixo;
			break;
		}
	}
	
	if mouse_check_button_pressed(mb_right){
		alarm[0] = 8;
		dash_dir = point_direction(x, y, mouse_x, mouse_y);
		state = scr_personagem_dash;
	}
}

function scr_personagem_dash(){
	hvel = lengthdir_x(dash_vel, dash_dir);
	vvel = lengthdir_y(dash_vel, dash_dir);
	
	x += hvel;
	y += vvel;
	
	var _inst =	instance_create_layer(x, y, "Instances", obj_dash);
	_inst.sprite_index = sprite_index;
}
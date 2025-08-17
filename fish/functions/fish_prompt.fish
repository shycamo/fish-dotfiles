function fish_prompt
 # Directory name
	set_color yellow
	echo " "
	echo (prompt_pwd)


 # Arrow
	set_color blue
	echo -n " > "
	set_color normal
end

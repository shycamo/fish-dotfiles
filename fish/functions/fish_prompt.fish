function fish_prompt
 # Directory name
	set_color yellow
	echo " "
	set full_path (pwd)
	set full_path (string replace -- $HOME '~' $full_path)
	echo $full_path

 # Arrow
	set_color blue
	echo -n " > "
	set_color normal
end

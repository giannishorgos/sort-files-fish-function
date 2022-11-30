#!/usr/bin/fish

function sort_files
	# Returns a list with all files ending in $argv[1] (file extension)
	set names (find ./ -name "*$argv[1]");

	# for every file ending in $argv[1] (file extension)
	for name in $names
		# get the file name, in list names there is the whole path of the file
		set name_file (string split '/' $name)[-1];

		# get the file name's first letter
		set first_char (string split '' $name_file)[1]

		# selects only the files that their names are starting with char from argv[2]
		if [ "$argv[2]" = "$first_char" ];
			# get the size of the file
			set size_name (wc -c $name);
			set size (string split ' ' $size_name)[1]

			if test -d $argv[2]/; # checks if the dir already exists
				echo "Dir $argv[2]/ already exists"		
			else
				mkdir $argv[2]/;
			end

			# checks the size of the files in order to create the right directories 
			# and moves the file in the correct dir
			if [ "$size" -lt "1024" ];
				if test -d $argv[2]/bytes/; # checks if the dir already exists
					echo "Dir $argv[2]/bytes/ already exists"		
				else
					mkdir $argv[2]/bytes/;
				end
				cp $name ./$argv[2]/bytes/;
			else if [ "$size" -lt "1048576" ];
				if test -d $argv[2]/kilobytes/; # checks if the dir already exists
					echo "Dir $argv[2]/kilobytes/ already exists"		
				else
					mkdir $argv[2]/kilobytes/;
				end
				cp $name ./$argv[2]/kilobytes/;
			else if [ "$size" -lt "1073741824" ];
				if test -d $argv[2]/megabytes/; # checks if the dir already exists
					echo "Dir $argv[2]/megabytes/ already exists"		
				else
					mkdir $argv[2]/megabytes/;
				end
				cp $name ./$argv[2]/megabytes/;
			else
				if test -d $argv[2]/gigabytes/; # checks if the dir already exists
					echo "Dir $argv[2]/gigabytes/ already exists"		
				else
					mkdir $argv[2]/gigabytes/;
				end
				cp $name ./$argv[2]/gigabytes/;
			end
		end
	end
end

sort_files $argv[1] $argv[2]


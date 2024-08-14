#!/bin/bash

SHELL_RC="$HOME/.bashrc"

#backup shell config file
cp "$SHELL_RC" "$SHELL_RC.bak"

#list all flatpak apps and loop through id list
flatpak list --app --columns=application | while read -r app_id; do  
    echo "Processing $app_id. . ."
    #take information for the package of a given id 
    flatpak_info=$(flatpak info "$app_id")
    #grab second line, where the name is
    second_line=$(echo "$flatpak_info" | sed -n '2p')


   #grab first word of second line, which is the app name
    app_name=$(echo "$second_line" | head -n 1 | cut -d '-' -f 1 | xargs)
    

   
    #if app name isn't empty string, try to process it 
    if [ -n "$app_name" ]; then
        #if app is already aliased, move on.
        if grep -q "alias $app_name=" "$SHELL_RC"; then
            echo "Alias $app_name already exists. Skipping."
    
        else
        #if app is not aliased, create new alias
            echo "alias $app_name='flatpak run $app_id'" >> "$SHELL_RC"
            echo "Added alias for $app_name."

        fi

    else
    #if app name is empty string, do nothing
        echo "Warning: Could not determine app name for $app_id"
    fi 

done

source "$SHELL_RC"

#tell user aliases are done
echo "Aliases created and shell configuration reloaded."

#Now to run Obsidian for example, you need only to type "Obsidian" instead of "flatpak run md.obsidian.Obsidian".
#!/bin/bash

# Define Class
declare -r COURSE="DS7333"
declare -r TERM="Spring 2020"

# Define subdirectories for each unit
declare -a directories=(
    "src"
    "reports"
    "notes"
)

# Define shared directories for course

declare -a shared=(
    "data"
    "course-docs"
    "resources"
    "misc"
)

makeUnit () {
    currUnit=unit_${1}
    echo "Unit $1"

    # Add missing subdirectories
    for subdir in "${directories[@]}";do
        if [ -d ${currUnit}/${subdir} ]; then
            echo "$subdir exits."
            continue
            fi
            mkdir -p ${currUnit}/${subdir}

    done

    # Check if symlink to shared data directory has been created
    if [[ -L "$currUnit/data" && -d "$currUnit/data" ]]
    then
        echo "$currUnit/data is a symlink to a directory"
    elif [ ! -d "$currUnit/data" ]; then
        ln -s $(pwd)/data/ ${currUnit}/data
    fi


    # Create Unit README's if they don't exit
    if [ ! -f "$currUnit/README.md" ]; then
        echo -e "# Unit $1 : NAMEHERE  \n\n**${COURSE} –${TERM}**\n\n## Summary">${currUnit}/README.md
    fi

}

main(){

    # Make shared directories
    for shareD in "${shared[@]}";do
        if [ -d $(pwd)/${shareD} ]; then
            echo "$shareD exists."
            continue
        else
            mkdir $(pwd)/${shareD}
        fi
    done

    # Handle Units 01-15
    for i in {1..15};do
        if [ $i -lt 10 ] ; then
            makeUnit 0${i}      # Add 0 padding to keep unit names all same length
        else
            makeUnit $i
        fi
      done


    # Create README
    if [ ! -f "README.md" ]; then
        echo -e "# ${COURSE} –${TERM}  \n\n**Carson Drake**  \n\n**SMU**">README.md
    fi
}

main

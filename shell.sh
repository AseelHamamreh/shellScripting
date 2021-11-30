#! /usr/bin/bash

echo -e "Enter the name of the directory: \c"    
read dir_name
main_path=`pwd`/$dir_name 

function ana(){
    echo -e "Enter the regex you want to search for: \c"   
    read regex 
    echo "Number of repeated '"$regex"' in "$dir_name" is : $(grep -roh $regex $main_path | wc -w)"
}

function arr(){
    echo -e "Enter the type of files you want to arrange: \c"    
    read file_type
    new_dirname=$file_type
    mkdir -p `pwd`/$new_dirname 
    newPath=`pwd`/$new_dirname 
    find $main_path -name "*.$file_type" -exec mv {} $newPath \;
    echo "all files with type $file_type has been moved to $file_type new directory"
}

function del(){
    echo -e "Enter the maximum size of files \c"    
    read MAXSIZE
    re='^[0-9]+$'
    if ! [[ $MAXSIZE =~ $re ]] ; 
    then
        echo "error: $MAXSIZE Not a number"
        del
    else
        find $main_path -type f -size +$MAXSIZE -delete
        echo "files more than $MAXSIZE byte size has been deleted"
    fi
}

if [ -e $dir_name ]
then
    if [ -d $dir_name ]
    then
        echo -e "Enter the procces you want to achieve: ana, del or arr: \c"    
        read procces
            if [ "$procces" = "ana" ]; 
            then
            ana
            elif [ "$procces" = "arr" ]; 
            then
                arr
            elif [ "$procces" = "del" ]; 
            then
                del
            else
                echo "process is not available."
            fi
    else
    echo "$dir_name is not a directory."
    fi
else
    echo "$dir_name is not exists."
fi

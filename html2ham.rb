for file in app/views/devise/**/*.erb; do html2haml -e $file ${file%erb}haml && rm $file; done
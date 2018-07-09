
add_prefix() {
    DIRNAME=$1
    export PATH=$DIRNAME/bin:$PATH
    export MANPATH=$DIRNAME/share/man:$MANPATH
    export INFOPATH=$DIRNAME/share/info:$INFOPATH
    if [ "$LD_LIBRARY_PATH" ]; then
        export LD_LIBRARY_PATH=$DIRNAME/lib;$LD_LIBRARY_PATH
    else
        export LD_LIBRARY_PATH=$DIRNAME/lib
    fi
}

add_prefix $HOME/.local

LOG=~/rcfiles.txt
rm -f $LOG
for fn in $HOME/.bashrc.d/*.rc; do
    echo $fn >> $LOG
    source $fn
done
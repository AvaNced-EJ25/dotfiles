
beepboop() {
    for i in {100..1000..100}; do
        ffplay -f lavfi -i "sine=frequency=${i}:duration=0.1" -autoexit -nodisp -loglevel quiet > /dev/null
    done
    return
}

play_tone(){
    hz=${1:-500}
    duration=${2:-10}
    ffplay -f lavfi -i "sine=frequency=$hz:duration=$duration" -autoexit -nodisp -loglevel quiet > /dev/null
    return
}

adhd_tone() { play_tone 852 100 }

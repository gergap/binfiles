#!/bin/bash
# This is script is a simple frontend to ffmpeg to make it easiert to encode videos using GPU support.
# It therefor uses VA-API and supports h264 and h265(hevc) codecs.
# This script will use VA-API to scale the video to Full-HD (1080p) or HD (720p) and for encoding
# as long as you hardware does support it. Scaling is required, because hardware encoders support
# only a limited set of resolutions.

# default vaapi devices
DEVICE=/dev/dri/renderD128
CODEC="hevc_vaapi"
SCALE="w=1920:h=1080"

function usage() {
    echo "usage: gpu-encode.sh [options] <input file> <output file>"
    echo "example: gpu-encode.sh input.mp4 output-x265.mp4"
    echo "Options:"
    echo "  -r <res>: res can be either 720p or 1080p (default)"
    echo "  -c <codec>: h264 or hevc (default)"
}

# parse commandline options
while getopts "r:c:s:h" opt; do
    case $opt in
        c)
            if [ "$OPTARG" == "h264" ]; then
                CODEC="h264_vaapi"
            elif [ "$OPTARG" == "hevc" ] || [ "$OPTARG" == "h265" ]; then
                CODEC="hevc_vaapi"
                CODEC="libx265"
            else
                usage
                exit 1
            fi
            ;;
        r)
            if [ "$OPTARG" == "1080p" ]; then
                SCALE=",scale_vaapi=w=1920:h=1080"
            elif [ "$OPTARG" == "720p" ]; then
                SCALE=",scale_vaapi=w=1280:h=720"
            elif [ "$OPTARG" == "600p" ]; then
                SCALE=",scale_vaapi=w=800:h=600"
            elif [ "$OPTARG" == "n" ]; then
                SCALE=""
            else
                usage
                exit 1
            fi
            ;;
        *)
            usage
            ;;
    esac
done

# shift out arguments processed by getopt
shift $((OPTIND-1))

if [ $# -eq 2 ]; then
    INPUT="$1"
    OUTPUT="$2"
elif [ $# -eq 1 ]; then
    INPUT="$1"
    OUTPUT="${INPUT%.mp4}-$CODEC.mp4"
else
    usage
    exit 1
fi

ffmpeg -vaapi_device $DEVICE -i "$INPUT" -vf "format=nv12,hwupload$SCALE" -c:v $CODEC -f mp4 -rc_mode 1 -qp 25 "$OUTPUT"


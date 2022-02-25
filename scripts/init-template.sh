GAME_NAME="$1"

if [ -z $GAME_NAME ]; then
    echo "Specify game name"
fi

echo "Setting game name to $GAME_NAME"
sed -i "s/##VAR_GAME_NAME/$GAME_NAME/g" project.godot
sed -i "s/##VAR_GAME_NAME/$GAME_NAME/g" .github/workflows/release.yml

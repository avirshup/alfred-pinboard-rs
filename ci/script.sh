# This script takes care of testing your crate

set -ex

# TODO This is the "test phase", tweak it as you see fit
main() {
    cross build --target "$TARGET"
    # cross build --target "$TARGET" --release

    if [ ! -z "$DISABLE_TESTS" ]; then
        return
    fi

    # cross test --target $TARGET
    export alfred_debug=1
    cross test --target "$TARGET" --release -- --test-threads=1 || return

}

# we don't run the "test phase" when doing deploys
if [ -z "$TRAVIS_TAG" ]; then
    main
fi

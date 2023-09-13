#!/bin/bash

# Check if no targets are provided, default to "all"
if [ $# -eq 0 ]; then
    targets=("all")
else
    targets=("$@")
fi

# Function to build a target and its dependencies
build_target() {
    local target="$1"

    # Check if the target exists in shmakefile
    if grep -q "^$target:" shmakefile; then
        # Get the dependencies for the target
        dependencies=$(grep -oP "(?<=$target: ).*" shmakefile)

        # Build dependencies first
        for dep in $dependencies; do
            build_target "$dep"
        done

        # Check if the target itself needs to be built
        if should_build_target "$target" "$dependencies"; then
            build_command "$target"
            touch "$target"  # Mark the target as built
        fi
    else
        echo "Error: Target '$target' not found in shmakefile"
        exit 1
    fi
}

# Function to determine if a target needs to be built
should_build_target() {
    local target="$1"
    local dependencies="$2"

    # Check if the target is missing
    if [ ! -e "$target" ]; then
        return 0
    fi

    # Check if any dependency is newer than the target
    for dep in $dependencies; do
        if [ "$dep" -nt "$target" ]; then
            return 0
        fi
    done

    return 1
}

# Function to execute the build command for a target
build_command() {
    local target="$1"
    echo $target
    # Execute the build command for the target (from shmakefile)
    eval "$(grep -A 1 "^$target:" shmakefile | grep -v "^$target:" | sed 's/^[ \t]*//')"
}

# Build each specified target
for target in "${targets[@]}"; do
    build_target "$target"
done

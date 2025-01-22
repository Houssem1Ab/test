#!/bin/bash

MODULES="$(find . -name 'main*.tf' -not -path "*/.terraform/*" -not -path "*/example/*" -exec dirname {} \; | sort -u)"
TEMPLATE="${PWD}/.terraform-docs.yml"

while IFS= read -r module; do
    echo "Building docs for $module"
    terraform-docs -c "${TEMPLATE}" markdown table "$module" > "${module}/README.md"
done <<< "$MODULES"

#!/bin/bash
# ERROR_COUNT=0; 

# echo "Validating AWS CloudFormation templates..."

# # Loop through the YAML templates in this repository
# for TEMPLATE in $(find . -name '*.yaml'); do 

#     # Validate the template with CloudFormation
#     ERRORS=$(aws cloudformation validate-template --template-body file://$TEMPLATE 2>&1 >/dev/null); 
#     if [ "$?" -gt "0" ]; then 
#         ((ERROR_COUNT++));
#         echo "[fail] $TEMPLATE: $ERRORS";
#     else 
#         echo "[pass] $TEMPLATE";
#     fi; 

# Find all yaml files BUT exclude the .github directory
find . -path "./.github" -prune -o -name "*.yaml" -print | while read -r template; do
    echo "Validating $template..."
    aws cloudformation validate-template --template-body "file://$template"
    if [ $? -eq 0 ]; then
        echo "[pass] $template"
    else
        echo "[fail] $template"
        exit 1
    fi
    
done; 

# echo "$ERROR_COUNT template validation error(s)"; 
# if [ "$ERROR_COUNT" -gt 0 ]; 
#     then exit 1; 
# fi

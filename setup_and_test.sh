#!/bin/bash
# Script to set up a virtual environment and test MkDocs

# Create a virtual environment
echo "Creating virtual environment..."
python -m venv venv

# Activate the virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Install dependencies
echo "Installing dependencies..."
pip install -r requirements.txt

# Build the documentation
echo "Building documentation..."
mkdocs build

# Serve the documentation (optional)
echo "To serve the documentation locally, run:"
echo "source venv/bin/activate && mkdocs serve"

echo "Setup and test complete. The site directory has been created."
echo "To deactivate the virtual environment, run: deactivate"

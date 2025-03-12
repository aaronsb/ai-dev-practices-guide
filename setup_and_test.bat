@echo off
REM Script to set up a virtual environment and test MkDocs on Windows

echo Creating virtual environment...
python -m venv venv

echo Activating virtual environment...
call venv\Scripts\activate.bat

echo Installing dependencies...
pip install -r requirements.txt

echo Building documentation...
mkdocs build

echo.
echo Setup and test complete. The site directory has been created.
echo To serve the documentation locally, run:
echo call venv\Scripts\activate.bat ^&^& mkdocs serve
echo.
echo To deactivate the virtual environment, run: deactivate

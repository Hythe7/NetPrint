# NetPrint
This is a draft of a net print service

# fetch_files.sh
Run this on your board connected to your printer. This one checks if the server has received sth that has to be printed and uploads it, sends to the printer and deletes the downloaded file from the server, afterwards just keeps monitoring if the server got something to print.

Sending for a print will be added later. The current version is just monitoring and downloading files to a directory

# server.py
Start this on your VDS or machine that will be your server

# bot
Almost complete.

# TO DO 
- Integration with the CUPS print server
- Connecting payment systems for online payment.
- Integration with geolocation to select the nearest printing point.
- Storing the order history in a database.
- An administrative panel for managing tariffs and printing points.

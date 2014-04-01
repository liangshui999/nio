#!/bin/bash

# Generate key for client
keytool -genkey -alias ccclient -keystore ccclient.auth  -keyalg rsa -dname "CN=Greg Travis, OU=Trivial Server Department, O=Ministry of Servers, L=New York City, S=NY, C=US" -storepass clientpass -keypass clientpass

# Generate key for server
keytool -genkey -alias ccserver -keystore ccserver.auth  -keyalg rsa -dname "CN=Greg Travis, OU=Trivial Server Department, O=Ministry of Servers, L=New York City, S=NY, C=US" -storepass serverpass -keypass serverpass

# Export keys for importing into trust files
keytool -export -alias ccclient -keystore ccclient.auth -file ccclient.key -storepass clientpass
keytool -export -alias ccserver -keystore ccserver.auth -file ccserver.key -storepass serverpass

# Import keys into trust files
keytool -import -noprompt -alias ccserver -keystore ccserver.trust -file ccclient.key -storepass serverpass
keytool -import -noprompt -alias ccclient -keystore ccclient.trust -file ccserver.key -storepass clientpass

# Clean up
rm -f ccclient.key
rm -f ccserver.key

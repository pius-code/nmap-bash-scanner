echo "Welcome to Pius's Scanner"
read -p "Enter an IP or domain to get started: " target
fileLoc="results/${target}_scan.txt"
mkdir -p results

echo "Running scan, results will be saved in $fileLoc"

# Pinging
echo -e "\nPinging ${target} " >> $fileLoc
nmap -sn --host-timeout 30s $target >> $fileLoc

# Port scanning
echo -e "\nChecking $target for Open ports" >> $fileLoc
nmap --top-ports 100 $target >> $fileLoc

# OS detecting
echo -e "\nScanning for OS version " >> $fileLoc
nmap -A --host-timeout 60s $target >> $fileLoc

# Save the XML output
nmap -A $target -oX results/${target}_scan.xml

# Convert the XML to HTML using xsltproc
xsltproc /usr/share/nmap/nmap.xsl results/${target}_scan.xml -o results/${target}_scan.html

# Inform the user about the HTML report location
echo "An HTML report has been added in results/${target}_scan.html"

echo -e "\nScan complete, check the results in $fileLoc"


import sys
from bs4 import BeautifulSoup

if len(sys.argv) < 2:
    print("Usage: python parse_html.py <html_file>")
    sys.exit(1)

html_file = sys.argv[1]
with open(html_file, "r") as f:
    soup = BeautifulSoup(f, "html.parser")

# Extract information from the HTML
version = soup.find('i', string='dependency-check version').next_sibling.strip(': ')
report_generated_on = soup.find('i', string='Report Generated On').next_sibling.strip(': ')
dependencies_scanned = soup.find('i', string='Dependencies Scanned').next_sibling.strip(': ')
vulnerable_dependencies = soup.find(id="vulnerableCount").get_text()
vulnerabilities_found = soup.find('i', string='Vulnerabilities Found').next_sibling.strip(': ')
vulnerabilities_suppressed = soup.find('i', string='Vulnerabilities Suppressed').next_sibling.strip(': ')

# Print information to standard output
print('\n\tDependency-check version:', version)
print('\n\tReport Generated On:', report_generated_on)
print('\n\tDependencies Scanned:', dependencies_scanned)
print('\n\tVulnerable Dependencies:', vulnerable_dependencies)
print('\n\tVulnerabilities Found:', vulnerabilities_found)
print('\n\tVulnerabilities Suppressed:', vulnerabilities_suppressed)

#find all the vulnerable dependencies and their information
vulnerable_deps = soup.find_all("tr", class_="vulnerable")
for dep in vulnerable_deps:
    name = dep.find_all("td")[0].get_text()
    package = dep.find_all("td")[2].get_text()
    severity = dep.find_all("td")[3].get_text()
    cve_count = dep.find_all("td")[4].get_text()
    confidence = dep.find_all("td")[5].get_text()

    # output the information in the desired format
    print(f"\n\t{name}\n\tPackage: {package}\n\tSeverity: {severity} \n\tCVE Count: {cve_count}\n\tConfidence: {confidence}\n\t")



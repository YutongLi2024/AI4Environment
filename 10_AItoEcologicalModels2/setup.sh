#!/bin/bash
echo -n "Downloading data... "
if [ ! -d "data" ]; then
	git clone https://github.com/MScEcologyAndDataScienceUCL/BIOS0032_AI4Environment tmp >>data.log 2>&1
	cp -r tmp/10_AItoEcologicalModels2/data/ data/ >>data.log 2>&1
	rm -rf tmp >>data.log 2>&1
fi
echo "done."

r_packages="dplyr lme4 sf gratia mgcv"

echo "Installing R libraries:"
for r_package in $r_packages; do
  echo -n "    [+] Installing $r_package... "
  Rscript -e "if (!requireNamespace('$r_package', quietly = TRUE)) install.packages('$r_package')" >>r.log 2>&1
  echo "done."
done
echo "done."

echo -n "Installing Python dependencies... "
pip install rpy2==3.5.1 >>python.log 2>&1
echo "done."

echo "All done!"

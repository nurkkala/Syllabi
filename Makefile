# Utility makefile for syllabi

.PHONY: clean

clean:
	$(RM) *.aux *.blg *.fls *.log *.out *.bbl *.fdb_latexmk *.out 
	$(RM) *.bcf *.run.xml
	$(RM) *~

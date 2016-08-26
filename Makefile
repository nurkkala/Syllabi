# Utility makefile for syllabi

.PHONY: clean

clean:
	$(RM) *.aux *.blg *.fls *.log *.out *.bbl
	$(RM) *~

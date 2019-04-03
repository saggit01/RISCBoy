YOSYS=yosys
NEXTPNR=nextpnr-ice40
CHIPNAME?=chip
DEVICE?=hx8k
TIME_DEVICE?=hx$(DEVICE)
PACKAGE?=bg121

DEFINES+=FPGA TRISTATE_ICE40

SYNTH_OPT?=
SYNTH_CMD=read_verilog $(addprefix -D,$(DEFINES)) $(SRCS);
ifneq (,$(TOP))
	SYNTH_CMD+=hierarchy -top $(TOP);
endif
SYNTH_CMD+=synth_ice40 $(SYNTH_OPT) -json $(CHIPNAME).json

# Kill implicit rules
.SUFFIXES:
.IMPLICIT:

.PHONY: all romfiles synth clean program dump

all: bit

romfiles::
synth: romfiles $(CHIPNAME).json
dump: romfiles
pnr: synth $(CHIPNAME).asc
bit: pnr $(CHIPNAME).bin

srcs.mk: Makefile $(DOTF)
	$(SCRIPTS)/listfiles --relative -f make -o srcs.mk $(DOTF)

-include srcs.mk

dump:
	$(YOSYS) -p "$(SYNTH_CMD); write_verilog $(CHIPNAME)_synth.v"

$(CHIPNAME).json: $(SRCS)
	@echo ">>> Synth"
	@echo
	$(YOSYS) -p "$(SYNTH_CMD)" > synth.log
	tail -n 35 synth.log


$(CHIPNAME).asc: $(CHIPNAME).json $(CHIPNAME).pcf
	@echo ">>> Place and Route"
	@echo
	$(NEXTPNR) -r --$(DEVICE) --package $(PACKAGE) --pcf $(CHIPNAME).pcf --json $(CHIPNAME).json --asc $(CHIPNAME).asc --quiet --log pnr.log
	@grep "Info: Max frequency for clock 'clk_sys" pnr.log | tail -n 1

$(CHIPNAME).bin: $(CHIPNAME).asc
	@echo ">>> Generate Bitstream"
	@echo
	icepack $(CHIPNAME).asc $(CHIPNAME).bin

clean::
	rm -f $(CHIPNAME).json $(CHIPNAME).asc $(CHIPNAME).bin $(CHIPNAME)_synth.v
	rm -f synth.log pnr.log
	rm -f srcs.mk
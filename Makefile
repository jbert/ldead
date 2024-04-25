SLIB=libl.a
SLIBOBJ=a.o b.o
EXE=e
EXEOBJ=e.o
CFLAGS=-fdata-sections -ffunction-sections
LDFLAGS=-Wl,--gc-sections

${EXE}: ${EXEOBJ} ${SLIB}
	gcc ${LDFLAGS} -o ${EXE} ${EXEOBJ} ${SLIB}

${SLIB}: ${SLIBOBJ}
	ar crs ${SLIB} ${SLIBOBJ}

clean:
	rm -f ${SLIB} ${SLIBOBJ} ${EXE} ${EXEOBJ}

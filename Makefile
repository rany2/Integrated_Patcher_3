OPT=-O2 -s -Wall
LDFLAGS=-nostartfiles -lucrt -limagehlp -lntdll -luser32 -nostdlib -lkernel32 -ladvapi32 -Wl,--exclude-all-symbols -Wl,--enable-stdcall-fixup
CFLAGS=-D_STDIO_DEFINED -fno-ident -fno-stack-check -fno-stack-protector

CC32=i686-w64-mingw32-clang -Wl,-e_dll_main -municode
CC64=x86_64-w64-mingw32-clang -Wl,-edll_main -municode
CCA64=aarch64-w64-mingw32-clang -Wl,-edll_main -municode

STRIP32=i686-w64-mingw32-strip
STRIP64=x86_64-w64-mingw32uwp-strip
STRIPA64=aarch64-w64-mingw32-strip

all: slshim32_akai.dll slshim64_akai.dll slshimARM64_akai.dll

slshim32_akai.dll: slshim.c
	$(CC32) $(OPT) $< slshim.def -shared -o $@ $(CFLAGS) $(LDFLAGS) -lclang_rt.builtins-i386
	$(STRIP32) -s $@

slshim64_akai.dll: slshim.c
	$(CC64) $(OPT) $< slshim.def -shared -o $@ $(CFLAGS) $(LDFLAGS) -lclang_rt.builtins-x86_64
	$(STRIP64) -s $@

slshimARM64_akai.dll: slshim.c
	$(CCA64) $(OPT) $< slshim.def -shared -o $@ $(CFLAGS) $(LDFLAGS) -lclang_rt.builtins-aarch64
	$(STRIPA64) -s $@

clean:
	rm -f *.dll

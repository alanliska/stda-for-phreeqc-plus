
PROG    = stda

#--------------------------------------------------------------------------

#-------------------------------------------------------------------------

   FC = aarch64-linux-android-gfortran.exe 
  # FC = lfc
   CC = aarch64-linux-android-gcc.exe 
  
  ### multithread ###
   LINKER = aarch64-linux-android-gfortran.exe -pie
    LIBS = ../../libs-aarch64/liblapack.a ../../libs-aarch64/libblas.a
  
  ### sequential ###
  # LINKER = ifort -static
  # LIBS = ${MKLROOT}/lib/intel64/libmkl_blas95_lp64.a ${MKLROOT}/lib/intel64/libmkl_lapack95_lp64.a -Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_intel_lp64.a ${MKLROOT}/lib/intel64/libmkl_core.a $(MKLROOT)/lib/intel64/libmkl_sequential.a -Wl,--end-group -lpthread -lm
  
   CFLAGS = -O -DLINUX -pie
   FFLAGS = -O3 -pie -w  -fno-range-check -std=legacy

#################################################
OBJS=\
     stdacommon.o stringmod.o main.o pckao.o \
     header.o intpack.o velo.o  \
     onetri.o prmat.o readl.o block.o\
     stda.o stda-rw.o stda-rw_dual.o sutda.o sfstda.o srpapack.o intslvm.o io.o\
     linal.o readbasa.o readbasmold.o printvec.o normalize.o\
     apbtrafo.o sosor.o readxtb.o linear_response.o molden.o print_nto.o
#################################################

%.o: %.f90
	@echo "making $@ from $<"
	$(FC) $(FFLAGS) -c $< -o $@
%.o: %.f
	@echo "making $@ from $<"
	$(FC) $(FFLAGS) -c $< -o $@

$(PROG):     $(OBJS) 
#		@echo  "Loading $(PROG) ... "
		$(LINKER) -o $(PROG) $(OBJS) $(LIBS) 

clean:
	rm -f *.o *.mod $(PROG)

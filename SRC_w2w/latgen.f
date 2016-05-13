!!! wien2wannier/SRC_w2w/latgen.f

      SUBROUTINE LATGEN
!
!     LATGEN GENERATES TWO BRAVAIS MATRICES, DEFINES THE VOLUME OF
!     THE UNIT CELL AND CALLS ROTDEF
!     BR1(3,3)  : TRANSFORMS INTEGER RECIPROCAL LATTICE VECTORS AS
!                 GIVEN IN THE VECTORLIST OF LAPW1  ( GENERATED IN
!                 COORS, TRANSFORMED IN BASISO, AND WRITTEN OUT IN
!                 WFTAPE) INTO CARTESIAN SYSTEM
!     BR2(3,3) :  TRANSFORMS A RECIPROCAL LATTICE VECTOR OF A SPE-
!                 CIAL COORDINATE SYSTEM ( IN UNITS OF 2 PI / A )
!                 TO CARTESIAN SYSTEM
        USE param
        USE struct
        use gener, only: br1, br2
!

        use const, only: R8, PI

      IMPLICIT REAL(R8) (A-H,O-Z)
!
      LOGICAL          ORTHO
!
      COMMON /ORTH/   ORTHO

!---------------------------------------------------------------------
!
      SQRT3=SQRT(3.D0)
      ALPHA(1)=ALPHA(1)*PI/180.0D0
      ALPHA(2)=ALPHA(2)*PI/180.0D0
      ALPHA(3)=ALPHA(3)*PI/180.0D0
      PIA(1)=2.D0*PI/AA
      PIA(2)=2.D0*PI/BB
      PIA(3)=2.D0*PI/CC
      IF(LATTIC(1:1).EQ.'H') GOTO 10
      IF(LATTIC(1:1).EQ.'S') GOTO 20
      IF(LATTIC(1:1).EQ.'P') GOTO 20
      IF(LATTIC(1:1).EQ.'F') GOTO 30
      IF(LATTIC(1:1).EQ.'B') GOTO 40
      IF(LATTIC(1:1).EQ.'C') GOTO 50
      IF(LATTIC(1:1).EQ.'R') GOTO 60
!
!        Error: wrong lattice, stop execution
!
         GOTO 900
!
!.....HEXAGONAL LATTICE
 10   CONTINUE
      BR1(1,1)=2.D0/SQRT3*PIA(1)
      BR1(1,2)=1.D0/SQRT3*PIA(1)
      BR1(1,3)=0.0D0
      BR1(2,1)=0.0D0
      BR1(2,2)=PIA(2)
      BR1(2,3)=0.0D0
      BR1(3,1)=0.0D0
      BR1(3,2)=0.0D0
      BR1(3,3)=PIA(3)
!
      BR2(1,1)=1.D0
      BR2(1,2)=0.D0
      BR2(1,3)=0.D0
      BR2(2,1)=0.0D0
      BR2(2,2)=1.D0
      BR2(2,3)=0.0D0
      BR2(3,1)=0.0D0
      BR2(3,2)=0.0D0
      BR2(3,3)=1.D0
!
      RVFAC=2.D0/SQRT(3.D0)
      ORTHO=.FALSE.
      GOTO 100
!
!.....RHOMBOHEDRAL CASE
 60   BR1(1,1)=1.D0/SQRT(3.D0)*PIA(1)
      BR1(1,2)=1.D0/SQRT(3.D0)*PIA(1)
      BR1(1,3)=-2.d0/sqrt(3.d0)*PIA(1)
      BR1(2,1)=-1.0d0*PIA(2)
      BR1(2,2)=1.0d0*PIA(2)
      BR1(2,3)=0.0d0*PIA(2)
      BR1(3,1)=1.0d0*PIA(3)
      BR1(3,2)=1.0d0*PIA(3)
      BR1(3,3)=1.0d0*PIA(3)
!
      BR2(1,1)=1.D0
      BR2(1,2)=0.D0
      BR2(1,3)=0.D0
      BR2(2,1)=0.0D0
      BR2(2,2)=1.D0
      BR2(2,3)=0.0D0
      BR2(3,1)=0.0D0
      BR2(3,2)=0.0D0
      BR2(3,3)=1.D0
!
      RVFAC=6.D0/SQRT(3.D0)
      ORTHO=.FALSE.
      GOTO 100
!
!.....PRIMITIVE LATTICE
!
  20  CONTINUE
      SINBC=SIN(ALPHA(1))
      COSAB=COS(ALPHA(3))
      COSAC=COS(ALPHA(2))
      COSBC=COS(ALPHA(1))
      WURZEL=SQRT(SINBC**2-COSAC**2-COSAB**2+2*COSBC*COSAC*COSAB)
!
      BR1(1,1)= SINBC/WURZEL*PIA(1)
      BR1(1,2)= (-COSAB+COSBC*COSAC)/(SINBC*WURZEL)*PIA(2)
      BR1(1,3)= (COSBC*COSAB-COSAC)/(SINBC*WURZEL)*PIA(3)
      BR1(2,1)= 0.0
      BR1(2,2)= PIA(2)/SINBC
      BR1(2,3)= -PIA(3)*COSBC/SINBC
      BR1(3,1)= 0.0
      BR1(3,2)= 0.0
      BR1(3,3)= PIA(3)
!
      BR2(1,1)=1.D0
      BR2(1,2)=0.D0
      BR2(1,3)=0.D0
      BR2(2,1)=0.0D0
      BR2(2,2)=1.D0
      BR2(2,3)=0.0D0
      BR2(3,1)=0.0D0
      BR2(3,2)=0.0D0
      BR2(3,3)=1.D0
!
      RVFAC= 1.d0/WURZEL
      ORTHO=.TRUE.
      if(abs(alpha(1)-pi/2.d0).gt.0.0001) ortho=.false.
      if(abs(alpha(2)-pi/2.d0).gt.0.0001) ortho=.false.
      if(abs(alpha(3)-pi/2.d0).gt.0.0001) ortho=.false.
!
      GOTO 100
!
!.....FC LATTICE
 30   CONTINUE
      BR1(1,1)=PIA(1)
      BR1(1,2)=0.0D0
      BR1(1,3)=0.0D0
      BR1(2,1)=0.0D0
      BR1(2,2)=PIA(2)
      BR1(2,3)=0.0D0
      BR1(3,2)=0.0D0
      BR1(3,1)=0.0D0
      BR1(3,3)=PIA(3)
!
!     definitions according to column, rows convention for BR2
!
      BR2(1,1)=-1.D0
      BR2(1,2)= 1.D0
      BR2(1,3)= 1.D0
      BR2(2,1)= 1.D0
      BR2(2,2)=-1.D0
      BR2(2,3)= 1.D0
      BR2(3,1)= 1.D0
      BR2(3,2)= 1.D0
      BR2(3,3)=-1.D0
!
      RVFAC=4.D0
      ORTHO=.TRUE.
      GOTO 100
!
!.....BC LATTICE
 40   CONTINUE
      BR1(1,1)=PIA(1)
      BR1(1,2)=0.0D0
      BR1(1,3)=0.0D0
      BR1(2,1)=0.0D0
      BR1(2,2)=PIA(2)
      BR1(2,3)=0.0D0
      BR1(3,1)=0.0D0
      BR1(3,2)=0.0D0
      BR1(3,3)=PIA(3)
!
      BR2(1,1)= 0.0D0
      BR2(1,2)= 1.D0
      BR2(1,3)= 1.D0
      BR2(2,1)= 1.D0
      BR2(2,2)= 0.0D0
      BR2(2,3)= 1.D0
      BR2(3,1)= 1.D0
      BR2(3,2)= 1.D0
      BR2(3,3)= 0.0D0
!
      RVFAC=2.D0
      ORTHO=.TRUE.
      GOTO 100
!
 50   CONTINUE
      IF(LATTIC(2:3).EQ.'XZ') GOTO 51
      IF(LATTIC(2:3).EQ.'YZ') GOTO 52
!.....CXY LATTICE
      BR1(1,1)=PIA(1)
      BR1(1,2)=0.0D0
      BR1(1,3)=0.0D0
      BR1(2,1)=0.0D0
      BR1(2,2)=PIA(2)
      BR1(2,3)=0.0D0
      BR1(3,1)=0.0D0
      BR1(3,2)=0.0D0
      BR1(3,3)=PIA(3)
!
      BR2(1,1)= 1.D0
      BR2(1,2)= 1.D0
      BR2(1,3)= 0.0D0
      BR2(2,1)=-1.D0
      BR2(2,2)= 1.D0
      BR2(2,3)= 0.0D0
      BR2(3,1)= 0.0D0
      BR2(3,2)= 0.0D0
      BR2(3,3)= 1.D0
!
      RVFAC=2.D0
      ORTHO=.TRUE.
      GOTO 100
!
!.....CXZ CASE (CXZ LATTICE BUILD UP)
 51   CONTINUE
!.....CXZ ORTHOROMBIC CASE
      IF(ABS(ALPHA(3)-PI/2.0D0).LT.0.0001) then
         BR1(1,1)=PIA(1)
         BR1(1,2)=0.0D0
         BR1(1,3)=0.0D0
         BR1(2,1)=0.0D0
         BR1(2,2)=PIA(2)
         BR1(2,3)=0.0D0
         BR1(3,1)=0.0D0
         BR1(3,2)=0.0D0
         BR1(3,3)=PIA(3)
!
         BR2(1,1)= 1.D0
         BR2(1,2)= 0.0
         BR2(1,3)= 1.D0
         BR2(2,1)= 0.0
         BR2(2,2)= 1.D0
         BR2(2,3)= 0.0
         BR2(3,1)=-1.D0
         BR2(3,2)= 0.0
         BR2(3,3)= 1.D0
!
         RVFAC=2.0
         ORTHO=.TRUE.
         GOTO 100
      ELSE
!.....CXZ MONOCLINIC CASE
         write(*,*) '  gamma not equal 90'
         SINAB=SIN(ALPHA(3))
         COSAB=COS(ALPHA(3))
!
         BR1(1,1)= PIA(1)/SINAB
         BR1(1,2)= -PIA(2)*COSAB/SINAB
         BR1(1,3)= 0.0
         BR1(2,1)= 0.0
         BR1(2,2)= PIA(2)
         BR1(2,3)= 0.0
         BR1(3,1)= 0.0
         BR1(3,2)= 0.0
         BR1(3,3)= PIA(3)
!
         BR2(1,1)= 1.D0
         BR2(1,2)= 0.D0
         BR2(1,3)= 1.D0
         BR2(2,1)= 0.0
         BR2(2,2)= 1.D0
         BR2(2,3)= 0.0
         BR2(3,1)=-1.D0
         BR2(3,2)= 0.0
         BR2(3,3)= 1.D0
!
         RVFAC=2.0/SINAB
         ORTHO=.FALSE.
         GOTO 100
      ENDIF
!
!.....CYZ CASE (CYZ LATTICE BUILD UP)
 52   CONTINUE
      BR1(1,1)=PIA(1)
      BR1(1,2)=0.0D0
      BR1(1,3)=0.0D0
      BR1(2,1)=0.0D0
      BR1(2,2)=PIA(2)
      BR1(2,3)=0.0D0
      BR1(3,1)=0.0D0
      BR1(3,2)=0.0D0
      BR1(3,3)=PIA(3)
!
      BR2(1,1)= 1.D0
      BR2(1,2)= 0.0
      BR2(1,3)= 0.0
      BR2(2,1)= 0.0
      BR2(2,2)= 1.D0
      BR2(2,3)= 1.D0
      BR2(3,1)= 0.0
      BR2(3,2)=-1.D0
      BR2(3,3)= 1.D0
!
      RVFAC=2.0
      ORTHO=.TRUE.
      GOTO 100
!
!.....DEFINE VOLUME OF UNIT CELL
 100  CONTINUE
      write(unit_out,*)' BR1,  BR2'
      do i=1,3
      write(unit_out,654)(br1(i,j),j=1,3),(br2(i,j),j=1,3)
654   format(3f10.5,3x,3f10.5)
      enddo
      VOL=AA*BB*CC/RVFAC
!
!.....DEFINE ROTATION MATRICES IN NONSYMMORPHIC CASE
      CALL ROTDEF
!
      RETURN
!
!        Error messages
!
  900 CALL OUTERR('LATGEN','wrong lattice.')
      STOP 'LATGEN - Error'
!
!        End of 'LATGEN'
!
      END


!!/---
!! Local Variables:
!! mode: f90
!! End:
!!\---
!!
!! Time-stamp: <2016-04-08 17:13:26 assman@faepop36.tu-graz.ac.at>

!!! wien2wannier/SRC_wplot/inth.f

subroutine INTH (DP,DQ,DV,DR)
!
! INTEGRATION PAR LA METHODE DE ADAMS A 5 POINTS DE LA GRANDE COMPOSANTE
! DP ET DE LA PETITE COMPOSANTE DQ AU POINT DR,DV ETANT LE POTENTIEL EN
! CE POINT
! **********************************************************************
  use const, only: R8
  use ps1,   only: dep, deq, db, dvc, dsal, dk, dm

  implicit none

  real(R8), intent(inout) :: dp, dq
  real(R8), intent(in)    :: dv, dr

! DEP,DEQ DERIVEES DE DP ET DQ   DB=ENERGIE/DVC    DVC VITESSE DE LA
! LUMIERE EN U.A.   DSAL=2.*DVC   DK NOMBRE QUANTIQUE KAPPA
! DM=PAS EXPONENTIEL/720.
! DKOEF1=405./502., DKOEF2=27./502.
! *********************************************************************

  ! dkoef1 is inferred from old numerical literal
  real(R8), parameter :: dkoef1 = 475 / 502._R8
  real(R8), parameter :: dkoef2 =  27 / 502._R8

  real(R8) :: DPR, DQR, dsum
  integer  :: i

  DPR=DP+DM*((251.*DEP(1)+2616.*DEP(3)+1901.*DEP(5))-(1274.*DEP(2)+2774.*DEP(4)))
  DQR=DQ+DM*((251.*DEQ(1)+2616.*DEQ(3)+1901.*DEQ(5))-(1274.*DEQ(2)+2774.*DEQ(4)))

  do I=2,5
     DEP(I-1)=DEP(I)
     DEQ(I-1)=DEQ(I)
  end do

  DSUM=(DB-DV/DVC)*DR

  DEP(5)=-DK*DPR + (DSAL*DR+DSUM)*DQR
  DEQ(5)= DK*DQR -  DSUM*DPR

  DP=DP+DM*((106.*DEP(2)+646.*DEP(4)+251.*DEP(5))-(19.*DEP(1)+264.*DEP(3)))
  DQ=DQ+DM*((106.*DEQ(2)+646.*DEQ(4)+251.*DEQ(5))-(19.*DEQ(1)+264.*DEQ(3)))
  DP = DKOEF1 * DP + DKOEF2 * DPR
  DQ = DKOEF1 * DQ + DKOEF2 * DQR
  DEP(5) = -DK * DP + (DSAL*DR+DSUM)*DQ
  DEQ(5) =  DK * DQ - DSUM * DP
end subroutine INTH


!!/---
!! Local Variables:
!! mode: f90
!! End:
!!\---
!!
!! Time-stamp: <2016-07-18 11:26:53 assman@faepop71.tu-graz.ac.at>

      module combi 
!     combi
!***********************************************************************
!  Copyright, 1993, 2004,  The  Regents of the University of California.
!  This program was prepared by the Regents of the University of 
!  California at Los Alamos National Laboratory (the University) under  
!  contract No. W-7405-ENG-36 with the U.S. Department of Energy (DOE). 
!  All rights in the program are reserved by the DOE and the University. 
!  Permission is granted to the public to copy and use this software 
!  without charge, provided that this Notice and any statement of 
!  authorship are reproduced on all copies. Neither the U.S. Government 
!  nor the University makes any warranty, express or implied, or 
!  assumes any liability or responsibility for the use of this software.
!***********************************************************************
!D1
!D1 PURPOSE
!D1
!D1 Global include file for array variables and pointers (FEHMN application).
!D1
!***********************************************************************
!D2
!D2 REVISION HISTORY
!D2
!D2 Revision                    ECD
!D2 Date         Programmer     Number  Comments
!D2
!D2 30-SEP-93    Z. Dash        22      Add prolog.
!D2              G. Zyvoloski           Initial implementation.
!D2
!D2 $Log:   /pvcs.config/fehm90/src/combi.f_a  $
!D2 
!D2    Rev 2.5   06 Jan 2004 10:42:26   pvcs
!D2 FEHM Version 2.21, STN 10086-2.21-00, Qualified October 2003
!D2 
!D2    Rev 2.4   29 Jan 2003 08:56:02   pvcs
!D2 FEHM Version 2.20, STN 10086-2.20-00
!D2 
!D2    Rev 2.3   14 Nov 2001 13:05:20   pvcs
!D2 FEHM Version 2.12, STN 10086-2.12-00
!D2 
!D2    Rev 2.2   06 Jun 2001 13:22:18   pvcs
!D2 FEHM Version 2.11, STN 10086-2.11-00
!D2 
!D2    Rev 2.1   30 Nov 2000 11:56:30   pvcs
!D2 FEHM Version 2.10, STN 10086-2.10-00
!D2 
!D2    Rev 2.0   Fri May 07 14:39:26 1999   pvcs
!D2 FEHM Version 2.0, SC-194 (Fortran 90)
!D2 
!D2    Rev 1.1   03/18/94 16:22:56   gaz
!D2 Added solve_new and cleaned up memory management.
!D2 
!D2    Rev 1.0   01/20/94 10:21:52   pvcs
!D2 original version in process of being certified
!D2
!***********************************************************************
!D3
!D3 INTERFACES
!D3
!D3 None
!D3
!***********************************************************************
!D4
!D4 GLOBAL OBJECTS
!D4
!D4 Global Constants
!D4
!D4   None
!D4
!D4 Global Types
!D4
!D4   None
!D4
!D4 Global Variables
!D4
!D4                            COMMON
!D4   Identifier      Type     Block  Description
!D4
!D4   ***** COMMON Block fbb pointers and associated variables *****
!D4   ipistrw         POINTER  fbb    Pointer to variable array istrw
!D4   ipizonef        POINTER  fbb    Pointer to variable array izonef
!D4   ipka            POINTER  fbb    Pointer to variable array ka
!D4   ipnar           POINTER  fbb    Pointer to variable array nar
!D4   ipnelm          POINTER  fbb    Pointer to variable array nelm
!D4   ipnelmdg        POINTER  fbb    Pointer to variable array nelmdg
!D4   ipnop           POINTER  fbb    Pointer to variable array nop
!D4
!D4   istrw           INT      fbb    Starting positions in sx(nr,9) array of 
!D4                                     finite element coefficients for each 
!D4                                     node 
!D4   izonef          INT      fbb    Zone in which each node is located 
!D4   ka              INT      fbb    Contains boundary type information for 
!D4                                     each node 
!D4   nar             INT      fbb    Array containing gauss elimination order 
!D4                                     for each node 
!D4   nelm            INT      fbb    Initially information about nodes in each 
!D4                                     element, later nodal connectivity 
!D4                                     information 
!D4   nelmdg          INT      fbb    Contains position of (i,i) element in 
!D4                                     connectivity array
!D4   nop             INT      fbb    Matrix sparsity structure for lu 
!D4                                     decomposition 
!D4
!D4   ***** COMMON Block fbc pointers and associated variables *****
!D4   ipsx            POINTER  fbc    Pointer to variable array sx
!D4   ipsx1           POINTER  fbc    Pointer to variable array sx1
!D4   ipsxs           POINTER  fbc    Pointer to variable array sxs
!D4
!D4   sx              REAL*8   fbc    Contains finite element geometric  
!D4                                     coefficients necessary for heat and mass
!D4                                     transfer simulation  
!D4   sx1             REAL*8   fbc    Contains volume associated with each node 
!D4   sxs             REAL*8   fbc    Contains more finite element geometric 
!D4                                     coefficients (ie., those necessary for 
!D4                                     the stress module) 
!D4
!D4   ***** COMMON Block fbs pointers and associated variables *****
!D4   ipcord          POINTER  fbs    Pointer to variable array cord
!D4   ipdr            POINTER  fbs    Pointer to variable array dr
!D4   ipdp            POINTER  fbs    Pointer to variable array dp
!D4   ipeta           POINTER  fbs    Pointer to variable array eta
!D4   ipexci          POINTER  fbs    Pointer to variable array exci
!D4   ipsi            POINTER  fbs    Pointer to variable array si
!D4   ipw             POINTER  fbs    Pointer to variable array w
!D4   ipwp            POINTER  fbs    Pointer to variable array wp
!D4   ipwr            POINTER  fbs    Pointer to variable array wr
!D4   ipwx            POINTER  fbs    Pointer to variable array wx
!D4   ipwxp           POINTER  fbs    Pointer to variable array wxp
!D4   ipwxr           POINTER  fbs    Pointer to variable array wxr
!D4   ipwy            POINTER  fbs    Pointer to variable array wy
!D4   ipwyp           POINTER  fbs    Pointer to variable array wyp
!D4   ipwyr           POINTER  fbs    Pointer to variable array wyr
!D4   ipwz            POINTER  fbs    Pointer to variable array wz
!D4   ipwzp           POINTER  fbs    Pointer to variable array wzp
!D4   ipwzr           POINTER  fbs    Pointer to variable array wzr
!D4   ipxd            POINTER  fbs    Pointer to variable array xd
!D4   ipxt            POINTER  fbs    Pointer to variable array xt
!D4   ipyd            POINTER  fbs    Pointer to variable array yd
!D4   ipyt            POINTER  fbs    Pointer to variable array yt
!D4   ipzd            POINTER  fbs    Pointer to variable array zd
!D4   ipzt            POINTER  fbs    Pointer to variable array zt
!D4   ipdx_bbox       POINTER  fbs    Pointer to variable array dx_bbox
!D4   ipdy_bbox       POINTER  fbs    Pointer to variable array dy_bbox
!D4   ipdz_bbox       POINTER  fbs    Pointer to variable array dz_bbox
!D4   ipda_bbox       POINTER  fbs    Pointer to variable array da_bbox
!D4 
!D4   cord            REAL*8   fbs    Contains the coordinates of each node 
!D4   dp              REAL*8   fbs    Contains weights for integration points   
!D4                                     (prisms, triangles) 
!D4   dr              REAL*8   fbs    Contains weights for integration  
!D4                                     points (bricks, rectangles) 
!D4   eta             REAL*8   fbs    Local coordinates in a finite element of  
!D4                                     the numerical integration points   
!D4   exci            REAL*8   fbs    Local coordinates in a finite element of  
!D4                                     the numerical integration points 
!D4   si              REAL*8   fbs    Local coordinates in a finite element of  
!D4                                     the numerical integration points   
!D4   w               REAL*8   fbs    Finite element shape functions 
!D4   wp              REAL*8   fbs    Finite element shape functions   
!D4                                     (prisms) 
!D4   wr              REAL*8   fbs    Finite element shape functions   
!D4                                     (rectangles) 
!D4   wx              REAL*8   fbs    Derivative of shape functions with 
!D4                                     respect to x 
!D4   wxp             REAL*8   fbs    Derivative of shape functions with  
!D4                                      respect to x (prisms) 
!D4   wxr             REAL*8   fbs    Derivative of shape functions with   
!D4                                     respect to x (rectangles) 
!D4   wy              REAL*8   fbs    Derivative of shape functions with  
!D4                                     respect to y 
!D4   wyp             REAL*8   fbs    Derivative of shape functions with   
!D4                                     respect to y (prisms) 
!D4   wyr             REAL*8   fbs    Derivative of shape functions with   
!D4                                     respect to y (rectangles) 
!D4   wz              REAL*8   fbs    Derivative of shape functions with  
!D4                                     respect to z 
!D4   wzp             REAL*8   fbs    Derivative of shape functions with   
!D4                                     respect to z (prisms)  
!D4   wzr             REAL*8   fbs    Derivative of shape functions with   
!D4                                     respect to z (rectangles) 
!D4   xd              REAL*8   fbs    Global coordinates of the nodes in a 
!D4                                     finite element 
!D4   xt              REAL*8   fbs    Parameters needed in element calculations 
!D4   yd              REAL*8   fbs    Global coordinates of the nodes in a  
!D4                                     finite element 
!D4   yt              REAL*8   fbs    Parameters needed in element calculations 
!D4   zd              REAL*8   fbs    Global coordinates of the nodes in a  
!D4                                     finite element   
!D4   zt              REAL*8   fbs    Parameters needed in element calculations
!D4   dx_bbox         REAL*8   fbs    X - apx. control volume range
!D4   dy_bbox         REAL*8   fbs    Y - apx. control volume range
!D4   dz_bbox         REAL*8   fbs    Z - apx. control volume range
!D4   da_bbox         REAL*8   fbs    A - apx. control volume area
!D4                                       (r2**2 - r1**2)*pi
!D4
!D4 Global Subprograms
!D4
!D4   None
!D4
!***********************************************************************
!D5
!D5 LOCAL IDENTIFIERS
!D5
!D5 None
!D5
!***********************************************************************
!D6
!D6 FUNCTIONAL DESCRIPTION
!D6
!D6 None
!D6
!***********************************************************************
!D7
!D7 ASSUMPTIONS AND LIMITATIONS
!D7
!D7 None
!D7
!***********************************************************************
!D8
!D8 SPECIAL COMMENTS
!D8
!D8 None
!D8
!***********************************************************************
!D9
!D9 REQUIREMENTS TRACEABILITY
!D9
!D9 N/A
!D9
!***********************************************************************
!DA
!DA REFERENCES
!DA
!DA None
!DA
!***********************************************************************
!PS
!PS PSEUDOCODE
!PS
!PS None
!PS
!***********************************************************************

      integer isox, isoy, isoz                   
      integer, allocatable ::  istrw(:)
      integer, allocatable ::  istrw_primary(:)
      integer, allocatable ::  istrw_itfc(:)
      integer, allocatable ::  istrw_cold(:)
      integer, allocatable ::  izonef(:)
      integer, allocatable ::  izoneflxz(:)
      integer, allocatable ::  izonefree(:)
      integer, allocatable ::  izonegrad(:)
      integer, allocatable ::  izonesubm(:)
      integer, allocatable ::  izonef_itfc(:)
      integer, allocatable ::  ka(:)
      integer, allocatable ::  nar(:)
      integer, allocatable ::  nelm(:)
      integer, allocatable ::  nelm_primary(:)
      integer, allocatable ::  nelmdg(:)
      integer, allocatable ::  nelmdg_primary(:)
      integer, allocatable ::  nop(:)
      integer, allocatable ::  igdpm(:)
      integer, allocatable ::  ngdpm_layers(:)

      integer, allocatable ::  ncon_x1(:)
      integer, allocatable ::  ncon_y1(:) 
      integer, allocatable ::  ncon_z1(:)
      integer, allocatable ::  ncon_x2(:)
      integer, allocatable ::  ncon_y2(:)
      integer, allocatable ::  ncon_z2(:)
      integer, allocatable ::  ncon_adv(:,:)

      integer, allocatable ::  icxani(:)
      integer, allocatable ::  icyani(:)
      integer, allocatable ::  iczani(:)

      real*8, allocatable ::   gdpm_x(:,:)
      real*8, allocatable ::   vfrac_primary(:)

      real*8, allocatable ::   sx(:,:)
      real*8, allocatable ::   sx_primary(:,:)
      real*8, allocatable ::   sx1(:)
      real*8, allocatable ::   sxs(:,:)
      real*8, allocatable ::   cord(:,:)
      real*8, allocatable ::   corz(:,:)
      real*8, allocatable ::   dp(:)
      real*8, allocatable ::   dr(:)
      real*8, allocatable ::   eta(:)
      real*8, allocatable ::   exci(:)
      real*8, allocatable ::   si(:)
      real*8, allocatable ::   w(:,:)
      real*8, allocatable ::   wp(:,:)
      real*8, allocatable ::   wr(:,:)
      real*8, allocatable ::   wx(:,:)
      real*8, allocatable ::   wxp(:,:)
      real*8, allocatable ::   wxr(:,:)
      real*8, allocatable ::   wy(:,:)
      real*8, allocatable ::   wyp(:,:)
      real*8, allocatable ::   wyr(:,:)
      real*8, allocatable ::   wz(:,:)
      real*8, allocatable ::   wzp(:,:)
      real*8, allocatable ::   wzr(:,:)
      real*8, allocatable ::   xd(:)
      real*8, allocatable ::   xt(:)
      real*8, allocatable ::   yd(:)
      real*8, allocatable ::   yt(:)
      real*8, allocatable ::   zd(:)
      real*8, allocatable ::   zt(:)
      real*8, allocatable ::   dx_bbox(:)
      real*8, allocatable ::   dy_bbox(:)
      real*8, allocatable ::   dz_bbox(:)
      real*8, allocatable ::   da_bbox(:)

      real*8, allocatable ::   sx_x(:)
      real*8, allocatable ::   sx_y(:)
      real*8, allocatable ::   sx_z(:)

c
c arrays for use with rate-limited processes (gdpm etc)
c
      integer igdpm_rate, ngdpm_rate
      integer, allocatable ::  igdpm_rate_nodes(:)
	real*8, allocatable ::   gdpm_cond(:)
      real*8 val_conh, val_cont
      end module combi


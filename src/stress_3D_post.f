      subroutine stress_3D_post(i)
C**********************************************************************
CD1
CD1 PURPOSE
CD1
CD1 To generate equations for stress at each node.
CD1 This simple version does not use symmetry
CD1
C**********************************************************************
CD2
CD2 REVISION HISTORY
CD2
CD2 Revision                    ECD
CD2 Date         Programmer     Number  Comments
CD2
CD2 9-08-05     G. Zyvoloski   00022   Initial implementation.
CD2
CD3
CD3
C**********************************************************************
CD9
CD9 REQUIREMENTS TRACEABILITY
CD9 
CD9 2.3.2 Heat- and mass-transfer equations
CD9 2.3.3 Noncondensible gas flow equations
CD9
C**********************************************************************
CDA
CDA REFERENCES
CDA
CDA See FEHMN SRS, MMS, and SDD
CDA
C**********************************************************************
C developer notes
C 3-21-06 gaz
C array stencil symmetry not used yet- will put in later
C need to think on how upper and lower diagonal are used 
C*******************************

***************************************
c
c generate equations for 3-d stress with finite elements ,
c full derivatives
c
      use comflow
      use davidi
      use comji
      use comfi
      use comgi
      use comei
      use comdi
      use comci
      use combi
      use comdti
      use comai
      use comsi
      implicit none

      integer i
      integer icd
      integer ii1
      integer ii2
      integer idg 
      integer iq
      integer jmi
      integer jml
      integer jmia
      integer jm
      integer neqp1
      integer ij
      integer ij1
      integer ij2
      integer iz
      integer kb
      integer neighc
      integer iau
      integer ial
      integer kz
      
      integer nmatavw
      real*8 sx1d
      real*8 axi
      real*8 ayi
      real*8 azi
      real*8 alxi
      real*8 alyi
      real*8 alzi
      real*8 avxi
      real*8 avyi
      real*8 avzi
      real*8 pvii
      real*8 phii
      real*8 swi
      real*8 dlpi
      real*8 dlpkb
      real*8 dvpi
      real*8 dvpkb
      real*8 dlei
      real*8 dvei
      real*8 dlekb
      real*8 dvekb
      real*8 dlapi
      real*8 dvapi
      real*8 dlapkb
      real*8 dvapkb
      real*8 dili
      real*8 dilkb
      real*8 divi
      real*8 divkb
      real*8 axkb
      real*8 aykb
      real*8 azkb
      real*8 alxkb
      real*8 alykb
      real*8 alzkb
      real*8 sx2c
      real*8 sx4d

      real*8 pvikb
      real*8 phikb
      real*8 radi
      real*8 radkb
      real*8 fid
      real*8 fid1
      real*8 axyd
      real*8 axy
      real*8 axyf
      real*8 heatc
      real*8 pvxy
      real*8 pxy
      real*8 pxyh
      real*8 pxyi
      real*8 sx4h
      real*8 vxyd
      real*8 vxy
      real*8 vxyf
      real*8 dpvti
      real*8 dilpi
      real*8 dilei
      real*8 divpi
      real*8 divei
      real*8 dilpkb
      real*8 divekb
      real*8 dilekb
      real*8 sx2t
      real*8 sx3t
      real*8 sxzt
      real*8 dlaei
      real*8 dlaekb
      real*8 dvaei
      real*8 dvaekb
      real*8 ti
      real*8 dis2,dis_tol,sx_min
      real*8 delx2
      real*8 dely2
      real*8 delz2
      real*8 redu
      real*8 divpkbction_factor
      real*8 grav_air
      real*8 grav_term

      real*8 e1i,e2i,e3i,e1kb,e2kb,e3kb
      real*8 e1bar,e2bar,e3bar
	real*8 efac,bulki,bulkkb,bulkb,alpi,alpkb,alphab
      real*8 dui,dvi,dwi,dukb,dvkb,dwkb
      real*8 xxx,xyy,xzz,xyx,xxy,xzx,yxy
      real*8 yyx,yyy,yxx,yzz,yzy,yyz,zxz
      real*8 zzx,zyz,zzy,zzz,zyy,zxx,xxz
      real*8 xx,xy,xz,yy,yx,yz,zx,zy,zz
      real*8 ddx,ddy,ddz,pxx,pxz,pyx
	real*8 pyy,pyz,pzx,pzy,pzz
	real*8 fad,fbd,fcd
      real*8 pdumi,tdumi,pdumkb,tdumkb,pdumt,tdumt,roli
	real*8 tdumx,tdumy,tdumz
	real*8 bforcex,bforcey,bforcez
	real*8 dtdumxp,dtdumxt
	real*8 dtdumyp,dtdumyt
	real*8 dtdumzp,dtdumzt
      real*8 sixsjx,siysjy,sizsjz,sixsjy
      real*8 siysjx,sixsjz,sizsjx,siysjz
      real*8 sizsjy,sjsix,sjsiy,sjsiz
	real*8 sisjx,sisjy,sisjz,termx,termy,termz
      real*8 vol,sxd,syd,tauxy,tauyz,tauzx,ctherm,biot,erat
	real*8 epi,eti,dpd,dt,shti,shpi

      integer, allocatable ::   itstress(:)
      integer iws

      parameter(dis_tol=1.d-12)

      logical bit
      integer isl
      integer iz4m1
      integer imd,iwd    

  


c changed by avw -- entered here by seh
      neqp1=neq+1
      ldna=nelm(neqp1)-neqp1
      if(i.gt.neq) then
         nmatavw=ldna
      else
         nmatavw=0
      endif
      if(icons.le.abs(maxit)) then
       grav_air=0.0
      else
       grav_air=grav
      endif

c
c zero out temporary storage
c
      if(.not.allocated(itstress)) then


       allocate(itstress(200))


      endif

c
c fluid and grid properties at node i
c
      sx1d=sx1(i)
      vol = sx1d
      pvii=phi(i)     
      phii=pvii
      ti=t(i)
      swi=s(i)
      e1i = e1(i)
      e2i = e2(i)
      e3i = e3(i)
c recall displacements at the node i
      dui = du(i)
      dvi = dv(i)
      dwi = dw(i)

c reference rock density
      roli=denr(i)
	bforcex = 0.0d0
	bforcey = 0.0d0
	bforcez = 0.0d0
c      
c
c form constants for i>neq
c
      if(i.gt.neq.and.idualp.eq.0) then
         icd=neq
      else
         icd=0
      endif
      iz=i-icd
c
      iz4m1 = 4*(iz-1)+1
c

      neqp1=neq+1
c define diagonal term for connectivity
      jmi=nelmdg(i-icd)
c define diagonal term for jacobian matrix 
      jmia=jmi-neqp1
      
      ii1=nelm(i-icd)+1
      ii2=nelm(i-icd+1)
      idg=nelmdg(i-icd)-ii1+1
      
      iq=0
      do jm=ii1,ii2
	  kb=nelm(jm)+icd
	 
        iq=iq+1
        it8(iq)=kb
        itstress(iq) = istrws(jm-neqp1) 
        	 
      enddo

      termx=0.
      termy=0.
      termz=0.
      tauxy=0.
      tauyz=0.
      tauzx=0.


	ctherm=alp(i)
c  ctherm=coef of temp expansion,  biot=1./3h from biot's paper
      biot=bulk(i)
      erat=e2i/e1i
      efac=3.d0*e2i+2.d0*e3i
c stress due to temp and pore pressure changes
      epi=efac*biot
      eti=efac*ctherm
      dpd=phi(i)-phini(i)
      dt=t(i)-tini(i)
c changed 5-25-08 gaz
      shti=(eti*dt)
      shpi=(epi*dpd)

c
c 3-d geometry 
c
         do jm=1,iq
            kb=it8(jm)
            kz=kb-icd          
        
            iws=itstress(jm)    
         	     
          
c recall geometric integrals, calculated in gencof.
c might be 7 8 9 gaz 11-2-2006
      sisjx=sxs(iws,7)
      sisjy=sxs(iws,8)
      sisjz=-sxs(iws,9)
c average material properties                     
            e1kb = e1(kb)
            e2kb = e2(kb)
            e3kb = e3(kb)
            e1bar=2.*e1i*e1kb/(e1i+e1kb + dis_tol)
            e2bar=2.*e2i*e2kb/(e2i+e2kb + dis_tol)
            e3bar=2.*e3i*e3kb/(e3i+e3kb + dis_tol)
c thermal conductivity
c            alpkb=alp(kb)
c            alphab=2.*alpi*alpkb/(alpi+alpkb + dis_tol)
c biot term
c            bulkkb=bulk(kb)
c            bulkb=2.*bulkkb*bulki/(bulkkb+bulki + dis_tol)
c            efac = 3.d0*e2bar + 2.d0*e3bar

c           tdumkb=t(kb)-tini(kb)
c           pdumkb=phi(kb)-phini(kb)
c           tdumt=0.5*(tdumkb+tdumi)
c	     pdumt=0.5*(pdumkb+pdumi)
c
c           tdumx=sjsix*(tdumt*alphab+pdumt*bulkb)*efac
c           tdumy=sjsiy*(tdumt*alphab+pdumt*bulkb)*efac
c           tdumz=sjsiz*(tdumt*alphab+pdumt*bulkb)*efac
             
c calculate stresses 

      ddx=du(kb)-dui
      ddy=dv(kb)-dvi
      ddz=dw(kb)-dwi
      xx=e1bar*sisjx*ddx
      xy=e2bar*sisjy*ddy
      xz=e2bar*sisjz*ddz
      yx=e2bar*sisjx*ddx
      yy=e1bar*sisjy*ddy
      yz=e2bar*sisjz*ddz
      zx=e2bar*sisjx*ddx
      zy=e2bar*sisjy*ddy
      zz=e1bar*sisjz*ddz
      xyx=e3bar*sisjy*ddx
      xyy=e3bar*sisjx*ddy
      yzy=e3bar*sisjz*ddy
      yzz=e3bar*sisjy*ddz
      zxx=e3bar*sisjz*ddx
      zxz=e3bar*sisjx*ddz
c
      termx=termx+(xx+xy+xz)
      termy=termy+(yx+yy+yz)
      termz=termz+(zx+zy+zz)
      tauxy=tauxy+xyx+xyy
      tauyz=tauyz+yzy+yzz
      tauzx=tauzx+zxx+zxz 

      enddo
      str_x(i)=(shpi+shti-termx/vol)
      str_y(i)=(shpi+shti-termy/vol)
      str_z(i)=(shpi+shti-termz/vol)
      str_xy(i)=tauxy/vol
      str_yz(i)=tauyz/vol
      str_xz(i)=tauzx/vol

      
      return
      end



MODULE TYPES

! Definitions of various derived data types
 
USE PRECISION_PARAMETERS
USE GLOBAL_CONSTANTS, ONLY : NULL_BOUNDARY,NEUMANN

IMPLICIT NONE
CHARACTER(255), PARAMETER :: typeid='$Id$'
CHARACTER(255), PARAMETER :: typerev='$Revision$'
CHARACTER(255), PARAMETER :: typedate='$Date$'

TYPE LAGRANGIAN_PARTICLE_CLASS_TYPE
   CHARACTER(30) :: ID,SPEC_ID,DEVC_ID='null',CTRL_ID='null',QUANTITIES(10),SMOKEVIEW_BAR_LABEL(10),SURF_ID='null',PROP_ID='null',&
                    RADIATIVE_PROPERTY_TABLE_ID='null',CNF_RAMP_ID='null',DISTRIBUTION='ROSIN-RAMMLER-LOGNORMAL',&
                    CHILD_DISTRIBUTION='ROSIN-RAMMLER-LOGNORMAL',CHILD_CNF_RAMP_ID='null'
   CHARACTER(60) :: SMOKEVIEW_LABEL(10)
   REAL(EB) :: HEAT_OF_COMBUSTION,ADJUST_EVAPORATION, &
               LIFETIME,DIAMETER,MINIMUM_DIAMETER,MAXIMUM_DIAMETER,GAMMA,KILL_RADIUS, &
               TMP_INITIAL,SIGMA,VERTICAL_VELOCITY,HORIZONTAL_VELOCITY, &
               USER_DRAG_COEFFICIENT, &
               SURFACE_TENSION,BREAKUP_CHILD_DIAMETER,BREAKUP_CHILD_GAMMA,BREAKUP_CHILD_SIGMA,DENSE_VOLUME_FRACTION, &
               REAL_REFRACTIVE_INDEX,COMPLEX_REFRACTIVE_INDEX,TOL_INT,DENSITY,FTPR
   REAL(EB), POINTER, DIMENSION(:) :: R_CDF=>NULL(),CDF=>NULL(),CHILD_R_CDF=>NULL(),CHILD_CDF=>NULL(),W_CDF=>NULL(),&
                                      R50=>NULL(),LAMBDA=>NULL()
   REAL(EB), POINTER, DIMENSION(:,:) :: WQABS=>NULL(),WQSCA=>NULL(),TABLE_ROW=>NULL()
   REAL(EB), POINTER, DIMENSION(:,:) :: ORIENTATION=>NULL()
   INTEGER :: SAMPLING,N_QUANTITIES,QUANTITIES_INDEX(10),ARRAY_INDEX=0,RGB(3),RADIATIVE_PROPERTY_INDEX=0, &
              SURF_INDEX=0,DRAG_LAW=1,DEVC_INDEX=0,CTRL_INDEX=0,PROP_INDEX=-1,N_ORIENTATION,Z_INDEX=-1,&
              Y_INDEX=-1,CNF_RAMP_INDEX=-1,CHILD_CNF_RAMP_INDEX=-1,N_STORAGE_REALS,N_STORAGE_INTEGERS,N_STORAGE_LOGICALS
   INTEGER,  POINTER, DIMENSION(:) :: IL_CDF=>NULL(),IU_CDF=>NULL()
   LOGICAL :: STATIC=.FALSE.,MASSLESS,MONODISPERSE=.FALSE.,EVAPORATE=.TRUE.,TURBULENT_DISPERSION=.FALSE., &
              BREAKUP=.FALSE.,CHECK_DISTRIBUTION=.FALSE.,FUEL=.FALSE.,CONSTANT_TEMPERATURE=.FALSE.
   !WUI Variables 
   CHARACTER(25) :: VEG_DEGRADATION
   LOGICAL ::VEG_REMOVE_CHARRED,VEG_STEM,VEG_CHAR_OXIDATION,TREE=.FALSE.
   REAL(EB) :: VEG_SV,VEG_MOISTURE,VEG_CHAR_FRACTION,VEG_DRAG_COEFFICIENT,VEG_BULK_DENSITY, &
               VEG_DENSITY,VEG_BURNING_RATE_MAX,VEG_DEHYDRATION_RATE_MAX,VEG_INITIAL_TEMPERATURE, &
               VEG_FUEL_MPV_MIN,VEG_MOIST_MPV_MIN          
               
END TYPE LAGRANGIAN_PARTICLE_CLASS_TYPE

TYPE (LAGRANGIAN_PARTICLE_CLASS_TYPE), DIMENSION(:), ALLOCATABLE, TARGET :: LAGRANGIAN_PARTICLE_CLASS

! Note: If you change the number of scalar variables in ONE_D_M_AND_E_XFER_TYPE, adjust the numbers below

INTEGER, PARAMETER :: N_ONE_D_SCALAR_REALS=13,N_ONE_D_SCALAR_INTEGERS=9,N_ONE_D_SCALAR_LOGICALS=2

TYPE ONE_D_M_AND_E_XFER_TYPE
   REAL(EB), POINTER, DIMENSION(:) :: TMP,LAYER_THICKNESS,X,MASSFLUX_ACTUAL,MASSFLUX
   REAL(EB), POINTER, DIMENSION(:,:) :: RHO,ILW
   INTEGER, POINTER, DIMENSION(:) :: N_LAYER_CELLS
   INTEGER, POINTER :: ARRAY_INDEX,STORAGE_INDEX,II,JJ,KK,IIG,JJG,KKG,IOR
   REAL(EB), POINTER :: AREA,RAREA,HEAT_TRANS_COEF,QCONF,QRADIN,QRADOUT,EMISSIVITY,AREA_ADJUST,T,TMP_F,TMP_B,UW,UWS
   LOGICAL, POINTER :: BURNAWAY,SHRINKING
END TYPE ONE_D_M_AND_E_XFER_TYPE

! Note: If you change the number of scalar variables in LAGRANGIAN_PARTICLE_TYPE, adjust the numbers below

INTEGER, PARAMETER :: N_PARTICLE_SCALAR_REALS=27,N_PARTICLE_SCALAR_INTEGERS=8,N_PARTICLE_SCALAR_LOGICALS=3

TYPE LAGRANGIAN_PARTICLE_TYPE
   TYPE (ONE_D_M_AND_E_XFER_TYPE) :: ONE_D
   LOGICAL, POINTER :: SHOW,SPLAT,IGNITOR
   REAL(EB), POINTER :: X,Y,Z,U,V,W,PWT,ACCEL_X,ACCEL_Y,ACCEL_Z,RE,MASS,TMP_B,&
                        VEG_KAPPA,VEG_EMISS,VEG_DIVQC,VEG_DIVQR,VEG_PACKING_RATIO,VEG_FUEL_MASS,VEG_MOIST_MASS,VEG_IGN_TON, &
                        VEG_IGN_TOFF,VEG_IGN_TRAMPON,VEG_IGN_TRAMPOFF,VEG_CHAR_MASS,VEG_SV,VEG_MLR,VEG_VOLFRACTION
   INTEGER, POINTER :: TAG,ARRAY_INDEX,STORAGE_INDEX,CLASS_INDEX,ORIENTATION_INDEX,SURF_INDEX,WALL_INDEX,&
                       VEG_N_TREE_OUTPUT
END TYPE LAGRANGIAN_PARTICLE_TYPE


TYPE STORAGE_TYPE
   INTEGER :: N_STORAGE_SLOTS=0
   REAL(EB), ALLOCATABLE, DIMENSION(:,:) :: REALS
   INTEGER, ALLOCATABLE, DIMENSION(:,:) :: INTEGERS
   LOGICAL, ALLOCATABLE, DIMENSION(:,:) :: LOGICALS
END TYPE STORAGE_TYPE

! Note: If you change the number of scalar variables in WALL_TYPE, adjust the numbers below

INTEGER, PARAMETER :: N_WALL_SCALAR_REALS=14,N_WALL_SCALAR_INTEGERS=10,N_WALL_SCALAR_LOGICALS=0

TYPE WALL_TYPE
   TYPE (ONE_D_M_AND_E_XFER_TYPE) :: ONE_D
   REAL(EB), POINTER, DIMENSION(:) :: A_LP_MPUA,LP_CPUA,LP_MPUA,AWM_AEROSOL,RHODW,ZZ_F,VEG_FUELMASS_L,VEG_MOISTMASS_L,VEG_TMP_L
   REAL(EB), POINTER :: AW,DUWDT,EW,KW,RAW,RDN,RHO_F,U_TAU,UVW_GHOST,UW0,XW,YW,ZW,VEG_HEIGHT
   INTEGER, POINTER, DIMENSION(:) :: NOM_IB
   INTEGER, POINTER :: WALL_INDEX,SURF_INDEX,BACK_INDEX,BOUNDARY_TYPE,SURF_INDEX_ORIG,OBST_INDEX, &
                       PRESSURE_BC_INDEX,PRESSURE_ZONE,VENT_INDEX,NOM
END TYPE WALL_TYPE

TYPE SPECIES_TYPE
   REAL(EB) :: MW=0._EB,YY0=0._EB,RCON,MAXMASS,MASS_EXTINCTION_COEFFICIENT=0._EB,&
               SPECIFIC_HEAT=-1._EB,REFERENCE_ENTHALPY=-1._EB,&
               REFERENCE_TEMPERATURE,MU_USER=-1._EB,K_USER=-1._EB,D_USER=-1._EB,EPSK=-1._EB,SIG=-1._EB,&
               FLD_LETHAL_DOSE=0._EB,FIC_CONCENTRATION=0._EB,&
               SPECIFIC_HEAT_LIQUID=-1,DENSITY_LIQUID,VAPORIZATION_TEMPERATURE,HEAT_OF_VAPORIZATION=-1._EB,MELTING_TEMPERATURE,&
               H_V_REFERENCE_TEMPERATURE=-1._EB,H_V_CORRECTOR=0._EB ,TMP_V=-1._EB,TMP_MELT=-1._EB,ATOMS(118)=0._EB,&
               MEAN_DIAMETER=1.E-6_EB,CONDUCTIVITY_SOLID,DENSITY_SOLID
   LOGICAL :: ABSORBING=.FALSE.,ISFUEL=.FALSE.,BACKGROUND=.FALSE.,SMIX_COMPONENT_ONLY=.FALSE.,LISTED=.FALSE.
   CHARACTER(30) :: ID,RAMP_CP,RAMP_CP_L,RAMP_K,RAMP_MU,RAMP_D
   CHARACTER(100) :: FORMULA
   INTEGER :: MODE=2,RAMP_CP_INDEX=-1,RAMP_CP_L_INDEX=-1,RAMP_K_INDEX=-1,RAMP_MU_INDEX=-1,RAMP_D_INDEX=-1
   REAL(EB),POINTER,DIMENSION(:) :: H_V=>NULL(),C_P_L=>NULL(),C_P_L_BAR=>NULL(),H_L=>NULL()
                 
END TYPE SPECIES_TYPE

TYPE (SPECIES_TYPE), DIMENSION(:), ALLOCATABLE, TARGET :: SPECIES

TYPE SPECIES_MIXTURE_TYPE
   REAL(EB), POINTER, DIMENSION(:) :: MASS_FRACTION,VOLUME_FRACTION
   REAL(EB) :: MW , RCON, ZZ0=0._EB, MASS_EXTINCTION_COEFFICIENT=0._EB,ADJUST_NU=1._EB,ATOMS(118)=0._EB,MEAN_DIAMETER,&
               DENSITY_SOLID,CONDUCTIVITY_SOLID
   CHARACTER(30), POINTER, DIMENSION(:) :: SPEC_ID
   CHARACTER(30) :: ID='null'
   CHARACTER(100) :: FORMULA='null'
   INTEGER :: AWM_INDEX = -1
   LOGICAL :: DEPOSITING=.FALSE.,VALID_ATOMS=.TRUE.,EVAPORATING=.FALSE.
END TYPE SPECIES_MIXTURE_TYPE

TYPE (SPECIES_MIXTURE_TYPE), DIMENSION(:), ALLOCATABLE, TARGET :: SPECIES_MIXTURE

TYPE REACTION_TYPE
   CHARACTER(30) :: FUEL,OXIDIZER,PRODUCTS,ID
   CHARACTER(30), DIMENSION(:), POINTER :: SMIX_ID=>NULL(),SMIX_ID_READ=>NULL(),SPEC_ID=>NULL(),SPEC_ID_READ=>NULL()
   REAL(EB) :: C,H,N,O,EPUMO2,HEAT_OF_COMBUSTION,HOC_COMPLETE,A,A_IN,E,E_IN,TOL_INT, &
      Y_O2_INFTY,Y_N2_INFTY=0._EB,MW_FUEL,MW_SOOT, &
      CO_YIELD,SOOT_YIELD,H2_YIELD, SOOT_H_FRACTION,RHO_EXPONENT, CRIT_FLAME_TMP, &
      NU_O2=0._EB,NU_N2=0._EB,NU_H2O=0._EB,NU_CO2=0._EB,NU_CO=0._EB,NU_SOOT=0._EB
   REAL(EB) :: AUTO_IGNITION_TEMPERATURE=0._EB,THRESHOLD_TEMP=0._EB,N_T=0._EB
   REAL(EB), DIMENSION(:), POINTER :: NU=>NULL(),NU_READ=>NULL(),NU_SPECIES=>NULL(),N_S=>NULL(),N_S_READ=>NULL()
   INTEGER :: FUEL_SMIX_INDEX=-1,MODE,N_SMIX,N_SPEC
   LOGICAL :: IDEAL,CHECK_ATOM_BALANCE,EDCM,REVERSIBLE
   CHARACTER(100) :: FYI='null'
   CHARACTER(255) :: EQUATION
   CHARACTER(100) :: FWD_ID
END TYPE REACTION_TYPE

TYPE (REACTION_TYPE), DIMENSION(:), ALLOCATABLE, TARGET :: REACTION

TYPE MATERIAL_TYPE
   REAL(EB) :: K_S,C_S,RHO_S,EMISSIVITY,DIFFUSIVITY,KAPPA_S,MOISTURE_FRACTION,TMP_BOIL,INIT_VAPOR_FLUX
   INTEGER :: PYROLYSIS_MODEL
   CHARACTER(30) :: RAMP_K_S,RAMP_C_S
   INTEGER :: N_REACTIONS,PROP_INDEX=-1
   INTEGER, DIMENSION(MAX_REACTIONS) :: N_RESIDUE
   INTEGER, DIMENSION(MAX_MATERIALS,MAX_REACTIONS) :: RESIDUE_MATL_INDEX
   REAL(EB), DIMENSION(MAX_REACTIONS) :: TMP_REF,TMP_IGN,TMP_THR,RATE_REF,THR_SIGN
   REAL(EB), DIMENSION(MAX_MATERIALS,MAX_REACTIONS) :: NU_RESIDUE
   REAL(EB), DIMENSION(MAX_REACTIONS) :: A,E,H_R,N_S,N_T,HEATING_RATE,PYROLYSIS_RANGE,HEAT_OF_COMBUSTION,TOL_INT
   REAL(EB), DIMENSION(MAX_SPECIES,MAX_REACTIONS) :: NU_SPEC,NU_GAS,ADJUST_BURN_RATE
   LOGICAL, DIMENSION(MAX_REACTIONS) :: PCR = .FALSE.
   CHARACTER(30), DIMENSION(MAX_MATERIALS,MAX_REACTIONS) :: RESIDUE_MATL_NAME
   CHARACTER(30), DIMENSION(MAX_SPECIES,MAX_REACTIONS) :: SPEC_ID
   CHARACTER(100) :: FYI='null'
END TYPE MATERIAL_TYPE

TYPE (MATERIAL_TYPE), DIMENSION(:), ALLOCATABLE, TARGET :: MATERIAL

TYPE SURFACE_TYPE
   REAL(EB) :: TMP_FRONT=-1._EB,VEL,PLE,Z0,CONVECTIVE_HEAT_FLUX,NET_HEAT_FLUX, &
               VOLUME_FLUX,HRRPUA,MLRPUA,T_IGN,SURFACE_DENSITY,CELL_SIZE_FACTOR, &
               E_COEFFICIENT,TEXTURE_WIDTH,TEXTURE_HEIGHT,THICKNESS,EXTERNAL_FLUX,TMP_BACK=-1._EB, &
               DXF,DXB,MASS_FLUX_TOTAL,PARTICLE_MASS_FLUX,EMISSIVITY,MAX_PRESSURE,&
               TMP_IGN,H_V,REGRID_FACTOR,LAYER_DIVIDE,ROUGHNESS,RADIUS=-1._EB,LENGTH=-1._EB,WIDTH=-1._EB, &
               DT_INSERT,H_FIXED=-1._EB,EMISSIVITY_BACK,CONV_LENGTH,XYZ(3),FIRE_SPREAD_RATE, &
               MINIMUM_LAYER_THICKNESS
   REAL(EB), POINTER, DIMENSION(:) :: DX=>NULL(),RDX=>NULL(),RDXN=>NULL(),X_S=>NULL(),DX_WGT=>NULL(),MF_FRAC=>NULL(),&
                                      PARTICLE_INSERT_CLOCK=>NULL()
   REAL(EB), POINTER, DIMENSION(:,:) :: RHO_0
   REAL(EB), DIMENSION(0:MAX_SPECIES) :: MASS_FRACTION,MASS_FLUX
   REAL(EB), DIMENSION(-5:MAX_SPECIES) :: TAU,ADJUST_BURN_RATE=1._EB
   INTEGER,  DIMENSION(-5:MAX_SPECIES) :: RAMP_INDEX=0
   INTEGER, DIMENSION(3) :: RGB
   REAL(EB) :: TRANSPARENCY
   REAL(EB), DIMENSION(2) :: VEL_T
   INTEGER, DIMENSION(2) :: LEAK_PATH,DUCT_PATH
   INTEGER :: THERMAL_BC_INDEX,NPPC,SPECIES_BC_INDEX,VELOCITY_BC_INDEX,SURF_TYPE,N_CELLS,PART_INDEX,PROP_INDEX=-1
   INTEGER :: PYROLYSIS_MODEL,NRA,NSB
   INTEGER :: N_LAYERS,N_MATL
   INTEGER :: N_ONE_D_STORAGE_REALS,N_ONE_D_STORAGE_INTEGERS,N_ONE_D_STORAGE_LOGICALS
   INTEGER :: N_WALL_STORAGE_REALS,N_WALL_STORAGE_INTEGERS,N_WALL_STORAGE_LOGICALS
   INTEGER, DIMENSION(10) :: ONE_D_REALS_ARRAY_SIZE=0,ONE_D_INTEGERS_ARRAY_SIZE=0,ONE_D_LOGICALS_ARRAY_SIZE=0
   INTEGER, DIMENSION(10) :: WALL_REALS_ARRAY_SIZE=0,WALL_INTEGERS_ARRAY_SIZE=0,WALL_LOGICALS_ARRAY_SIZE=0
   INTEGER, POINTER, DIMENSION(:) :: N_LAYER_CELLS,LAYER_INDEX,MATL_INDEX
   INTEGER, DIMENSION(MAX_LAYERS,MAX_MATERIALS) :: LAYER_MATL_INDEX
   INTEGER, DIMENSION(MAX_LAYERS) :: N_LAYER_MATL
   INTEGER, POINTER, DIMENSION(:,:,:) :: RESIDUE_INDEX=>NULL()
   REAL(EB), POINTER, DIMENSION(:) :: MIN_DIFFUSIVITY=>NULL()
   REAL(EB), POINTER, DIMENSION(:) :: LAYER_THICKNESS
   REAL(EB), DIMENSION(MAX_LAYERS) :: LAYER_DENSITY, TMP_INNER, STRETCH_FACTOR
   CHARACTER(30), POINTER, DIMENSION(:) :: MATL_NAME=>NULL()
   CHARACTER(30), DIMENSION(MAX_LAYERS,MAX_MATERIALS) :: LAYER_MATL_NAME
   REAL(EB), DIMENSION(MAX_LAYERS,MAX_MATERIALS) :: LAYER_MATL_FRAC
   LOGICAL :: BURN_AWAY,ADIABATIC,THERMALLY_THICK,INTERNAL_RADIATION,SHRINK,USER_DEFINED=.TRUE., &
              FREE_SLIP=.FALSE.,NO_SLIP=.FALSE.,SPECIFIED_NORMAL_VELOCITY=.FALSE.,SPECIFIED_TANGENTIAL_VELOCITY=.FALSE.
   INTEGER :: GEOMETRY,BACKING,PROFILE
   CHARACTER(30) :: PART_ID,RAMP_Q,RAMP_V,RAMP_T,RAMP_EF,RAMP_PART
   CHARACTER(30), DIMENSION(0:MAX_SPECIES) :: RAMP_MF
   CHARACTER(60) :: ID,TEXTURE_MAP
   CHARACTER(100) :: FYI='null'

   ! Boundary vegetation
   LOGICAL  :: VEGETATION=.FALSE.,VEG_NO_BURN=.FALSE.,VEG_GROUND_ZERO_RAD=.TRUE., &
               VEG_LINEAR_DEGRAD,VEG_ARRHENIUS_DEGRAD
   INTEGER  :: NVEG_L
   REAL(EB) :: VEG_CHARFRAC,VEG_DRAG_INI,VEG_ELEMENT_DENSITY,VEG_HEIGHT,VEG_INITIAL_TEMP,VEG_LOAD, &
               VEG_MOISTURE,VEG_SVRATIO,VEG_PACKING,VEG_KAPPA,FIRELINE_MLR_MAX,VEG_GROUND_TEMP
   REAL(EB), POINTER, DIMENSION(:) :: VEG_FUEL_FLUX_L=>NULL(),VEG_MOIST_FLUX_L=>NULL(),VEG_DIVQNET_L=>NULL()
   REAL(EB), POINTER, DIMENSION(:) :: VEG_INCM_RADFCT_L=>NULL(),VEG_FINCM_RADFCT_L=>NULL(),VEG_FINCP_RADFCT_L=>NULL()
   !add index for mult veg
   REAL(EB), POINTER, DIMENSION(:,:) :: VEG_SEMISSM_RADFCT_L=>NULL(),VEG_SEMISSP_RADFCT_L=>NULL() !add index for mult veg

   ! Level Set Firespread
   LOGICAL :: VEG_LSET_SPREAD
   REAL(EB) :: VEG_LSET_IGNITE_T,VEG_LSET_ROS_HEAD,VEG_LSET_ROS_FLANK,VEG_LSET_ROS_BACK,VEG_LSET_WIND_EXP

   ! Unstructured geometry
   CHARACTER(60) :: BC_FILENAME='null'

END TYPE SURFACE_TYPE

TYPE (SURFACE_TYPE), DIMENSION(:), ALLOCATABLE, TARGET :: SURFACE

TYPE WALL_ILW_TYPE
   REAL(EB), POINTER, DIMENSION(:,:) :: ILW=>NULL()
END TYPE WALL_ILW_TYPE

TYPE OMESH_TYPE
   REAL(EB), POINTER, DIMENSION(:,:,:) :: MU=>NULL(),RHO=>NULL(),RHOS=>NULL(),U=>NULL(),V=>NULL(),W=>NULL(),&
                                          US=>NULL(),VS=>NULL(),WS=>NULL(),H=>NULL(),HS=>NULL(),&
                                          FVX=>NULL(),FVY=>NULL(),FVZ=>NULL(),D=>NULL(),DS=>NULL(),KRES=>NULL()
   REAL(EB), POINTER, DIMENSION(:,:,:,:) :: ZZ=>NULL(),ZZS=>NULL()
   INTEGER, POINTER, DIMENSION(:,:) :: IJKW=>NULL()
   INTEGER, POINTER, DIMENSION(:) :: BOUNDARY_TYPE=>NULL()
   INTEGER, ALLOCATABLE, DIMENSION(:) :: N_PART_ORPHANS,N_PART_ADOPT
   TYPE(WALL_ILW_TYPE), POINTER, DIMENSION(:) :: WALL_ILW=>NULL()
   INTEGER :: I_MIN_R=-10,I_MAX_R=-10,J_MIN_R=-10,J_MAX_R=-10,K_MIN_R=-10,K_MAX_R=-10,NIC_R=0, &
              I_MIN_S=-10,I_MAX_S=-10,J_MIN_S=-10,J_MAX_S=-10,K_MIN_S=-10,K_MAX_S=-10,NIC_S=0  
   REAL(EB), POINTER, DIMENSION(:) :: &
         REAL_SEND_PKG1=>NULL(),REAL_SEND_PKG2=>NULL(),REAL_SEND_PKG3=>NULL(),REAL_SEND_PKG4=>NULL(),REAL_SEND_PKG5=>NULL(),&
         REAL_SEND_PKG7=>NULL(),&
         REAL_RECV_PKG1=>NULL(),REAL_RECV_PKG2=>NULL(),REAL_RECV_PKG3=>NULL(),REAL_RECV_PKG4=>NULL(),REAL_RECV_PKG5=>NULL(),&
         REAL_RECV_PKG7=>NULL()
   TYPE (STORAGE_TYPE), ALLOCATABLE, DIMENSION(:) :: ORPHAN_PARTICLE_STORAGE,ADOPT_PARTICLE_STORAGE
END TYPE OMESH_TYPE
 
TYPE OBSTRUCTION_TYPE
   CHARACTER(30) :: DEVC_ID='null',CTRL_ID='null',PROP_ID='null'
   INTEGER, DIMENSION(-3:3) :: SURF_INDEX=0
   LOGICAL, DIMENSION(-3:3) :: SHOW_BNDF=.TRUE.
   INTEGER, DIMENSION(3) :: RGB=(/0,0,0/)
   INTEGER, DIMENSION(3) :: DIMENSIONS=0
   REAL(EB) :: TRANSPARENCY=1._EB,BULK_DENSITY=-1._EB,VOLUME_ADJUST=1._EB
   REAL(EB), DIMENSION(3) :: TEXTURE=0._EB
   REAL(EB) :: X1=0._EB,X2=1._EB,Y1=0._EB,Y2=1._EB,Z1=0._EB,Z2=1._EB,MASS=1.E6_EB
   REAL(EB), DIMENSION(3) :: FDS_AREA=-1._EB,INPUT_AREA=-1._EB
   INTEGER :: I1=-1,I2=-1,J1=-1,J2=-1,K1=-1,K2=-1,COLOR_INDICATOR=-1,TYPE_INDICATOR=-1,ORDINAL=0
   INTEGER :: DEVC_INDEX=-1,CTRL_INDEX=-1,PROP_INDEX=-1
   LOGICAL :: SAWTOOTH=.TRUE.,HIDDEN=.FALSE.,PERMIT_HOLE=.TRUE.,ALLOW_VENT=.TRUE.,CONSUMABLE=.FALSE.,REMOVABLE=.FALSE., &
              THIN=.FALSE.,HOLE_FILLER=.FALSE.,NOTERRAIN=.FALSE.
END TYPE OBSTRUCTION_TYPE

TYPE GEOMETRY_TYPE
   CHARACTER(30) :: ID='geom',SMVOBJECT='sensor',TFILE='null'
   CHARACTER(30) :: SHAPE='SPHERE',SURF_ID='null'
   REAL(EB) :: X1=0._EB,X2=0._EB,Y1=0._EB,Y2=0._EB,Z1=0._EB,Z2=0._EB
   REAL(EB) :: X0=0._EB,Y0=0._EB,Z0=0._EB,X=0._EB,Y=0._EB,Z=0._EB,XOR=0._EB,YOR=0._EB,ZOR=0._EB
   REAL(EB) :: RADIUS=1.E6_EB
   REAL(EB) :: U0=0._EB,V0=0._EB,W0=0._EB,U=0._EB,V=0._EB,W=0._EB
   REAL(EB) :: OMEGA=0._EB ! rotation rate (rad/s) about orientation axis
   REAL(EB) :: OMEGA_X=0._EB,OMEGA_Y=0._EB,OMEGA_Z=0._EB ! rotation rate about grid basis vectors
   LOGICAL :: TRANSLATE=.FALSE.,ROTATE=.FALSE.,HOLE=.FALSE.,TWO_SIDED=.FALSE.
   INTEGER :: ISHAPE
   INTEGER, POINTER, DIMENSION(:) :: MIN_I=>NULL(),MAX_I=>NULL(),MIN_J=>NULL(),MAX_J=>NULL(),MIN_K=>NULL(),MAX_K=>NULL()
   INTEGER, DIMENSION(3) :: RGB=(/192,192,192/)
   REAL(EB), DIMENSION(3) :: NN=(/0._EB,0._EB,0._EB/),HL=(/0.5_EB,0.5_EB,0.5_EB/)
   REAL(EB) :: PIXELS=1.0
   REAL(EB) :: ROUGHNESS
END TYPE GEOMETRY_TYPE

TYPE(GEOMETRY_TYPE), POINTER, DIMENSION(:) :: GEOMETRY

TYPE VERTEX_TYPE
   REAL(EB) :: X,Y,Z
END TYPE VERTEX_TYPE

TYPE(VERTEX_TYPE), POINTER, DIMENSION(:) :: VERTEX

! http://www.sdsc.edu/~tkaiser/f90.html#Linked lists 
TYPE LINKED_LIST_TYPE
   INTEGER :: INDEX                           ! data
   TYPE(LINKED_LIST_TYPE), POINTER :: NEXT    ! pointer to the next element
END TYPE LINKED_LIST_TYPE

TYPE CUTCELL_LINKED_LIST_TYPE
   INTEGER :: INDEX                           ! data
   TYPE(CUTCELL_LINKED_LIST_TYPE), POINTER :: NEXT    ! pointer to the next element
   REAL(EB) :: AREA                           ! cutcell area for index
END TYPE CUTCELL_LINKED_LIST_TYPE

TYPE FACET_TYPE
   INTEGER :: VERTEX(3)=0,SURF_INDEX=0
   CHARACTER(30) :: SURF_ID='null'
   REAL(EB) :: NVEC(3)=0._EB,TMP_F=300._EB,TMP_G=300._EB,AREA=0._EB
   TYPE(CUTCELL_LINKED_LIST_TYPE), POINTER :: CUTCELL_LIST
   TYPE(SURFACE_TYPE), POINTER :: SURFACE_QUANTITY
END TYPE FACET_TYPE

TYPE(FACET_TYPE), POINTER, DIMENSION(:) :: FACET

TYPE VOLUME_TYPE
   INTEGER :: VERTEX(4)=0
   CHARACTER(30) :: MATL_ID='null'
END TYPE VOLUME_TYPE

TYPE(VOLUME_TYPE), POINTER, DIMENSION(:) :: VOLUME

TYPE CSVF_TYPE
    CHARACTER(256) :: CSVFILE,UVWFILE
END TYPE CSVF_TYPE

TYPE(CSVF_TYPE), POINTER, DIMENSION(:) :: CSVFINFO
 
TYPE VENTS_TYPE
   INTEGER :: I1=-1,I2=-1,J1=-1,J2=-1,K1=-1,K2=-1,BOUNDARY_TYPE=0,IOR=0,SURF_INDEX=0,DEVC_INDEX=-1,CTRL_INDEX=-1, &
              COLOR_INDICATOR=99,TYPE_INDICATOR=0,ORDINAL=0,PRESSURE_RAMP_INDEX=0,NODE_INDEX=-1
   INTEGER, DIMENSION(3) :: RGB=-1
   REAL(EB) :: TRANSPARENCY = 1._EB
   REAL(EB), DIMENSION(3) :: TEXTURE=0._EB
   REAL(EB) :: X1=0._EB,X2=0._EB,Y1=0._EB,Y2=0._EB,Z1=0._EB,Z2=0._EB,FDS_AREA=0._EB,TOTAL_INPUT_AREA=0._EB, &
               X0=-9.E6_EB,Y0=-9.E6_EB,Z0=-9.E6_EB,FIRE_SPREAD_RATE=0.05_EB,INPUT_AREA=0._EB,TMP_EXTERIOR=-1000._EB, &
               DYNAMIC_PRESSURE=0._EB,UVW(3)=-1.E12_EB
   LOGICAL :: ACTIVATED=.TRUE.,GHOST_CELLS_ONLY=.FALSE.
   CHARACTER(30) :: DEVC_ID='null',CTRL_ID='null',ID='null'
   ! turbulent inflow (experimental)
   INTEGER :: N_EDDY=0
   REAL(EB) :: R_IJ(3,3)=0._EB,A_IJ(3,3),SIGMA_IJ(3,3),EDDY_BOX_VOLUME=0._EB, &
               X_EDDY_MIN=0._EB,X_EDDY_MAX=0._EB, &
               Y_EDDY_MIN=0._EB,Y_EDDY_MAX=0._EB, &
               Z_EDDY_MIN=0._EB,Z_EDDY_MAX=0._EB
   REAL(EB), POINTER, DIMENSION(:,:) :: U_EDDY,V_EDDY,W_EDDY
   REAL(EB), POINTER, DIMENSION(:) :: X_EDDY,Y_EDDY,Z_EDDY,CU_EDDY,CV_EDDY,CW_EDDY
END TYPE VENTS_TYPE
 
TYPE TABLES_TYPE
   INTEGER :: NUMBER_ROWS,NUMBER_COLUMNS
   REAL(EB), POINTER, DIMENSION (:,:) :: TABLE_DATA=>NULL()
END TYPE TABLES_TYPE

TYPE (TABLES_TYPE), DIMENSION(:), ALLOCATABLE, TARGET :: TABLES
   
TYPE RAMPS_TYPE
   REAL(EB) :: SPAN,DT,T_MIN,T_MAX
   REAL(EB), POINTER, DIMENSION(:) :: INDEPENDENT_DATA=>NULL(),DEPENDENT_DATA=>NULL(),INTERPOLATED_DATA=>NULL()
   INTEGER :: NUMBER_DATA_POINTS,NUMBER_INTERPOLATION_POINTS,DEVC_INDEX=-1,CTRL_INDEX=-1
   CHARACTER(30) :: DEVC_ID='null',CTRL_ID='null'
END TYPE RAMPS_TYPE

TYPE (RAMPS_TYPE), DIMENSION(:), ALLOCATABLE, TARGET :: RAMPS

TYPE HUMAN_TYPE
   CHARACTER(60) :: NODE_NAME='null'
   CHARACTER(30) :: FFIELD_NAME='null'
   REAL(EB) :: X=0._EB,Y=0._EB,Z=0._EB,U=0._EB,V=0._EB,W=0._EB,F_X=0._EB,F_Y=0._EB,&
               X_old=0._EB,Y_old=0._EB,X_group=0._EB,Y_group=0._EB
   REAL(EB) :: UBAR=0._EB, VBAR=0._EB, UBAR_Center=0._EB, VBAR_Center=0._EB
   REAL(EB) :: Speed=1.25_EB, Radius=0.255_EB, Mass=80.0_EB, Tpre=1._EB, Tau=1._EB, &
               Eta=0._EB, Ksi=0._EB, Tdet=0._EB, Speed_ave=0._EB, T_Speed_ave=0._EB
   REAL(EB) :: r_torso=0.15_EB, r_shoulder=0.095_EB, d_shoulder=0.055_EB, angle=0._EB, &
               torque=0._EB, m_iner=4._EB
   REAL(EB) :: tau_iner=0.2_EB, angle_old=0._EB, omega=0._EB
   REAL(EB) :: A=2000._EB, B=0.08_EB, C_Young=120000._EB, Gamma=16000._EB, Kappa=40000._EB, &
               Lambda=0.5_EB, Commitment=0._EB
   REAL(EB) :: SumForces=0._EB, IntDose=0._EB, DoseCrit1=0._EB, DoseCrit2=0._EB, SumForces2=0._EB
   REAL(EB) :: TempMax1=0._EB, FluxMax1=0._EB, TempMax2=0._EB, FluxMax2=0._EB, Density=0._EB, DensityR=0._EB, DensityL=0._EB
   REAL(EB) :: P_detect_tot=0._EB, v0_fac=1._EB, D_Walls=0._EB
   REAL(EB) :: T_FallenDown=0._EB, F_FallDown=0._EB, Angle_FallenDown=0._EB, SizeFac_FallenDown=0._EB, T_CheckFallDown=0._EB
   INTEGER  :: IOR=-1, ILABEL=0, COLOR_INDEX=0, INODE=0, IMESH=-1, IPC=0, IEL=0, I_FFIELD=0, I_Target2=0
   INTEGER  :: GROUP_ID=0, DETECT1=0, GROUP_SIZE=0, I_Target=0, I_DoorAlgo=0, I_Door_Mode=0, STRS_Direction = 1
   INTEGER  :: STR_SUB_INDX, SKIP_WALL_FORCE_IOR
   LOGICAL  :: SHOW=.TRUE., NewRnd=.TRUE.
   LOGICAL  :: SeeDoorXB1=.FALSE., SeeDoorXB2=.FALSE., SeeDoorXYZ1=.FALSE., SeeDoorXYZ2=.FALSE.
END TYPE HUMAN_TYPE

TYPE HUMAN_GRID_TYPE
! (x,y,z) Centers of the grid cells in the main evacuation meshes
! SOOT_DENS: Smoke density at the center of the cell (mg/m3)
! FED_CO_CO2_O2: Purser's FED for co, co2, and o2
   REAL(EB) :: X,Y,Z,SOOT_DENS,FED_CO_CO2_O2,TMP_G,RADFLUX
   INTEGER :: N, N_old, IGRID, IHUMAN, ILABEL
! IMESH: (x,y,z) which fire mesh, if any
! II,JJ,KK: Fire mesh cell reference
   INTEGER  :: IMESH,II,JJ,KK
END TYPE HUMAN_GRID_TYPE
 
TYPE SLICE_TYPE
   INTEGER :: I1,I2,J1,J2,K1,K2,INDEX,INDEX2=0,Z_INDEX=-999,Y_INDEX=-999,PART_INDEX=0,VELO_INDEX=0
   REAL(FB), DIMENSION(2) :: MINMAX
   REAL(EB):: SLICE_AGL
   LOGICAL :: TERRAIN_SLICE=.FALSE.,CELL_CENTERED=.FALSE., FIRE_LINE=.FALSE.,LEVEL_SET_FIRE_LINE=.FALSE.
   CHARACTER(60) :: SMOKEVIEW_LABEL
   CHARACTER(30) :: SMOKEVIEW_BAR_LABEL,ID='null'
END TYPE SLICE_TYPE

TYPE BOUNDARY_FILE_TYPE
   INTEGER :: INDEX,PROP_INDEX,Z_INDEX=-999,Y_INDEX=-999,PART_INDEX=0
   CHARACTER(60) :: SMOKEVIEW_LABEL
   CHARACTER(30) :: SMOKEVIEW_BAR_LABEL
   LOGICAL :: CELL_CENTERED=.FALSE.
END TYPE BOUNDARY_FILE_TYPE

TYPE (BOUNDARY_FILE_TYPE), DIMENSION(:), ALLOCATABLE, TARGET :: BOUNDARY_FILE

TYPE BOUNDARY_ELEMENT_FILE_TYPE
   INTEGER :: INDEX,PROP_INDEX,Z_INDEX=-999,Y_INDEX=-999,PART_INDEX=0
   CHARACTER(60) :: SMOKEVIEW_LABEL
   CHARACTER(30) :: SMOKEVIEW_BAR_LABEL
   LOGICAL :: CELL_CENTERED=.TRUE.
END TYPE BOUNDARY_ELEMENT_FILE_TYPE

TYPE (BOUNDARY_ELEMENT_FILE_TYPE), DIMENSION(:), ALLOCATABLE, TARGET :: BOUNDARY_ELEMENT_FILE

TYPE ISOSURFACE_FILE_TYPE
   INTEGER :: INDEX=1,REDUCE_TRIANGLES=1,N_VALUES=1,Y_INDEX=-999,Z_INDEX=-999,VELO_INDEX=0
   REAL(FB) :: VALUE(10)
   CHARACTER(60) :: SMOKEVIEW_LABEL
   CHARACTER(30) :: SMOKEVIEW_BAR_LABEL
END TYPE ISOSURFACE_FILE_TYPE

TYPE (ISOSURFACE_FILE_TYPE), DIMENSION(:), ALLOCATABLE, TARGET :: ISOSURFACE_FILE

TYPE PROFILE_TYPE
   REAL(EB) :: X,Y,Z
   INTEGER  :: IOR,IW,ORDINAL,MESH
   CHARACTER(30) :: ID,QUANTITY
END TYPE PROFILE_TYPE

TYPE (PROFILE_TYPE), DIMENSION(:), ALLOCATABLE, TARGET :: PROFILE

TYPE INITIALIZATION_TYPE
   REAL(EB) :: TEMPERATURE,DENSITY,MASS_FRACTION(MAX_SPECIES)=0._EB,X1,X2,Y1,Y2,Z1,Z2,MASS_PER_VOLUME,MASS_PER_TIME,DT_INSERT, &
               X0,Y0,Z0,U0,V0,W0,VOLUME,HRRPUV=0._EB
   REAL(EB), POINTER, DIMENSION(:) :: PARTICLE_INSERT_CLOCK=>NULL()
   INTEGER  :: PART_INDEX=0,NUMBER_INITIAL_PARTICLES,LU_PARTICLE,PROF_INDEX=0,DEVC_INDEX=0,CTRL_INDEX=0,TABL_INDEX=0
   LOGICAL :: ADJUST_DENSITY=.FALSE.,ADJUST_TEMPERATURE=.FALSE.,&
              SINGLE_INSERTION=.TRUE.,ALREADY_INSERTED=.FALSE.,UNIFORM=.FALSE.
   CHARACTER(30) :: SHAPE,PROF_ID,DEVC_ID,CTRL_ID,ID
END TYPE INITIALIZATION_TYPE

TYPE (INITIALIZATION_TYPE), DIMENSION(:), ALLOCATABLE, TARGET :: INITIALIZATION

TYPE P_ZONE_TYPE
   REAL(EB) :: X1,X2,Y1,Y2,Z1,Z2,DPSTAR=0._EB
   REAL(EB), POINTER, DIMENSION(:) :: LEAK_AREA=>NULL()
   INTEGER :: N_DUCTNODES
   INTEGER, POINTER, DIMENSION(:) :: NODE_INDEX=>NULL()
   CHARACTER(30) :: ID
END TYPE P_ZONE_TYPE

TYPE (P_ZONE_TYPE), DIMENSION(:), ALLOCATABLE, TARGET :: P_ZONE

TYPE MULTIPLIER_TYPE
   REAL(EB) :: DXB(6),DX0,DY0,DZ0
   INTEGER  :: I_LOWER,I_UPPER,J_LOWER,J_UPPER,K_LOWER,K_UPPER,N_LOWER,N_UPPER,N_COPIES
   CHARACTER(30) :: ID
   LOGICAL :: SEQUENTIAL=.FALSE.
END TYPE MULTIPLIER_TYPE

TYPE (MULTIPLIER_TYPE), DIMENSION(:), ALLOCATABLE, TARGET :: MULTIPLIER

TYPE FILTER_TYPE
   INTEGER :: RAMP_INDEX = -1
   CHARACTER(30) :: ID,TABLE_ID
   REAL(EB), DIMENSION(:), POINTER :: EFFICIENCY=>NULL(),MULTIPLIER=>NULL()
   REAL(EB) :: CLEAN_LOSS,LOADING_LOSS
END TYPE FILTER_TYPE

TYPE (FILTER_TYPE), DIMENSION(:), ALLOCATABLE,  TARGET :: FILTER

TYPE DUCTNODE_TYPE
   INTEGER :: FILTER_INDEX=-1, N_DUCTS,VENT_INDEX = -1, MESH_INDEX = -1,ZONE_INDEX=-1
   INTEGER, DIMENSION(:), POINTER :: DUCT_INDEX=>NULL()
   CHARACTER(30) :: ID,TABLE_ID,VENT_ID='null'
   REAL(EB), DIMENSION(:,:), POINTER :: LOSS_ARRAY=>NULL(), FILTER_LOADING=>NULL()
   REAL(EB), DIMENSION(:), POINTER :: ZZ=>NULL(), DIR=>NULL(), ZZ_V=>NULL()
   REAL(EB) :: LOSS, P,TMP,RHO,RSUM,CP,XYZ(3),FILTER_LOSS,TMP_V,RHO_V,RSUM_V,CP_V
   LOGICAL :: UPDATED, FIXED, AMBIENT = .FALSE.,LEAKAGE=.FALSE.
END TYPE DUCTNODE_TYPE

TYPE (DUCTNODE_TYPE), DIMENSION(:), ALLOCATABLE,  TARGET :: DUCTNODE

TYPE NODE_BC_TYPE
   REAL(EB), DIMENSION(:), POINTER :: ZZ_V
   REAL(EB) :: TMP_V,RHO_V,RSUM_V,CP_V, P
END TYPE NODE_BC_TYPE

TYPE DUCT_TYPE
   INTEGER :: NODE_INDEX(2)=-1,DEVC_INDEX=-1,CTRL_INDEX=-1,FAN_INDEX=-1,AIRCOIL_INDEX=-1,RAMP_INDEX=0
   REAL(EB) :: ROUGHNESS,LENGTH, DIAMETER, AREA_INITIAL, AREA, CP_D, RHO_D,TMP_D,LOSS(2)=0._EB,VEL(4)=0._EB,RSUM_D=0._EB,&
               DP_FAN=0._EB,TOTAL_LOSS = 0._EB,COIL_Q=0._EB,VOLUME_FLOW=1.E6_EB,VOLUME_FLOW_INITIAL=1.E6_EB,&
               X(2),Y(2),Z(2),TAU=-1._EB
   REAL(EB), DIMENSION(:), POINTER :: ZZ=>NULL()
   LOGICAL :: ROUND = .TRUE.,SQUARE = .FALSE.,DAMPER = .FALSE.,DAMPER_OPEN = .TRUE.,FAN_OPERATING=.TRUE.,COIL_OPERATING=.TRUE.,&
              FIXED=.FALSE.,REVERSE=.FALSE.,UPDATED,LEAKAGE=.FALSE.
   CHARACTER(30) :: ID,RAMP_ID
   REAL(EB) :: FAN_ON_TIME = 1.E10_EB
END TYPE DUCT_TYPE

TYPE (DUCT_TYPE), DIMENSION(:), ALLOCATABLE,  TARGET :: DUCT

TYPE FAN_TYPE
   INTEGER :: FAN_TYPE,RAMP_INDEX,SPIN_INDEX=0
   REAL(EB) :: VOL_FLOW,MAX_FLOW,MAX_PRES,OFF_LOSS=0._EB,TAU
   CHARACTER(30) :: ID,FAN_RAMP
END TYPE FAN_TYPE

TYPE(FAN_TYPE), DIMENSION(:), ALLOCATABLE, TARGET :: FAN

TYPE AIRCOIL_TYPE
   REAL(EB) :: COOLANT_TEMPERATURE=293.15_EB,COOLANT_CP=4186._EB, EFFICIENCY, COOLANT_MDOT=-9999._EB,FIXED_Q=-1.E10_EB
   CHARACTER(30) :: ID
END TYPE AIRCOIL_TYPE

TYPE(AIRCOIL_TYPE), DIMENSION(:), ALLOCATABLE, TARGET :: AIRCOIL

TYPE NETWORK_TYPE
   INTEGER :: N_DUCTS,N_DUCTNODES,N_MATRIX
   INTEGER, DIMENSION(:), POINTER :: DUCT_INDEX=>NULL(),NODE_INDEX=>NULL(),MATRIX_INDEX=>NULL()
END TYPE NETWORK_TYPE

TYPE(NETWORK_TYPE), DIMENSION(:), ALLOCATABLE, TARGET :: NETWORK


CONTAINS


SUBROUTINE GET_REV_type(MODULE_REV,MODULE_DATE)
INTEGER,INTENT(INOUT) :: MODULE_REV
CHARACTER(255),INTENT(INOUT) :: MODULE_DATE

WRITE(MODULE_DATE,'(A)') typerev(INDEX(typerev,':')+2:LEN_TRIM(typerev)-2)
READ (MODULE_DATE,'(I5)') MODULE_REV
WRITE(MODULE_DATE,'(A)') typedate

END SUBROUTINE GET_REV_type

END MODULE TYPES
 

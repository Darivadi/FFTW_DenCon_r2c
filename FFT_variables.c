/*********************************************************************
Index conventions:
i = x axis
j = y axis
k = z axis
l = particle
m = grid cell  
*********************************************************************/


/********************************************************************
                                   UNITS

Frame's time = 1
Redshift = 0
Flagsfr = 0
Flagsfed = 0
Flagcool = 0
numfiles = 1
Box Size = 1
Matter density parameter \Omega_{m,0} = 0.258
Dark energy density parameter \Omega_{\Lambda,0} = 0.742
Hubble's parameter h = 0.72
Hubble's constant H_0 = 100/h
Particle's mass = 3.41454 (* 10^{10} M_{Sun}/h)
Total number of particles = 134217728 (512^3)
Mass unit = 1 * 10^{10} M_{Sun}/h
Lenght unit = 1 Mpc/h
Gravitational constant in the interal units G = 43.0071
 *******************************************************************/


/*****************************************************************
                            STRUCTURES
******************************************************************/

struct grid
{
  double pos[3];     //Cell position
  int gridParts;     //Number of particles in the cell
  int GID;           // Gid; Cell ID (m)

  
  /*+++ Mass density in r-space and k-space and wave vectors +++*/
  double DenConCell;        // Density contrast in each cell in r-space (Used for CIC)
  double DenCon_FFTout[2];  /* Density contrast as output from FFTW. [0] is real, 
			       [1] imaginary */
  double DenCon_K[2];       /* Density contrast deconvolved with weight function. 
			       [0] is real, [1] imaginary */
  double DenCon_K_2;

  double k_vector[3];       // Wave vector components in c-order
  double k_module;          // Wave vector module in c-order
  double weight_NGP;        // Weight function of NPG
  double weight_CIC;        // Weight function of CIC
  
  /*+++ Velocities and momentum density +++*/
#ifdef NGP
  double v_cm[3];     /* Center of mass' velocity of each cell.                                                 
                         [0] is X, [1] is Y, [2] is Z */
#endif

  double p_r[3];      /* momentum_den_cm_r;Momentum density (from v_cm)                                         
                         in r-space with grid[m] order.  [0] is X, [1]                                          
                         is Y, [2] is Z */
  double p_k[3][2];   /* momentum_den_cm_k; Momentum density (from v_cm)                                        
                         in k-space with FFT[p] order.  [0][i] is X,                                            
                         [1][i] is Y, [2][i] is Z.  [i][0] is Re(),                                             
                         [i][1]  is Im() */

  /*+++ Potential and its time derivative +++*/
  double poten_k[2];      /* Potential in k-space (Fourier space). 
			     [0] is real, [1] imaginary */
  double poten_r;      /* potential in real space.  [0] is real, 
			     [1] imaginary */
  double potDot_r;     /* Potential's time derivative in r-space,                                            
                             grid[m]-order. [0] is Re(), [1] is Im() */
  double potDot_k[2];     /* pot_dot_k; Potential's time derivative in                                          
                             k-space, FFTW[p] order.  [0] is Re(), [1]                                          
                             is Im() */

  /*+++ Linear approximation for the time derivative of the potential +++*/
  double potDot_r_l_app1; /* Time derivative of gravitational potential 
				in r-space with linear approximation. [0] 
				is Re(), [1] is Im() */
  double potDot_k_l_app1[2]; /*Time derivative of gravitational potentia in 
			       k-space with linear approximation. [0] is 
			       Re(), [1] is Im() */

  double potDot_r_l_app2; /* Time derivative of gravitational potentia in 
				r-space with linear approximation. [0] is 
				Re(), [1] is Im() */
  double potDot_k_l_app2[2]; /* Time derivative of gravitational potentia in 
				k-space with linear approximation. [0] is 
				Re(), [1] is Im() */

}*gp; //grid


struct GlobalVariables
{
  char FILENAME[1000]; //Path of the data file
  
  /*+++ Grid constants +++*/
  int Total_NParts; // Total number of particles
  double BoxSize;      // Size of the simulation box in one axis (all must be the same)
  int NCELLS;       // Number of cells in one axis
  int NTOTALCELLS;  // Total number of cell
  double NORM;      //Normalization for the Fourier transforms
  int CNMESH;       // Half of the NCELLS variable
  int PADDING;      //Padding for in-place transforms
  int NTOTK;        // Total number of cells in Fourier space for r2c Fourier transform
  double CellSize;  // Size of the cell
  double ZERO;      // Zero for the computer
 
  /*+++ Cosmological Parameters +++*/
  double H0;      //= 100.0 Hubble's constant in the inner units
  double z_RS;    // = 0.0 Redshift of the simulation
  double a_SF;    // Scale factor's time derivative
  double Hz;      //Hubble's parameter a_dot/a
  double Omega_M0; //= 0.258 Density parameter of matter
  double Omega_L0; //= 0.742 Density parameter of cosmological constant
  double MeanDen; // MeanDens;= 7.160809 Units *1E10 M_Sun/h

  /*+++++ Power Spectrum +++++*/
  size_t *SortedID;
  double DeltaK; //Delta k 
  double *BinsPS;
  double *BinsK;
  int *BinsCount;
  double kF;
  double kN;
  double shotNoise;


}GV;//globalVariables


/***************************************************************
                       DEFINITIONS
 ***************************************************************/
#define X 0
#define Y 1
#define Z 2
#define INDEX_GRID(i,j,k) (k)+GV.NCELLS*((j)+GV.NCELLS*(i)) //Index in C-order in position-space
#define INDEX_K(i,j,k) (k) + (GV.CNMESH+1)*((j)+GV.NCELLS*(i)) //Index in C-order in Fourier space after r2c
#define KVALUE(n) ((n) <= GV.CNMESH ? (n) : ((n)-GV.NCELLS) )//Values of index for wave vector

/*+++++ Power Spectrum +++++*/
#define COMPLEXMAG(A,i) ( (A[i][0] * A[i][0]) + (A[i][1] * A[i][1]) )
#define VECTORMAG(x,y,z) sqrt( (x * x) + (y * y) + (z * z) )
#define C1(k) 1.0 - 0.666666666667*sin(k*GV.CellSize*0.5)*sin(k*GV.CellSize*0.5)

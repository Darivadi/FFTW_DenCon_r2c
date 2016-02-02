/****************************************************************************************************
NAME: growth_rate_OmegaL0
FUNCTION: Computes the growth rate f(t) for first linear approx. proportional to Omega_Lambda0
INPUT: Scale factor
RETURN: Growth rate f(t) for first approx. proportional to Omega_Lambda0
****************************************************************************************************/

double growth_rate_OmegaL0(double a_SF)
{ 
  double GR_OmegaL0, a_cube;  
  a_cube = pow(a_SF, 3.0);
  GR_OmegaL0 = 1.0/( pow( (1.0+GV.Omega_L0*a_cube), 0.6) );

  printf("-----------------------------------------------------------------\n");
  printf("First approximation to f(t)\n");
  printf("OmegaL0=%lf,  growth rate f(t)=%lf\n", 
	 GV.Omega_L0, GR_OmegaL0);
  printf("-----------------------------------------------------------------\n");

  return GR_OmegaL0;
  
}//growth_rate_app1


/****************************************************************************************************
NAME: growth_rate_OmegaM
FUNCTION: Computes the growth rate f(t) for second linear approx. proportional to Omega_M(a)
INPUT: Scale factor
RETURN: Growth rate f(t) for second linear approx. proportional to Omega_M(a)
****************************************************************************************************/

double growth_rate_OmegaM(double a_SF)
{ 
  double OmegaM_ofa, mu, GR_OmegaM, z;
  
  mu = a_SF * pow((GV.Omega_L0/GV.Omega_M0), 1.0/3.0);
  OmegaM_ofa = GV.Omega_M0 / ( (double) (1 + pow(mu, 3.0)) ); 
  GR_OmegaM = pow(OmegaM_ofa, 0.6);

  
  printf("-----------------------------------------------------------------\n");
  printf("Second approximation to f(t)\n");
  printf("mu=%lf, OmegaM(a)=%lf, growth rate f(t)=%lf\n", 
	 mu, OmegaM_ofa, GR_OmegaM);
  printf("-----------------------------------------------------------------\n");
  
  return GR_OmegaM;
}//growth_rate_app2


/****************************************************************************************************
NAME: potential_dot_linear                                                                                      
FUNCTION: Calculates the time derivative of the gravitational potential the k-space, and then with 
an IFFT calculates the time derivative of potential in the position's space.  This is performed in 
the linear approximations computed before.
INPUT: None
RETURN: none
****************************************************************************************************/

/****** COMPUTING LINEAR POTDOT ******/
int potential_dot_linear(void)
{  
  int m;
  double norm, alpha, z, fn_app1, fn_app2, factor;
  FILE *pf=NULL;
   
  /*----- Computing the approximations to the linear growth rate f -----*/
  fn_app1 = 1.0 - ( growth_rate_OmegaL0(GV.a_SF) );
  fn_app2 = 1.0 - ( growth_rate_OmegaM(GV.a_SF) );  

  printf("GR_OmegaL0=%lf GR_OmegaM=%lf a_SF=%lf\n", 
	 growth_rate_OmegaL0(GV.a_SF), growth_rate_OmegaM(GV.a_SF), GV.a_SF);
  printf("---------------------------------------\n");
 

  /*----- Computing the time derivative of potential in k-space -----*/
  factor = (3.0/2.0) * GV.H0 * GV.H0 * (GV.Hz / GV.a_SF) * GV.Omega_M0;

  printf("Computing the linear approximations in Fourier space");
  printf("----------------------------------------------------");

  for( m=0; m<GV.NTOTK; m++ )
    {
      if( fabs(gp[m].k_module) > GV.ZERO )
	{
	  alpha = factor / (gp[m].k_module * gp[m].k_module);
	  	  
	  /*::::: Approximation proportional to 1/\Omega_{L0} :::::*/
	  gp[m].potDot_k_l_app1[0] = alpha * gp[m].DenCon_K[0] * fn_app1; //Re()
	  gp[m].potDot_k_l_app1[1] = alpha * gp[m].DenCon_K[1] * fn_app1; //Im()
	  
	  /*::::: Aproximation proportional to \Omega_M(a) :::::*/
	  gp[m].potDot_k_l_app2[0] = alpha * gp[m].DenCon_K[0] * fn_app2; //Re()
	  gp[m].potDot_k_l_app2[1] = alpha * gp[m].DenCon_K[1] * fn_app2; //Im()
	  
	}//if
      else
	{
	  gp[m].potDot_k_l_app1[0] = 0.0;
	  gp[m].potDot_k_l_app1[1] = 0.0;

	  gp[m].potDot_k_l_app2[0] = 0.0;
	  gp[m].potDot_k_l_app2[1] = 0.0;	  
	}//else
      
    }//for m
   
  printf("Time derivative of potential in k-space saved!\n");
  printf("--------------------------------------------------\n");



  /*+++++ OUT-OF-PLACE TRANSFORM +++++*/
#ifdef OUTOFPLACE
  /*+++++ FFTW DEFINITIONS +++++*/
  fftw_complex *in=NULL;
  fftw_complex *in2=NULL;
  double *out=NULL;
  fftw_plan plan_k2r; // FFTW from k-space to r-space
  fftw_plan plan_r2k; // FFTW from r-space to k-space


  /**************************************************************************************/
  /* Linear PotDot with the first approximation to the linear growth rate f */
  /**************************************************************************************/
  /*+++++ Creating input/output  arrays +++++*/
  in  = ( fftw_complex *) fftw_malloc( sizeof( fftw_complex ) * GV.NTOTK);
  out = ( double *) fftw_malloc( sizeof( double ) * GV.NTOTALCELLS );
  
  for( m=0; m<GV.NTOTK; m++ )
    {      
      in[m][0] = gp[m].potDot_k_l_app1[0]; //Re()
      in[m][1] = gp[m].potDot_k_l_app1[1]; //Im()
    }//for m
  
  
  /*+++++ Making the FFT +++++*/
  plan_k2r = fftw_plan_dft_c2r_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, in, out, FFTW_ESTIMATE );
  fftw_execute(plan_k2r);  
  printf("FFT of potential derivative in r finished!\n");
  printf("-----------------------------------------\n");
  
  
  /*+++++ Saving data +++++*/
  for( m=0; m<GV.NTOTALCELLS; m++ )
    {
      gp[m].potDot_r_l_app1 = out[m]/GV.NORM; //Re()
    }//for m
  
  
  /*+++++ Recreating input array +++++*/
  /*
    in2 = (fftw_complex *) malloc( sizeof( fftw_complex ) * GV.NTOTK );  
    plan_r2k = fftw_plan_dft_r2c_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, out, in2, FFTW_ESTIMATE );
    fftw_execute( plan_r2k );  
  */  
  
  
  fftw_free(in);
  //fftw_free(in2);
  fftw_free(out);
  
  
  /**************************************************************************************/
  /* Linear PotDot with the second approximation to the linear growth rate f */
  /**************************************************************************************/
  /*+++++ Creating input/output  arrays +++++*/
  in  = ( fftw_complex *) fftw_malloc( sizeof( fftw_complex ) * GV.NTOTK );
  out = ( double *) fftw_malloc( sizeof( double ) * GV.NTOTALCELLS );
  
  for( m=0; m<GV.NTOTK; m++ )
    {      
      in[m][0] = gp[m].potDot_k_l_app2[0];
      in[m][1] = gp[m].potDot_k_l_app2[1]; 
    }//for m
  
  
  /*+++++ Making the FFT +++++*/
  plan_k2r = fftw_plan_dft_c2r_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, in, out, FFTW_ESTIMATE );
  fftw_execute(plan_k2r);  
  printf("FFT of potential derivative in r finished!\n");
  printf("-----------------------------------------\n");
  
  
  /*+++++ Saving data +++++*/
  for( m=0; m<GV.NTOTALCELLS; m++ )
    {
      gp[m].potDot_r_l_app2 = out[m]/GV.NORM;
    }//for m
  
  
  /*+++++ Recreating input array +++++*/
  /*
    in2 = (double *) malloc( sizeof( double ) * GV.NTOTALCELLS );  
    plan_r2k = fftw_plan_dft_r2c_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, out, in2, FFTW_ESTIMATE );
    fftw_execute( plan_r2k );  
  */  
  
  fftw_free(in);
  //fftw_free(in2);
  fftw_free(out);
  
  /*+++++ Finishing +++++*/
  fftw_destroy_plan( plan_k2r );
  //fftw_destroy_plan( plan_r2k );
#endif


  /*+++++ IN-PLACE TRANSFORM +++++*/
#ifdef INPLACE
  /*+++++ FFTW DEFINITIONS +++++*/
  fftw_complex *in=NULL;
  fftw_plan plan_k2r; // FFTW from k-space to r-space
  fftw_plan plan_r2k; // FFTW from r-space to k-space


  /**************************************************************************************/
  /* Linear PotDot with the first approximation to the linear growth rate f */
  /**************************************************************************************/
  /*+++++ Creating input/output  arrays +++++*/
  in  = ( fftw_complex *) fftw_malloc( sizeof( fftw_complex ) * GV.NTOTK);
  
  for( m=0; m<GV.NTOTK; m++ )
    {      
      in[m][0] = gp[m].potDot_k_l_app1[0]; //Re()
      in[m][1] = gp[m].potDot_k_l_app1[1]; //Im()
    }//for m
  
  
  /*+++++ Making the FFT +++++*/
  plan_k2r = fftw_plan_dft_c2r_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, in, (double*)in, FFTW_ESTIMATE );
  fftw_execute(plan_k2r);  
  printf("FFT of potential derivative in r finished!\n");
  printf("-----------------------------------------\n");
  
  
  /*+++++ Saving data +++++*/
  for( m=0; m<GV.NTOTALCELLS/2; m++ )
    {
      gp[2*m].potDot_r_l_app1 = in[m][0]/GV.NORM; 
      gp[2*m+1].potDot_r_l_app1 = in[m][1]/GV.NORM; 
    }//for m
  
  
  /*+++++ Recreating input array +++++*/
  /*
    plan_r2k = fftw_plan_dft_r2c_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, (double*)in, in, FFTW_ESTIMATE );
    fftw_execute( plan_r2k );  
  */  
  
  fftw_free(in);  
  

  /**************************************************************************************/
  /* Linear PotDot with the second approximation to the linear growth rate f */
  /**************************************************************************************/
  /*+++++ Creating input/output  arrays +++++*/
  in  = ( fftw_complex *) fftw_malloc( sizeof( fftw_complex ) * GV.NTOTALCELLS );
  
  for( m=0; m<GV.NTOTK; m++ )
    {      
      in[m][0] = gp[m].potDot_k_l_app2[0];
      in[m][1] = gp[m].potDot_k_l_app2[1]; 
    }//for m
  
  
  /*+++++ Making the FFT +++++*/
  plan_k2r = fftw_plan_dft_c2r_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, in, (double*) in, FFTW_ESTIMATE );
  fftw_execute(plan_k2r);  
  printf("FFT of potential derivative in r finished!\n");
  printf("-----------------------------------------\n");
  
  
  /*+++++ Saving data +++++*/
  for( m=0; m<GV.NTOTALCELLS/2; m++ )
    {
      gp[2*m].potDot_r_l_app2 = in[m][0]/GV.NORM;
      gp[2*m+1].potDot_r_l_app2 = in[m][1]/GV.NORM;
    }//for m
  
  
  /*+++++ Recreating input array +++++*/
  /*
    plan_r2k = fftw_plan_dft_r2c_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, (double*)in, in, FFTW_ESTIMATE );
    fftw_execute( plan_r2k );  
  */  
  
  /*+++++ Finishing +++++*/
  fftw_free(in);  
  fftw_destroy_plan( plan_k2r );
  fftw_destroy_plan( plan_k2r );

#endif


  printf("FFT_pot_dot lineal code finished!\n");
  printf("--------------------------\n");

  return 0;  
}//potential_dot_linear

/*************************************************************************************
NAME: potential_dot
FUNCTION: Calculates the time derivative of the potential of the 
density contrast in the k-space (from the FFT)in the grid[m] order, 
and then with an IFFT calculates the time derivative of potential in 
the position's space
INPUT: density contrast in the k-space, wave vectors, momentum field 
in k-space.
RETURN: File with the input and outputs (sorted in the grid[m] order)
*************************************************************************************/
int potential_dot()
{
  int m, i, j, k;
  double norm, alpha, pot_Re1, pot_Re2, pot_Im1, pot_Im2, factor;
  FILE *pf=NULL;


  printf("Computing time derivative of potential in k-space!\n");
  printf("-----------------------------------------------------------------\n");

  /*+++ Computing the time derivative of potential in k-space +++*/
  factor = (3.0/2.0) * (GV.H0*GV.H0) * GV.Omega_M0 / GV.a_SF;

  for( m=0; m<GV.NTOTK; m++ )
    {
      if( fabs(gp[m].k_module) > GV.ZERO ) 
	{
	  pot_Re1 = GV.Hz*gp[m].DenCon_K[0];
	  pot_Re2 = -1.0*( gp[m].k_vector[X]*gp[m].p_k[X][1] + gp[m].k_vector[Y]*gp[m].p_k[Y][1] + gp[m].k_vector[Z]*gp[m].p_k[Z][1] )/GV.a_SF;
	  
	  pot_Im1 = GV.Hz*gp[m].DenCon_K[1];
	  pot_Im2 = ( gp[m].k_vector[X]*gp[m].p_k[X][0] + gp[m].k_vector[Y]*gp[m].p_k[Y][0] + gp[m].k_vector[Z]*gp[m].p_k[Z][0] )/GV.a_SF;
	  
	  //--- Unifying ---
	  alpha = factor / (gp[m].k_module * gp[m].k_module);
	  gp[m].potDot_k[0] = alpha * ( pot_Re1 + pot_Re2 ); //Re()
	  gp[m].potDot_k[1] = alpha * ( pot_Im1 + pot_Im2 ); //Im()
	}//if
      else
	{
	  gp[m].potDot_k[0] = 0.0;
	  gp[m].potDot_k[1] = 0.0;
	}//else
      
      pot_Re1 = 0.0;
      pot_Re2 = 0.0;
      pot_Im1 = 0.0;
      pot_Im2 = 0.0;
      
    }//for m
  
  printf("Data time derivative of potential in k-space assigned!\n");
  printf("-----------------------------------------------------------------\n");

  
  /*+++++ OUT-OF-PLACE TRANSFORM +++++*/
#ifdef OUTOFPLACE
  /*+++ FFTW DEFINITIONS +++*/
  fftw_complex *in=NULL;
  double *out=NULL;
  fftw_plan plan_k2r; // FFTW from k-space to r-space
  fftw_complex *in2=NULL;
  fftw_plan plan_r2k; // FFTW from r-space to k-space
  
  
  /*+++ Creating input/output  arrays +++*/
  in  = (fftw_complex *) fftw_malloc( sizeof( fftw_complex ) * GV.NTOTK);
  out = (double *) fftw_malloc( sizeof( double ) * GV.NTOTALCELLS);

  pf = fopen("./../PotDot_k_out.dat", "w");
  fprintf(pf, "%s%3s %15s %15s\n", "#", "ID", "Re_PotDot", "Im_PotDot");
  for( m=0; m<GV.NTOTK; m++ )
    {
      in[m][0] = gp[m].potDot_k[0];
      in[m][1] = gp[m].potDot_k[1];
      fprintf(pf, 
	      "%10d %16.8lf %16.8lf\n",
	      m, gp[m].potDot_k[0], gp[m].potDot_k[1]);

    }//for m
  fclose(pf);
  
  /*+++ Making the FFT +++*/
  plan_k2r = fftw_plan_dft_c2r_3d(GV.NCELLS, GV.NCELLS, GV.NCELLS, in, out, FFTW_ESTIMATE);
  fftw_execute(plan_k2r);
  
  printf("FFT of potential derivative in r finished!\n");
  printf("-----------------------------------------\n");
  
  
  /*+++ Saving data +++*/
  pf = fopen("./../PotDot_r_out.dat", "w");
  fprintf(pf, "%s%3s %15s\n", "#", "ID", "PotDot_r");
  for( m=0; m<GV.NTOTALCELLS; m++ )
    {
      gp[m].potDot_r = out[m]/GV.NORM;
      fprintf(pf, 
	      "%10d %16.8lf\n",
	      m, gp[m].potDot_r);
    }//for m
  fclose(pf);
   
  /*Recreating input array*/
  /*
  in2 = (fftw_complex *) malloc( sizeof( fftw_complex ) * GV.NTOTK );  
  plan_r2k = fftw_plan_dft_r2c_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, out, in2, FFTW_ESTIMATE );
  fftw_execute( plan_r2k );  
  */  

  fftw_destroy_plan( plan_k2r );
  //fftw_destroy_plan( plan_r2k );
  
  free(in);
  //fftw_free(in2);
  fftw_free(out);
#endif  


  /*+++++ IN-PLACE TRANSFORM +++++*/
#ifdef INPLACE
    /*+++ FFTW DEFINITIONS +++*/
  fftw_complex *in=NULL;
  fftw_plan plan_k2r; // FFTW from k-space to r-space
  fftw_plan plan_r2k; // FFTW from r-space to k-space
  
  
  /*+++ Creating input/output  arrays +++*/
  in  = (fftw_complex *) fftw_malloc( sizeof( fftw_complex ) * GV.NTOTALCELLS );
    
  pf = fopen("./../PotDot_k_in.dat", "w");
  fprintf(pf, "%s%3s %15s %25s\n", "#", "ID", "Re_potDot", "Im_potDot");
  for( m=0; m<GV.NTOTK; m++ )
    {
      in[m][0] = gp[m].potDot_k[0];
      in[m][1] = gp[m].potDot_k[1]; 
      fprintf(pf, 
	      "%10d %16.8lf %16.8lf\n",
	      m, gp[m].potDot_k[0], gp[m].potDot_k[1]);
    }//for m
  fclose(pf);
  
  /*+++ Making the FFT +++*/
  plan_k2r = fftw_plan_dft_c2r_3d(GV.NCELLS, GV.NCELLS, GV.NCELLS, in, (double*)in, FFTW_ESTIMATE);
  fftw_execute(plan_k2r);
  
  printf("FFT of potential derivative in r finished!\n");
  printf("-----------------------------------------\n");
  
  
  /*+++ Saving data +++*/
  for( m=0; m<GV.NTOTALCELLS/2; m++ )
    {
      gp[2*m].potDot_r = in[m][0]/GV.NORM;
      gp[2*m+1].potDot_r = in[m][1]/GV.NORM;
    }//for m

  pf = fopen("./../PotDot_r_in.dat", "w");
  fprintf(pf, "%s%3s %15s\n", "#", "ID", "PotDot" );

  for(m=0; m<GV.NTOTALCELLS; m++)
    {
      fprintf(pf,
	      "%10d %16.8lf\n",
	      m, gp[m].potDot_r);
    }
  fclose(pf);

   
  /*Recreating input array*/
  /*
  plan_r2k = fftw_plan_dft_r2c_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, (double*)in, in, FFTW_ESTIMATE );
  fftw_execute( plan_r2k );  
  */  

  fftw_destroy_plan( plan_k2r );
  //fftw_destroy_plan( plan_r2k );
  
  free(in);
#endif


  printf("FFT_pot_dot code finished!\n");
  printf("--------------------------\n");

  return 0;
}//potential_dot

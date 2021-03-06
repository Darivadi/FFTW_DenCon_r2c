/********************************************************************
NAME: potential
FUNCTION: Calculates the potential of the contrast density in the k-space (from the FFT)in the grid[m] order, and then with an IFFT calculates the potential in the real space
INPUT: density contrast in the k-space
RETURN: File with the input and outputs (sorted in the grid[m] order)
**********************************************************************/
int potential()
{
  int m, i, j, k;
  double factor;
  FILE *pf=NULL;
    
  /*+++++ Computing the potential in k-space +++++*/
  printf("Computing potential in k-space\n");
  printf("-----------------------------------------\n");

  /*----- Factor of the potential -----*/
  factor = (-3.0/2.0) * (GV.H0*GV.H0) * GV.Omega_M0 / GV.a_SF;

  for(m=0; m<GV.NTOTK; m++)
    {
      if( gp[m].k_module > GV.ZERO )
	{
	  gp[m].poten_k[0] = factor * gp[m].DenCon_K[0]/(gp[m].k_module * gp[m].k_module); //Re()
	  gp[m].poten_k[1] = factor * gp[m].DenCon_K[1]/(gp[m].k_module * gp[m].k_module); //Im()
	}//if 
      else
	{
	  gp[m].poten_k[0] = 0.0; //Re()
	  gp[m].poten_k[1] = 0.0; //Im()
	}//else 
    }//for m

  printf("Potential in k-space saved!\n");
  printf("-----------------------------------------\n");

  
#ifdef OUTOFPLACE

  /*+++++ Definitions +++++*/
  fftw_complex *in=NULL;
  double *out=NULL;
  fftw_complex *in2=NULL;
  fftw_plan plan_k2r; // FFTW from k-space to r-space
  fftw_plan plan_r2k; // FFTW from r-space to k-space
    

  /*----- Creating input/output arrays -----*/
  in  = (fftw_complex *) fftw_malloc( sizeof( fftw_complex ) * GV.NTOTK );
  out = (double *) fftw_malloc( sizeof( double ) * GV.NTOTALCELLS );
  
  /*----- Saving the potential input of the FFT -----*/
  for(m=0; m<GV.NTOTK; m++)
    {
      in[m][0] = gp[m].poten_k[0]; //Re()
      in[m][1] = gp[m].poten_k[1]; //Im()
    }//for m

  
  /*----- Making the FFT -----*/
  //plan_k2r = fftw_plan_dft_c2r_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, in, out, FFTW_ESTIMATE ); //out-of-place transform
  plan_k2r = fftw_plan_dft_c2r_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, in, out, FFTW_MEASURE ); //out-of-place transform
  fftw_execute( plan_k2r );
  
  printf("FFT potential k2r finished!\n");
  printf("---------------------------------------\n");
  
  /*----- Saving the output data for an out-of-place transform -----*/
  pf = fopen("./../Potential_r_out.dat", "w");
  fprintf(pf, "%s%14s %15s\n", "#", "ID", "Poten(r)");
  for( m=0; m<GV.NTOTALCELLS; m++ )
    {
      gp[m].poten_r = out[m]/GV.NORM; //Re()      
      fprintf(pf, 
	      "%10d %16.8lf\n",
	      m, gp[m].poten_r );
    }//for m
  fclose(pf);
    
  printf("---------------------------------------\n");
  printf("Potential in r space from an out-of-place transform saved!\n");
  printf("---------------------------------------\n");
 

  /*----- Recreating input array -----*/
  in2  = (fftw_complex *) fftw_malloc( sizeof( fftw_complex ) * GV.NTOTK );
  plan_r2k = fftw_plan_dft_r2c_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, out, in2, FFTW_ESTIMATE );
  fftw_execute( plan_r2k );

  printf("Recreated input of potential in k-space from out-of-place transform performed\n");
  printf("---------------------------------------\n");


  /*+++++ Saving recreated data +++++*/
  pf = fopen("./../Testing_potential_k_space.dat", "w");
  fprintf(pf, "%s%14s %15s %15s %15s\n", "#", "Re_Pot(k)", "Im_Pot(k)", "Reconst_Re", "Reconst_Im");

  for(m=0; m<GV.NTOTK; m++)
    {
      fprintf(pf, 
	      "%10d %20.8lf %20.8lf %20.8lf %20.8lf\n", 
	      m, 
	      gp[m].poten_k[0], gp[m].poten_k[1],
	      in2[m][0]/(GV.NORM*GV.NORM), in2[m][1]/(GV.NORM*GV.NORM));
    }//for m
  fclose(pf),

  printf("Recreated input of potential in k-space from out-of-place transform saved\n");
  printf("---------------------------------------\n");
  

  fftw_destroy_plan( plan_k2r );
  fftw_destroy_plan( plan_r2k );
  
  fftw_free( in );
  fftw_free( in2 );
  fftw_free( out );
#endif
  


#ifdef INPLACE
  /*+++++ Definitions +++++*/
  fftw_complex *in=NULL;  
  fftw_plan plan_k2r; // FFTW from k-space to r-space
  fftw_plan plan_r2k; // FFTW from r-space to k-space
    

  /*----- Creating input/output arrays -----*/
  in  = (fftw_complex *) fftw_malloc( sizeof( fftw_complex ) * GV.NTOTALCELLS );

  /*----- Saving the potential input of the FFT -----*/
  for(m=0; m<GV.NTOTK; m++)
    {
      in[m][0] = gp[m].poten_k[0]; //Re()
      in[m][1] = gp[m].poten_k[1]; //Im()
    }//for m

  /*----- Making the FFT -----*/
  //plan_k2r = fftw_plan_dft_c2r_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, in, (double *)in, FFTW_ESTIMATE ); //in-place transform  
  plan_k2r = fftw_plan_dft_c2r_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, in, (double *)in, FFTW_MEASURE ); //in-place transform  
  //plan_k2r = fftw_plan_dft_c2r_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, in, (double *)in, FFTW_IN_PLACE ); //in-place transform  
  fftw_execute( plan_k2r );

  /*----- Saving the output data for an in-place transform -----*/
  for( m=0; m<GV.NTOTALCELLS/2; m++ )
    {
      gp[2*m].poten_r = in[m][0]/GV.NORM;
      gp[2*m+1].poten_r = in[m][1]/GV.NORM;
    }//for m

  pf = fopen("./../Potential_r_in.dat", "w");
  fprintf(pf, "%s%14s %15s\n", "#", "ID", "Poten(r)");
  for( m=0; m<GV.NTOTALCELLS; m++ )
    {
      fprintf(pf,
	      "%10d %16.8lf\n", 
	      m, gp[m].poten_r );
    }//for m
  fclose(pf);

  //fftw_free( in );

  /*----- Recreating input array -----*/
  //in  = (double *) fftw_malloc( sizeof( double ) * GV.PADDING );
  plan_r2k = fftw_plan_dft_r2c_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, (double*) in, in, FFTW_ESTIMATE );
  //plan_r2k = fftw_plan_dft_r2c_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, in, (fftw_complex*)in, FFTW_IN_PLACE );
  fftw_execute( plan_r2k );
  
  printf("Recreated input of potential in k-space from out-of-place transform performed\n");
  printf("---------------------------------------\n");


  /*+++++ Saving recreated data +++++*/
  pf = fopen("./../Testing_potential_k_space_in-place.dat", "w");
  fprintf(pf, "%s%14s %15s %15s %15s\n", "#", "Re_Pot(k)", "Im_Pot(k)", "Reconst_Re", "Reconst_Im");

  for(m=0; m<GV.NTOTK; m++)
    {
      fprintf(pf, 
	      "%10d %20.8lf %20.8lf %20.8lf %20.8lf\n", 
	      m, 
	      gp[m].poten_k[0], gp[m].poten_k[1],
	      in[m][0]/(GV.NORM*GV.NORM), in[m][1]/(GV.NORM*GV.NORM));
    }//for m
  fclose(pf),

  printf("Recreated input of potential in k-space from out-of-place transform saved\n");
  printf("---------------------------------------\n");
  
  fftw_free( in );  
  fftw_destroy_plan( plan_k2r );
  fftw_destroy_plan( plan_r2k );
  
#endif

  printf("FFT_potential code finished!\n");
  printf("----------------------------\n");   

  return 0;
}//potential

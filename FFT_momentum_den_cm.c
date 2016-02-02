/********************************************************************
NAME: momentum_den_cm
FUNCTION: Calculates the momentum density using the contrast density and the center of mass velocities (both in r-space) in the grid[m] order
INPUT: density contrast and center of mass velocities in r-space, grid[m]-ordered
RETURN: FFT of momentums
**********************************************************************/
int momentum_den_cm()
{  
  int m, i, j, k;
  FILE *pf=NULL;
     
  /*--- Momentun density in position-space ---*/
#ifdef NGP      
  for(m=0; m<GV.NTOTALCELLS; m++)
    {
      //NGP
      gp[m].p_r[X] = (GV.NCELLS*GV.NCELLS*GV.NCELLS)*gp[m].gridParts*gp[m].v_cm[X]/(512.0*512.0*512.0);
      gp[m].p_r[Y] = (GV.NCELLS*GV.NCELLS*GV.NCELLS)*gp[m].gridParts*gp[m].v_cm[Y]/(512.0*512.0*512.0);
      gp[m].p_r[Z] = (GV.NCELLS*GV.NCELLS*GV.NCELLS)*gp[m].gridParts*gp[m].v_cm[Z]/(512.0*512.0*512.0);    
    }//for m
#endif


  /*+++++ OUT-OF-PLACE TRANSFORMS +++++*/
#ifdef OUTOFPLACE
  /*+++++ Definitions +++++*/
  double *in=NULL;
  fftw_complex *out=NULL;
  fftw_plan plan_r2k; // FFTW from r-space to k-space
  double *in2=NULL;
  fftw_plan plan_k2r; // FFTW from k-space to r-space

  /*----------------------------------------------------------------------------
                               FFT of momentum in X
  ----------------------------------------------------------------------------*/
  printf("Dealing with FFT momentum_cm in X!\n");
  printf("---------------------------------\n");

  /*+++++ Those transforms are also made out-of-place because we need to know the+++++*/  
  in  = (double *) fftw_malloc( sizeof( double ) * GV.NTOTALCELLS );
  out = (fftw_complex *) fftw_malloc( sizeof( fftw_complex ) * GV.NTOTK );

  /*--- Assigning momentum to the input of the fft ---*/
  for(m=0; m<GV.NTOTALCELLS; m++)
    {
      in[m] = gp[m].p_r[X]; //Re()
    }//for m
    
  /*--- Making the FFT ---*/
  plan_r2k = fftw_plan_dft_r2c_3d(GV.NCELLS, GV.NCELLS, GV.NCELLS, in, out, FFTW_ESTIMATE);
  fftw_execute( plan_r2k );
  printf("FFT of momentum_cm in X finished!\n");
  printf("---------------------------------\n");

  /*--- Saving output data ---*/
  pf = fopen("./../p_x_k-space_out-place.dat", "w");
  fprintf(pf, "%s%14s %15s\n", "#", "Re_p_x_k", "Im_p_x_k" );
  for(m=0; m<GV.NTOTK; m++)
    {
      gp[m].p_k[X][0] = out[m][0]/GV.NORM; //Re()
      gp[m].p_k[X][1] = out[m][1]/GV.NORM; //Im()
      fprintf(pf, 
	      "%10d %16.8lf %16.8lf\n",
	      m, gp[m].p_k[X][0], gp[m].p_k[X][1]);
    }//for m
  fclose(pf);
  

  /*--- Recreate the input ---*/
  in2 = (double *) fftw_malloc( sizeof( double) * GV.NCELLS * GV.NCELLS * GV.NCELLS );
  plan_k2r = fftw_plan_dft_c2r_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, out, in2, FFTW_ESTIMATE );
  fftw_execute( plan_k2r );
  printf("Inverse FFT for momentum in y finished!\n");
  
  pf = fopen("./../p_x_r_out.dat", "w");
  fprintf(pf, "%s%9s %15s\n", "#", "p_x", "In-place_rec");
  
  for(m=0; m<GV.NTOTALCELLS; m++)
    {      
      fprintf(pf, 
	      "%10d %16.8lf %16.8lf\n", 
	      m, 
	      gp[m].p_r[X],
	      in2[m]/(GV.NORM*GV.NORM) );
    }//for m
  fclose(pf);



  fftw_free(in);
  //fftw_free(in2);
  fftw_free(out);
  

  /*----------------------------------------------------------------------------
                                FFT momentum in Y 
  ----------------------------------------------------------------------------*/
  printf(" Dealing with FFT momentum_cm in Y!\n");
  printf("---------------------------------\n");
  
  in = (double *)  fftw_malloc( sizeof( fftw_complex )*GV.NTOTALCELLS);
  out = ( fftw_complex *) fftw_malloc( sizeof( fftw_complex )*GV.NTOTK);
  
  /* Sorting the momentum density in Y as input of the FFT */
  for(m=0; m<GV.NTOTALCELLS; m++)
    {
      in[m] = gp[m].p_r[Y];
    }//for m

  
  /* Making the FFT */
  plan_r2k = fftw_plan_dft_r2c_3d(GV.NCELLS, GV.NCELLS, GV.NCELLS, in, out, FFTW_ESTIMATE);
  fftw_execute( plan_r2k );
  printf("FFT of momentum_cm in Y finished!\n");
  printf("---------------------------------\n");
  
  /* Saving output data */
  for(m=0; m<GV.NTOTK; m++)
    {
      gp[m].p_k[Y][0] = out[m][0]/GV.NORM; //Re()
      gp[m].p_k[Y][1] = out[m][1]/GV.NORM; //Im()
    }//for m
  

  /* Recreate the input */    
  /*in2 = (double *) fftw_malloc( sizeof( double ) * GV.NTOTALCELLS );
  plan_k2r = fftw_plan_dft_c2r_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, out, in2, FFTW_ESTIMATE );
  fftw_execute( plan_k2r );
  */

  fftw_free(in);
  //fftw_free(in2);
  fftw_free(out);
  
  
  /*----------------------------------------------------------------------------
                                  FFT momentum in Z
  ----------------------------------------------------------------------------*/
  printf(" Dealing with FFT momentum_cm in Z!\n");
  printf("---------------------------------\n");
  
  /* Creating input array */
  in  = (double *) fftw_malloc( sizeof( double ) * GV.NTOTALCELLS);
  out = (fftw_complex *) fftw_malloc( sizeof( fftw_complex ) * GV.NTOTK);

  for(m=0; m<GV.NTOTALCELLS; m++)
    {
      in[m] = gp[m].p_r[Z]; //Re()
    }//for m
  
 
  /* Making the FFT */
  plan_r2k = fftw_plan_dft_r2c_3d(GV.NCELLS, GV.NCELLS, GV.NCELLS, in, out, FFTW_ESTIMATE);
  fftw_execute( plan_r2k );
  printf("FFT of momentum_cm in Z finished!\n");
  printf("---------------------------------\n");
  
  /* Saving output data */
  for(m=0; m<GV.NTOTK; m++)
    {
      gp[m].p_k[Z][0] = out[m][0]/GV.NORM;
      gp[m].p_k[Z][1] = out[m][1]/GV.NORM;
    }//for m
  

  /* Recreate the input */
  /*
  in2 = (double *) fftw_malloc( sizeof( double ) * GV.NTOTALCELLS );
  plan_k2r = fftw_plan_dft_c2r_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, out, in2, FFTW_ESTIMATE );
  fftw_execute( plan_k2r );
  */  
  
  fftw_destroy_plan( plan_r2k );
  //fftw_destroy_plan( plan_k2r );
  fftw_free(in);
  //fftw_free(in2);
  fftw_free(out);

#endif
 

  /*+++++ IN-PLACE TRANSFORMS +++++*/
#ifdef INPLACE
  /*+++++ Definitions +++++*/
  double *in=NULL;
  fftw_plan plan_r2k; // FFTW from r-space to k-space
  fftw_plan plan_k2r; // FFTW from k-space to r-space

  /*----------------------------------------------------------------------------
                               FFT of momentum in X
  ----------------------------------------------------------------------------*/
  printf("Dealing with FFT momentum_cm in X!\n");
  printf("---------------------------------\n");

  /*+++++ Those transforms are also made out-of-place because we need to know the+++++*/  
  in  = (double *) fftw_malloc( sizeof( double ) * GV.PADDING );

  /*--- Assigning momentum to the input of the fft ---*/
  for(m=0; m<GV.NTOTALCELLS; m++)
    {
      in[m] = gp[m].p_r[X]; //Re()
    }//for m
    
  /*--- Making the FFT ---*/
  plan_r2k = fftw_plan_dft_r2c_3d(GV.NCELLS, GV.NCELLS, GV.NCELLS, in, (fftw_complex *)in, FFTW_ESTIMATE);
  fftw_execute( plan_r2k );
  printf("FFT of momentum_cm in X finished!\n");
  printf("---------------------------------\n");

  /*--- Saving output data ---*/
  pf = fopen("./../p_x_k-space_in-place.dat", "w");
  fprintf(pf, "%s%14s %15s\n", "#", "Re_p_x_k", "Im_p_x_k" );

  for(m=0; m<GV.NTOTK; m++)
    {
      gp[m].p_k[X][0] = in[2*m]/GV.NORM; //Re()
      gp[m].p_k[X][1] = in[2*m+1]/GV.NORM; //Im()

      fprintf(pf, 
	     "%10d %16.8lf %16.8lf\n",
	     m, gp[m].p_k[X][0], gp[m].p_k[X][1]);
    }//for m
  fclose(pf);

  /*--- Recreate the input ---*/  
  plan_k2r = fftw_plan_dft_c2r_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, (fftw_complex *) in, in, FFTW_ESTIMATE );
  fftw_execute( plan_k2r );
  printf("Inverse FFT for momentum in y finished!\n");
  

  /*----- Saving recreated data in the in-place transform------*/  
  pf = fopen("./../p_x_r_in.dat", "w");
  fprintf(pf, "%s%9s %15s\n", "#", "p_x", "In-place_rec");
  
  for(m=0; m<GV.NTOTALCELLS; m++)
    {      
      fprintf(pf, 
	      "%10d %16.8lf %16.8lf\n", 
	      m, 
	      gp[m].p_r[X],
	      in[m]/(GV.NORM*GV.NORM) );
    }//for m
  fclose(pf);

  fftw_free(in);


  /*----------------------------------------------------------------------------
                                FFT momentum in Y 
  ----------------------------------------------------------------------------*/
  printf(" Dealing with FFT momentum_cm in Y!\n");
  printf("---------------------------------\n");
  
  in = (double *)  fftw_malloc( sizeof( fftw_complex )*GV.NTOTALCELLS);

  
  /* Sorting the momentum density in Y as input of the FFT */
  for(m=0; m<GV.NTOTALCELLS; m++)
    {
      in[m] = gp[m].p_r[Y];
    }//for m

  
  /* Making the FFT */
  plan_r2k = fftw_plan_dft_r2c_3d(GV.NCELLS, GV.NCELLS, GV.NCELLS, in, (fftw_complex*) in, FFTW_ESTIMATE);
  fftw_execute( plan_r2k );
  printf("FFT of momentum_cm in Y finished!\n");
  printf("---------------------------------\n");
  
  /* Saving output data */
  for(m=0; m<GV.NTOTK; m++)
    {
      gp[m].p_k[Y][0] = in[2*m]/GV.NORM; //Re()
      gp[m].p_k[Y][1] = in[2*m+1]/GV.NORM; //Im()
    }//for m
  

  /* Recreate the input */
  in = (double *) fftw_malloc( sizeof( double ) * GV.NTOTALCELLS );
  plan_k2r = fftw_plan_dft_c2r_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, (fftw_complex*)in, in, FFTW_ESTIMATE );
  fftw_execute( plan_k2r );
  
  fftw_free(in);  
  
  /*----------------------------------------------------------------------------
                                  FFT momentum in Z
  ----------------------------------------------------------------------------*/
  printf(" Dealing with FFT momentum_cm in Z!\n");
  printf("---------------------------------\n");
  
  /* Creating input array */
  in  = (double *) fftw_malloc( sizeof( double ) * GV.NTOTALCELLS);


  for(m=0; m<GV.NTOTALCELLS; m++)
    {
      in[m] = gp[m].p_r[Z]; //Re()
    }//for m
  
 
  /* Making the FFT */
  plan_r2k = fftw_plan_dft_r2c_3d(GV.NCELLS, GV.NCELLS, GV.NCELLS, in, (fftw_complex*)in, FFTW_ESTIMATE);
  fftw_execute( plan_r2k );
  printf("FFT of momentum_cm in Z finished!\n");
  printf("---------------------------------\n");
  
  /* Saving output data */
  for(m=0; m<GV.NTOTK; m++)
    {
      gp[m].p_k[Z][0] = in[2*m]/GV.NORM;
      gp[m].p_k[Z][1] = in[2+m+1]/GV.NORM;
    }//for m
  

  /* Recreate the input */
  /*
  plan_k2r = fftw_plan_dft_c2r_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, (fftw_complex*)in, in, FFTW_ESTIMATE );
  fftw_execute( plan_k2r );
  */  
  
  fftw_destroy_plan( plan_r2k );
  //fftw_destroy_plan( plan_k2r );
  fftw_free(in);
#endif

  
  /*----------------------------------------------------------------------------
                                   Weighted Momentum
  ----------------------------------------------------------------------------*/

  /*--- NGP ---*/
#ifdef NGP
  for(m=0; m<GV.NTOTALCELLS; m++)
   {
     if( fabs(gp[m].weight_NGP) > GV.ZERO)
       {
       //p_w_k(x) NGP
       gp[m].p_k[X][0] = gp[m].p_k[X][0]/gp[m].weight_NGP;
       gp[m].p_k[X][1] = gp[m].p_k[X][1]/gp[m].weight_NGP;

       //p_w_k(y) NGP
       gp[m].p_k[Y][0] = gp[m].p_k[Y][0]/gp[m].weight_NGP;
       gp[m].p_k[Y][1] = gp[m].p_k[Y][1]/gp[m].weight_NGP;
       
       //p_w_k(z) NGP
       gp[m].p_k[Z][0] = gp[m].p_k[Z][0]/gp[m].weight_NGP;
       gp[m].p_k[Z][1] = gp[m].p_k[Z][1]/gp[m].weight_NGP;     

       }//if
     else
     {
	 gp[m].p_k[X][0] = 0.0;
	 gp[m].p_k[X][1] = 0.0;
	 
	 gp[m].p_k[Y][0] = 0.0;
	 gp[m].p_k[Y][1] = 0.0;
	 
	 gp[m].p_k[Z][0] = 0.0;
	 gp[m].p_k[Z][1] = 0.0;
     }//else
   }//for m

  printf("Weighted momentum with NGP window function computed!\n");
  printf("-----------------------------------------------------------------\n");
#endif


  /*--- CIC ---*/
#ifdef CIC
  for(m=0; m<GV.NTOTALCELLS; m++)
    {
      if( fabs(gp[m].weight_CIC) > GV.ZERO )
	{
	  //p_w_k(x) CIC
	  gp[m].p_k[X][0] = gp[m].p_k[X][0]/gp[m].weight_CIC;
	  gp[m].p_k[X][1] = gp[m].p_k[X][1]/gp[m].weight_CIC;		  
	  
	  //p_w_k(y) CIC
	  gp[m].p_k[Y][0] = gp[m].p_k[Y][0]/gp[m].weight_CIC;
	  gp[m].p_k[Y][1] = gp[m].p_k[Y][1]/gp[m].weight_CIC;
	  
	  //p_w_k(z) CIC
	  gp[m].p_k[Z][0] = gp[m].p_k[Z][0]/gp[m].weight_CIC;
	  gp[m].p_k[Z][1] = gp[m].p_k[Z][1]/gp[m].weight_CIC;
	}//if
      else
	{
	  //p_w_k(x) CIC
	  gp[m].p_k[X][0] = 0.0;
	  gp[m].p_k[X][1] = 0.0;
	  
	  //p_w_k(x) CIC
	  gp[m].p_k[Y][0] = 0.0;
	  gp[m].p_k[Y][1] = 0.0;
	  
	  //p_w_k(x) CIC
	  gp[m].p_k[Z][0] = 0.0;
	  gp[m].p_k[Z][1] = 0.0;
	}//else
	      
    }//for m

  printf("Weighted momentum with CIC window function computed!\n");
  printf("-----------------------------------------------------------------\n");
#endif 

  return 0;
} // momentum_den_cm

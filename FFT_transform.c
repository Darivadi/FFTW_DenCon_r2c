/******************************************************************************
NAME: transform
FUNCTION: makes a FFT of an 3D input array and the inverse FFT to obtain 
the initial array to verify. Reorganizes the order of the output array to 
put it in an order according to the filled of the grid[m].
INPUT: A file with the data of densities and velocities. The files 
contains 11 columns: 1.Cell ID - 2.Density -  3,4,5.gp[m].pos[X,Y,Z]
-  6,7,8. gp[m].v_cm[X,Y,Z] - 9,10,11 gp[m].avg_v[X,Y,Z] 
columns are used.
RETURN: The output of the FFT ordered in c-order
******************************************************************************/
int transform()
{
  /*--- DEFINITIONS ---*/
  int m, i, j, k;
  double fx, fy, fz, k2;
  double wx_NGP, wy_NGP, wz_NGP, wx_CIC, wy_CIC, wz_CIC;
  double fundamental_freq;

  FILE *pf=NULL;
  
  /*----------------------------------------------------------------------------
                               FFT OF DENSITIES
    --------------------------------------------------------------------------*/  

  /****** OUT-OF-PLACE TRANSFORM ******/
#ifdef OUTOFPLACE
  
  /*------ Definitions for the out-of-place transform ------*/
  double *in=NULL;
  fftw_complex *out=NULL;
  fftw_plan plan_r2k; //plan_forward
  double *in2=NULL;
  fftw_plan plan_k2r; //plan_backward
  

  /*+++++ Creating the input/output array  +++++*/
  in  = (double *) fftw_malloc( sizeof( double )*GV.NTOTALCELLS); //out-of-place transform
  out = (fftw_complex *) fftw_malloc( sizeof( fftw_complex )*GV.NTOTK);


  /*----- Copying DenCon data to input array -----*/
  for(m=0; m<GV.NTOTALCELLS; m++)
    {
      in[m] = gp[m].DenConCell; //Re(DenCon_in)
    }//for m
  
  printf("Copy of input of Density Contrast for FFTW finished.\n");
  printf("-----------------------------------------------------------------\n");

  /*--- Making the FFT ---*/
  plan_r2k = fftw_plan_dft_r2c_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, in, out, FFTW_ESTIMATE ); //Out-of-place transform
  fftw_execute( plan_r2k );

  printf("FFT: density contrast r2k out-of-place finished!\n");
  printf("-----------------------------------------------------------------\n");


  /*--- Saving the output of the out-of-place transform ---*/
  pf = fopen("./../DenCon_k_raw.dat", "w");
  fprintf(pf, "%s%14s %15s\n", 
	  "#", "Re_DenCon", "Im_DenCon");

  for(m=0; m<GV.NTOTK; m++)
    {
      gp[m].DenCon_FFTout[0] = out[m][0]/GV.NORM; //Re()
      gp[m].DenCon_FFTout[1] = out[m][1]/GV.NORM; //Im()
      
      fprintf(pf,
	      "%10d %16.8lf %16.8lf\n",
	      m, 
	      out[m][0], out[m][1]);
    }//for m
  fclose(pf);

  /*+++++ Recreating the input +++++*/    
  in2 = (double *) fftw_malloc( sizeof(double) * GV.NTOTALCELLS );
  plan_k2r = fftw_plan_dft_c2r_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, out, in2, FFTW_ESTIMATE );
  fftw_execute( plan_k2r );

  printf("Inverse FFT for contrast density finished!\n");
  printf("-----------------------------------------------------------------\n");


  /*----- Saving recreated data in the out-of-place transform------*/  
  pf = fopen("./../Testing_c2r.dat", "w");
  fprintf(pf, "%s%9s %15s\n", "#", "DenCon", "Reconstruted");

  for(m=0; m<GV.NTOTALCELLS; m++)
    {
      fprintf(pf, 
	      "%10d %16.8lf %16.8lf\n", 
	      m, gp[m].DenConCell, in2[m]/(GV.NORM*GV.NORM));
    }//for m
  fclose(pf);
  
  /*--- Freeing up memory! ---*/
  printf("Freeing up memory!\n");
  printf("--------------------------------------------------\n");
  fftw_free(in);
  fftw_free(in2);
  fftw_free(out);


  /*--- Destroying plans ---*/
  printf("Destroying plans!\n");
  printf("--------------------------------------------------\n");
  fftw_destroy_plan( plan_r2k );
  printf("plan_r2k destroyed!");
  fftw_destroy_plan( plan_k2r );
  printf("plan_r2k destroyed!");

#endif


  /****** IN-PLACE TRANSFORM ******/
#ifdef INPLACE
  double *in=NULL;  
  fftw_plan plan_r2k; //plan_forward
  fftw_plan plan_k2r; //plan_backward
  
  /*+++++ Creating the input/output array  +++++*/
  in  = (double *) fftw_malloc( sizeof( double )*GV.PADDING); //in-place transform
  
  /*----- Copying DenCon data to input array -----*/
  for(m=0; m<GV.NTOTALCELLS; m++)
    {
      in[m] = gp[m].DenConCell; //Re(DenCon_in)
    }//for m
  
  printf("Copy of input of Density Contrast for FFTW finished.\n");
  printf("-----------------------------------------------------------------\n");


  /*--- Making the FFT ---*/
  plan_r2k = fftw_plan_dft_r2c_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, in, (fftw_complex*)in, FFTW_ESTIMATE ); //In-place transform
  //plan_r2k = fftw_plan_dft_r2c_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, in, (fftw_complex*)in, FFTW_IN_PLACE ); //In-place transform
  fftw_execute( plan_r2k );

  printf("FFT: density contrast r2k in-place finished!\n");
  printf("-----------------------------------------------------------------\n");
      
  /*--- Saving the output of the in-place transform ---*/
  pf = fopen("./../DenCon_k_raw_in-place.dat", "w");
  fprintf(pf, "%s%14s %15s\n", 
	  "#", "Re_DenCon", "Im_DenCon");

  for(m=0; m<GV.NTOTK; m++)
    {
      gp[m].DenCon_FFTout[0] = in[2*m]/GV.NORM; //Re()
      gp[m].DenCon_FFTout[1] = in[2*m+1]/GV.NORM; //Im()
      
      fprintf(pf,
	      "%10d %16.8lf %16.8lf\n",
	      m, 
	      in[2*m], in[2*m+1]);
    }//for m
  fclose(pf);

  //fftw_free(in);


  /*+++++ Recreating the input +++++*/ 
  //in  = (double *) fftw_malloc( sizeof( double )*GV.PADDING); //in-place transform
  plan_k2r = fftw_plan_dft_c2r_3d( GV.NCELLS, GV.NCELLS, GV.NCELLS, (fftw_complex*)in, in, FFTW_ESTIMATE );
  fftw_execute( plan_k2r );

  /*----- Saving recreated data in the in-place transform------*/  
  pf = fopen("./../Testing_c2r_in-place.dat", "w");
  fprintf(pf, "%s%9s %15s\n", "#", "DenCon", "In-place_rec");
  
  for(m=0; m<GV.NTOTALCELLS; m++)
    {      
      fprintf(pf, 
	      "%10d %16.8lf %16.8lf\n", 
	      m, 
	      gp[m].DenConCell,
	      in[m]/(GV.NORM*GV.NORM) );
    }//for m
  fclose(pf);
  
  
  /*--- Freeing up memory! ---*/
  printf("Freeing up memory!\n");
  printf("--------------------------------------------------\n");
  fftw_free(in);

  /*--- Destroying plans ---*/
  printf("Destroying plans!\n");
  printf("--------------------------------------------------\n");
  fftw_destroy_plan( plan_r2k );
  printf("plan_r2k destroyed!");
  fftw_destroy_plan( plan_k2r );
  printf("plan_r2k destroyed!");

#endif

  
  /*+++++ K vector: components and module +++++*/
  fundamental_freq = 2.0*M_PI/(1.0*GV.BoxSize);

  for(i=0; i<GV.NCELLS; i++)
    {
      for(j=0; j<GV.NCELLS; j++)
	{	  
	  for(k=0; k<=GV.CNMESH; k++)
	    { 
	      //m = INDEX_GRID(i,j,k); //ID in C-order
	      m = INDEX_K(i,j,k); //ID in C-order for Fourier space after r2c
	      
	      /*::: k_x :::*/
	      gp[m].k_vector[X] = fundamental_freq * KVALUE(i);
	      
	      /*::: k_y :::*/
	      gp[m].k_vector[Y] = fundamental_freq * KVALUE(j);
	      
	      /*::: k_z :::*/
	      gp[m].k_vector[Z] = fundamental_freq * KVALUE(k);

	      /*::: k-vector module :::*/
	      k2 = gp[m].k_vector[X]*gp[m].k_vector[X] + gp[m].k_vector[Y]*gp[m].k_vector[Y] + gp[m].k_vector[Z]*gp[m].k_vector[Z] ;
	      gp[m].k_module = sqrt(k2);
	      
	    }//for k
	}//for j
    }//for i
 
  printf("k vectors computed!\n");
  printf("------------------------------------------------\n");

  
  /*--- Density contrast in k-space with NGP weight function ---*/
#ifdef NGP
  printf("Computing density contrast in k space with NGP weight fn!\n");
  printf("------------------------------------------------\n");
  
  for(m=0; m<GV.NTOTALCELLS; m++)
    {
      /*----- Weight function in x -----*/
      if(fabs(gp[m].k_vector[X]) > GV.ZERO)
	{
	  fx = (gp[m].k_vector[X]*GV.BoxSize)/(2.0*GV.NCELLS);
	  wx_NGP = (sin(fx)/fx);
	}//if 1
      else
	{
	  wx_NGP = 1.0;
	}//else
      
      /*----- Weight function in y -----*/
      if(fabs(gp[m].k_vector[Y]) > GV.ZERO)
	{
	  fy = (gp[m].k_vector[Y]*GV.BoxSize)/(2.0*GV.NCELLS);
	  wy_NGP = (sin(fy)/fy);
	}//if 1
      else
	{
	  wy_NGP = 1.0;
	}//else
      
      /*----- Weight function in z -----*/
      if(fabs(gp[m].k_vector[Z]) > GV.ZERO)
	{
	  fz = (gp[m].k_vector[Z]*GV.BoxSize)/(2.0*GV.NCELLS);
	  wz_NGP = (sin(fz)/fz);  
	}//if 1
      else
	{
	  wz_NGP = 1.0;
	}//else
      
      /*----- Total weight function -----*/
      gp[m].weight_NGP = wx_NGP*wy_NGP*wz_NGP;
      
      
      /*----- Deconvolution of DenCon -----*/
      if(fabs(gp[m].weight_NGP) > GV.ZERO)
	{
	  gp[m].DenCon_K[0] = gp[m].DenCon_FFTout[0] / gp[m].weight_NGP;
	  gp[m].DenCon_K[1] = gp[m].DenCon_FFTout[1] / gp[m].weight_NGP;	  
	}//if
      else
	{
	  gp[m].DenCon_K[0] = 0.0;
	  gp[m].DenCon_K[1] = 0.0;
	}//else    
    }//for m
  
  printf("Density contrast in k-space with NGP weight fn ready!!\n");
  printf("------------------------------------------------\n");
#endif
  

    /*--- Density contrast in k-space with CIC weight function ---*/
#ifdef CIC  
  printf("Computing density contrast in k space with CIC weight-function!\n");
  printf("------------------------------------------------\n");
  for(m=0; m<GV.NTOTALCELLS; m++)
    {	     
      /*----- Weight function in x -----*/
      if(fabs(gp[m].k_vector[X]) > GV.ZERO)
	{
	  fx = (gp[m].k_vector[X]*GV.BoxSize)/(2.0*GV.NCELLS);
	  wx_CIC = (sin(fx)/fx)*(sin(fx)/fx);
	}//if 1
      else
	{
	  wx_CIC = 1.0;
	}//else
      
      /*----- Weight function in y -----*/
      if(fabs(gp[m].k_vector[Y]) > GV.ZERO)
	{
	  fy = (gp[m].k_vector[Y]*GV.BoxSize)/(2.0*GV.NCELLS);
	  wy_CIC = (sin(fy)/fy)*(sin(fy)/fy);
	}//if 1
      else
	{
	  wy_CIC = 1.0;
	}//else
      
      /*----- Weight function in z -----*/
      if(fabs(gp[m].k_vector[Z]) > GV.ZERO)
	{
	  fz = (gp[m].k_vector[Z]*GV.BoxSize)/(2.0*GV.NCELLS);
	  wz_CIC = (sin(fz)/fz)*(sin(fz)/fz);  
	}//if 1
      else
	{
	  wz_CIC = 1.0;
	}//else
      
      /*----- Total weight function -----*/
      gp[m].weight_CIC = wx_CIC*wy_CIC*wz_CIC;
      
      /*----- Deconvolution of DenCon with the total weight function -----*/
      if(fabs(gp[m].weight_CIC) > GV.ZERO)
	{
	  gp[m].DenCon_K[0] = gp[m].DenCon_FFTout[0] / gp[m].weight_CIC;
	  gp[m].DenCon_K[1] = gp[m].DenCon_FFTout[1] / gp[m].weight_CIC;
	}//if
      else
	{
	  gp[m].DenCon_K[0] = 0.0;
	  gp[m].DenCon_K[1] = 0.0;
      }//else

      gp[m].DenCon_K_2 = gp[m].DenCon_K[0]*gp[m].DenCon_K[0] + gp[m].DenCon_K[1]*gp[m].DenCon_K[1];
      
      if(gp[m].DenCon_K_2 < 0.0)
	{
	  printf("Negative Delta^2=%lf for m=%d\n", gp[m].DenCon_K_2, m);
	}

    }//for m
  
  printf("Density contrast in k-space with CIC weight fn ready!!\n");
  printf("-----------------------------------------------------------------\n");
#endif

   
  printf("FFT_transform code finished!\n");
  printf("--------------------------------------------------\n");

  return 0;
}//transform

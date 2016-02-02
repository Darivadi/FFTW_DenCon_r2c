/******************************************************************************
NAME: Power Spectrum
FUNCTION: Computes the Power spectrum.
INPUT: A file with the data of densities and velocities. The files contains 11 
columns: 1.Cell ID - 2.Density -  3,4,5.gp[m].pos[X,Y,Z] -  6,7,8. gp[m].v_cm[X,Y,Z]
- 9,10,11 gp[m].avg_v[X,Y,Z] columns are used.
RETURN: Files: the output of the FFT ordered in FFTW[p]-order; output of the FFT 
ordered according to the grid[m]
******************************************************************************/
void power_spectrum()
{
  int m, i, j, k, nx, ny, nz; 
  int iCenter, jCenter, kCenter, mCenter;
  int suma = 0;
  double norm, K_radius1 = 0.0, K_radius2 = 0.0, K_center = 0.0;
  double logBins, lmin, lmax;
  int NBins;
  FILE *outfile;

  
  //Linear binning  
  GV.DeltaK = 0.02;
  NBins = 200;

  printf("Creating bins: %d\n", NBins);
  
  GV.BinsPS = (double *)calloc(NBins, sizeof(double));
  GV.BinsK = (double *)calloc(NBins, sizeof(double));
  GV.BinsCount = (int *)calloc(NBins, sizeof(int));
  
  //Initializing vectors
  for(j=0; j<NBins; j++)
    {
      GV.BinsPS[j] = 0.0; 
      GV.BinsK[j] = 0.0;
      GV.BinsCount[j] = 0;
    }//for j

  printf("Vectors initialized\n");

  //Method using the sorted values according to index
  printf("Computing power spectrum\n");
  j = 0;

  for (i=0; i<NBins; i++)
    {
      K_radius1 = (double) i * GV.DeltaK;
      K_radius2 = ((double) (i+1)) * GV.DeltaK;
      for(m=0; m<GV.NTOTALCELLS; m++)
	{
	  if( gp[GV.SortedID[m]].k_module >= K_radius1 && gp[GV.SortedID[m]].k_module < K_radius2 )
	    {     
	      GV.BinsPS[i] +=  gp[GV.SortedID[m]].DenCon_K_2;
	      GV.BinsK[i] = K_radius2;
	      GV.BinsCount[i]++;
	    }//if 1
	  else
	    {
	      continue;
	    }//else	  
	}//for m
    }//for i  
  */

  //With logaritmic binning
  /* Taking the maximum value of the k_modules which is stored in 
     gp[GV.SortedID[GV.NTOTALCELLS-1]].k_module */

  NBins = 200;
  lmax = log10(1.0+gp[GV.SortedID[GV.NTOTALCELLS-1]].k_module);
  GV.logDeltaK = lmax / ((double) NBins);
  printf("DeltaK_log=%lf, DeltaK=%lf, logmax=%lf\n", 
	 GV.DeltaK, pow(10.0, GV.DeltaK), lmax );
  printf("k_max=%lf, 1+k_max=%lf\n", 
	 gp[GV.SortedID[GV.NTOTALCELLS-1]].k_module, 
	 1.0+gp[GV.SortedID[GV.NTOTALCELLS-1]].k_module);

  GV.BinsPS = (double *)calloc(NBins, sizeof(double));
  GV.BinsK = (double *)calloc(NBins+1, sizeof(double));
  GV.BinsCount = (int *)calloc(NBins, sizeof(int));
  
  //Initializing vectors
  for(i=0; i<=NBins; i++)
    {
      GV.BinsPS[i] = 0.0; 
      GV.BinsK[i] = 0.0;
      GV.BinsCount[i] = 0;
    }//for j
  printf("Vectors initialized\n");

  for(i=0; i<=NBins; i++)
    {
      GV.BinsK[i] = i * GV.logDeltaK;
      GV.BinsK[i] = pow(10, GV.BinsK[i]) - 1.0;
      //printf("bin i=%d, value=%lf\n", i, GV.BinsK[i]);
    }

  //Method using the sorted values according to index
  printf("Computing power spectrum\n");

  i=0;
  for(j=0; j<NBins; j++)
    {
      while((gp[GV.SortedID[i]].k_module <= GV.BinsK[j+1]) && (i<GV.NTOTALCELLS))
	{
	  GV.BinsPS[j] += gp[GV.SortedID[i]].DenCon_K_2;
	  GV.BinsCount[j]++;
 
	  /*
	  if((GV.BinsK[NBins]-0.001 < gp[GV.SortedID[i]].k_module))
	    {
	      GV.BinsPS[NBins] += gp[GV.SortedID[i]].DenCon_K_2;
	      GV.BinsCount[NBins]++;
	    }//if
	  */
	  i++;
	}//while
    }//for j

  printf("Final i=%d\n", i);

  /*
  for (i=0; i<NBins; i++)
    {
      //K_radius1 = (double) i * GV.DeltaK;
      //K_radius2 = ((double) (i+1)) * GV.DeltaK;

      for(m=0; m<GV.NTOTALCELLS; m++)
	{
	  if(gp[GV.SortedID[m]].k_module >= GV.BinsK[i] && gp[GV.SortedID[m]].k_module < GV.BinsK[i+1])
	    {     
	      GV.BinsPS[i] +=  gp[GV.SortedID[m]].DenCon_K_2;
	      //GV.BinsK[i] = pow(10.0,K_radius2);
	      GV.BinsCount[i]++;
	    }//else if 
	  else if((i==NBins-1) && (GV.BinsK[NBins+1]-0.001 < gp[GV.SortedID[m]].k_module))
	    {
	      printf("Last one!\n");
	      GV.BinsPS[i+1] +=  gp[GV.SortedID[m]].DenCon_K_2;
	      GV.BinsCount[i+1]++;
	    }//else if
	  else
	    {
	      continue;
	    }//else
  */
	  /*
	  if(GV.BinsK[i] > gp[GV.SortedID[GV.NTOTALCELLS-1]].k_module )
	    {
	      printf("for bin i=%d we have GV.BinsK[i]=%lf > gp[max].k_module=%lf\n", 
		     i, GV.BinsK[i], 
		     gp[GV.SortedID[GV.NTOTALCELLS-1]].k_module);
	      break;
	    }//if
	  */
  /*
	}//for m
    }//for i
  */
  
  //Normalizing over the counts  
  for(j=0; j<=NBins; j++)
    {
      if( GV.BinsCount[j] == 0 )
	{
	  GV.BinsPS[j] = 0.0;
	  printf("bin j=%d is null\n", j);
	}//if
      else
	{
	  GV.BinsPS[j] /= GV.BinsCount[j];
	}//else
    }//for j
  printf("Divided by the number of counts\n");

  printf("Printing outfile\n");
  outfile = fopen("Power_Spectrum.dat", "w");
  fprintf(outfile,"%s\t %9s\t %10s %10s\n", "#", "Delta_k", "PS(Delta_k)", "CountsInBin");

  for(j=0; j<=NBins; j++)
    {
      fprintf(outfile, "%16.8lf %20.10lf %12.6d\n", GV.BinsK[j], GV.BinsPS[j], GV.BinsCount[j]);
      suma += GV.BinsCount[j];
    }//for j

  fclose(outfile);

  printf("Total counts = %d\n", suma);


  /* N-method
  for(m=0; m<GV.NTOTALCELLS; m++)
    {
      j = floor( (gp[m].k_module/3.48) * 174);
      //Average over Density contrast in k-space to find the power spectrum
      GV.BinsDenCon[j] += gp[j].DenCon_K[0]*gp[j].DenCon_K[0] + gp[j].DenCon_K[1]*gp[j].DenCon_K[1];
      GV.BinsK[j] = (double) GV.DeltaK*(j+1);
      GV.BinsCount[j]++;
      j = 0;
    }//for m

  //Normalizing over the counts
  for(j=0; j<174; j++)
    {
      GV.BinsDenCon[j] /= GV.BinsCount[j];
    }//for j

  outfile = fopen("Power_Spectrum_N.dat", "w");
  fprintf(outfile,"%s\t %9s\t %10s\n", "#", "Delta_k", "PS(Delta_k)");

  for(j=0; j<174; j++)
    {
      fprintf(outfile, "%12.6lf %12.6lf\n", GV.BinsK[j], GV.BinsDenCon[j]);
    }//for j

  fclose(outfile);
  N-method  */

}//power_spectrum

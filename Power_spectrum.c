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
  int m, i, j, k; 
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

  GV.kF     = (2.0*M_PI)/GV.BoxSize;
  GV.kN     = M_PI/GV.CellSize;
  GV.shotNoise = pow(GV.CellSize,3);
  printf("Shot Noise:%lf\n", GV.shotNoise);

  
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
	      GV.BinsPS[i] += gp[GV.SortedID[m]].DenCon_K_2;
	      GV.BinsK[i] = K_radius2;
	      GV.BinsCount[i]++;
	    }//if 1
	  else
	    {
	      continue;
	    }//else	  
	}//for m
    }//for i  
  
  
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
	  GV.BinsPS[j] /= (1.0*GV.BinsCount[j]);
	}//else
    }//for j
  printf("Divided by the number of counts\n");


  printf("Printing outfile\n");
  outfile = fopen("Power_Spectrum_lineal.dat", "w");
  fprintf(outfile,"%s\t %9s\t %10s %10s\n", "#", "Delta_k", "PS(Delta_k)", "CountsInBin");

  for(j=0; j<=NBins; j++)
    {
      if(GV.DeltaK*(j+0.5)>GV.kN)
	{
	  continue;
	}//if      
      
      GV.BinsPS[j] *= (GV.CellSize * GV.CellSize * GV.CellSize)/(1.0*GV.NTOTALCELLS);
      GV.BinsPS[j] -= GV.shotNoise;
      GV.BinsPS[j] /= C1(GV.DeltaK*(j+0.5));

      fprintf(outfile, "%16.8lf %20.10lf %12.6d\n", GV.BinsK[j], GV.BinsPS[j], GV.BinsCount[j]);
      suma += GV.BinsCount[j];
    }//for j

  fclose(outfile);

  printf("Total counts = %d\n", suma);


}//power_spectrum

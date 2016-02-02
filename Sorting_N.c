int Sorting_k (void){
  int i;
  double *k_aux=NULL;

  k_aux = (double *)calloc(GV.NTOTALCELLS, sizeof(double));
  GV.SortedID = malloc(GV.NTOTALCELLS * sizeof(size_t));

  //Assigning each value of the k-vector of the cell to the auxiliar vector
  for(i = 0; i < GV.NTOTALCELLS; i++ )
    {
      k_aux[i] = gp[i].k_module;
    }//for i
  
  /*                                                                                          
    Rutina que recibe las distancias y los indices de las
    particulas y devulve, organizadas en orden creciente,                                      
    las distancias y los respectivos indices de las particulas
  */
  gsl_sort_index(GV.SortedID, k_aux, 1, GV.NTOTALCELLS);

  return 0;  
}

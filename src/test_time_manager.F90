program test_time_manager
  use time_manager
  
  implicit none
  type(timedelta) dt_atmos, dt_ocean, dt_cpl, dt_tmp
  type(datetime)  Time_curr, Time_strt, Time_last
  type(clock)    clock_atmos, clock_ocean
  real(8) :: factor, days_prev
  
  !!
  dt_atmos  = timedelta(hours=4)
  dt_ocean  = timedelta(hours=12)
  
  write(*, *) dt_atmos%total_days(), " to ", dt_ocean%total_days()
  
  dt_cpl = dt_ocean - dt_atmos
  write(*, *) dt_cpl%total_hours()

  dt_cpl = - dt_atmos
  write(*, *) dt_cpl%total_hours()
  
  factor = dt_ocean/dt_atmos
  write(*, *) factor
  
  Time_strt = datetime(1980, 1, 1, 0, 0, 0, calendar=noleap)
  Time_last = datetime(2020, 1, 1, 0, 0, 0, calendar=noleap)
  write(*, *) Time_strt%isoformat(), " to ", Time_last%isoformat()

  clock_atmos = clock(Time_strt, Time_last, dt_atmos)
  
  do while (.not. clock_atmos%stopped)
      !! write(*, *) clock_atmos%Time%days_in_year()
      
      days_prev = int(clock_atmos%Time%days_in_month())
      
      call clock_atmos%tick()
      
      if( clock_atmos%alarm_repeatmon ) then
           dt_tmp = clock_atmos%Time-Time_strt
        !  print *, dt_tmp%total_days()
          write(*, *) clock_atmos%Time%isoformat(), clock_atmos%Time%days_in_year(), dt_tmp%total_days()-days_prev

      end if
      
  end do

end program test_time_manager

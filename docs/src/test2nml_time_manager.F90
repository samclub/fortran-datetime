program test_time_manager
  use time_manager
  
  implicit none
  type(timedelta) dt_atmos
  type(datetime)  Time_strt, Time_last
  
  namelist /time_nml/ Time_strt, Time_last, dt_atmos
  integer :: jm
  logical :: namelist_file_exists

  ! Read namelist file
  inquire(file="input.nml", exist=namelist_file_exists)
  if (namelist_file_exists) then
     open(10, file="input.nml")
     read(10, nml=time_nml)
     close(10)
  end if
            
  write(*, '(2A)') " Model runs from ", Time_strt%isoformat()
  write(*, '(2A)') " Model ends at   ", Time_last%isoformat()
  write(*, '(A, F5.3, A)') " dt_atmos = ", dt_atmos%total_hours(), " hours"

end program test_time_manager

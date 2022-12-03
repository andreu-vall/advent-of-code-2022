program demo_readline
    implicit none
    character(len=:),allocatable :: line
    integer :: ier
    integer, dimension(52) :: priorities
    integer, dimension(52, 3) :: common
    integer i, half, priority, suma, suma2, number

    suma = 0
    suma2 = 0
    number = 0
    INFINITE: do
        call readline(line, ier)
        if(ier.ne.0) exit INFINITE

        number = number + 1
        
        half = len(line) / 2

        do i = 1, 52
            priorities(i) = 0
        enddo

        do i = 1, half
            priority = get_priority(line(i:i))
            priorities(priority) = priorities(priority) + 1
        enddo
        
        do i = half+1, len(line)
            priority = get_priority(line(i:i))
            if (priorities(priority) > 0) then
                suma = suma + priority
                exit
            endif
        enddo

        do i = 1, 52
            common(i, number) = 0
        enddo

        do i = 1, len(line)
            common(get_priority(line(i:i)), number) = 1
        enddo

        if (number == 3) then
            number = 0
            do i = 1, 52
                if (common(i, 1) + common(i, 2) + common(i, 3) == 3) then
                    suma2 = suma2 + i
                    exit
                endif
            enddo
        endif


    enddo INFINITE

    print *, suma
    print *, suma2

 contains

 function get_priority (char)  

    implicit none          
    integer :: get_priority   
    character :: char

    get_priority = iachar(char)
    if (get_priority > 96) then
        get_priority = get_priority - 96
    else
        get_priority = get_priority - 65 + 27
    endif
       
end function get_priority

 subroutine readline(line,ier)
 implicit none
 character(len=:),allocatable,intent(out) :: line
 integer,intent(out)                      :: ier
 
    integer,parameter                     :: buflen=1024
    character(len=buflen)                 :: buffer
    integer                               :: last
    integer                               :: isize
 
    line=''
    ier=0
 
    INFINITE: do
       read(*,iostat=ier,fmt='(a)',advance='no',size=isize) buffer
       if(isize.gt.0)line=line//buffer(:isize)
       if(is_iostat_eor(ier))then
          last=len(line)
          if(last.ne.0)then
             if(line(last:last).eq.'\\')then
                line=line(:last-1)
                cycle INFINITE
             endif
          endif
          ier=0
          exit INFINITE
      elseif(ier.ne.0)then
         exit INFINITE
      endif
    enddo INFINITE
    line=trim(line)

 end subroutine readline

 end program demo_readline

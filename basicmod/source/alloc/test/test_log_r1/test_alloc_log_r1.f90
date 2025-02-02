program test_alloc_log_r1
use module_alloc
implicit none
logical, allocatable :: v(:)
integer, allocatable :: x(:)
integer :: p

print*, 'Extension of a non-allocated array without fitting:'
print*, 'call extend(v, 1, fit=.false.)'
         call extend(v, 1, fit=.false.)
if (.not. allocated(v)) stop 'Error, v not allocated'
print*, 'New extension: ', size(v,1)
deallocate(v)

print*, ' '
print*, 'Extension of a non-allocated array with fitting:'
print*, 'call extend(v, 1)'
         call extend(v, 1)
if (.not. allocated(v)) stop 'Error, v not allocated'
print*, 'New extension: ', size(v,1)

print*, ' '
print*, 'Extension of an allocated array with fitting:'
print*, 'call extend(v, 2)'
         call extend(v, 2)
if (.not. allocated(v)) stop 'Error, v not allocated'
print*, 'New extension: ', size(v,1)

print*, ' '
print*, 'Extension of an allocated array without surpassing current dimensions:'
print*, 'call extend(v, 1, fit=.false.)'
         call extend(v, 1, fit=.false.)
if (.not. allocated(v)) stop 'Error, v not allocated'
print*, 'New extension: ', size(v,1)

print*, ' '
print*, 'Setting a scalar in a preallocated 1x3 array:'
print*, 'call alloc(v, 3)'
         call alloc(v, 3)
print*, 'call set(v, .true., 1)'
         call set(v, .true., 1)
if (.not. allocated(v)) stop 'Error, v not allocated'
print*, v

print*, 'Setting a vector in a preallocated 1x3 array:'
print*, 'call set(v, [.false., .true.], [1, 3])'
         call set(v, [.false., .true.], [1, 3])
if (.not. allocated(v)) stop 'Error, v not allocated'
print*, v

print*, 'Inserting a scalar in a preallocated 1x3 array:'
print*, 'call insert(v, .false., 5)'
         call insert(v, .false., 5)
if (.not. allocated(v)) stop 'Error, v not allocated'
print*, v

print*, 'Reducing a preallocated 1x7 array to 1x2:'
print*, 'call reduce(v, 2)'
         call reduce(v, 2)
if (.not. allocated(v)) stop 'Error, v not allocated'
print*, v

end program   

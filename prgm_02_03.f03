      Program prgm_02_03
!
!     This program reads a file name from the command line, opens that
!     file, and loads a packed form of a symmetric matrix. Then, the packed
!     matrix is expanded assuming a column-wise lower-triangle form and
!     printed. Finally, the matrix is diagonalized using the LAPack routine
!     SSPEV. The eigenvalues and eigenvectors are printed.
!
!     The input file is expected to have the leading dimension (an integer
!     NDim) of the matrix on the first line. The next (NDim*(NDim+1))/2
!     lines each have one real number each given.
!
!
      Implicit None
      Integer::IIn=10,IError,NDim,i,j
      Real,Dimension(:),Allocatable::Array_Input,EVals,Temp_Vector
      Real,Dimension(:,:),Allocatable::Matrix,EVecs,Temp_Matrix
      Character(Len=256)::FileName
!
!     Begin by reading the input file name from the command line. Then,
!     open the file and read the input array, Array_Input.
!
      Call Get_Command_Argument(1,FileName)
      Open(Unit=IIn,File=TRIM(FileName),Status='OLD',IOStat=IError)
      If(IError.ne.0) then
        Write(*,*)' Error opening input file.'
        STOP
      endIf
      Read(IIn,*) NDim
      Allocate(Array_Input((NDim*(NDim+1))/2),Matrix(NDim,NDim))
      Allocate(EVals(NDim),EVecs(NDim,NDim),Temp_Vector(3*NDim))
      Allocate(Temp_Matrix(NDim,NDim))
!
! *************************************************************************
! WRITE CODE HERE TO READ THE ARRAY ELEMENTS FROM THE INPUT FILE.
! *************************************************************************
!
      Do i = 1, (NDim*(NDim+1))/2
         Read(IIn,*) Array_Input(i)
      End Do
      Close(Unit=IIn)
!
!     Convert Array_Input to Matrix and print the matrix.
!
      Write(*,*)' The matrix loaded (column) lower-triangle packed:'
      Call SymmetricPacked2Matrix_LowerPac(NDim,Array_Input,Matrix)
      Call Print_Matrix_Full_Real(Matrix,NDim,NDim)
      Call SSPEV('***','***',NDim,Array_Input,EVals,EVecs,NDim,  &
        Temp_Vector,IError)
      If(IError.ne.0) then
        Write(*,*)' Failure in DSPEV.'
        STOP
      endIf
      Write(*,*)' EVals:'
      Call Print_Matrix_Full_Real(RESHAPE(EVals,(/1,NDim/)),1,NDim)
      Write(*,*)' EVecs:'
      Call Print_Matrix_Full_Real(EVecs,NDim,NDim)
!
      End Program prgm_02_03

      Subroutine SymmetricPacked2Matrix_LowerPac(N,ArrayIn,AMatOut)
!
!     This subroutine accepts an array, ArrayIn, that is (N*(N+1))/2 long.
!     It then converts that form to the N-by-N matrix AMatOut taking
!     ArrayIn to be in lower-packed storage form. Note: The storage mode
!     also assumes the lower-packed storage is packed by columns.
!
      Implicit None
      Integer,Intent(In)::N
      Real,Dimension((N*(N+1))/2),Intent(In)::ArrayIn
      Real,Dimension(N,N),Intent(Out)::AMatOut
!
      Integer::i,j,k
!
!     Loop through the elements of AMatOut and fill them appropriately from
!     Array_Input.
!
!
! *************************************************************************
! WRITE CODE HERE TO UNPACK ARRYIN INTO AMATOUT.
! *************************************************************************
!
      k = 1
      Do j = 1, N
         Do i = j, N
            AMatOut(i,j) = ArrayIn(k)
            AMatOut(j,i) = ArrayIn(k)
            k = k + 1
         End Do
      End Do
!
      Return
      End Subroutine SymmetricPacked2Matrix_LowerPac
      Subroutine Print_Matrix_Full_Real(AMat, M, N)
!
      Implicit None
      Integer, Intent(In) :: M, N
      Real, Dimension(M,N), Intent(In) :: AMat
      Integer :: i, j


      Write(*, '(1X, 100I10)') (j, j = 1, N)
      Do i = 1, M
         Write(*, '(I4,100F10.6)') i, (AMat(i, j), j = 1, N)
      End Do

      Return
      End Subroutine Print_Matrix_Full_Real

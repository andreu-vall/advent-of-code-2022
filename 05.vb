Module Program

  Sub Main()
    
    Dim init_max_height As Integer = 20
    Dim towers_str(init_max_height) As String
    Dim index As Integer = 0
    While (index < init_max_height)
      Dim myline As String = Console.ReadLine()
      If (GetChar(myline, 2) = "1") Then
        Exit While
      End If
      index += 1
      towers_str(index) = myline
      End While
  
    Dim num_towers As Integer = 9
    Dim max_tower_height As integer = num_towers * index
    
    Dim towers(num_towers, max_tower_height) As Char
    Dim tower_position(num_towers) As Integer
    
    For i As Integer = 1 To num_towers
      tower_position(i) = 0
      While (tower_position(i) < index)
        Dim mychar = GetChar(towers_str(index-tower_position(i)), -2+4*i)
        If (Not mychar = " ") Then
          tower_position(i) += 1
          towers(i, tower_position(i)) = mychar
        Else
          Exit While
        End If
      End While
    Next 'I cannot express how much I hate that this is not a "End For"
  
    Console.ReadLine() 'Ignore blank line
    
    Dim towers2(num_towers, max_tower_height) As Char
    Array.Copy(towers, towers2, towers.Length)
    
    While (true)
      Dim myline As String = Console.ReadLine()
      If (myline = "")
        Exit While
      End If
      
      Dim strArr() As String = myline.Split(" ")
      Dim quant As Integer = Convert.toInt32(strArr(1))
      Dim origin As Integer = Convert.toInt32(strArr(3))
      Dim dest As Integer = Convert.toInt32(strArr(5))
      
      Dim reverse_order As Integer = tower_position(origin) - quant + 1
      For i As Integer = 1 To quant
        tower_position(dest) += 1
        towers(dest, tower_position(dest)) = towers(origin, tower_position(origin))
        towers2(dest, tower_position(dest)) = towers2(origin, reverse_order)
        tower_position(origin) -= 1
        reverse_order += 1
      Next
    End While
    
    Print(towers, num_towers, tower_position)
    Print(towers2, num_towers, tower_position)
    
  End Sub
  
  'Yay I deduced the way of passing arrays and multidimensional arrays by myself!
  Function Print(towers(,) As Char, num_towers As Integer, tower_position() As Integer)
    For i As Integer = 1 To num_towers
      Console.Write(towers(i, tower_position(i)))
    Next
    Console.WriteLine()
    Return 0
  End Function
  
End Module

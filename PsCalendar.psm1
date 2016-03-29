Function Get-Calendar
{
    <#
    .Synopsis
        PowerShell calendar display
    .EXAMPLE
        Get-Calendar
    .EXAMPLE
        Get-Calendar -date 01/01/2000
    #>
    Param([Parameter(Position=0)][DateTime]$date=(Get-Date))
    $dateTimeObject = new-object System.Globalization.DateTimeFormatInfo
    $title = (Get-Date($date) -Format $dateTimeObject.YearMonthPattern)
    Write-Host -NoNewline $title.PadLeft(((27 - $title.Length) / 2) + $title.Length)
    
    $p = $dateTimeObject.ShortestDayNames
    $col1 = @{expression=$dateTimeObject.AbbreviatedDayNames[0];alignment="right"}
    $col2 = @{expression=$dateTimeObject.AbbreviatedDayNames[1];alignment="right"}
    $col3 = @{expression=$dateTimeObject.AbbreviatedDayNames[2];alignment="right"}
    $col4 = @{expression=$dateTimeObject.AbbreviatedDayNames[3];alignment="right"}
    $col5 = @{expression=$dateTimeObject.AbbreviatedDayNames[4];alignment="right"}
    $col6 = @{expression=$dateTimeObject.AbbreviatedDayNames[5];alignment="right"}
    $col7 = @{expression=$dateTimeObject.AbbreviatedDayNames[6];alignment="right"}

    Get-MonthObject -date $date |
        Format-Table -Property $col1, $col2, $col3, $col4, $col5, $col6, $col7  -AutoSize
}

Function Get-MonthObject
{
    Param([DateTime]$date)
    $dateTimeObject = new-object System.Globalization.DateTimeFormatInfo
    [DateTime]$first = Get-FirstDayOfMonth $date
    [DateTime]$last = Get-LastDayOfMonth $date
    [DateTime]$day=$first
    do
    {
        $week = (0..6)
        for ($inx=0; $inx -le 6; $inx++)
        {
            if ($day.DayOfWeek.value__ -eq $inx -and $day -le $last) {
                $week[$inx] = if ($day.Date -eq (Get-Date).Date) {
                    $day.Day.ToString() + "*"
                } else { 
                    $day.Day.ToString().PadRight(3)
                }
                $day = $day.AddDays(1)
            }
            else
            {
                $week[$inx] = ""
            }
        }
        Get-WeekObject($week)
    }
    While ($day -le $last)
}

Function Get-WeekObject
{
    Param($week)
    New-Object PSObject -Property @{
        $dateTimeObject.AbbreviatedDayNames[0] = $week[0];
        $dateTimeObject.AbbreviatedDayNames[1] = $week[1];
        $dateTimeObject.AbbreviatedDayNames[2] = $week[2];
        $dateTimeObject.AbbreviatedDayNames[3] = $week[3];
        $dateTimeObject.AbbreviatedDayNames[4] = $week[4];
        $dateTimeObject.AbbreviatedDayNames[5] = $week[5];
        $dateTimeObject.AbbreviatedDayNames[6] = $week[6];
    }
}

Function Get-FirstDayOfMonth
{
    Param([DateTime]$date)
    Get-Date $date -day 1 -hour 0 -minute 0 -Second 0
}

Function Get-LastDayOfMonth
{
    Param([DateTime]$date)
    $date = Get-FirstDayOfMonth($date).AddMonths(1)
    $date.AddDays(-1)
}

New-Alias Cal Get-Calendar

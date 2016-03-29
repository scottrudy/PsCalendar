# PsCalendar
Calendar module for PowerShell

##Install instructions
This module is available on the [PowerShell Gallery](https://www.powershellgallery.com/packages/PsCalendar). Instructions are available on the site for global installation, but if you need to install without admin rights to your profile, simply open a PS session and type one of the following commands.

```PowerShell
Install-Package PsCalendar -Scope CurrentUser
```
or
```PowerShell
Install-Module PsCalendar -Scope CurrentUser
```

##Usage
Once installed you can run the command and optionally pass in a date [-date=01/01/2000].
```PowerShell
calendar 01/01/2000
```
or
```PowerShell
calendar -date 01/01/2000
```

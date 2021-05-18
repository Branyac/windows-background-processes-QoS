<#
MIT License
Copyright (c) 2021 Sergio Monedero
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#>

[float] $vfloat_cpuPercentageForBackgroundProcesses = 50.0;	# CPU percentage for background tasks

[int] $vint_logicalProcessors = (Get-CIMInstance -Class 'CIM_Processor').NumberOfLogicalProcessors
[int] $vint_coresForBackgroundProcesses = [int] [Math]::Ceiling($vint_logicalProcessors * 0.01 * $vfloat_cpuPercentageForBackgroundProcesses);
[string] $vstr_afinityBitmask = "1" * $vint_coresForBackgroundProcesses + "0" * ($vint_logicalProcessors - $vint_coresForBackgroundProcesses);
[int] $vint_processorAfinity = [Convert]::ToInt32($vstr_afinityBitmask, 2);

$vo_backgroundProcesses = Get-Process | Where-Object { $_.MainWindowHandle -eq 0 };	# Background processes don't have MainWindowHandle

[int] $vint_successCounter = 0;
ForEach ($vo_process in $vo_backgroundProcesses) {
	try {
		($vo_process.ProcessorAffinity = $vint_processorAfinity) | Out-Null;
		$vint_successCounter++;
	}
	catch {
		Write-Host "ERROR: $($vo_process.Name) $($_.Exception.Message)"
	}
}

Write-Host "$vint_successCounter processes where optimized";
Write-Host "End";

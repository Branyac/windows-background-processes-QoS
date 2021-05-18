# windows-background-processes-QoS

This scripts tries to emulate Apple's M1 QoS on Windows 10.

More info at: [Apple’s M1 is a fast CPU—but M1 Macs feel even faster due to QoS](https://arstechnica.com/gadgets/2021/05/apples-m1-is-a-fast-cpu-but-m1-macs-feel-even-faster-due-to-qos/)

The script was tested on Windows 10 20H2 with an Intel(R) Core(TM) i5-8350U CPU.

## Instructions
1. Set in ``$vfloat_cpuPercentageForBackgroundProcesses`` value the % of CPU cores you want to use for background tasks. Default value is 50%.
2. Open Windows Powershell as administrator and execute the script file or paste the code directly to the console.

## Notes
- The affinity of some special protected processes like Windows core and Antivirus can't be changed and you will get 'Access denied' message. Please ignore these errors since it don't affect other processes.
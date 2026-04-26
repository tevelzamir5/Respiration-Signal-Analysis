# Respiration Signal Preprocessing GUI (MATLAB)
## Overview
The project presents a MATLAB based GUI for preprocessing and analyzing respiration signals. It was developed as part of a biomedical engineering final project, focusing on signal cleaning, feature extraction, and user-guided analysis.
The system enables both automated and manual interaction with respiration data, supporting robust anakysis under complex conditions such as motion and cognitive load.

## Key Features
- Signal preprocessing pipline (filtering, normalization, downsampling, smoothing)
- Adaptive LMS filtering for motion artifacr reduction
- Automatic peak detection
- Manual peak correction via GUI
- Event tagging and synchronization
- Visualization of signals at different processing stages

## GUI Modules
The system is divided into several dedicated GUI components:
- **PreProcessGUI -** Main interface for loading and managing signals
- **FilterLMSGUI -** Adative filtering using LMS algorithm
- **SmoothSignalGUI -** Signal smoothing (moving average)
- **PeakDetectGUI -** Automatic detection of inhale/exhale peaks
- **ManualEditOeakDetectGUI -** Manual correcrion of detected peaks
- **EventTagGUI -** Event labeling and alignment with signal timeline

## Processing Pipeline
1. Load respiration signal
2. Apply preprocessing (DC Remove, Band-Pass Filter, Downsampling, Normalization)
3. Reduce motion artifacts using LMS filtering
4. Smooth the signal
5. Detect peaks (inhale/exhale)
6. Manually detect peaks if needed
7. Tag events and align with signal

## Application
- Physiological signal analysis
- Biomedical research
- Motion artifact handling in wearable sensing
- Human performance and cognitive load studies

## Author
Tevel Zamir
B.Sc Biomedical Engineering
  

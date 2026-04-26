function subject_struct = PeakDetectGUI(subject_struct, minPeakDist, minAmp)

    signal = subject_struct.preprocess.signal;
    time = subject_struct.preprocess.time;
    fs = subject_struct.preprocess.fs;

    %% Peak Detect
    [peaks_v_in, peaks_locs_in] = findpeaks(signal, "MinPeakDistance", minPeakDist, 'MinPeakProminence', minAmp);
    peaks_t_in = peaks_locs_in/fs;
    [peaks_values_ex, peaks_locs_ex] = findpeaks(-signal, "MinPeakDistance", minPeakDist, 'MinPeakProminence', minAmp);
    peaks_v_ex = -peaks_values_ex;
    peaks_t_ex = peaks_locs_ex/fs;

    NinPeaks = length(peaks_t_in);
    NexPeaks = length(peaks_t_ex);

    %% Update Subject Structure
    subject_struct.peaks_data.in.v = peaks_v_in;
    subject_struct.peaks_data.in.t = peaks_t_in;
    subject_struct.peaks_data.in.N = NinPeaks;
    subject_struct.peaks_data.ex.v = peaks_v_ex;
    subject_struct.peaks_data.ex.t = peaks_t_ex;
    subject_struct.peaks_data.ex.N = NexPeaks;
end
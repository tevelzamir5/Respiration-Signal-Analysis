function subject_struct = SmoothSignalGUI(subject_struct, wind_size)
    fs = subject_struct.preprocess.fs;
    signal = subject_struct.preprocess.signal;

    %%
    wind_samples = round(wind_size*fs);
    smoothed_signal = movmean(signal, wind_samples);
    signal = (smoothed_signal - mean(smoothed_signal))/std(smoothed_signal);

    subject_struct.preprocess.signal = signal;
end
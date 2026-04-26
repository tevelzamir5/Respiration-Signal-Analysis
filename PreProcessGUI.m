function subject_struct = PreProcessGUI(subject_struct)
    subject = subject_struct.traildata.Subject;
    session = subject_struct.traildata.Session;
    condition = subject_struct.traildata.Condition;
    test = subject_struct.traildata.Test;

    raw_signal = subject_struct.raw.raw_signal;
    raw_time = subject_struct.raw.raw_time;
    raw_fs = subject_struct.raw.raw_fs;

    %% 0. Load ACC data and interpolate time vectors
    acc_trails = fullfile("0. Unprocessed Data", subject, "Dflow", session, condition, subject + "_CTT_" + test + "_0001.txt");
    acc_table = readtable(acc_trails);
    acc_x = acc_table.mKr_Pos_X;
    acc_y = acc_table.mKr_Pos_Y;
    acc_z = acc_table.mKr_Pos_Z;
    acc_mag = sqrt(acc_x.^2 + acc_y.^2 + acc_z.^2);
    acc_t = acc_table.Timer;
    
    t_start = max(raw_time(1), acc_t(1));
    t_end = min(raw_time(end), acc_t(end));
    
    mask_signal = (raw_time >= t_start) & (raw_time <= t_end);
    common_signal = raw_signal(mask_signal);
    common_t = raw_time(mask_signal);
    
    acc = interp1(acc_t, acc_mag, common_t, 'linear', 'extrap');
    
    %% 1. DC remove and Detrending
    % Detrending
    clean_signal = detrend(common_signal);
    
    % DC Remove
    clean_signal = clean_signal - mean(clean_signal);
    
    %% 2. Band-Pass Filter
    fc_low = 0.05;
    fc_high = 1;
    filter_order = 2;
    
    [b, a] = butter(filter_order, [fc_low, fc_high]/(raw_fs/2), 'bandpass');
    
    bpf_signal = filtfilt(b, a,clean_signal);

    %% 3. Downsampling
    new_fs = 16;
    resample_signal = resample(bpf_signal, new_fs, raw_fs);
    resample_acc = resample(acc, new_fs, raw_fs);
    N = length(resample_signal);
    resample_time = (0:N-1)/new_fs;

    %% 4. Update Sturcure
    subject_struct.acc.acc_x = acc_x;
    subject_struct.acc.acc_y = acc_y;
    subject_struct.acc.acc_z = acc_z;
    subject_struct.acc.acc_mag = acc;
    subject_struct.acc.acc_t = common_t;

    subject_struct.preprocess.signal = resample_signal;
    subject_struct.preprocess.time = resample_time;
    subject_struct.preprocess.fs = new_fs;
end
function subject_struct = FilterLMSGUI(subject_struct, M, mu)

    signal = subject_struct.preprocess.signal;
    acc = subject_struct.acc.acc_mag;

    %% LMS Filter
    signal_ref = zscore(signal);
    signal_ref = signal_ref(:);
    acc_ref = zscore(acc);
    acc_ref = acc_ref(:);
    
    
    N = length(signal_ref);
    y = zeros(N,1);
    e = zeros(N,1);
    w = zeros(M,1);
    
    for n = M:N
        x = acc_ref(n:-1:n-M+1);
        y(n) = w' * x;
        e(n) = signal_ref(n)-y(n);
        w = w+2*mu*e(n)*x;
    end
    
    lms_signal = e;

    %% Update Subject Structure
    subject_struct.preprocess.signal = lms_signal;
end

function subject_struct = EventTagGUI(subject_struct)
    subject = subject_struct.traildata.Subject;
    session = subject_struct.traildata.Session;
    condition = subject_struct.traildata.Condition;
    test = subject_struct.traildata.Test;

    time = subject_struct.raw.raw_time;
    signal = subject_struct.raw.raw_signal;
    fs = subject_struct.raw.raw_fs;
    %% Read txt File
    file = "C:\Users\תבל\Desktop\Tevel Zamir\1. BioMedical Engineering\4th Year\Final Project\Data\MatlabData_Vers2\0. Unprocessed Data\" + subject + "\Dflow\" + session + "\" + condition + "\" + subject + "_CTT_" + test + "_EC_";
    events = readtable(file);
    event_time = double(events.Time);
    event_count = cellstr(string(events.Count));
    event_label = events.Event;

    %% Update Signal Time
    start_idx = find(strcmp(event_count, "1") & strcmp(event_label, "correct"));
    start_time = event_time(start_idx);
    end_idx = find(strcmp(event_count, "25") & strcmp(event_label, "correct"));
    end_time = event_time(end_idx);

    event_count = event_count(start_idx:end_idx);
    event_label = event_label(start_idx:end_idx);
    event_time = event_time(start_idx:end_idx);
    event_time = event_time - start_time;

    event_data = table(event_count, event_label, event_time);

    [~, signal_start_idx] = min(abs(time - start_time));
    [~, signal_end_idx] = min(abs(time - end_time));

    time = time(signal_start_idx:signal_end_idx);
    time = time - time(1);

    signal = signal(signal_start_idx:signal_end_idx);

    %% Update Subject Struct
    subject_struct.event_data = event_data;
    subject_struct.raw.raw_signal = signal;
    subject_struct.raw.raw_time = time;

    %% Plot the events
    figure('Visible','off');
    plot(time, signal);
    xlabel("Time [Sec]");
    ylabel("Resipration");
    xlim([0 time(end)]);
    title(subject + " " + condition + " " + "Signal with Events");
    hold on
    for i = 1:length(event_time)
        xline(event_time(i), "Color", "Red", "LineWidth", 1);
        text(event_time(i), min(signal), event_label{i}, 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 10, 'Color', 'black');
        text(event_time(i), min(signal)+0.1, event_count{i}, 'HorizontalAlignment', 'center', 'FontSize', 10, 'Color', 'black');
    end

end
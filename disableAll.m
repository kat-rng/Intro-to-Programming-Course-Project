function disableAll(enableComponent)
    % Disables all buttons and components within the input array. Enables
    % the additional component
    global allButtons
    [~, x] = size(allButtons);
    for i = 1:x
        allButtons(i).Enable = 'off';
    end
    enableComponent.Enable = 'on';
end
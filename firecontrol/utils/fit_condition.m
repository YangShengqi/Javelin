function A = fit_condition(vm, vt, hm, ht)
    A = [1; vm; vt; hm; ht; vm^2; vm*vt; vm*hm; vm*ht; vt^2; vt*hm; vt*ht;
         hm^2; hm*ht; ht^2];
    A = A';
end
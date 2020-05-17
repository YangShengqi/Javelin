function coe = cal_coe(loadMatName, condition_num, qsj_num, vm_idx, vt_idx, hm_idx)
    loadVar = load(loadMatName);
    key = loadVar.key;
    rvalue = loadVar.rvalue;
    sample_num = length(vm_idx)*length(vt_idx)*length(hm_idx)*length(ht_idx);
    key_ = zeros(sample_num, condition_num);
    rvalue_ = zeros(sample_num, qsj_num);
    coe = zeros(qsj_num, condition_num);
    
    sample_i = 1;
    for vm = vm_idx
        for vt = vt_idx
            for hm = hm_idx
                for ht_i = 1:1:7
                   key_(sample_i, :) = key{vm_idx==vm, vt_idx==vt, hm_idx==hm, ht_i};
                   rvalue_(sample_i, :) = rvalue{vm_idx==vm, vt_idx==vt, hm_idx==hm, ht_i};
                   sample_i = sample_i + 1;
                end
            end
        end
    end
    
    for qsj_i = 1 : qsj_num
        Y = rvalue_(:, qsj_i)./1000;
        H = key_;
        coe(qsj_i, :) = LS_fit(Y, H);
    end
end
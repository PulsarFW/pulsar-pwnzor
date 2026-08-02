function RegisterEvents()
    CreateThread(function()
        plsr.Callbacks:ServerCallback('Pwnzor:GetEvents', {}, function(e)
            for k, v in ipairs(e) do
                AddEventHandler(v, function()
                    plsr.Callbacks:ServerCallback('Pwnzor:Trigger', {
                        check = v,
                        match = v,
                    }, function(s)
                        CancelEvent()
                        return
                    end)
                end)
            end
        end)
    end)
end
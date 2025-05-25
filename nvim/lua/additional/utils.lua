local M = {}
function M.stop_insert()
    vim.schedule(
        function()
            vim.cmd("stopinsert")
        end
    )
end

function M.call_with_normal(fn)
    return function(...)
        local result = fn(...)
        M.stop_insert()
        return result
    end
end

return M

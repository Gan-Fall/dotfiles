months = {'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September',
    'October', 'November', 'December'}
widget = {
    plugin = 'timer',
    cb = function()
        local d = os.date('*t')
        return {
            string.format('  %d %s', d.day, months[d.month]),
            string.format('  %d:%02d:%02d', d.hour, d.min, d.sec),
        }
    end,
}

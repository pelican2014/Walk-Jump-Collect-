local FinishCollecting = {}

function FinishCollecting:load()
  self._pre = nil
end

function FinishCollecting:update()
  if Diamond.num == 0 and self._pre ~= 0 then
    Signal.emit('finishCollecting')
  end
  self._pre = Diamond.num
end

return FinishCollecting
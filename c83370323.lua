--トラパート
---@param c Card
function c83370323.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_EVENT_PLAYER)
	e1:SetCondition(c83370323.con)
	e1:SetOperation(c83370323.op)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(c83370323.synlimit)
	c:RegisterEffect(e2)
end
function c83370323.con(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_SYNCHRO
end
function c83370323.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sync=c:GetReasonCard()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c83370323.aclimit)
	e1:SetCondition(c83370323.actcon)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	sync:RegisterEffect(e1,true)
end
function c83370323.aclimit(e,re,tp)
	return re:GetHandler():IsType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c83370323.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
function c83370323.synlimit(e,c)
	if not c then return false end
	return not c:IsRace(RACE_WARRIOR)
end

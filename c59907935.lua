--サイバーデーモン
---@param c Card
function c59907935.initial_effect(c)
	--chk
	local ge1=Effect.CreateEffect(c)
	ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	ge1:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	ge1:SetOperation(c59907935.drchk)
	Duel.RegisterEffect(ge1,0)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(59907935,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_DRAW)
	e1:SetCondition(c59907935.drcon)
	e1:SetTarget(c59907935.drtg)
	e1:SetOperation(c59907935.drop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(59907935,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCondition(c59907935.descon)
	e2:SetTarget(c59907935.destg)
	e2:SetOperation(c59907935.desop)
	c:RegisterEffect(e2)
end
function c59907935.drchk(e,tp,eg,ep,ev,re,r,rp,c)
	if Duel.GetFieldGroupCount(ep,LOCATION_HAND,0)==0 then
		Duel.RegisterFlagEffect(ep,59907935,RESET_PHASE+PHASE_END,0,1)
	end
end
function c59907935.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(ep,59907935)~=0 and ep==tp and r&REASON_RULE==REASON_RULE
end
function c59907935.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c59907935.drop(e,tp,eg,ep,ev,re,r,rp,c)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c59907935.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0
end
function c59907935.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c59907935.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.Destroy(c,REASON_EFFECT)
	end
end

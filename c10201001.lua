local cm,m,o=GetID()
function cm.initial_effect(c)
	vgf.VgCard(c)
	vgf.AddRideMaterialCode(c,m,10406013)
	vgf.AddRideMaterialSetCard(c,m,0xc014,0x74)
	vgd.EffectTypeContinuousChangeAttack(c,EFFECT_TYPE_SINGLE,5000,cm.con)
	vgd.EffectTypeTrigger(c,m,LOCATION_MZONE,EFFECT_TYPE_SINGLE,EVENT_ATTACK_ANNOUNCE,cm.op,cm.cost,vgf.VMonsterCondition)
end
function cm.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(FLAG_SUPPORTED)>0 and Duel.GetAttacker()==e:GetHandler() and vgf.RMonsterCondition(e)
end
function cm.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return vgf.OverlayCost(1)(e,tp,eg,ep,ev,re,r,rp,chk) and vgf.DisCardCost(1)(e,tp,eg,ep,ev,re,r,rp,chk) end
	vgf.OverlayCost(1)(e,tp,eg,ep,ev,re,r,rp,chk)
	vgf.DisCardCost(1)(e,tp,eg,ep,ev,re,r,rp,chk)
end
function cm.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=vgf.GetMatchingGroup(cm.filter,tp,LOCATION_MZONE,0,nil)
    Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
	for tc in vgf.Next(g) do
    tc:RegisterFlagEffect(FLAG_SUPPORT,RESET_EVENT+RESETS_STANDARD,0,1)
	end
    c:RegisterFlagEffect(FLAG_SUPPORTED,RESET_EVENT+RESETS_STANDARD,0,1)
    Duel.RaiseEvent(g,EVENT_CUSTOM+EVENT_SUPPORT,e,0,tp,tp,0)
end
function cm.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsAttribute(SKILL_SUPPORT) and vgf.RMonsterFilter(c)
end
local cm,m,o=GetID()
function cm.initial_effect(c)
	vgf.VgCard(c)
	vgd.CardToG(c,nil,cm.op)
end
function cm.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MONSTER)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		if vgf.RMonsterFilter(tc) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetValue(1)
			tc:RegisterEffect(e1)
			vgf.EffectReset(c,e1,EVENT_BATTLED)
		elseif vgf.VMonsterFilter(tc) then
			tc:RegisterFlagEffect(DefenseEntirelyFlag,RESET_EVENT+RESETS_STANDARD,0,1)
		end
	end
	local sg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if sg:GetCount()>=2 then
		sg=sg:FilterSelect(tp,Card.IsDiscardable,1,1,nil,REASON_EFFECT)
		Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
	end
end
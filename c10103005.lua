--激烈的魔女 拉玛娜
local cm,m,o=GetID()
function cm.initial_effect(c)
    VgF.VgCard(c)
    --【自】【R】：这个单位攻击时，通过【费用】[计数爆发1]，这次战斗中，这个单位的力量+5000。
    vgd.EffectTypeTrigger(c,m,LOCATION_MZONE,EFFECT_TYPE_SINGLE,EVENT_ATTACK_ANNOUNCE,cm.operation,DamageCost(1),RMonsterCondition)
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    VgF.AtkUp(c,c,5000,nil)
end
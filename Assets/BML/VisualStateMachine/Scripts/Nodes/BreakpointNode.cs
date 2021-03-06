using System.Collections;
using System.Collections.Generic;
using MyAssets.ScriptableObjects.Variables;
using Sirenix.OdinInspector;
using UnityEngine;

public class BreakpointNode : StateNode
{
    [HideIf("$collapsed")] [LabelWidth(LABEL_WIDTH)] [TextArea] [SerializeField] private string Message = "";


    public override void Enter()
    {
        base.Enter();
        Debug.LogError(Message);
    }
}

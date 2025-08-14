using UnityEngine;

[ExecuteAlways]
public class HealthBar : MonoBehaviour
{
    public float health;
    
    void Update()
    {
        //health = Mathf.Clamp(health, 0, 1);

        MaterialPropertyBlock props = new MaterialPropertyBlock();
        if (props.GetFloat("_Health") != health)
        {
            MeshRenderer renderer;
            
            props.SetFloat("_Health", health);

            renderer = GetComponent<MeshRenderer>();
            renderer.SetPropertyBlock(props);
        }
    }
}

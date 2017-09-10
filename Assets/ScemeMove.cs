using UnityEngine;  
using System.Collections;  

public class ScemeMove : MonoBehaviour {  
	private Vector3 rota;  
	public float x_speed = 50f;  
	public float y_speed = 50f;  
	public float m_speed = 10f;  
	public float f_speed = 10f;  
	public float h_speed = 1f;  
	public float v_speed = 1f;
	public float groundDis = 5f;  
	public float skyDis = 50f;  
	public Camera camera;  
	// Use this for initialization  
	void Start () {  
		camera = Camera.main;  
		rota = camera.transform.eulerAngles;  
	}  

	// Update is called once per frame  
	void Update () {  
		//鼠标右键  
		if(Input.GetMouseButton(1)){  
			rota.y += Input.GetAxis ("Mouse X") * x_speed;  
			rota.x -= Input.GetAxis ("Mouse Y") * y_speed;  
			Quaternion q = Quaternion.Euler (rota);  
			camera.transform.rotation = q;  
		}  
		//滚轮滑动  
		float middle = Input.GetAxis ("Mouse ScrollWheel");  

		camera.transform.position += -camera.transform.up * middle * m_speed + (camera.transform.forward * middle * f_speed);  

		//空格  
		if(Input.GetKey(KeyCode.Space)){  
			middle = -0.1f;  
			camera.transform.position += -camera.transform.up * middle * m_speed + (camera.transform.forward * middle * f_speed);  
		}  

		//WASD  
		float h = Input.GetAxis ("Horizontal");  
		float v = Input.GetAxis ("Vertical");  
		camera.transform.position += camera.transform.right * h * h_speed;  
		camera.transform.position += camera.transform.forward * v * v_speed;
		clamp ();  

	}  

	private void clamp(){  
		Vector3 upUp;  
		upUp = camera.transform.position;  
		upUp.y = Mathf.Clamp (upUp.y,groundDis,skyDis);  
		camera.transform.position = upUp;  
	}  
}
//
//  AcuerdoPrivVC.swift
//  MallConcierge
//
//  Created by Rodrigo Sánchez on 20/11/20.
//

import UIKit
import WebKit

class AcuerdoPrivVC: UIViewController {
    
    var acepto: Int = 0
    
    @IBOutlet weak var acuerdoHTML: WKWebView!
    
    override func viewDidLoad() {
        
        let spinningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        spinningActivity?.labelText = "Configurando"
        spinningActivity?.detailsLabelText = "un momento por favor"
        
        super.viewDidLoad()
        
        let html = """
        <p style="text-align: center;"><strong>AVISO DE PRIVACIDAD</strong></p>
        <p style="text-align: justify;"><strong>Compañía Integradora Inmobiliaria, S.C.</strong>  (con domicilio en Av. Ejército Nacional 843-B, Corporativo Antara II, Piso 3, Col Granada, Alcaldía Miguel Hidalgo C.P. 11000, Ciudad de México) (en lo sucesivo el “<u>Responsable</u>”) es el responsable del tratamiento de los datos personales que cualquier visitante (en lo sucesivo el “<u>Visitante</u>”) llegase a proporcionar con motivo de la visita/ trámite o gestión efectuada dentro de los centros comerciales que se enlistan en el Anexo I (en lo sucesivo “<u>Centro Comercial)</u>.</p>
        <p style="text-align: justify;">En estricto cumplimiento a lo establecido en la Ley Federal de Protección de Datos Personales en Posesión de los Particulares (la “<u>Ley</u>”), el Responsable hace del conocimiento del Visitante lo siguiente:</p>

        <ol style="text-align: justify;">
            <li><strong> </strong>Qué información o datos recopilamos?</li>
        </ol>
        <p style="text-align: justify;">Los Datos Personales que Usted, de manera libre y voluntaria, proporcione personalmente al Responsable a través del módulo de Concierge del Centro Comercial, podrán incluir, entre otros, los siguientes: nombre, domicilio, correo electrónico, teléfono, tickets de compra, artículos adquiridos en el Centro Comercial y tiendas visitadas.</p>

        <ol start="2" style="text-align: justify;">
            <li><strong> </strong>¿Qué uso se le da a esta información?</li>
        </ol>
        <p style="text-align: justify;">Los Datos Personales recopilados, se utilizan únicamente para efectos de incorporarlos para su uso en las actividades del plan de lealtad del Centro Comercial.</p>

        <ol start="3" style="text-align: justify;">
            <li><strong> </strong>¿Con quién compartimos su información y bajo qué términos?</li>
        </ol>
        <p style="text-align: justify;">Sus Datos Personales pueden ser transferidos y tratados, sin fines comerciales, dentro y fuera del país, por personas distintas al Responsable.</p>
        <p style="text-align: justify;">En ningún caso comercializaremos, venderemos o rentaremos su información personal a un tercero sin contar con su consentimiento previo. Si usted no manifiesta su oposición para que sus Datos Personales sean transferidos, se entenderá que ha otorgado su consentimiento para ello.</p>

        <ol start="4" style="text-align: justify;">
            <li><strong> </strong>¿Qué medidas de seguridad y control utilizamos para la protección de sus Datos Personales?</li>
        </ol>
        <p style="text-align: justify;">El Responsable tiene implementadas medidas de seguridad administrativas, técnicas y físicas para proteger sus Datos Personales, mismas que igualmente exigimos sean cumplidas por los proveedores de servicios que contratamos, inclusive tratándose de servicios que prestan las empresas subsidiarias o afiliadas del Responsable. Toda la información agregada y datos personales que se obtengan de usted, constituirán una base de datos propiedad del Responsable, información que es almacenada con el fin de protegerla y evitar su pérdida, uso indebido, o alteración.</p>

        <ol start="5" style="text-align: justify;">
            <li><strong> </strong>¿Cuál es el área responsable del manejo y administración de Datos Personales?</li>
        </ol>
        <p style="text-align: justify;">El área responsable del manejo y administración de sus Datos Personales es la oficina de mercadotecnia del centro comercial, misma que puede ser contactada mediante correo electrónico, a la dirección <a href="mailto:cvallejo@antara.com.mx">(correo</a> electrónico), o físicamente en las instalaciones del Responsable, ubicadas en Avenida Ejército Nacional 843-B, Corporativo Antara II, Piso 3,  Colonia Granada, Ciudad de México, Alcaldía Miguel Hidalgo, C.P. 11000.</p>

        <ol start="6" style="text-align: justify;">
            <li><strong> </strong>¿Cómo puede Usted ejercer sus derechos de Acceso, Rectificación, Cancelación y Oposición (“Derechos ARCO”)?</li>
        </ol>
        <p style="text-align: justify;">De conformidad con lo establecido en el artículo 28 de la Ley, Usted tiene el derecho de solicitar al Responsable, en cualquier momento el acceso a sus Datos Personales, la rectificación de los mismos en caso de ser estos inexactos o incompletos, la cancelación en el uso de sus datos cuando considere que están siendo usados para finalidades no consentidas o la oposición al tratamiento de los datos para fines de brindar protección a su esfera personal íntima.</p>
        <p style="text-align: justify;">Los mecanismos que se han implementado para el ejercicio de sus Derechos ARCO son a través de la presentación de la solicitud respectiva, poniendo a su disposición el siguiente mecanismo para realizar el trámite:</p>

        <ol type="a">
            <li><strong> </strong>Dirigirse a la oficina de mercadotecnia-privacidad</li>
            <li><strong> </strong>Indicar al responsable de área que desea realizar alguna rectificación, cancelación u oposición a sus Datos Personales.</li>
            <li><strong> </strong>Acreditar su identidad mostrando una identificación oficial vigente con fotografía.</li>
            <li><strong> </strong>Firmar el formato correspondiente, mismo que será llenado por el responsable del área, en donde asentará la rectificación, cancelación y oposición a los Datos Personales que Usted solicite y al cabo de 3 (tres) días hábiles estos se verán reflejados en el sistema.</li>
            <li><strong> </strong>Si Usted lo desea puede recibir un email de confirmación de que la modificación solicitada fue llevada a cabo, para lo cual sólo deberá indicar a que cuenta de correo desea recibir el aviso.</li>
            <li><strong> </strong>Modificaciones al Aviso de Privacidad.</li>
        </ol>
        <p style="text-align: justify;">Nos reservamos el derecho de efectuar en cualquier momento modificaciones o actualizaciones al presente Aviso de Privacidad, para cumplir en todo momento con las disposiciones legales aplicables, políticas internas o nuevos requerimientos para la prestación u ofrecimiento de nuestros servicios. Estas modificaciones estarán disponibles al público a través de los siguientes medios:</p>
        <p style="text-align: justify;">Para consulta, por escrito en la oficina de Privacidad del área de Mercadotecnia</p>
        <p style="text-align: justify;">Si Usted considera que en algún momento su derecho de protección de Datos Personales ha sido lesionado por cualquier conducta de nuestros empleados o por nuestras actuaciones o respuestas, o presume que en el tratamiento de sus Datos Personales existe alguna violación a las disposiciones previstas en la Ley, podrá interponer la queja o denuncia correspondiente ante el Instituto Nacional de Transparencia Acceso a la Información y Protección de Datos Personales. Para más información, puede dirigirse al sitio <a href="http://www.inai.org.mx">www.inai.org.mx</a>.</p>
        <p style="text-align: justify;">Fecha de última actualización de este Aviso de Privacidad: 01/11/2020.</p>
        <p style="text-align: justify;"><u>Responsable</u>:</p>
        <p style="text-align: justify;"><strong><u>Compañía Integradora Inmobiliaria, S.C.</u></strong></p>
        <p style="text-align: justify;">ANEXO I</p>
        <p style="text-align: justify;">-Centro Comercial Artz Pedregal</p>
        <p style="text-align: justify;">-Centro Comercial Angelópolis</p>
        <p style="text-align: justify;">-Centro Comercial Andamar</p>
        <p style="text-align: justify;">-Centro Comercial Antara Fashion Hall</p>
        <p style="text-align: justify;">-Antea Life Style Center</p>
        <p style="text-align: justify;">-Centro Comercial Luxury Hall</p>
        """
        acuerdoHTML.loadHTMLString(html, baseURL: nil)
        spinningActivity?.hide(true)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func returnBtn(_ sender: Any) {
        
        let acepta:Int = 1
        
        UserDefaults.standard.set(acepta, forKey: "acepta")
        UserDefaults.standard.synchronize()
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelaBtn(_ sender: Any){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

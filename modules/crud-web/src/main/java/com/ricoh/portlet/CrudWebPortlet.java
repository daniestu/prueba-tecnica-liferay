package com.ricoh.portlet;

import com.ricoh.constants.CrudWebPortletKeys;
import com.ricoh.model.Usuario;
import com.ricoh.service.UsuarioLocalServiceUtil;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.liferay.captcha.util.CaptchaUtil;
import com.liferay.counter.kernel.service.CounterLocalServiceUtil;
import com.liferay.mail.kernel.model.MailMessage;
import com.liferay.mail.kernel.service.MailServiceUtil;
import com.liferay.portal.kernel.captcha.CaptchaException;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.ParamUtil;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.ProcessAction;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;

/**
 * @author Daniel Estupiña
 */
@Component(
	immediate = true,
	property = {
		"com.liferay.portlet.display-category=category.sample",
		"com.liferay.portlet.header-portlet-css=/css/main.css",
		"com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=CrudWeb",
		"javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view.jsp",
		"javax.portlet.name=" + CrudWebPortletKeys.CRUDWEB,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user"
	},
	service = Portlet.class
)
public class CrudWebPortlet extends MVCPortlet {
	
	@ProcessAction(name="add")
    public void add(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
		
		Usuario usuario = UsuarioLocalServiceUtil.createUsuario(CounterLocalServiceUtil.increment(Usuario.class.getName()));
		
		Date fecha = null;
		
		try {
			fecha = formatoFecha.parse(ParamUtil.getString(actionRequest, "fecha_nac"));
			CaptchaUtil.check(actionRequest);
		} catch (Exception e) {
			if(e instanceof CaptchaException) {
                SessionErrors.add(actionRequest, e.getClass(), e);
            }else {
            	throw new IOException("Fecha incorrecta",e);
            }
			
		}
		
		usuario.setNombre(ParamUtil.getString(actionRequest, "nombre"));
		usuario.setApellidos(ParamUtil.getString(actionRequest, "apellidos"));
		usuario.setCorreo(ParamUtil.getString(actionRequest, "correo"));
		usuario.setFecha_nac(fecha);
		
		UsuarioLocalServiceUtil.addUsuario(usuario);
		
		enviarEmail(usuario);
		
		SessionMessages.add(actionRequest, "success");
    }
	
	@ProcessAction(name="getAll")
	public void getAll(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		final List<Usuario> usuarios = UsuarioLocalServiceUtil.getUsuarios(0, UsuarioLocalServiceUtil.getUsuariosCount());
		
		actionRequest.setAttribute("usuarios", usuarios);
		
		actionResponse.getRenderParameters().setValue("jspPage","/show-users.jsp");
	}
	
	@ProcessAction(name="remove")
	public void remove(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		Long id = ParamUtil.getLong(actionRequest, "idSelected");
		
		try {
			UsuarioLocalServiceUtil.deleteUsuario(id);
		} catch (PortalException e) {
			e.printStackTrace();
		}
		
		SessionMessages.add(actionRequest, "success");
		
		getAll(actionRequest, actionResponse);
	}
	
	@ProcessAction(name="update")
	public void update(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
		
		String nombre = ParamUtil.getString(actionRequest, "nombre");
		String apellidos = ParamUtil.getString(actionRequest, "apellidos");
		String correo = ParamUtil.getString(actionRequest, "correo");
		long id = ParamUtil.getLong(actionRequest, "id");
	
		Date fecha = null;
		
		try {
			fecha = formatoFecha.parse(ParamUtil.getString(actionRequest, "fecha"));
		} catch (Exception e) {
            throw new IOException("Fecha incorrecta",e);
		}
		
		try {
			Usuario usuario = UsuarioLocalServiceUtil.getUsuario(id);
			usuario.setNombre(nombre);
			usuario.setApellidos(apellidos);
			usuario.setCorreo(correo);
			usuario.setFecha_nac(fecha);
			
			UsuarioLocalServiceUtil.updateUsuario(usuario);
		} catch (PortalException e) {
			e.printStackTrace();
		}
		
		SessionMessages.add(actionRequest, "success");
		
		getAll(actionRequest, actionResponse);
	}
	
	private void enviarEmail(Usuario usuario) {
		try {
			InternetAddress fromAdress = new InternetAddress("destupina97@gmail.com");
			InternetAddress toAdress = new InternetAddress(usuario.getCorreo());
			
			MailMessage mailMessage = new MailMessage();
			mailMessage.setHTMLFormat(true);
			mailMessage.setTo(toAdress);
			mailMessage.setFrom(fromAdress);
			mailMessage.setSubject("Nuevo usuario");
			mailMessage.setBody("Nuevo usuario registrado.<br>correo: " + usuario.getCorreo() + "<br>Nombre: " + usuario.getNombre() + " " + usuario.getApellidos());
			
			MailServiceUtil.sendEmail(mailMessage);
		} catch (AddressException e) {
			e.printStackTrace();
		}
	}

	@Override
    public void serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
        throws  IOException, PortletException {
        try {
            CaptchaUtil.serveImage(resourceRequest, resourceResponse);
        }catch(Exception e) {
            throw new IOException(e);
        }
    }
	
	protected boolean isCheckMethodOnProcessAction() {
        return _CHECK_METHOD_ON_PROCESS_ACTION;
    }
 
    private static final boolean _CHECK_METHOD_ON_PROCESS_ACTION = false;
}
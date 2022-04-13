<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %><%@
taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %><%@
taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %><%@
taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ricoh.model.Usuario" %>

<liferay-theme:defineObjects />

<portlet:defineObjects />

<portlet:renderURL var="addUserUrl">
	<portlet:param name="mvcPath" value="/view.jsp" />
</portlet:renderURL>
<portlet:renderURL var="deleteUserUrl">
	<portlet:param name="mvcPath" value="/remove-user.jsp" />
</portlet:renderURL>

<portlet:actionURL name="getAll" var="getAll"></portlet:actionURL>
<div class="container">
	<c:set var="titulo"><liferay-ui:message key="crudweb.titulo"/></c:set>
	<c:set var="nuevo"><liferay-ui:message key="crudweb.nuevo"/></c:set>
	<c:set var="mostrar"><liferay-ui:message key="crudweb.mostrar"/></c:set>
	<c:set var="eliminar"><liferay-ui:message key="crudweb.eliminar"/></c:set>
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary" id="navbar">
		<a class="navbar-brand" href="#">${titulo}</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="#navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
	
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="<%= addUserUrl %>">${nuevo}<span
						class="sr-only">(current)</span></a></li>
				<li class="nav-item"><a class="nav-link" href="<%= getAll %>">${mostrar}</a></li>
				<li class="nav-item"><a class="nav-link" href="<%= deleteUserUrl %>">${eliminar}</a></li>
			</ul>
	
		</div>
	</nav>
</div>
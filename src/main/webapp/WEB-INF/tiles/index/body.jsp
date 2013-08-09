<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<spring:url value="/resources/bootstrap" var="bootstrap" />
<spring:url value="/login-process" var="loginUrl" />
<spring:url value="/logout" var="logoutUrl" />

<sec:authorize ifAnyGranted="ROLE_ANONYMOUS">
	<c:set var="username">
		<c:url value="guest" />
	</c:set>
</sec:authorize>

<sec:authorize ifNotGranted="ROLE_ANONYMOUS">
	<c:set var="username">
		<c:url value="${user.username}" />
	</c:set>
	<c:set var="loggedIn" value="true" />
</sec:authorize>

<spring:message var="siteTitle" code="site.title" />
<spring:message var="indexTitle" code="index.title" />
<spring:message var="indexDescription" code="index.description" />
<spring:message var="login" code="login"  />
<spring:message var="welcome" code="welcome" arguments="${username}" />
<spring:message var="formUsername" code="index.login.form.username" />
<spring:message var="formPassword" code="index.login.form.password" />
<spring:message var="formSubmit" code="index.login.form.submit" />

<c:if test="${empty loggedIn}">
	<div class="row">
		<div class="col-lg-1"></div>
		<div class="col-lg-8">
			<h1>${indexTitle}</h1>
			<h5>${indexDescription}</h5>
		</div>
		<div class="col-lg-2">
			<form action="${loginUrl}" method="POST">
				<fieldset>
					<legend>${login}</legend>
					<c:if test="${not empty param.loginError}">
						<div class="form-group col-lg-12">
							<p class="text-danger">${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}</p>
						</div>
					</c:if>
					<div class="form-group col-lg-12">
						<label for="j_username">${formUsername}</label> <input type="text"
							class="form-control" id="j_username" name="j_username"
							placeholder="Username">
					</div>
					<div class="form-group col-lg-12">
						<label for="j_password">${formPassword}</label> <input
							type="password" class="form-control" id="j_password"
							name="j_password" placeholder="Password">
					</div>
					<button type="submit"
						class="btn btn-default col-lg-8 col-lg-offset-2">${formSubmit}</button>
				</fieldset>
			</form>
		</div>
		<div class="col-lg-1"></div>
	</div>
</c:if>





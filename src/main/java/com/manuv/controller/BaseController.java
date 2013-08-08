package com.manuv.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.manuv.persistence.entities.User;


/**
 * @author emanuele.ivaldi@gmail.com
 *
 */
public class BaseController {

	/*
	 * LIST OF ALL THE ROUTES HANDLED BY THE WEBAPP
	 * */
	protected final static String INDEX_ROUTE = "/";
	protected final static String PAGE_NOT_FOUND_ROUTE = "/page-not-found";
	protected final static String EXCEPTION_HANDLED_ROUTE = "/exception";
	
	/*
	 * LIST OF ALL THE VIEWS HANDLED BY THE WEBAPP
	 * */
	protected final static String INDEX_VIEW = "index";
	protected final static String PAGE_NOT_FOUND_VIEW = "page_not_found";
	protected final static String EXCEPTION_HANDLED_VIEW = "exception_handled";
	
	
	/**
	 * Catch all the exceptions (exceptions and its subclasses)
	 * @param exception
	 * @param request
	 * @return the view "exceptionHandler.jsp"
	 */
	@ExceptionHandler(Exception.class)
	protected String exceptionHandler(Exception exception, HttpServletRequest request) {

		logger.debug("exception caught by the exception handler");

		request.setAttribute("exception", exception);
		logger.error("exception handled", exception);

		return EXCEPTION_HANDLED_VIEW;
	}

	/**
	 * @return the current user if he's logged in, null otherwise
	 */
	public User getCurrentUser() {

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (User.class.isAssignableFrom(principal.getClass())) {

			return (User) principal;
		}

		return null;
	}

	@Autowired
	protected MessageSource messageSource;

	private static final Logger logger = LoggerFactory.getLogger(BaseController.class);

}

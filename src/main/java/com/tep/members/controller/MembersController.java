package com.tep.members.controller;

import java.util.Enumeration;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.tep.commons.common.TepConstants;
import com.tep.members.model.MembersModel;
import com.tep.members.service.MembersService;
import com.tep.members.validator.LoginValidator;
import com.tep.members.validator.RegisterValidator;

@Controller
public class MembersController {
	protected Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "membersService")
	private MembersService membersService;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String accountForm() {
		return "accountForm";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login(@ModelAttribute("login") MembersModel mem, BindingResult bindingResult, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();

		MembersModel result = membersService.selectMembersLogin(mem);
		new LoginValidator().validate(mem, bindingResult);
		if(bindingResult.hasErrors()){
			mv.setViewName("accountForm");
			return mv;
		} else if (membersService.selectMEmailMembers(mem.getM_email()) == null) {
			bindingResult.rejectValue("m_email", "login.email.notfound");
			mv.setViewName("accountForm");
			return mv;
		} else if(result == null){
			bindingResult.rejectValue("m_password", "login.password.invalid");
			mem.setM_password("");
			mv.setViewName("accountForm");
			return mv;
		}

		session.setAttribute(TepConstants.M_EMAIL, result.getM_email());
		session.setAttribute(TepConstants.M_NAME, result.getM_name());
		session.setAttribute(TepConstants.M_NO, result.getM_no());

		mv.setViewName("loginSuccess");
		return mv;
	}

	@RequestMapping(value = "/logout")
	public ModelAndView logout(MembersModel mem, HttpSession session) throws Exception {
		Enumeration<?> valueNames = session.getAttributeNames();
		while (valueNames.hasMoreElements()) {
			String sessionKey = (String) valueNames.nextElement();
			log.debug("remove sessionKey : " + sessionKey);
			session.removeAttribute(sessionKey);
		}

		session.invalidate();
		return new ModelAndView("redirect:/main");
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public ModelAndView insertMembers(@ModelAttribute("mem") MembersModel mem, BindingResult bindingResult, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		new RegisterValidator().validate(mem, bindingResult);
		if (membersService.selectMEmailMembers(mem.getM_email()) != null) {
			bindingResult.rejectValue("m_email", "reg.email.duplication");
		}
		
		if(bindingResult.hasErrors()){
			mv.setViewName("accountForm");
			return mv;
		}

		MembersModel m = membersService.insertMembers(mem);
		if (m != null) {
			session.setAttribute(TepConstants.M_EMAIL, m.getM_email());
			session.setAttribute(TepConstants.M_NAME, m.getM_name());
			session.setAttribute(TepConstants.M_NO, m.getM_no());
		}

		mv.setViewName("registerSuccess");
		return mv;
	}

	@RequestMapping(value = "/find/account", method = RequestMethod.GET)
	public String findAccount() {
		return "findAccount";
	}

	@RequestMapping(value = "/find/account/email", method = RequestMethod.POST)
	public ModelAndView findAccountEmail(@ModelAttribute("email") MembersModel mem, BindingResult bindingResult) throws Exception {
		ModelAndView mv = new ModelAndView();

		MembersModel m = membersService.selectFindEmail(mem);

		if (m == null || StringUtils.isBlank(m.getM_email())) {
			mv.setViewName("error/errorMemberFindEmail");
			return mv;
		} else {
			mv.addObject("email", m.getM_email());
			mv.setViewName("members/membersFindEmailResult");
			return mv;
		}
	}

	@RequestMapping(value = "/find/account/pw", method = RequestMethod.POST)
	public ModelAndView findAccountPassword(@ModelAttribute("pw") MembersModel mem, BindingResult bindingResult) throws Exception {
		ModelAndView mv = new ModelAndView();

		MembersModel m = membersService.selectFindPassword(mem);

		if (m == null || StringUtils.isBlank(m.getM_password())) {
			mv.setViewName("error/errorMemberFindPassword");
			return mv;
		} else {
			mv.addObject("password", m.getM_password());
			mv.setViewName("members/membersFindPasswordResult");
			return mv;
		}

	}
	
}

package ${restful.packageName};

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.HashMap;

import nju.software.sjjhpt.okhttp.OkHttpUtils;
import nju.software.sjjhpt.okhttp.callback.FileCallBack;

/**
 * @author
 * @date ${date}
 * @version V1.0
 */
public class ${restful.className} {

	private final String baseUrl = "${restful.baseUrl}";
	
	<#list restful.restfulMethods as method>
	private final String ${method.name}Url = baseUrl + "/${method.url}";
	</#list>
	<#list restful.restfulMethods as method>
	<#if method.type=='get'>
	
	public <#if method.returnType??>${method.returnType}<#else>void</#if> ${method.name}(<#list method.restfulParameters as parameter >String ${parameter.name}<#if parameter_index!=(method.restfulParameters?size-1)>,</#if></#list>) throws IOException {
		Map<String, String> params = new HashMap<>();
		<#list method.restfulParameters as parameter>	
		<#if parameter.type=='String'>
		params.put("${parameter.name}", ${parameter.name});
		</#if>
		</#list>
		<#if method.returnType??>String result = OkHttpUtils.get().url(${method.name}Url).params(params).build().executeString();
		return result;
	}
		<#else>OkHttpUtils.get().url(${method.name}Url).params(params).build().executeString();
	}
		</#if>
	
	<#elseif method.type=='post'>
	public <#if method.returnType??>${method.returnType}<#else>void</#if> ${method.name}(<#list method.restfulParameters as parameter >String ${parameter.name}<#if parameter_index!=(method.restfulParameters?size-1)>,</#if></#list>) throws IOException {
		Map<String, String> params = new HashMap<>();
		<#list method.restfulParameters as parameter>	
		<#if parameter.type=='String'>
		params.put("${parameter.name}", ${parameter.name});
		</#if>
		</#list>
		<#if method.returnType??>String result = OkHttpUtils.post().url(${method.name}Url).params(params).build().executeString();
		return result;
	}
		<#else>OkHttpUtils.post().url(${method.name}Url).params(params).build().executeString();
	}
		</#if>
	
	<#elseif method.type=='postFormFile'>
	public <#if method.returnType??>${method.returnType}<#else>void</#if> ${method.name}(<#list method.restfulParameters as parameter >${parameter.type} ${parameter.name}<#if parameter_index!=(method.restfulParameters?size-1)>,</#if></#list>) throws IOException {
		Map<String, String> params = new HashMap<>();
		<#list method.restfulParameters as parameter>
		<#if parameter.type=='String'>
		params.put("${parameter.name}", ${parameter.name});
		</#if>
		</#list>
		<#if method.returnType??>String result = OkHttpUtils.post().url(${method.name}Url).<#list method.restfulParameters as parameter ><#if parameter.type=='File'>addFile("${parameter.name}", "${parameter.name}", ${parameter.name}).</#if></#list>params(params).build().executeString();
		return result;
	}
		<#else>OkHttpUtils.post().url(${method.name}Url).<#list method.restfulParameters as parameter ><#if parameter.type=='File'>addFile("${parameter.name}", "${parameter.name}", ${parameter.name}).</#if></#list>params(params).build().executeString();
	}
		</#if>
	
	<#elseif method.type=='postString'>
	public <#if method.returnType??>${method.returnType}<#else>void</#if> ${method.name}(String content) throws IOException {
		<#if method.returnType??>String result = OkHttpUtils.postString().url(${method.name}Url).content(content).build().executeString();
		return result;
	}
		<#else>OkHttpUtils.postString().url(${method.name}Url).content(content).build().executeString();
	}
		</#if>
	
	<#elseif method.type=='postFile'>
	public <#if method.returnType??>${method.returnType}<#else>void</#if> ${method.name}(File file) throws IOException {
		<#if method.returnType??>String result = OkHttpUtils.postFile().url(${method.name}Url).file(file).build().executeString();
		return result;
	}
		<#else>OkHttpUtils.postFile().url(${method.name}Url).file(file).build().executeString();
	}
		</#if>
	
	<#elseif method.type=='downloadFile'>
	public void ${method.name}(<#list method.restfulParameters as parameter >${parameter.type} ${parameter.name},</#list>FileCallBack fileCallBack) throws IOException {
		Map<String, String> params = new HashMap<>();
		<#list method.restfulParameters as parameter>
			<#if parameter.type=='String'>
		params.put("${parameter.name}", ${parameter.name});
			</#if>
		</#list>
		OkHttpUtils.get().url(${method.name}Url).params(params).build().execute(fileCallBack);
	}
	</#if>
	</#list>
	
}
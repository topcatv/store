/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.topcat.store.web.product;

import java.util.Map;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springside.modules.web.Servlets;
import org.topcat.store.entity.Catalog;
import org.topcat.store.entity.Product;
import org.topcat.store.service.CatalogService;
import org.topcat.store.service.ProductService;

/**
 * @author topcat
 *
 */
@Controller
@RequestMapping(value = "/product")
public class ProductController {
	
	private CatalogService catalogService;
	private ProductService productService;
	
	@RequestMapping(value = "/catalog", method = RequestMethod.GET)
	public String listCatalog(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "20") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			ServletRequest request){
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "catalog_");
		Page<Catalog> catalogs = catalogService.getAllCatalog(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("catalogs", catalogs);
		model.addAttribute("sortType", sortType);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "catalog_"));
		return "product/catalogList";
	}
	
	@RequestMapping(value = "/catalog/create", method = RequestMethod.GET)
	public String newCatalog(){
		return "product/catalogForm";
	}
	
	@RequestMapping(value = "/catalog/{id}", method = RequestMethod.GET)
	public String getCatalog(@PathVariable Long id, Model model){
		Catalog catalog = catalogService.getCatalog(id);
		model.addAttribute("catalog", catalog);
		return "product/catalogForm";
	}

	@RequestMapping(value = "/catalog", method = RequestMethod.POST)
	public String createCatalog(Catalog catalog, Model model){
		catalogService.save(catalog);
		model.addAttribute("success", true);
		model.addAttribute("message", "保存成功！");
		return "product/catalogForm";
	}
	
	@RequestMapping(value = "/catalog", method = RequestMethod.PUT)
	public String updateCatalog(Catalog catalog, Model model){
		Catalog catalog2 = catalogService.getCatalog(catalog.getId());
		catalog2.setName(catalog.getName());
		catalog2.setCode(catalog.getCode());
		model.addAttribute("success", true);
		model.addAttribute("message", "保存成功！");
		return "product/catalogForm";
	}
	
	@RequestMapping(method = RequestMethod.GET)
	public String listProduct(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "20") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			ServletRequest request){
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "product_");
		Page<Product> products = productService.getAllProduct(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("products", products);
		model.addAttribute("sortType", sortType);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "product_"));
		return "product/productList";
	}
	
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String newProduct(Model model){
		model.addAttribute("catalogs",catalogService.getAllCatalog());
		return "product/productForm";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String createProduct(Product product, Model model){
		productService.save(product);
		model.addAttribute("success", true);
		model.addAttribute("message", "保存成功！");
		model.addAttribute("catalogs",catalogService.getAllCatalog());
		return "product/productForm";
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String getProduct(@PathVariable Long id, Model model){
		Product product = productService.getProduct(id);
		model.addAttribute("product", product);
		model.addAttribute("catalogs",catalogService.getAllCatalog());
		return "product/productForm";
	}

	@Autowired
	public void setCatalogService(CatalogService catalogService) {
		this.catalogService = catalogService;
	}

	@Autowired
	public void setProductService(ProductService productService) {
		this.productService = productService;
	}
	
}

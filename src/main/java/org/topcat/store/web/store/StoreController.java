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
package org.topcat.store.web.store;

import java.util.List;
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
import org.topcat.store.entity.Product;
import org.topcat.store.entity.Store;
import org.topcat.store.service.ProductService;
import org.topcat.store.service.StoreService;

/**
 * @author topcat
 * 
 */
@Controller
@RequestMapping(value = "/store")
public class StoreController {

	private StoreService storeService;
	private ProductService productService;

	@RequestMapping(method = RequestMethod.GET)
	public String newInStore(
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "20") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType,
			Model model, ServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "product_");
		Page<Product> products = productService.getAllProduct(searchParams,
				pageNumber, pageSize, sortType);
		model.addAttribute("products", products);
		model.addAttribute("sortType", sortType);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets
				.encodeParameterStringWithPrefix(searchParams, "product_"));
		return "store/storeForm";
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String getStores(@PathVariable("id") Long productId, Model model) {
		List<Store> stores = storeService.findStoreByProductId(productId);
		model.addAttribute("stores", stores);
		return "store/storeForm";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String inStore(Store store, Model model) {
//		Product product = productService.getProduct(store.getProduct().getId());
//		store.setProduct(product);
		storeService.save(store);
		model.addAttribute("success", true);
		model.addAttribute("message", "保存成功！");
		return "store/storeForm";
	}

	@Autowired
	public void setStoreService(StoreService storeService) {
		this.storeService = storeService;
	}

	@Autowired
	public void setProductService(ProductService productService) {
		this.productService = productService;
	}

}

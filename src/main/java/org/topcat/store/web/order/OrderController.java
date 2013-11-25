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
package org.topcat.store.web.order;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springside.modules.web.Servlets;
import org.topcat.store.entity.OrderList;
import org.topcat.store.entity.Store;
import org.topcat.store.service.OrderService;
import org.topcat.store.service.StoreService;

/**
 * @author topcat
 * 
 */
@Controller
@RequestMapping(value = "/order")
public class OrderController {
	private OrderService orderService;

	private StoreService storeService;

	@RequestMapping(method = RequestMethod.GET)
	public String listOrder(
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "20") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType,
			Model model, ServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "order_");
		Page<OrderList> orders = orderService.getAllOrder(searchParams,
				pageNumber, pageSize, sortType);
		model.addAttribute("orders", orders);
		model.addAttribute("sortType", sortType);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets
				.encodeParameterStringWithPrefix(searchParams, "order_"));
		return "order/orderList";
	}

	@RequestMapping(value = "/store", method = RequestMethod.GET)
	public String listAllStore(Model model) {
		List<Store> stores = storeService.getAllStore();
		model.addAttribute("stores", stores);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		return "order/orderForm";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String saveOrderList(@ModelAttribute OrderList ol) {
		orderService.saveOrderList(ol);
		return "order/orderForm";
	}

	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String newOrderList(Model model) {
		model.addAttribute("orderList", new OrderList());
		return "order/orderForm";
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String getOrderList(@PathVariable("id") Long id, Model model) {
		model.addAttribute("orderList", orderService.getOrderList(id));
		return "order/orderForm";
	}

	@Autowired
	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}

	@Autowired
	public void setStoreService(StoreService storeService) {
		this.storeService = storeService;
	}

}

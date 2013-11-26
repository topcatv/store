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
package org.topcat.store.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.DynamicSpecifications;
import org.springside.modules.persistence.SearchFilter;
import org.topcat.store.entity.Order;
import org.topcat.store.entity.OrderList;
import org.topcat.store.entity.Store;
import org.topcat.store.entity.User;
import org.topcat.store.repository.OrderDao;
import org.topcat.store.repository.OrderListDao;
import org.topcat.store.repository.StoreDao;
import org.topcat.store.repository.UserDao;
import org.topcat.store.service.account.ShiroDbRealm.ShiroUser;

/**
 * @author topcat
 * 
 */
@Service
@Transactional
public class OrderService {
	private OrderDao orderDao;
	private OrderListDao orderListDao;
	private UserDao userDao;
	private StoreDao storeDao;

	@Autowired
	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}

	public Page<OrderList> getAllOrder(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		Specification<OrderList> spec = buildSpecification(searchParams);
		return orderListDao.findAll(spec, pageRequest);
	}

	/**
	 * 创建分页请求.
	 */
	private PageRequest buildPageRequest(int pageNumber, int pagzSize,
			String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("name".equals(sortType)) {
			sort = new Sort(Direction.ASC, "name");
		}

		return new PageRequest(pageNumber - 1, pagzSize, sort);
	}

	/**
	 * 创建动态查询条件组合.
	 */
	private Specification<OrderList> buildSpecification(
			Map<String, Object> searchParams) {
		Map<String, SearchFilter> filters = SearchFilter.parse(searchParams);
		Specification<OrderList> spec = DynamicSpecifications.bySearchFilter(
				filters.values(), OrderList.class);
		return spec;
	}

	@Autowired
	public void setOrderListDao(OrderListDao orderListDao) {
		this.orderListDao = orderListDao;
	}

	public void saveOrder(Order order) {
		orderDao.save(order);
	}

	public void saveOrders(List<Order> orders) {
		orderDao.save(orders);
	}

	public void saveOrderList(OrderList ol) {
		List<Order> orders = ol.getOrders();
		orderDao.save(orders);
		Date createDate = new Date();
		ol.setCreateDate(createDate);
		ol.setStatus(1);
		ol.setModifyDate(createDate);
		ShiroUser currentUser = (ShiroUser) SecurityUtils.getSubject()
				.getPrincipal();
		User user = userDao.findOne(currentUser.id);
		ol.setOperator(user);
		orderListDao.save(ol);

		for (Order order : orders) {
			Store inDBStore = storeDao.findOne(order.getStore().getId());
			Store store = order.getStore();
			inDBStore.setAmount(inDBStore.getAmount() - order.getAmount());
			storeDao.save(inDBStore);
		}
	}

	@Autowired
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public OrderList getOrderList(Long id) {
		return orderListDao.findOne(id);
	}

	@Autowired
	public void setStoreDao(StoreDao storeDao) {
		this.storeDao = storeDao;
	}

}

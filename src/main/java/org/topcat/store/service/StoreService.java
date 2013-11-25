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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.DynamicSpecifications;
import org.springside.modules.persistence.SearchFilter;
import org.topcat.store.entity.Store;
import org.topcat.store.repository.StoreDao;

import com.google.common.collect.Maps;

/**
 * @author topcat
 * 
 */
@Service
@Transactional
public class StoreService {

	private StoreDao storeDao;

	@Autowired
	public void setStoreDao(StoreDao storeDao) {
		this.storeDao = storeDao;
	}

	public void save(Store store) {
		storeDao.save(store);
	}

	public List<Store> findStoreByProductId(Long productId) {
		HashMap<String, Object> newHashMap = Maps.newHashMap();
		newHashMap.put("EQ_product.id", productId.toString());
		Map<String, SearchFilter> filters = SearchFilter.parse(newHashMap);
		Specification<Store> spec = DynamicSpecifications.bySearchFilter(filters.values(), Store.class);
		return storeDao.findAll(spec);
	}

	public List<Store> getAllStore() {
		return storeDao.findAll();
	}

}

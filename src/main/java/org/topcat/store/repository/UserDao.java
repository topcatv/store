package org.topcat.store.repository;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.topcat.store.entity.User;

public interface UserDao extends PagingAndSortingRepository<User, Long> {
	User findByLoginName(String loginName);
}

package com.mohammali.tst.springdbtest.data;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NamesRepo extends JpaRepository<NamesEntity, Long> {
}

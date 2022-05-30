package com.mohammali.tst.springdbtest.usecase;

import com.mohammali.tst.springdbtest.data.NamesEntity;
import com.mohammali.tst.springdbtest.data.NamesRepo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FindAllNamesUseCase {

    private final NamesRepo repo;

    public FindAllNamesUseCase(NamesRepo repo) {
        this.repo = repo;
    }

    public List<NamesEntity> get() {
        return repo.findAll();
    }
}

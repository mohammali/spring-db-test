package com.mohammali.tst.springdbtest.usecase;

import com.mohammali.tst.springdbtest.data.NamesEntity;
import com.mohammali.tst.springdbtest.data.NamesRepo;
import com.mohammali.tst.springdbtest.usecase.dto.NewNameDTO;
import com.mxninja.snowflake.Snowflake;
import org.springframework.stereotype.Service;

@Service
public class NewNameUseCase {

    private final Snowflake idGenerator = new Snowflake();

    private final NamesRepo repo;

    public NewNameUseCase(NamesRepo repo) {
        this.repo = repo;
    }

    public NamesEntity apply(NewNameDTO dto) {
        var newName = new NamesEntity();
        newName.setId(idGenerator.nextId());
        newName.setName(dto.name());
        return repo.save(newName);
    }
}

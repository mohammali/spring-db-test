package com.mohammali.tst.springdbtest.web;

import com.mohammali.tst.springdbtest.data.NamesEntity;
import com.mohammali.tst.springdbtest.usecase.FindAllNamesUseCase;
import com.mohammali.tst.springdbtest.usecase.NewNameUseCase;
import com.mohammali.tst.springdbtest.usecase.dto.NewNameDTO;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api.names")
public class NamesController {

    private final FindAllNamesUseCase findAllNamesUseCase;
    private final NewNameUseCase newNameUseCase;

    public NamesController(FindAllNamesUseCase findAllNamesUseCase, NewNameUseCase newNameUseCase) {
        this.findAllNamesUseCase = findAllNamesUseCase;
        this.newNameUseCase = newNameUseCase;
    }

    @PostMapping
    public NamesEntity addNewName(@RequestBody NewNameDTO body) {
        return newNameUseCase.apply(body);
    }

    @GetMapping
    public List<NamesEntity> findAll() {
        return findAllNamesUseCase.get();
    }
}

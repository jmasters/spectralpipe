function get_sources
    compile_opt idl2

    sources_all=!g.lineio->get_index_values('SOURCE')
    procedure=!g.lineio->get_index_values('PROCEDURE')
    restfreq=!g.lineio->get_index_values('RESTFREQ')

    sources = sources_all[where(((procedure eq 'OnOff' or procedure eq 'OffOn') and (restfreq gt 1.419e+09 and restfreq lt 1.421e+09)) or ((procedure eq 'Nod') and (restfreq gt 22.234080e+09 and restfreq lt 22.235080e+09)))]

 ;   print,'number of sources',n_elements(sources)
    sources = sources[uniq(sources,sort(sources))]
;    print,'number of sources',n_elements(sources)
    return, sources
end


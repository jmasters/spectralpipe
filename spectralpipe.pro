pro spectralpipe, filename
    compile_opt idl2

    filein, filename
    ; make sure it worked
    if !g.line_filein_name ne filename then begin
       print,'Could not open : ',filename
       return
    endif
    if (nrecords() eq 0) then begin
       print,filename,' is empty'
       return
    endif

    makeplots = 1
    
    freeze
    sources = get_sources()
    print,'sources', sources

    ; for each source
    for isource=0, n_elements(sources)-1 do begin

        sourcename = sources[isource]
        scans = get_scans(sourcename)

        print, 'sourcname ', sourcename, ' scans ', scans

        ;inspect every integration for wavy baselines
        flag_broad_rfi, scans, sourcename

        ; get an average of all scans on the source
        ; average_source_scans, scans
	
	; blank out the channels near band edges
        blank_edges
	
        smooth_spectrum
        blank_galactic
       	flag_narrow_rfi
        fit_baseline
	write_output, sourcename, scans

        if makeplots eq 1 then begin
            spawn, '/home/gbtpipeline/integration/spectralpipe/showreduced ' + sourcename + '_' + !g.s[0].date + '.fits'
        endif
   
    endfor ; end loop over sources

    unfreeze

end


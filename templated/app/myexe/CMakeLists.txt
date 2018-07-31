define_app(
    myexe
    SOURCES
        main.cpp
    #PRIV_HEADERS 
    #API_HEADERS 
    #API_DIR 
    LIBS 
        infra::mylib1
        infra::mylib2
    #SYS_LIBS
)


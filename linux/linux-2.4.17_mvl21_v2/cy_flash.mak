CONFIG_MTD_CFI_AMDSTD=n
CONFIG_MTD_CFI_INTELEXT=n
ifeq ($(FLASHTYPE),INTELJ3)
CONFIG_MTD_CFI_INTELEXT=y
else
ifeq ($(FLASHTYPE),AMD)
CONFIG_MTD_CFI_AMDSTD=y
endif
endif
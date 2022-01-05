Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EF3484D1C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 05:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbiAEE32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 23:29:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:64817 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237052AbiAEE30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 23:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641356966; x=1672892966;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0XIBxc4TTqcDdK2EzunyhpoBqcdG8259wsybmgkBsww=;
  b=IAJ7YFPpfryEcUqkAhdF2n+57QJAR9Hz6HIwnWXuF89QZV25b3gd6Iwc
   GItkYXWDFW9n5njJMwxQIBQHF/ijWEU5wJ+NkCOgChso2rmStqgwf7G7/
   zb/r1vX1CPolAKujXVUhl2TrQqngr2SaDn9c7QJVKsmCcYtaWXUGwLJ8q
   XqzIIsFB9nlvhfe5Zg7P4JYgIUE/gDUtg7x88Dnf3f/KuF+HOichxQPAS
   q4x2c9Ez7i494gsahRyFYfkq3otqsARFJK/YIOEPUJe1GkvXV5XnfP+S3
   vh5qT8d89D6Kvaz1XR+b0LnJo+6JPjwMJS3Hv4KGwAnpUZwQrtnWccr0m
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="239906828"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="239906828"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 20:26:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="688835550"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 Jan 2022 20:26:24 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4xsW-000GDw-7I; Wed, 05 Jan 2022 04:26:24 +0000
Date:   Wed, 5 Jan 2022 12:26:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/pinctrl/tegra/pinctrl-tegra194.c:1113:27: warning: unused
 variable 'sdmmc1_hv_trim_pins'
Message-ID: <202201051232.zIoqaHF1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prathamesh,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
commit: 613c0826081bb4c6517f1a593480f9d60a00d88f pinctrl: tegra: Add pinmux support for Tegra194
date:   2 months ago
config: arm64-randconfig-r013-20220105 (https://download.01.org/0day-ci/archive/20220105/202201051232.zIoqaHF1-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=613c0826081bb4c6517f1a593480f9d60a00d88f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 613c0826081bb4c6517f1a593480f9d60a00d88f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/pinctrl/tegra/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1390:14: note: expanded from macro 'PIN_PINGROUP_ENTRY_Y'
                   .drv_reg = -1,                                  \
                              ^~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1851:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           PINGROUP(usb_vbus_en0_pz1,      USB,            RSVD1,          RSVD2,          RSVD3,          0xD0b0,         0,      Y,      5,      -1,     6,      8,      -1,     10,     11,     12,     N,      -1,     -1,     N,      "vddio_uart"),
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1631:3: note: expanded from macro 'PINGROUP'
                   drive_##pg_name,                                \
                   ^~~~~~~~~~~~~~~
   <scratch space>:55:1: note: expanded from here
   drive_usb_vbus_en0_pz1
   ^~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1555:41: note: expanded from macro 'drive_usb_vbus_en0_pz1'
   #define drive_usb_vbus_en0_pz1          DRV_PINGROUP_ENTRY_Y(0xD0b4,    12,     5,      20,     5,      -1,     -1,     -1,     -1,     0)
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1341:14: note: expanded from macro 'DRV_PINGROUP_ENTRY_Y'
                   .drv_reg = ((r)),                               \
                              ^~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1851:2: note: previous initialization is here
           PINGROUP(usb_vbus_en0_pz1,      USB,            RSVD1,          RSVD2,          RSVD3,          0xD0b0,         0,      Y,      5,      -1,     6,      8,      -1,     10,     11,     12,     N,      -1,     -1,     N,      "vddio_uart"),
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1625:3: note: expanded from macro 'PINGROUP'
                   PIN_PINGROUP_ENTRY_Y(r, bank, pupd, e_io_hv, e_lpbk,    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1390:14: note: expanded from macro 'PIN_PINGROUP_ENTRY_Y'
                   .drv_reg = -1,                                  \
                              ^~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1852:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           PINGROUP(usb_vbus_en1_pz2,      USB,            RSVD1,          RSVD2,          RSVD3,          0xD0b8,         0,      Y,      5,      -1,     6,      8,      -1,     10,     11,     12,     N,      -1,     -1,     N,      "vddio_uart"),
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1631:3: note: expanded from macro 'PINGROUP'
                   drive_##pg_name,                                \
                   ^~~~~~~~~~~~~~~
   <scratch space>:64:1: note: expanded from here
   drive_usb_vbus_en1_pz2
   ^~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1556:41: note: expanded from macro 'drive_usb_vbus_en1_pz2'
   #define drive_usb_vbus_en1_pz2          DRV_PINGROUP_ENTRY_Y(0xD0bc,    12,     5,      20,     5,      -1,     -1,     -1,     -1,     0)
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1341:14: note: expanded from macro 'DRV_PINGROUP_ENTRY_Y'
                   .drv_reg = ((r)),                               \
                              ^~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1852:2: note: previous initialization is here
           PINGROUP(usb_vbus_en1_pz2,      USB,            RSVD1,          RSVD2,          RSVD3,          0xD0b8,         0,      Y,      5,      -1,     6,      8,      -1,     10,     11,     12,     N,      -1,     -1,     N,      "vddio_uart"),
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1625:3: note: expanded from macro 'PINGROUP'
                   PIN_PINGROUP_ENTRY_Y(r, bank, pupd, e_io_hv, e_lpbk,    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1390:14: note: expanded from macro 'PIN_PINGROUP_ENTRY_Y'
                   .drv_reg = -1,                                  \
                              ^~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1853:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           PINGROUP(ufs0_rst_pff1,         UFS0,           RSVD1,          RSVD2,          RSVD3,          0x11000,        0,      Y,      -1,     -1,     6,      -1,     9,      10,     -1,     12,     Y,      15,     17,     Y,      "vddio_ufs"),
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1631:3: note: expanded from macro 'PINGROUP'
                   drive_##pg_name,                                \
                   ^~~~~~~~~~~~~~~
   <scratch space>:73:1: note: expanded from here
   drive_ufs0_rst_pff1
   ^~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1557:41: note: expanded from macro 'drive_ufs0_rst_pff1'
   #define drive_ufs0_rst_pff1             DRV_PINGROUP_ENTRY_Y(0x11004,   12,     9,      24,     8,      -1,     -1,     -1,     -1,     0)
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1341:14: note: expanded from macro 'DRV_PINGROUP_ENTRY_Y'
                   .drv_reg = ((r)),                               \
                              ^~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1853:2: note: previous initialization is here
           PINGROUP(ufs0_rst_pff1,         UFS0,           RSVD1,          RSVD2,          RSVD3,          0x11000,        0,      Y,      -1,     -1,     6,      -1,     9,      10,     -1,     12,     Y,      15,     17,     Y,      "vddio_ufs"),
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1625:3: note: expanded from macro 'PINGROUP'
                   PIN_PINGROUP_ENTRY_Y(r, bank, pupd, e_io_hv, e_lpbk,    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1390:14: note: expanded from macro 'PIN_PINGROUP_ENTRY_Y'
                   .drv_reg = -1,                                  \
                              ^~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1854:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           PINGROUP(ufs0_ref_clk_pff0,     UFS0,           RSVD1,          RSVD2,          RSVD3,          0x11008,        0,      Y,      -1,     -1,     6,      -1,     9,      10,     -1,     12,     Y,      15,     17,     Y,      "vddio_ufs"),
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1631:3: note: expanded from macro 'PINGROUP'
                   drive_##pg_name,                                \
                   ^~~~~~~~~~~~~~~
   <scratch space>:82:1: note: expanded from here
   drive_ufs0_ref_clk_pff0
   ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1558:41: note: expanded from macro 'drive_ufs0_ref_clk_pff0'
   #define drive_ufs0_ref_clk_pff0         DRV_PINGROUP_ENTRY_Y(0x1100c,   12,     9,      24,     8,      -1,     -1,     -1,     -1,     0)
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1341:14: note: expanded from macro 'DRV_PINGROUP_ENTRY_Y'
                   .drv_reg = ((r)),                               \
                              ^~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1854:2: note: previous initialization is here
           PINGROUP(ufs0_ref_clk_pff0,     UFS0,           RSVD1,          RSVD2,          RSVD3,          0x11008,        0,      Y,      -1,     -1,     6,      -1,     9,      10,     -1,     12,     Y,      15,     17,     Y,      "vddio_ufs"),
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1625:3: note: expanded from macro 'PINGROUP'
                   PIN_PINGROUP_ENTRY_Y(r, bank, pupd, e_io_hv, e_lpbk,    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/tegra/pinctrl-tegra194.c:1390:14: note: expanded from macro 'PIN_PINGROUP_ENTRY_Y'
                   .drv_reg = -1,                                  \
                              ^~
>> drivers/pinctrl/tegra/pinctrl-tegra194.c:1113:27: warning: unused variable 'sdmmc1_hv_trim_pins' [-Wunused-const-variable]
   static const unsigned int sdmmc1_hv_trim_pins[] = {
                             ^
>> drivers/pinctrl/tegra/pinctrl-tegra194.c:1119:27: warning: unused variable 'sdmmc3_hv_trim_pins' [-Wunused-const-variable]
   static const unsigned int sdmmc3_hv_trim_pins[] = {
                             ^
>> drivers/pinctrl/tegra/pinctrl-tegra194.c:1128:27: warning: unused variable 'sys_reset_n_pins' [-Wunused-const-variable]
   static const unsigned int sys_reset_n_pins[] = {
                             ^
   222 warnings generated.


vim +/sdmmc1_hv_trim_pins +1113 drivers/pinctrl/tegra/pinctrl-tegra194.c

   476	
   477	static const unsigned int dap6_sclk_pa0_pins[] = {
   478		TEGRA_PIN_DAP6_SCLK_PA0,
   479	};
   480	static const unsigned int dap6_dout_pa1_pins[] = {
   481		TEGRA_PIN_DAP6_DOUT_PA1,
   482	};
   483	static const unsigned int dap6_din_pa2_pins[] = {
   484		TEGRA_PIN_DAP6_DIN_PA2,
   485	};
   486	static const unsigned int dap6_fs_pa3_pins[] = {
   487		TEGRA_PIN_DAP6_FS_PA3,
   488	};
   489	static const unsigned int dap4_sclk_pa4_pins[] = {
   490		TEGRA_PIN_DAP4_SCLK_PA4,
   491	};
   492	static const unsigned int dap4_dout_pa5_pins[] = {
   493		TEGRA_PIN_DAP4_DOUT_PA5,
   494	};
   495	static const unsigned int dap4_din_pa6_pins[] = {
   496		TEGRA_PIN_DAP4_DIN_PA6,
   497	};
   498	static const unsigned int dap4_fs_pa7_pins[] = {
   499		TEGRA_PIN_DAP4_FS_PA7,
   500	};
   501	static const unsigned int cpu_pwr_req_0_pb0_pins[] = {
   502		TEGRA_PIN_CPU_PWR_REQ_0_PB0,
   503	};
   504	static const unsigned int cpu_pwr_req_1_pb1_pins[] = {
   505		TEGRA_PIN_CPU_PWR_REQ_1_PB1,
   506	};
   507	static const unsigned int qspi0_sck_pc0_pins[] = {
   508		TEGRA_PIN_QSPI0_SCK_PC0,
   509	};
   510	static const unsigned int qspi0_cs_n_pc1_pins[] = {
   511		TEGRA_PIN_QSPI0_CS_N_PC1,
   512	};
   513	static const unsigned int qspi0_io0_pc2_pins[] = {
   514		TEGRA_PIN_QSPI0_IO0_PC2,
   515	};
   516	static const unsigned int qspi0_io1_pc3_pins[] = {
   517		TEGRA_PIN_QSPI0_IO1_PC3,
   518	};
   519	static const unsigned int qspi0_io2_pc4_pins[] = {
   520		TEGRA_PIN_QSPI0_IO2_PC4,
   521	};
   522	static const unsigned int qspi0_io3_pc5_pins[] = {
   523		TEGRA_PIN_QSPI0_IO3_PC5,
   524	};
   525	static const unsigned int qspi1_sck_pc6_pins[] = {
   526		TEGRA_PIN_QSPI1_SCK_PC6,
   527	};
   528	static const unsigned int qspi1_cs_n_pc7_pins[] = {
   529		TEGRA_PIN_QSPI1_CS_N_PC7,
   530	};
   531	static const unsigned int qspi1_io0_pd0_pins[] = {
   532		TEGRA_PIN_QSPI1_IO0_PD0,
   533	};
   534	static const unsigned int qspi1_io1_pd1_pins[] = {
   535		TEGRA_PIN_QSPI1_IO1_PD1,
   536	};
   537	static const unsigned int qspi1_io2_pd2_pins[] = {
   538		TEGRA_PIN_QSPI1_IO2_PD2,
   539	};
   540	static const unsigned int qspi1_io3_pd3_pins[] = {
   541		TEGRA_PIN_QSPI1_IO3_PD3,
   542	};
   543	static const unsigned int eqos_txc_pe0_pins[] = {
   544		TEGRA_PIN_EQOS_TXC_PE0,
   545	};
   546	static const unsigned int eqos_td0_pe1_pins[] = {
   547		TEGRA_PIN_EQOS_TD0_PE1,
   548	};
   549	static const unsigned int eqos_td1_pe2_pins[] = {
   550		TEGRA_PIN_EQOS_TD1_PE2,
   551	};
   552	static const unsigned int eqos_td2_pe3_pins[] = {
   553		TEGRA_PIN_EQOS_TD2_PE3,
   554	};
   555	static const unsigned int eqos_td3_pe4_pins[] = {
   556		TEGRA_PIN_EQOS_TD3_PE4,
   557	};
   558	static const unsigned int eqos_tx_ctl_pe5_pins[] = {
   559		TEGRA_PIN_EQOS_TX_CTL_PE5,
   560	};
   561	static const unsigned int eqos_rd0_pe6_pins[] = {
   562		TEGRA_PIN_EQOS_RD0_PE6,
   563	};
   564	static const unsigned int eqos_rd1_pe7_pins[] = {
   565		TEGRA_PIN_EQOS_RD1_PE7,
   566	};
   567	static const unsigned int eqos_rd2_pf0_pins[] = {
   568		TEGRA_PIN_EQOS_RD2_PF0,
   569	};
   570	static const unsigned int eqos_rd3_pf1_pins[] = {
   571		TEGRA_PIN_EQOS_RD3_PF1,
   572	};
   573	static const unsigned int eqos_rx_ctl_pf2_pins[] = {
   574		TEGRA_PIN_EQOS_RX_CTL_PF2,
   575	};
   576	static const unsigned int eqos_rxc_pf3_pins[] = {
   577		TEGRA_PIN_EQOS_RXC_PF3,
   578	};
   579	static const unsigned int eqos_sma_mdio_pf4_pins[] = {
   580		TEGRA_PIN_EQOS_SMA_MDIO_PF4,
   581	};
   582	static const unsigned int eqos_sma_mdc_pf5_pins[] = {
   583		TEGRA_PIN_EQOS_SMA_MDC_PF5,
   584	};
   585	static const unsigned int soc_gpio00_pg0_pins[] = {
   586		TEGRA_PIN_SOC_GPIO00_PG0,
   587	};
   588	static const unsigned int soc_gpio01_pg1_pins[] = {
   589		TEGRA_PIN_SOC_GPIO01_PG1,
   590	};
   591	static const unsigned int soc_gpio02_pg2_pins[] = {
   592		TEGRA_PIN_SOC_GPIO02_PG2,
   593	};
   594	static const unsigned int soc_gpio03_pg3_pins[] = {
   595		TEGRA_PIN_SOC_GPIO03_PG3,
   596	};
   597	static const unsigned int soc_gpio08_pg4_pins[] = {
   598		TEGRA_PIN_SOC_GPIO08_PG4,
   599	};
   600	static const unsigned int soc_gpio09_pg5_pins[] = {
   601		TEGRA_PIN_SOC_GPIO09_PG5,
   602	};
   603	static const unsigned int soc_gpio10_pg6_pins[] = {
   604		TEGRA_PIN_SOC_GPIO10_PG6,
   605	};
   606	static const unsigned int soc_gpio11_pg7_pins[] = {
   607		TEGRA_PIN_SOC_GPIO11_PG7,
   608	};
   609	static const unsigned int soc_gpio12_ph0_pins[] = {
   610		TEGRA_PIN_SOC_GPIO12_PH0,
   611	};
   612	static const unsigned int soc_gpio13_ph1_pins[] = {
   613		TEGRA_PIN_SOC_GPIO13_PH1,
   614	};
   615	static const unsigned int soc_gpio14_ph2_pins[] = {
   616		TEGRA_PIN_SOC_GPIO14_PH2,
   617	};
   618	static const unsigned int uart4_tx_ph3_pins[] = {
   619		TEGRA_PIN_UART4_TX_PH3,
   620	};
   621	static const unsigned int uart4_rx_ph4_pins[] = {
   622		TEGRA_PIN_UART4_RX_PH4,
   623	};
   624	static const unsigned int uart4_rts_ph5_pins[] = {
   625		TEGRA_PIN_UART4_RTS_PH5,
   626	};
   627	static const unsigned int uart4_cts_ph6_pins[] = {
   628		TEGRA_PIN_UART4_CTS_PH6,
   629	};
   630	static const unsigned int dap2_sclk_ph7_pins[] = {
   631		TEGRA_PIN_DAP2_SCLK_PH7,
   632	};
   633	static const unsigned int dap2_dout_pi0_pins[] = {
   634		TEGRA_PIN_DAP2_DOUT_PI0,
   635	};
   636	static const unsigned int dap2_din_pi1_pins[] = {
   637		TEGRA_PIN_DAP2_DIN_PI1,
   638	};
   639	static const unsigned int dap2_fs_pi2_pins[] = {
   640		TEGRA_PIN_DAP2_FS_PI2,
   641	};
   642	static const unsigned int gen1_i2c_scl_pi3_pins[] = {
   643		TEGRA_PIN_GEN1_I2C_SCL_PI3,
   644	};
   645	static const unsigned int gen1_i2c_sda_pi4_pins[] = {
   646		TEGRA_PIN_GEN1_I2C_SDA_PI4,
   647	};
   648	static const unsigned int sdmmc1_clk_pj0_pins[] = {
   649		TEGRA_PIN_SDMMC1_CLK_PJ0,
   650	};
   651	static const unsigned int sdmmc1_cmd_pj1_pins[] = {
   652		TEGRA_PIN_SDMMC1_CMD_PJ1,
   653	};
   654	static const unsigned int sdmmc1_dat0_pj2_pins[] = {
   655		TEGRA_PIN_SDMMC1_DAT0_PJ2,
   656	};
   657	static const unsigned int sdmmc1_dat1_pj3_pins[] = {
   658		TEGRA_PIN_SDMMC1_DAT1_PJ3,
   659	};
   660	static const unsigned int sdmmc1_dat2_pj4_pins[] = {
   661		TEGRA_PIN_SDMMC1_DAT2_PJ4,
   662	};
   663	static const unsigned int sdmmc1_dat3_pj5_pins[] = {
   664		TEGRA_PIN_SDMMC1_DAT3_PJ5,
   665	};
   666	static const unsigned int pex_l0_clkreq_n_pk0_pins[] = {
   667		TEGRA_PIN_PEX_L0_CLKREQ_N_PK0,
   668	};
   669	static const unsigned int pex_l0_rst_n_pk1_pins[] = {
   670		TEGRA_PIN_PEX_L0_RST_N_PK1,
   671	};
   672	static const unsigned int pex_l1_clkreq_n_pk2_pins[] = {
   673		TEGRA_PIN_PEX_L1_CLKREQ_N_PK2,
   674	};
   675	static const unsigned int pex_l1_rst_n_pk3_pins[] = {
   676		TEGRA_PIN_PEX_L1_RST_N_PK3,
   677	};
   678	static const unsigned int pex_l2_clkreq_n_pk4_pins[] = {
   679		TEGRA_PIN_PEX_L2_CLKREQ_N_PK4,
   680	};
   681	static const unsigned int pex_l2_rst_n_pk5_pins[] = {
   682		TEGRA_PIN_PEX_L2_RST_N_PK5,
   683	};
   684	static const unsigned int pex_l3_clkreq_n_pk6_pins[] = {
   685		TEGRA_PIN_PEX_L3_CLKREQ_N_PK6,
   686	};
   687	static const unsigned int pex_l3_rst_n_pk7_pins[] = {
   688		TEGRA_PIN_PEX_L3_RST_N_PK7,
   689	};
   690	static const unsigned int pex_l4_clkreq_n_pl0_pins[] = {
   691		TEGRA_PIN_PEX_L4_CLKREQ_N_PL0,
   692	};
   693	static const unsigned int pex_l4_rst_n_pl1_pins[] = {
   694		TEGRA_PIN_PEX_L4_RST_N_PL1,
   695	};
   696	static const unsigned int pex_wake_n_pl2_pins[] = {
   697		TEGRA_PIN_PEX_WAKE_N_PL2,
   698	};
   699	static const unsigned int sata_dev_slp_pl3_pins[] = {
   700		TEGRA_PIN_SATA_DEV_SLP_PL3,
   701	};
   702	static const unsigned int dp_aux_ch0_hpd_pm0_pins[] = {
   703		TEGRA_PIN_DP_AUX_CH0_HPD_PM0,
   704	};
   705	static const unsigned int dp_aux_ch1_hpd_pm1_pins[] = {
   706		TEGRA_PIN_DP_AUX_CH1_HPD_PM1,
   707	};
   708	static const unsigned int dp_aux_ch2_hpd_pm2_pins[] = {
   709		TEGRA_PIN_DP_AUX_CH2_HPD_PM2,
   710	};
   711	static const unsigned int dp_aux_ch3_hpd_pm3_pins[] = {
   712		TEGRA_PIN_DP_AUX_CH3_HPD_PM3,
   713	};
   714	static const unsigned int hdmi_cec_pm4_pins[] = {
   715		TEGRA_PIN_HDMI_CEC_PM4,
   716	};
   717	static const unsigned int soc_gpio50_pm5_pins[] = {
   718		TEGRA_PIN_SOC_GPIO50_PM5,
   719	};
   720	static const unsigned int soc_gpio51_pm6_pins[] = {
   721		TEGRA_PIN_SOC_GPIO51_PM6,
   722	};
   723	static const unsigned int soc_gpio52_pm7_pins[] = {
   724		TEGRA_PIN_SOC_GPIO52_PM7,
   725	};
   726	static const unsigned int soc_gpio53_pn0_pins[] = {
   727		TEGRA_PIN_SOC_GPIO53_PN0,
   728	};
   729	static const unsigned int soc_gpio54_pn1_pins[] = {
   730		TEGRA_PIN_SOC_GPIO54_PN1,
   731	};
   732	static const unsigned int soc_gpio55_pn2_pins[] = {
   733		TEGRA_PIN_SOC_GPIO55_PN2,
   734	};
   735	static const unsigned int sdmmc3_clk_po0_pins[] = {
   736		TEGRA_PIN_SDMMC3_CLK_PO0,
   737	};
   738	static const unsigned int sdmmc3_cmd_po1_pins[] = {
   739		TEGRA_PIN_SDMMC3_CMD_PO1,
   740	};
   741	static const unsigned int sdmmc3_dat0_po2_pins[] = {
   742		TEGRA_PIN_SDMMC3_DAT0_PO2,
   743	};
   744	static const unsigned int sdmmc3_dat1_po3_pins[] = {
   745		TEGRA_PIN_SDMMC3_DAT1_PO3,
   746	};
   747	static const unsigned int sdmmc3_dat2_po4_pins[] = {
   748		TEGRA_PIN_SDMMC3_DAT2_PO4,
   749	};
   750	static const unsigned int sdmmc3_dat3_po5_pins[] = {
   751		TEGRA_PIN_SDMMC3_DAT3_PO5,
   752	};
   753	static const unsigned int extperiph1_clk_pp0_pins[] = {
   754		TEGRA_PIN_EXTPERIPH1_CLK_PP0,
   755	};
   756	static const unsigned int extperiph2_clk_pp1_pins[] = {
   757		TEGRA_PIN_EXTPERIPH2_CLK_PP1,
   758	};
   759	static const unsigned int cam_i2c_scl_pp2_pins[] = {
   760		TEGRA_PIN_CAM_I2C_SCL_PP2,
   761	};
   762	static const unsigned int cam_i2c_sda_pp3_pins[] = {
   763		TEGRA_PIN_CAM_I2C_SDA_PP3,
   764	};
   765	static const unsigned int soc_gpio04_pp4_pins[] = {
   766		TEGRA_PIN_SOC_GPIO04_PP4,
   767	};
   768	static const unsigned int soc_gpio05_pp5_pins[] = {
   769		TEGRA_PIN_SOC_GPIO05_PP5,
   770	};
   771	static const unsigned int soc_gpio06_pp6_pins[] = {
   772		TEGRA_PIN_SOC_GPIO06_PP6,
   773	};
   774	static const unsigned int soc_gpio07_pp7_pins[] = {
   775		TEGRA_PIN_SOC_GPIO07_PP7,
   776	};
   777	static const unsigned int soc_gpio20_pq0_pins[] = {
   778		TEGRA_PIN_SOC_GPIO20_PQ0,
   779	};
   780	static const unsigned int soc_gpio21_pq1_pins[] = {
   781		TEGRA_PIN_SOC_GPIO21_PQ1,
   782	};
   783	static const unsigned int soc_gpio22_pq2_pins[] = {
   784		TEGRA_PIN_SOC_GPIO22_PQ2,
   785	};
   786	static const unsigned int soc_gpio23_pq3_pins[] = {
   787		TEGRA_PIN_SOC_GPIO23_PQ3,
   788	};
   789	static const unsigned int soc_gpio40_pq4_pins[] = {
   790		TEGRA_PIN_SOC_GPIO40_PQ4,
   791	};
   792	static const unsigned int soc_gpio41_pq5_pins[] = {
   793		TEGRA_PIN_SOC_GPIO41_PQ5,
   794	};
   795	static const unsigned int soc_gpio42_pq6_pins[] = {
   796		TEGRA_PIN_SOC_GPIO42_PQ6,
   797	};
   798	static const unsigned int soc_gpio43_pq7_pins[] = {
   799		TEGRA_PIN_SOC_GPIO43_PQ7,
   800	};
   801	static const unsigned int soc_gpio44_pr0_pins[] = {
   802		TEGRA_PIN_SOC_GPIO44_PR0,
   803	};
   804	static const unsigned int soc_gpio45_pr1_pins[] = {
   805		TEGRA_PIN_SOC_GPIO45_PR1,
   806	};
   807	static const unsigned int uart1_tx_pr2_pins[] = {
   808		TEGRA_PIN_UART1_TX_PR2,
   809	};
   810	static const unsigned int uart1_rx_pr3_pins[] = {
   811		TEGRA_PIN_UART1_RX_PR3,
   812	};
   813	static const unsigned int uart1_rts_pr4_pins[] = {
   814		TEGRA_PIN_UART1_RTS_PR4,
   815	};
   816	static const unsigned int uart1_cts_pr5_pins[] = {
   817		TEGRA_PIN_UART1_CTS_PR5,
   818	};
   819	static const unsigned int dap1_sclk_ps0_pins[] = {
   820		TEGRA_PIN_DAP1_SCLK_PS0,
   821	};
   822	static const unsigned int dap1_dout_ps1_pins[] = {
   823		TEGRA_PIN_DAP1_DOUT_PS1,
   824	};
   825	static const unsigned int dap1_din_ps2_pins[] = {
   826		TEGRA_PIN_DAP1_DIN_PS2,
   827	};
   828	static const unsigned int dap1_fs_ps3_pins[] = {
   829		TEGRA_PIN_DAP1_FS_PS3,
   830	};
   831	static const unsigned int aud_mclk_ps4_pins[] = {
   832		TEGRA_PIN_AUD_MCLK_PS4,
   833	};
   834	static const unsigned int soc_gpio30_ps5_pins[] = {
   835		TEGRA_PIN_SOC_GPIO30_PS5,
   836	};
   837	static const unsigned int soc_gpio31_ps6_pins[] = {
   838		TEGRA_PIN_SOC_GPIO31_PS6,
   839	};
   840	static const unsigned int soc_gpio32_ps7_pins[] = {
   841		TEGRA_PIN_SOC_GPIO32_PS7,
   842	};
   843	static const unsigned int soc_gpio33_pt0_pins[] = {
   844		TEGRA_PIN_SOC_GPIO33_PT0,
   845	};
   846	static const unsigned int dap3_sclk_pt1_pins[] = {
   847		TEGRA_PIN_DAP3_SCLK_PT1,
   848	};
   849	static const unsigned int dap3_dout_pt2_pins[] = {
   850		TEGRA_PIN_DAP3_DOUT_PT2,
   851	};
   852	static const unsigned int dap3_din_pt3_pins[] = {
   853		TEGRA_PIN_DAP3_DIN_PT3,
   854	};
   855	static const unsigned int dap3_fs_pt4_pins[] = {
   856		TEGRA_PIN_DAP3_FS_PT4,
   857	};
   858	static const unsigned int dap5_sclk_pt5_pins[] = {
   859		TEGRA_PIN_DAP5_SCLK_PT5,
   860	};
   861	static const unsigned int dap5_dout_pt6_pins[] = {
   862		TEGRA_PIN_DAP5_DOUT_PT6,
   863	};
   864	static const unsigned int dap5_din_pt7_pins[] = {
   865		TEGRA_PIN_DAP5_DIN_PT7,
   866	};
   867	static const unsigned int dap5_fs_pu0_pins[] = {
   868		TEGRA_PIN_DAP5_FS_PU0,
   869	};
   870	static const unsigned int directdc1_clk_pv0_pins[] = {
   871		TEGRA_PIN_DIRECTDC1_CLK_PV0,
   872	};
   873	static const unsigned int directdc1_in_pv1_pins[] = {
   874		TEGRA_PIN_DIRECTDC1_IN_PV1,
   875	};
   876	static const unsigned int directdc1_out0_pv2_pins[] = {
   877		TEGRA_PIN_DIRECTDC1_OUT0_PV2,
   878	};
   879	static const unsigned int directdc1_out1_pv3_pins[] = {
   880		TEGRA_PIN_DIRECTDC1_OUT1_PV3,
   881	};
   882	static const unsigned int directdc1_out2_pv4_pins[] = {
   883		TEGRA_PIN_DIRECTDC1_OUT2_PV4,
   884	};
   885	static const unsigned int directdc1_out3_pv5_pins[] = {
   886		TEGRA_PIN_DIRECTDC1_OUT3_PV5,
   887	};
   888	static const unsigned int directdc1_out4_pv6_pins[] = {
   889		TEGRA_PIN_DIRECTDC1_OUT4_PV6,
   890	};
   891	static const unsigned int directdc1_out5_pv7_pins[] = {
   892		TEGRA_PIN_DIRECTDC1_OUT5_PV7,
   893	};
   894	static const unsigned int directdc1_out6_pw0_pins[] = {
   895		TEGRA_PIN_DIRECTDC1_OUT6_PW0,
   896	};
   897	static const unsigned int directdc1_out7_pw1_pins[] = {
   898		TEGRA_PIN_DIRECTDC1_OUT7_PW1,
   899	};
   900	static const unsigned int gpu_pwr_req_px0_pins[] = {
   901		TEGRA_PIN_GPU_PWR_REQ_PX0,
   902	};
   903	static const unsigned int cv_pwr_req_px1_pins[] = {
   904		TEGRA_PIN_CV_PWR_REQ_PX1,
   905	};
   906	static const unsigned int gp_pwm2_px2_pins[] = {
   907		TEGRA_PIN_GP_PWM2_PX2,
   908	};
   909	static const unsigned int gp_pwm3_px3_pins[] = {
   910		TEGRA_PIN_GP_PWM3_PX3,
   911	};
   912	static const unsigned int uart2_tx_px4_pins[] = {
   913		TEGRA_PIN_UART2_TX_PX4,
   914	};
   915	static const unsigned int uart2_rx_px5_pins[] = {
   916		TEGRA_PIN_UART2_RX_PX5,
   917	};
   918	static const unsigned int uart2_rts_px6_pins[] = {
   919		TEGRA_PIN_UART2_RTS_PX6,
   920	};
   921	static const unsigned int uart2_cts_px7_pins[] = {
   922		TEGRA_PIN_UART2_CTS_PX7,
   923	};
   924	static const unsigned int spi3_sck_py0_pins[] = {
   925		TEGRA_PIN_SPI3_SCK_PY0,
   926	};
   927	static const unsigned int spi3_miso_py1_pins[] = {
   928		TEGRA_PIN_SPI3_MISO_PY1,
   929	};
   930	static const unsigned int spi3_mosi_py2_pins[] = {
   931		TEGRA_PIN_SPI3_MOSI_PY2,
   932	};
   933	static const unsigned int spi3_cs0_py3_pins[] = {
   934		TEGRA_PIN_SPI3_CS0_PY3,
   935	};
   936	static const unsigned int spi3_cs1_py4_pins[] = {
   937		TEGRA_PIN_SPI3_CS1_PY4,
   938	};
   939	static const unsigned int uart5_tx_py5_pins[] = {
   940		TEGRA_PIN_UART5_TX_PY5,
   941	};
   942	static const unsigned int uart5_rx_py6_pins[] = {
   943		TEGRA_PIN_UART5_RX_PY6,
   944	};
   945	static const unsigned int uart5_rts_py7_pins[] = {
   946		TEGRA_PIN_UART5_RTS_PY7,
   947	};
   948	static const unsigned int uart5_cts_pz0_pins[] = {
   949		TEGRA_PIN_UART5_CTS_PZ0,
   950	};
   951	static const unsigned int usb_vbus_en0_pz1_pins[] = {
   952		TEGRA_PIN_USB_VBUS_EN0_PZ1,
   953	};
   954	static const unsigned int usb_vbus_en1_pz2_pins[] = {
   955		TEGRA_PIN_USB_VBUS_EN1_PZ2,
   956	};
   957	static const unsigned int spi1_sck_pz3_pins[] = {
   958		TEGRA_PIN_SPI1_SCK_PZ3,
   959	};
   960	static const unsigned int spi1_miso_pz4_pins[] = {
   961		TEGRA_PIN_SPI1_MISO_PZ4,
   962	};
   963	static const unsigned int spi1_mosi_pz5_pins[] = {
   964		TEGRA_PIN_SPI1_MOSI_PZ5,
   965	};
   966	static const unsigned int spi1_cs0_pz6_pins[] = {
   967		TEGRA_PIN_SPI1_CS0_PZ6,
   968	};
   969	static const unsigned int spi1_cs1_pz7_pins[] = {
   970		TEGRA_PIN_SPI1_CS1_PZ7,
   971	};
   972	static const unsigned int can1_dout_paa0_pins[] = {
   973		TEGRA_PIN_CAN1_DOUT_PAA0,
   974	};
   975	static const unsigned int can1_din_paa1_pins[] = {
   976		TEGRA_PIN_CAN1_DIN_PAA1,
   977	};
   978	static const unsigned int can0_dout_paa2_pins[] = {
   979		TEGRA_PIN_CAN0_DOUT_PAA2,
   980	};
   981	static const unsigned int can0_din_paa3_pins[] = {
   982		TEGRA_PIN_CAN0_DIN_PAA3,
   983	};
   984	static const unsigned int can0_stb_paa4_pins[] = {
   985		TEGRA_PIN_CAN0_STB_PAA4,
   986	};
   987	static const unsigned int can0_en_paa5_pins[] = {
   988		TEGRA_PIN_CAN0_EN_PAA5,
   989	};
   990	static const unsigned int can0_wake_paa6_pins[] = {
   991		TEGRA_PIN_CAN0_WAKE_PAA6,
   992	};
   993	static const unsigned int can0_err_paa7_pins[] = {
   994		TEGRA_PIN_CAN0_ERR_PAA7,
   995	};
   996	static const unsigned int can1_stb_pbb0_pins[] = {
   997		TEGRA_PIN_CAN1_STB_PBB0,
   998	};
   999	static const unsigned int can1_en_pbb1_pins[] = {
  1000		TEGRA_PIN_CAN1_EN_PBB1,
  1001	};
  1002	static const unsigned int can1_wake_pbb2_pins[] = {
  1003		TEGRA_PIN_CAN1_WAKE_PBB2,
  1004	};
  1005	static const unsigned int can1_err_pbb3_pins[] = {
  1006		TEGRA_PIN_CAN1_ERR_PBB3,
  1007	};
  1008	static const unsigned int spi2_sck_pcc0_pins[] = {
  1009		TEGRA_PIN_SPI2_SCK_PCC0,
  1010	};
  1011	static const unsigned int spi2_miso_pcc1_pins[] = {
  1012		TEGRA_PIN_SPI2_MISO_PCC1,
  1013	};
  1014	static const unsigned int spi2_mosi_pcc2_pins[] = {
  1015		TEGRA_PIN_SPI2_MOSI_PCC2,
  1016	};
  1017	static const unsigned int spi2_cs0_pcc3_pins[] = {
  1018		TEGRA_PIN_SPI2_CS0_PCC3,
  1019	};
  1020	static const unsigned int touch_clk_pcc4_pins[] = {
  1021		TEGRA_PIN_TOUCH_CLK_PCC4,
  1022	};
  1023	static const unsigned int uart3_tx_pcc5_pins[] = {
  1024		TEGRA_PIN_UART3_TX_PCC5,
  1025	};
  1026	static const unsigned int uart3_rx_pcc6_pins[] = {
  1027		TEGRA_PIN_UART3_RX_PCC6,
  1028	};
  1029	static const unsigned int gen2_i2c_scl_pcc7_pins[] = {
  1030		TEGRA_PIN_GEN2_I2C_SCL_PCC7,
  1031	};
  1032	static const unsigned int gen2_i2c_sda_pdd0_pins[] = {
  1033		TEGRA_PIN_GEN2_I2C_SDA_PDD0,
  1034	};
  1035	static const unsigned int gen8_i2c_scl_pdd1_pins[] = {
  1036		TEGRA_PIN_GEN8_I2C_SCL_PDD1,
  1037	};
  1038	static const unsigned int gen8_i2c_sda_pdd2_pins[] = {
  1039		TEGRA_PIN_GEN8_I2C_SDA_PDD2,
  1040	};
  1041	static const unsigned int safe_state_pee0_pins[] = {
  1042		TEGRA_PIN_SAFE_STATE_PEE0,
  1043	};
  1044	static const unsigned int vcomp_alert_pee1_pins[] = {
  1045		TEGRA_PIN_VCOMP_ALERT_PEE1,
  1046	};
  1047	static const unsigned int ao_retention_n_pee2_pins[] = {
  1048		TEGRA_PIN_AO_RETENTION_N_PEE2,
  1049	};
  1050	static const unsigned int batt_oc_pee3_pins[] = {
  1051		TEGRA_PIN_BATT_OC_PEE3,
  1052	};
  1053	static const unsigned int power_on_pee4_pins[] = {
  1054		TEGRA_PIN_POWER_ON_PEE4,
  1055	};
  1056	static const unsigned int pwr_i2c_scl_pee5_pins[] = {
  1057		TEGRA_PIN_PWR_I2C_SCL_PEE5,
  1058	};
  1059	static const unsigned int pwr_i2c_sda_pee6_pins[] = {
  1060		TEGRA_PIN_PWR_I2C_SDA_PEE6,
  1061	};
  1062	static const unsigned int ufs0_ref_clk_pff0_pins[] = {
  1063		TEGRA_PIN_UFS0_REF_CLK_PFF0,
  1064	};
  1065	static const unsigned int ufs0_rst_pff1_pins[] = {
  1066		TEGRA_PIN_UFS0_RST_PFF1,
  1067	};
  1068	static const unsigned int pex_l5_clkreq_n_pgg0_pins[] = {
  1069		TEGRA_PIN_PEX_L5_CLKREQ_N_PGG0,
  1070	};
  1071	static const unsigned int pex_l5_rst_n_pgg1_pins[] = {
  1072		TEGRA_PIN_PEX_L5_RST_N_PGG1,
  1073	};
  1074	static const unsigned int directdc_comp_pins[] = {
  1075		TEGRA_PIN_DIRECTDC_COMP,
  1076	};
  1077	static const unsigned int sdmmc4_clk_pins[] = {
  1078		TEGRA_PIN_SDMMC4_CLK,
  1079	};
  1080	static const unsigned int sdmmc4_cmd_pins[] = {
  1081		TEGRA_PIN_SDMMC4_CMD,
  1082	};
  1083	static const unsigned int sdmmc4_dqs_pins[] = {
  1084		TEGRA_PIN_SDMMC4_DQS,
  1085	};
  1086	static const unsigned int sdmmc4_dat7_pins[] = {
  1087		TEGRA_PIN_SDMMC4_DAT7,
  1088	};
  1089	static const unsigned int sdmmc4_dat6_pins[] = {
  1090		TEGRA_PIN_SDMMC4_DAT6,
  1091	};
  1092	static const unsigned int sdmmc4_dat5_pins[] = {
  1093		TEGRA_PIN_SDMMC4_DAT5,
  1094	};
  1095	static const unsigned int sdmmc4_dat4_pins[] = {
  1096		TEGRA_PIN_SDMMC4_DAT4,
  1097	};
  1098	static const unsigned int sdmmc4_dat3_pins[] = {
  1099		TEGRA_PIN_SDMMC4_DAT3,
  1100	};
  1101	static const unsigned int sdmmc4_dat2_pins[] = {
  1102		TEGRA_PIN_SDMMC4_DAT2,
  1103	};
  1104	static const unsigned int sdmmc4_dat1_pins[] = {
  1105		TEGRA_PIN_SDMMC4_DAT1,
  1106	};
  1107	static const unsigned int sdmmc4_dat0_pins[] = {
  1108		TEGRA_PIN_SDMMC4_DAT0,
  1109	};
  1110	static const unsigned int sdmmc1_comp_pins[] = {
  1111		TEGRA_PIN_SDMMC1_COMP,
  1112	};
> 1113	static const unsigned int sdmmc1_hv_trim_pins[] = {
  1114		TEGRA_PIN_SDMMC1_HV_TRIM,
  1115	};
  1116	static const unsigned int sdmmc3_comp_pins[] = {
  1117		TEGRA_PIN_SDMMC3_COMP,
  1118	};
> 1119	static const unsigned int sdmmc3_hv_trim_pins[] = {
  1120		TEGRA_PIN_SDMMC3_HV_TRIM,
  1121	};
  1122	static const unsigned int eqos_comp_pins[] = {
  1123		TEGRA_PIN_EQOS_COMP,
  1124	};
  1125	static const unsigned int qspi_comp_pins[] = {
  1126		TEGRA_PIN_QSPI_COMP,
  1127	};
> 1128	static const unsigned int sys_reset_n_pins[] = {
  1129		TEGRA_PIN_SYS_RESET_N,
  1130	};
  1131	static const unsigned int shutdown_n_pins[] = {
  1132		TEGRA_PIN_SHUTDOWN_N,
  1133	};
  1134	static const unsigned int pmu_int_n_pins[] = {
  1135		TEGRA_PIN_PMU_INT_N,
  1136	};
  1137	static const unsigned int soc_pwr_req_pins[] = {
  1138		TEGRA_PIN_SOC_PWR_REQ,
  1139	};
  1140	static const unsigned int clk_32k_in_pins[] = {
  1141		TEGRA_PIN_CLK_32K_IN,
  1142	};
  1143	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD90492E39
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245281AbiARTNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:13:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:52208 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245130AbiARTNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642533188; x=1674069188;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BXNS1bTUDqh0oQ1WR0mnyRRTaK2frHrBYh6HpN8lKwo=;
  b=JEx8qh+uAvZc7wrjnVd146WaaiSqt8yDWsAP2AU8LMcCOcjEeaoNbA2e
   UGCs8zYBa3LUfg8hhvL9WmJw/kjHaSFu0InC9xVMgdtD0VJ+1Efmd7CP3
   VGtQQGgeEThEQ4mO7makFIA63RJ7brkJr1j4LZHXmqq1rP6qbfNrlmK8e
   9mJ00MbX5M5smvIHTtwuNGJLC/g1MzJX1rhTz9AZezs5F8VTfLRFYh/UF
   zZ66VhYBuGxhSY2ZezLQ8TwMXsc1XDDfMPiIwVV9qjrAnViWx9Fl4AQ7P
   UzUPouM3mAf/7jJAIjN6S427c0yu5NWkdZk0symlGfIIdPAJD56yxm8tG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="308233473"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="308233473"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 11:13:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="474866555"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Jan 2022 11:13:05 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9tuj-000CsQ-7A; Tue, 18 Jan 2022 19:13:05 +0000
Date:   Wed, 19 Jan 2022 03:12:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive-5.16.y 61/80] drivers/net/phy/motorcomm.c:163:5:
 warning: no previous prototype for 'genphy_config_init'
Message-ID: <202201190351.34Nj9vc7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive-5.16.y
head:   eeeb46a916e77aecbe1699537a5592746f3130f6
commit: d4993dd33c50b5ea0db8f5a8cdcd0dee5458b299 [61/80] net: phy: motorcomm: Support the YT8521 gigabit PHY
config: ia64-randconfig-r021-20220116 (https://download.01.org/0day-ci/archive/20220119/202201190351.34Nj9vc7-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/d4993dd33c50b5ea0db8f5a8cdcd0dee5458b299
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive-5.16.y
        git checkout d4993dd33c50b5ea0db8f5a8cdcd0dee5458b299
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/net/phy/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from arch/ia64/include/asm/uaccess.h:40,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/compat.h:17,
                    from include/linux/ethtool.h:17,
                    from include/linux/phy.h:16,
                    from drivers/net/phy/motorcomm.c:10:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   drivers/net/phy/motorcomm.c: At top level:
>> drivers/net/phy/motorcomm.c:163:5: warning: no previous prototype for 'genphy_config_init' [-Wmissing-prototypes]
     163 | int genphy_config_init(struct phy_device *phydev)
         |     ^~~~~~~~~~~~~~~~~~
>> drivers/net/phy/motorcomm.c:195:5: warning: no previous prototype for 'yt8521_soft_reset' [-Wmissing-prototypes]
     195 | int yt8521_soft_reset(struct phy_device *phydev)
         |     ^~~~~~~~~~~~~~~~~
>> drivers/net/phy/motorcomm.c:484:5: warning: no previous prototype for 'yt8521_suspend' [-Wmissing-prototypes]
     484 | int yt8521_suspend(struct phy_device *phydev)
         |     ^~~~~~~~~~~~~~
>> drivers/net/phy/motorcomm.c:503:5: warning: no previous prototype for 'yt8521_resume' [-Wmissing-prototypes]
     503 | int yt8521_resume(struct phy_device *phydev)
         |     ^~~~~~~~~~~~~
   drivers/net/phy/motorcomm.c:14:33: warning: initialized field overwritten [-Woverride-init]
      14 | #define MOTORCOMM_PHY_ID_MASK   0x00000fff
         |                                 ^~~~~~~~~~
   drivers/net/phy/motorcomm.c:556:35: note: in expansion of macro 'MOTORCOMM_PHY_ID_MASK'
     556 |                 .phy_id_mask    = MOTORCOMM_PHY_ID_MASK,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/motorcomm.c:14:33: note: (near initialization for 'motorcomm_phy_drvs[1].phy_id_mask')
      14 | #define MOTORCOMM_PHY_ID_MASK   0x00000fff
         |                                 ^~~~~~~~~~
   drivers/net/phy/motorcomm.c:556:35: note: in expansion of macro 'MOTORCOMM_PHY_ID_MASK'
     556 |                 .phy_id_mask    = MOTORCOMM_PHY_ID_MASK,
         |                                   ^~~~~~~~~~~~~~~~~~~~~


vim +/genphy_config_init +163 drivers/net/phy/motorcomm.c

  > 10	#include <linux/phy.h>
    11	
    12	#define PHY_ID_YT8511		0x0000010a
    13	#define PHY_ID_YT8521 		0x0000011a
    14	#define MOTORCOMM_PHY_ID_MASK 	0x00000fff
    15	
    16	#define YT8511_PAGE_SELECT	0x1e
    17	#define YT8511_PAGE		0x1f
    18	#define YT8511_EXT_CLK_GATE	0x0c
    19	#define YT8511_EXT_DELAY_DRIVE	0x0d
    20	#define YT8511_EXT_SLEEP_CTRL	0x27
    21	
    22	/* 2b00 25m from pll
    23	 * 2b01 25m from xtl *default*
    24	 * 2b10 62.m from pll
    25	 * 2b11 125m from pll
    26	 */
    27	#define YT8511_CLK_125M		(BIT(2) | BIT(1))
    28	#define YT8511_PLLON_SLP	BIT(14)
    29	
    30	/* RX Delay enabled = 1.8ns 1000T, 8ns 10/100T */
    31	#define YT8511_DELAY_RX		BIT(0)
    32	
    33	/* TX Gig-E Delay is bits 7:4, default 0x5
    34	 * TX Fast-E Delay is bits 15:12, default 0xf
    35	 * Delay = 150ps * N - 250ps
    36	 * On = 2000ps, off = 50ps
    37	 */
    38	#define YT8511_DELAY_GE_TX_EN	(0xf << 4)
    39	#define YT8511_DELAY_GE_TX_DIS	(0x2 << 4)
    40	#define YT8511_DELAY_FE_TX_EN	(0xf << 12)
    41	#define YT8511_DELAY_FE_TX_DIS	(0x2 << 12)
    42	
    43	#define YT8521_SLEEP_SW_EN 	BIT(15)
    44	#define YT8521_LINK_STATUS 	BIT(10)
    45	#define YT8521_DUPLEX 		0x2000
    46	#define YT8521_SPEED_MODE 	0xc000
    47	#define YTPHY_REG_SPACE_UTP 	0
    48	#define YTPHY_REG_SPACE_FIBER 	2
    49	#define REG_PHY_SPEC_STATUS 	0x11
    50	/* based on yt8521 wol config register */
    51	#define YTPHY_UTP_INTR_REG 	0x12
    52	
    53	#define SYS_WAKEUP_BASED_ON_ETH_PKT 	0
    54	
    55	/* to enable system WOL of phy, please define this macro to 1
    56	 * otherwise, define it to 0.
    57	 */
    58	#define YTPHY_ENABLE_WOL 	0
    59	
    60	#if (YTPHY_ENABLE_WOL)
    61		#undef SYS_WAKEUP_BASED_ON_ETH_PKT
    62		#define SYS_WAKEUP_BASED_ON_ETH_PKT     1
    63	#endif
    64	
    65	#if (YTPHY_ENABLE_WOL)
    66	enum ytphy_wol_type_e {
    67		YTPHY_WOL_TYPE_LEVEL,
    68		YTPHY_WOL_TYPE_PULSE,
    69		YTPHY_WOL_TYPE_MAX
    70	};
    71	typedef enum ytphy_wol_type_e ytphy_wol_type_t;
    72	
    73	enum ytphy_wol_width_e {
    74		YTPHY_WOL_WIDTH_84MS,
    75		YTPHY_WOL_WIDTH_168MS,
    76		YTPHY_WOL_WIDTH_336MS,
    77		YTPHY_WOL_WIDTH_672MS,
    78		YTPHY_WOL_WIDTH_MAX
    79	};
    80	typedef enum ytphy_wol_width_e ytphy_wol_width_t;
    81	
    82	struct ytphy_wol_cfg_s {
    83		int enable;
    84		int type;
    85		int width;
    86	};
    87	typedef struct ytphy_wol_cfg_s ytphy_wol_cfg_t;
    88	#endif /*(YTPHY_ENABLE_WOL)*/
    89	
    90	static int yt8511_read_page(struct phy_device *phydev)
    91	{
    92		return __phy_read(phydev, YT8511_PAGE_SELECT);
    93	};
    94	
    95	static int yt8511_write_page(struct phy_device *phydev, int page)
    96	{
    97		return __phy_write(phydev, YT8511_PAGE_SELECT, page);
    98	};
    99	
   100	static int yt8511_config_init(struct phy_device *phydev)
   101	{
   102		int oldpage, ret = 0;
   103		unsigned int ge, fe;
   104	
   105		oldpage = phy_select_page(phydev, YT8511_EXT_CLK_GATE);
   106		if (oldpage < 0)
   107			goto err_restore_page;
   108	
   109		/* set rgmii delay mode */
   110		switch (phydev->interface) {
   111		case PHY_INTERFACE_MODE_RGMII:
   112			ge = YT8511_DELAY_GE_TX_DIS;
   113			fe = YT8511_DELAY_FE_TX_DIS;
   114			break;
   115		case PHY_INTERFACE_MODE_RGMII_RXID:
   116			ge = YT8511_DELAY_RX | YT8511_DELAY_GE_TX_DIS;
   117			fe = YT8511_DELAY_FE_TX_DIS;
   118			break;
   119		case PHY_INTERFACE_MODE_RGMII_TXID:
   120			ge = YT8511_DELAY_GE_TX_EN;
   121			fe = YT8511_DELAY_FE_TX_EN;
   122			break;
   123		case PHY_INTERFACE_MODE_RGMII_ID:
   124			ge = YT8511_DELAY_RX | YT8511_DELAY_GE_TX_EN;
   125			fe = YT8511_DELAY_FE_TX_EN;
   126			break;
   127		default: /* do not support other modes */
   128			ret = -EOPNOTSUPP;
   129			goto err_restore_page;
   130		}
   131	
   132		ret = __phy_modify(phydev, YT8511_PAGE, (YT8511_DELAY_RX | YT8511_DELAY_GE_TX_EN), ge);
   133		if (ret < 0)
   134			goto err_restore_page;
   135	
   136		/* set clock mode to 125mhz */
   137		ret = __phy_modify(phydev, YT8511_PAGE, 0, YT8511_CLK_125M);
   138		if (ret < 0)
   139			goto err_restore_page;
   140	
   141		/* fast ethernet delay is in a separate page */
   142		ret = __phy_write(phydev, YT8511_PAGE_SELECT, YT8511_EXT_DELAY_DRIVE);
   143		if (ret < 0)
   144			goto err_restore_page;
   145	
   146		ret = __phy_modify(phydev, YT8511_PAGE, YT8511_DELAY_FE_TX_EN, fe);
   147		if (ret < 0)
   148			goto err_restore_page;
   149	
   150		/* leave pll enabled in sleep */
   151		ret = __phy_write(phydev, YT8511_PAGE_SELECT, YT8511_EXT_SLEEP_CTRL);
   152		if (ret < 0)
   153			goto err_restore_page;
   154	
   155		ret = __phy_modify(phydev, YT8511_PAGE, 0, YT8511_PLLON_SLP);
   156		if (ret < 0)
   157			goto err_restore_page;
   158	
   159	err_restore_page:
   160		return phy_restore_page(phydev, oldpage, ret);
   161	}
   162	
 > 163	int genphy_config_init(struct phy_device *phydev)
   164	{
   165		return genphy_read_abilities(phydev);
   166	}
   167	
   168	static int ytphy_read_ext(struct phy_device *phydev, u32 regnum)
   169	{
   170		int ret;
   171		int val;
   172	
   173		ret = phy_write(phydev, YT8511_PAGE_SELECT, regnum);
   174		if (ret < 0)
   175			return ret;
   176	
   177		val = phy_read(phydev, YT8511_PAGE);
   178	
   179		return val;
   180	}
   181	
   182	static int ytphy_write_ext(struct phy_device *phydev, u32 regnum, u16 val)
   183	{
   184		int ret;
   185	
   186		ret = phy_write(phydev, YT8511_PAGE_SELECT, regnum);
   187		if (ret < 0)
   188			return ret;
   189	
   190		ret = phy_write(phydev, YT8511_PAGE, val);
   191	
   192		return ret;
   193	}
   194	
 > 195	int yt8521_soft_reset(struct phy_device *phydev)
   196	{
   197		int ret, val;
   198	
   199		val = ytphy_read_ext(phydev, 0xa001);
   200		ytphy_write_ext(phydev, 0xa001, (val & ~0x8000));
   201	
   202		ret = genphy_soft_reset(phydev);
   203		if (ret < 0)
   204			return ret;
   205	
   206		return 0;
   207	}
   208	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17632475DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244873AbhLOQk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:40:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:60507 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230350AbhLOQk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639586427; x=1671122427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vhEBbZ+jwYEuILt3HN04Xco0CXoxwLOvM2i5TvA0zyo=;
  b=HeP/6gFjJgn8YNGi5++UrAcBCVbRdqOPSCk4t/f2Pg0cs3SdkGTJ8Pkd
   OyCbuDwRwvUOh7cbdSEHZvVaP1YA6SHysFQOhljS4fgTH4n+haRx3r1Ao
   7NV4fe/i4C67ifxV62/zesimIx4AMcvP3LizZqxelW4JjFSzbTI5IFp89
   P25SsWsbrfYfiX3ZMeL0I+fl2wSt1rPffu2KumQt538aQj+SryGzErdDq
   eAhck6i0PyZx1llZzMs6yLvqQ7suWBQgVHPXGu2Qr72i9LxnD/NMdjz0x
   B4kW3P1+io6nShqZOY92pbVy7dfQYHSw36QDo02gd7mXq+QTEBgsZ67TQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="238009442"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="238009442"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 08:38:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="505874551"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Dec 2021 08:38:07 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxXI6-00023A-Ax; Wed, 15 Dec 2021 16:38:06 +0000
Date:   Thu, 16 Dec 2021 00:37:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Shih <vincent.sunplus@gmail.com>,
        srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com, vincent.shih@sunplus.com
Cc:     kbuild-all@lists.01.org, Vincent Shih <vincent.sunplus@gmail.com>
Subject: Re: [PATCH v3 1/2] nvmem: Add driver for OCOTP in Sunplus SP7021
Message-ID: <202112160054.c4ehe4QI-lkp@intel.com>
References: <1639568148-22872-2-git-send-email-vincent.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639568148-22872-2-git-send-email-vincent.sunplus@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linux/master linus/master v5.16-rc5 next-20211214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Vincent-Shih/Add-driver-for-OCOTP-in-Sunplus-SP7021/20211215-193707
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20211216/202112160054.c4ehe4QI-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c0a3142f164bb92fe79eafeb333050e7fcf42560
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Vincent-Shih/Add-driver-for-OCOTP-in-Sunplus-SP7021/20211215-193707
        git checkout c0a3142f164bb92fe79eafeb333050e7fcf42560
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/nvmem/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:555,
                    from include/linux/kernel.h:20,
                    from include/linux/clk.h:13,
                    from drivers/nvmem/sunplus-ocotp.c:9:
   drivers/nvmem/sunplus-ocotp.c: In function 'sp_ocotp_probe':
>> drivers/nvmem/sunplus-ocotp.c:206:22: warning: format '%d' expects argument of type 'int', but argument 6 has type 'long unsigned int' [-Wformat=]
     206 |         dev_dbg(dev, "banks:%d x wpb:%d x wsize:%d = %d",
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/nvmem/sunplus-ocotp.c:206:9: note: in expansion of macro 'dev_dbg'
     206 |         dev_dbg(dev, "banks:%d x wpb:%d x wsize:%d = %d",
         |         ^~~~~~~
   drivers/nvmem/sunplus-ocotp.c:206:50: note: format string is defined here
     206 |         dev_dbg(dev, "banks:%d x wpb:%d x wsize:%d = %d",
         |                                                 ~^
         |                                                  |
         |                                                  int
         |                                                 %ld
   In file included from include/linux/printk.h:555,
                    from include/linux/kernel.h:20,
                    from include/linux/clk.h:13,
                    from drivers/nvmem/sunplus-ocotp.c:9:
   drivers/nvmem/sunplus-ocotp.c:206:22: warning: format '%d' expects argument of type 'int', but argument 7 has type 'long unsigned int' [-Wformat=]
     206 |         dev_dbg(dev, "banks:%d x wpb:%d x wsize:%d = %d",
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/nvmem/sunplus-ocotp.c:206:9: note: in expansion of macro 'dev_dbg'
     206 |         dev_dbg(dev, "banks:%d x wpb:%d x wsize:%d = %d",
         |         ^~~~~~~
   drivers/nvmem/sunplus-ocotp.c:206:55: note: format string is defined here
     206 |         dev_dbg(dev, "banks:%d x wpb:%d x wsize:%d = %d",
         |                                                      ~^
         |                                                       |
         |                                                       int
         |                                                      %ld
   drivers/nvmem/sunplus-ocotp.c:158:37: warning: variable 'otp_data' set but not used [-Wunused-but-set-variable]
     158 |         const struct sp_ocotp_data *otp_data;
         |                                     ^~~~~~~~


vim +206 drivers/nvmem/sunplus-ocotp.c

     2	
     3	/*
     4	 * The OCOTP driver for Sunplus	SP7021
     5	 *
     6	 * Copyright (C) 2019 Sunplus Technology Inc., All rights reserved.
     7	 */
     8	
   > 9	#include <linux/clk.h>
    10	#include <linux/delay.h>
    11	#include <linux/device.h>
    12	#include <linux/io.h>
    13	#include <linux/iopoll.h>
    14	#include <linux/module.h>
    15	#include <linux/nvmem-provider.h>
    16	#include <linux/of_device.h>
    17	#include <linux/platform_device.h>
    18	
    19	/*
    20	 * OTP memory
    21	 * Each bank contains 4 words (32 bits).
    22	 * Bank 0 starts at offset 0 from the base.
    23	 */
    24	
    25	#define OTP_WORDS_PER_BANK		4
    26	#define OTP_WORD_SIZE			sizeof(u32)
    27	#define OTP_BIT_ADDR_OF_BANK		(8 * OTP_WORD_SIZE * OTP_WORDS_PER_BANK)
    28	#define QAC628_OTP_NUM_BANKS		8
    29	#define QAC628_OTP_SIZE			(QAC628_OTP_NUM_BANKS * OTP_WORDS_PER_BANK * OTP_WORD_SIZE)
    30	#define OTP_READ_TIMEOUT_US		200000
    31	
    32	/* HB_GPIO */
    33	#define ADDRESS_8_DATA			0x20
    34	
    35	/* OTP_RX */
    36	#define OTP_CONTROL_2			0x48
    37	#define OTP_RD_PERIOD			GENMASK(15, 8)
    38	#define OTP_RD_PERIOD_MASK		~GENMASK(15, 8)
    39	#define ONE_CPU_CLOCK			0x1
    40	#define SEL_BAK_KEY2			BIT(5)
    41	#define SEL_BAK_KEY2_MASK		~BIT(5)
    42	#define SW_TRIM_EN			BIT(4)
    43	#define SW_TRIM_EN_MASK			~BIT(4)
    44	#define SEL_BAK_KEY			BIT(3)
    45	#define SEL_BAK_KEY_MASK		~BIT(3)
    46	#define OTP_READ			BIT(2)
    47	#define OTP_LOAD_SECURE_DATA		BIT(1)
    48	#define OTP_LOAD_SECURE_DATA_MASK	~BIT(1)
    49	#define OTP_DO_CRC			BIT(0)
    50	#define OTP_DO_CRC_MASK			~BIT(0)
    51	#define OTP_STATUS			0x4c
    52	#define OTP_READ_DONE			BIT(4)
    53	#define OTP_READ_DONE_MASK		~BIT(4)
    54	#define OTP_LOAD_SECURE_DONE_MASK	~BIT(2)
    55	#define OTP_READ_ADDRESS		0x50
    56	
    57	enum base_type {
    58		HB_GPIO,
    59		OTPRX,
    60		BASEMAX,
    61	};
    62	
    63	struct sp_ocotp_priv {
    64		struct device *dev;
    65		void __iomem *base[BASEMAX];
    66		struct clk *clk;
    67	};
    68	
    69	struct sp_ocotp_data {
    70		int size;
    71	};
    72	
    73	const struct sp_ocotp_data  sp_otp_v0 = {
    74		.size = QAC628_OTP_SIZE,
    75	};
    76	
    77	static int sp_otp_read_real(struct sp_ocotp_priv *otp, int addr, char *value)
    78	{
    79		unsigned int addr_data;
    80		unsigned int byte_shift;
    81		unsigned int status;
    82		int ret;
    83	
    84		addr_data = addr % (OTP_WORD_SIZE * OTP_WORDS_PER_BANK);
    85		addr_data = addr_data / OTP_WORD_SIZE;
    86	
    87		byte_shift = addr % (OTP_WORD_SIZE * OTP_WORDS_PER_BANK);
    88		byte_shift = byte_shift % OTP_WORD_SIZE;
    89	
    90		addr = addr / (OTP_WORD_SIZE * OTP_WORDS_PER_BANK);
    91		addr = addr * OTP_BIT_ADDR_OF_BANK;
    92	
    93		writel(readl(otp->base[OTPRX] + OTP_STATUS) & OTP_READ_DONE_MASK &
    94		       OTP_LOAD_SECURE_DONE_MASK, otp->base[OTPRX] + OTP_STATUS);
    95		writel(addr, otp->base[OTPRX] + OTP_READ_ADDRESS);
    96		writel(readl(otp->base[OTPRX] + OTP_CONTROL_2) | OTP_READ,
    97		       otp->base[OTPRX] + OTP_CONTROL_2);
    98		writel(readl(otp->base[OTPRX] + OTP_CONTROL_2) & SEL_BAK_KEY2_MASK & SW_TRIM_EN_MASK
    99		       & SEL_BAK_KEY_MASK & OTP_LOAD_SECURE_DATA_MASK & OTP_DO_CRC_MASK,
   100		       otp->base[OTPRX] + OTP_CONTROL_2);
   101		writel((readl(otp->base[OTPRX] + OTP_CONTROL_2) & OTP_RD_PERIOD_MASK) |
   102		       ((ONE_CPU_CLOCK * 0x1e) << 8), otp->base[OTPRX] + OTP_CONTROL_2);
   103	
   104		ret = readl_poll_timeout(otp->base[OTPRX] + OTP_STATUS, status,
   105					 status & OTP_READ_DONE, 10, OTP_READ_TIMEOUT_US);
   106	
   107		if (ret < 0)
   108			return ret;
   109	
   110		*value = (readl(otp->base[HB_GPIO] + ADDRESS_8_DATA + addr_data * OTP_WORD_SIZE)
   111			  >> (8 * byte_shift)) & 0xff;
   112	
   113		return ret;
   114	}
   115	
   116	static int sp_ocotp_read(void *priv, unsigned int offset, void *value, size_t bytes)
   117	{
   118		struct sp_ocotp_priv *otp = priv;
   119		unsigned int addr;
   120		char *buf = value;
   121		char val[4];
   122		int ret;
   123	
   124		ret = clk_enable(otp->clk);
   125		if (ret)
   126			return ret;
   127	
   128		*buf = 0;
   129		for (addr = offset; addr < (offset + bytes); addr++) {
   130			ret = sp_otp_read_real(otp, addr, val);
   131			if (ret < 0) {
   132				dev_err(otp->dev, "OTP read fail:%d at %d", ret, addr);
   133				goto disable_clk;
   134			}
   135	
   136			*buf++ = *val;
   137		}
   138	
   139	disable_clk:
   140		clk_disable(otp->clk);
   141	
   142		return ret;
   143	}
   144	
   145	static struct nvmem_config sp_ocotp_nvmem_config = {
   146		.name = "sp-ocotp",
   147		.read_only = true,
   148		.word_size = 1,
   149		.size = QAC628_OTP_SIZE,
   150		.stride = 1,
   151		.reg_read = sp_ocotp_read,
   152		.owner = THIS_MODULE,
   153	};
   154	
   155	static int sp_ocotp_probe(struct platform_device *pdev)
   156	{
   157		const struct of_device_id *match;
   158		const struct sp_ocotp_data *otp_data;
   159		struct device *dev = &pdev->dev;
   160		struct nvmem_device *nvmem;
   161		struct sp_ocotp_priv *otp;
   162		struct resource *res;
   163		int ret;
   164	
   165		match = of_match_device(dev->driver->of_match_table, dev);
   166		if (match && match->data)
   167			otp_data = match->data;
   168	
   169		otp = devm_kzalloc(dev, sizeof(*otp), GFP_KERNEL);
   170		if (!otp)
   171			return -ENOMEM;
   172	
   173		otp->dev = dev;
   174	
   175		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hb_gpio");
   176		otp->base[HB_GPIO] = devm_ioremap_resource(dev, res);
   177		if (IS_ERR(otp->base[HB_GPIO]))
   178			return PTR_ERR(otp->base[HB_GPIO]);
   179	
   180		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otprx");
   181		otp->base[OTPRX] = devm_ioremap_resource(dev, res);
   182		if (IS_ERR(otp->base[OTPRX]))
   183			return PTR_ERR(otp->base[OTPRX]);
   184	
   185		otp->clk = devm_clk_get(&pdev->dev, NULL);
   186		if (IS_ERR(otp->clk))
   187			return dev_err_probe(&pdev->dev, PTR_ERR(otp->clk),
   188							"devm_clk_get fail\n");
   189	
   190		ret = clk_prepare(otp->clk);
   191		if (ret < 0) {
   192			dev_err(dev, "failed to prepare clk: %d\n", ret);
   193			return ret;
   194		}
   195	
   196		sp_ocotp_nvmem_config.priv = otp;
   197		sp_ocotp_nvmem_config.dev = dev;
   198	
   199		nvmem = devm_nvmem_register(dev, &sp_ocotp_nvmem_config);
   200		if (IS_ERR(nvmem))
   201			return dev_err_probe(&pdev->dev, PTR_ERR(nvmem),
   202							"register nvmem device fail\n");
   203	
   204		platform_set_drvdata(pdev, nvmem);
   205	
 > 206		dev_dbg(dev, "banks:%d x wpb:%d x wsize:%d = %d",
   207			QAC628_OTP_NUM_BANKS, OTP_WORDS_PER_BANK,
   208			OTP_WORD_SIZE, QAC628_OTP_SIZE);
   209	
   210		dev_info(dev, "by Sunplus (C) 2020");
   211	
   212		return 0;
   213	}
   214	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

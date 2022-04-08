Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1A94F931C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiDHKgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbiDHKg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:36:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD99C31E791
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649414057; x=1680950057;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uWZ6+CvphHT2bMmUhKQEAC7jbFBzswpuOyfYU8bi1Cc=;
  b=IdhEmDYQoj0Hg3j5/CY89+GS5Zl8++s7MbJroxDRoDA/k4GihImabrIp
   qp2vLd/ULS9JMVo/iah83+Busfr1Ed504r4IYGkRomtEvkInbqRaczwD8
   hpOaiWSQUS+2E8pfX10jZz6RgbaaTJXd2EP81ucW2+adnDAJc3KP7Xjn6
   u8MNFU2TLrLY6XCqGilMwTmQ7HK5pIxHM4oNpW+7He/Zxm0rQy93nVSPP
   gCm0y7o0/LWBiC0Awt9nKXC8iLN02dlZ3lWAbyLNISXwavlasyI0Qjggq
   gDHf4aG/PRFsg5Wc4yVYJ5tswt08Il8qbQBJeKibJr4T8qe0yExXX0b2I
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="249093186"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="249093186"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 03:34:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="609709665"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 08 Apr 2022 03:34:15 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nclwV-0000AH-0k;
        Fri, 08 Apr 2022 10:34:15 +0000
Date:   Fri, 8 Apr 2022 18:33:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>
Subject: [l1k:smsc95xx_5.17 578/887]
 drivers/gpu/drm/panel/panel-sitronix-st7701.c:341:1: warning: the frame size
 of 2664 bytes is larger than 2048 bytes
Message-ID: <202204081822.fgrKAt55-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: 72c355c6c7656888e6124c1356c3f68cb9cf5b35 [578/887] drm/panel/panel-sitronix-st7701: Support SPI config and RGB data
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220408/202204081822.fgrKAt55-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/72c355c6c7656888e6124c1356c3f68cb9cf5b35
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 72c355c6c7656888e6124c1356c3f68cb9cf5b35
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/drm/panel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/panel/panel-sitronix-st7701.c: In function 'txw210001b0_init_sequence':
>> drivers/gpu/drm/panel/panel-sitronix-st7701.c:341:1: warning: the frame size of 2664 bytes is larger than 2048 bytes [-Wframe-larger-than=]
     341 | }
         | ^


vim +341 drivers/gpu/drm/panel/panel-sitronix-st7701.c

   237	
   238	static void txw210001b0_init_sequence(struct st7701 *st7701)
   239	{
   240		ST7701_SPI(st7701, MIPI_DCS_SOFT_RESET);
   241	
   242		usleep_range(5000, 7000);
   243	
   244		ST7701_SPI(st7701, DSI_CMD2BKX_SEL,
   245			   0x177, 0x101, 0x100, 0x100, SPI_CMD2BK0_SEL);
   246	
   247		ST7701_SPI(st7701, DSI_CMD2_BK0_LNESET, 0x13B, 0x100);
   248	
   249		ST7701_SPI(st7701, DSI_CMD2_BK0_PORCTRL, 0x10B, 0x102);
   250	
   251		ST7701_SPI(st7701, DSI_CMD2_BK0_INVSEL, 0x100, 0x102);
   252	
   253		ST7701_SPI(st7701, 0xCC, 0x110);
   254	
   255		/*
   256		 * Gamma option B:
   257		 * Positive Voltage Gamma Control
   258		 */
   259		ST7701_SPI(st7701, DSI_CMD2_BK0_PVGAMCTRL,
   260			   0x102, 0x113, 0x11B, 0x10D, 0x110, 0x105, 0x108, 0x107,
   261			   0x107, 0x124, 0x104, 0x111, 0x10E, 0x12C, 0x133, 0x11D);
   262	
   263		/* Negative Voltage Gamma Control */
   264		ST7701_SPI(st7701, DSI_CMD2_BK0_NVGAMCTRL,
   265			   0x105, 0x113, 0x11B, 0x10D, 0x111, 0x105, 0x108, 0x107,
   266			   0x107, 0x124, 0x104, 0x111, 0x10E, 0x12C, 0x133, 0x11D);
   267	
   268		ST7701_SPI(st7701, DSI_CMD2BKX_SEL,
   269			   0x177, 0x101, 0x100, 0x100, SPI_CMD2BK1_SEL);
   270	
   271		ST7701_SPI(st7701, DSI_CMD2_BK1_VRHS, 0x15D);
   272	
   273		ST7701_SPI(st7701, DSI_CMD2_BK1_VCOM, 0x143);
   274	
   275		ST7701_SPI(st7701, DSI_CMD2_BK1_VGHSS, 0x181);
   276	
   277		ST7701_SPI(st7701, DSI_CMD2_BK1_TESTCMD, 0x180);
   278	
   279		ST7701_SPI(st7701, DSI_CMD2_BK1_VGLS, 0x143);
   280	
   281		ST7701_SPI(st7701, DSI_CMD2_BK1_PWCTLR1, 0x185);
   282	
   283		ST7701_SPI(st7701, DSI_CMD2_BK1_PWCTLR2, 0x120);
   284	
   285		ST7701_SPI(st7701, DSI_CMD2_BK1_SPD1, 0x178);
   286	
   287		ST7701_SPI(st7701, DSI_CMD2_BK1_SPD2, 0x178);
   288	
   289		ST7701_SPI(st7701, DSI_CMD2_BK1_MIPISET1, 0x188);
   290	
   291		ST7701_SPI(st7701, 0xE0, 0x100, 0x100, 0x102);
   292	
   293		ST7701_SPI(st7701, 0xE1,
   294			   0x103, 0x1A0, 0x100, 0x100, 0x104, 0x1A0, 0x100, 0x100,
   295			   0x100, 0x120, 0x120);
   296	
   297		ST7701_SPI(st7701, 0xE2,
   298			   0x100, 0x100, 0x100, 0x100, 0x100, 0x100, 0x100, 0x100,
   299			   0x100, 0x100, 0x100, 0x100, 0x100);
   300	
   301		ST7701_SPI(st7701, 0xE3, 0x100, 0x100, 0x111, 0x100);
   302	
   303		ST7701_SPI(st7701, 0xE4, 0x122, 0x100);
   304	
   305		ST7701_SPI(st7701, 0xE5,
   306			   0x105, 0x1EC, 0x1A0, 0x1A0, 0x107, 0x1EE, 0x1A0, 0x1A0,
   307			   0x100, 0x100, 0x100, 0x100, 0x100, 0x100, 0x100, 0x100);
   308	
   309		ST7701_SPI(st7701, 0xE6, 0x100, 0x100, 0x111, 0x100);
   310	
   311		ST7701_SPI(st7701, 0xE7, 0x122, 0x100);
   312	
   313		ST7701_SPI(st7701, 0xE8,
   314			   0x106, 0x1ED, 0x1A0, 0x1A0, 0x108, 0x1EF, 0x1A0, 0x1A0,
   315			   0x100, 0x100, 0x100, 0x100, 0x100, 0x100, 0x100, 0x100);
   316	
   317		ST7701_SPI(st7701, 0xEB,
   318			   0x100, 0x100, 0x140, 0x140, 0x100, 0x100, 0x100);
   319	
   320		ST7701_SPI(st7701, 0xED,
   321			   0x1FF, 0x1FF, 0x1FF, 0x1BA, 0x10A, 0x1BF, 0x145, 0x1FF,
   322			   0x1FF, 0x154, 0x1FB, 0x1A0, 0x1AB, 0x1FF, 0x1FF, 0x1FF);
   323	
   324		ST7701_SPI(st7701, 0xEF, 0x110, 0x10D, 0x104, 0x108, 0x13F, 0x11F);
   325	
   326		ST7701_SPI(st7701, DSI_CMD2BKX_SEL,
   327			   0x177, 0x101, 0x100, 0x100, SPI_CMD2BK3_SEL);
   328	
   329		ST7701_SPI(st7701, 0xEF, 0x108);
   330	
   331		ST7701_SPI(st7701, DSI_CMD2BKX_SEL,
   332			   0x177, 0x101, 0x100, 0x100, SPI_CMD2BKX_SEL_NONE);
   333	
   334		ST7701_SPI(st7701, 0xCD, 0x108);  /* RGB format COLCTRL */
   335	
   336		ST7701_SPI(st7701, 0x36, 0x108); /* MadCtl */
   337	
   338		ST7701_SPI(st7701, 0x3A, 0x166);  /* Colmod */
   339	
   340		ST7701_SPI(st7701, MIPI_DCS_EXIT_SLEEP_MODE);
 > 341	}
   342	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

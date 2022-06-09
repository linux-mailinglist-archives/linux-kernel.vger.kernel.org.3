Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FC454541E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345416AbiFIS0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiFIS0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:26:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4221EF072A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654799206; x=1686335206;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jr0lIf0jCMlZxD8aPAkcAccpuSBw8ZVqumU2RXeM7gw=;
  b=XKOsKq+/z4ZNDO7IENwwl3BcGwk9O27swwWRtpxRuw8MuiXBQOQbBL2B
   p6JpkSo3OU5fPmUlOR5J38sIWN1Lql04B5VVMUAknM3OiEccexj0C1HE3
   hAHQSTUr9PV0xw1+AbC6hz7Pa6A1YiigOD0t1QZquEbHCx77lZg1+Z2Vx
   jU0r3YmjScHAAneh1ZH6AfxcJYM9IIv2QE7h1X+LYkpplCJ7l21oKVnEU
   Qls3fd8/dN033VadKkE/LTPE7ceP/FqFUssLGoXTt2+QDz9JLDgY2AWH6
   OlOAqGxQIChTPB8R0epWCOGf3juShRno9oJ2NPtDbhjcQctRiCmteki10
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="302750416"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="302750416"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 11:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="585726010"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2022 11:26:44 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzMrk-000GGX-BB;
        Thu, 09 Jun 2022 18:26:44 +0000
Date:   Fri, 10 Jun 2022 02:26:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-lpc32xx/serial.c:63:6: warning: no previous prototype
 for 'lpc32xx_loopback_set'
Message-ID: <202206100243.FIBW6bJC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bfb56e93bcef41859c2d5ab234ffd80b691be35
commit: 7036440eab3e2d47a775d4616909f8235488d714 ARM: omap1: enable multiplatform
date:   6 days ago
config: arm-buildonly-randconfig-r012-20220608 (https://download.01.org/0day-ci/archive/20220610/202206100243.FIBW6bJC-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7036440eab3e2d47a775d4616909f8235488d714
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7036440eab3e2d47a775d4616909f8235488d714
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-lpc32xx/serial.c:63:6: warning: no previous prototype for 'lpc32xx_loopback_set' [-Wmissing-prototypes]
      63 | void lpc32xx_loopback_set(resource_size_t mapbase, int state)
         |      ^~~~~~~~~~~~~~~~~~~~


vim +/lpc32xx_loopback_set +63 arch/arm/mach-lpc32xx/serial.c

e6e912c4964ce5 Kevin Wells   2010-07-27  61  
ffba29c9ebd097 Arnd Bergmann 2019-08-09  62  /* LPC3250 Errata HSUART.1: Hang workaround via loopback mode on inactivity */
ffba29c9ebd097 Arnd Bergmann 2019-08-09 @63  void lpc32xx_loopback_set(resource_size_t mapbase, int state)
ffba29c9ebd097 Arnd Bergmann 2019-08-09  64  {
ffba29c9ebd097 Arnd Bergmann 2019-08-09  65  	int bit;
ffba29c9ebd097 Arnd Bergmann 2019-08-09  66  	u32 tmp;
ffba29c9ebd097 Arnd Bergmann 2019-08-09  67  
ffba29c9ebd097 Arnd Bergmann 2019-08-09  68  	switch (mapbase) {
ffba29c9ebd097 Arnd Bergmann 2019-08-09  69  	case LPC32XX_HS_UART1_BASE:
ffba29c9ebd097 Arnd Bergmann 2019-08-09  70  		bit = 0;
ffba29c9ebd097 Arnd Bergmann 2019-08-09  71  		break;
ffba29c9ebd097 Arnd Bergmann 2019-08-09  72  	case LPC32XX_HS_UART2_BASE:
ffba29c9ebd097 Arnd Bergmann 2019-08-09  73  		bit = 1;
ffba29c9ebd097 Arnd Bergmann 2019-08-09  74  		break;
ffba29c9ebd097 Arnd Bergmann 2019-08-09  75  	case LPC32XX_HS_UART7_BASE:
ffba29c9ebd097 Arnd Bergmann 2019-08-09  76  		bit = 6;
ffba29c9ebd097 Arnd Bergmann 2019-08-09  77  		break;
ffba29c9ebd097 Arnd Bergmann 2019-08-09  78  	default:
ffba29c9ebd097 Arnd Bergmann 2019-08-09  79  		WARN(1, "lpc32xx_hs: Warning: Unknown port at %08x\n", mapbase);
ffba29c9ebd097 Arnd Bergmann 2019-08-09  80  		return;
ffba29c9ebd097 Arnd Bergmann 2019-08-09  81  	}
ffba29c9ebd097 Arnd Bergmann 2019-08-09  82  
ffba29c9ebd097 Arnd Bergmann 2019-08-09  83  	tmp = readl(LPC32XX_UARTCTL_CLOOP);
ffba29c9ebd097 Arnd Bergmann 2019-08-09  84  	if (state)
ffba29c9ebd097 Arnd Bergmann 2019-08-09  85  		tmp |= (1 << bit);
ffba29c9ebd097 Arnd Bergmann 2019-08-09  86  	else
ffba29c9ebd097 Arnd Bergmann 2019-08-09  87  		tmp &= ~(1 << bit);
ffba29c9ebd097 Arnd Bergmann 2019-08-09  88  	writel(tmp, LPC32XX_UARTCTL_CLOOP);
ffba29c9ebd097 Arnd Bergmann 2019-08-09  89  }
ffba29c9ebd097 Arnd Bergmann 2019-08-09  90  EXPORT_SYMBOL_GPL(lpc32xx_loopback_set);
ffba29c9ebd097 Arnd Bergmann 2019-08-09  91  

:::::: The code at line 63 was first introduced by commit
:::::: ffba29c9ebd0977dbf77bf6064776716a51b8ae5 serial: lpc32xx: allow compile testing

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

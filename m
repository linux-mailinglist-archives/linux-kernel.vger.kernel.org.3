Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1644C23FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiBXGRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiBXGRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:17:36 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3A9673F7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645683426; x=1677219426;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G2mdp6HxN1a+2naZZWsU9dYVOxgWYVpBp/V4/N2e1OM=;
  b=YhRph+ioSUwe3Jjxj8POTO3twwXZphmxakL5QP1KDNNJYtPO+3QgKCIt
   cD96poDyOvJg96KkSN+vc2SH1TdiBdyLyq1CUZbn6jgGs/1ycAIvWU37N
   YJR1vqO4afdaXMwxRKwcgXDcWPIb7mJEymr6W2taKPhcPD1NwFgv+AH88
   Itg+S47WbrlpVic7krMTIxTFm8Z8rI9UvzWXhB4ku7z64ujusWyMkNvFO
   m93epqn3khoIGRyszaBTOI7Xc3pskIoEsTHlWQP5Y9JjNtleJsk3E09Ul
   gwaIzwjyxYlYszyh5qKKQAmYWYuFVa8JEyzuV3PQnm+QrBqkHO6DRKlrl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="315386284"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="315386284"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 22:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="548598902"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Feb 2022 22:17:05 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN7R2-0002LO-G3; Thu, 24 Feb 2022 06:17:04 +0000
Date:   Thu, 24 Feb 2022 14:16:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2145/2340]
 arch/mips/include/asm/mach-lantiq/lantiq.h:14:33: error: implicit
 declaration of function '__raw_readl'; did you mean '__raw_emt'?
Message-ID: <202202241447.nXvL1YYU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: fffdadeabd0c2d37ab9e2d170c1676dad47ffe6c [2145/2340] headers/deps: node: Optimize <linux/node.h> dependencies
config: mips-xway_defconfig (https://download.01.org/0day-ci/archive/20220224/202202241447.nXvL1YYU-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=fffdadeabd0c2d37ab9e2d170c1676dad47ffe6c
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout fffdadeabd0c2d37ab9e2d170c1676dad47ffe6c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/irq.h:20,
                    from arch/mips/include/asm/mach-lantiq/lantiq.h:9,
                    from arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h:12,
                    from arch/mips/lantiq/early_printk.c:8:
   arch/mips/include/asm/irq.h:23:20: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'init_IRQ'
      23 | extern void __init init_IRQ(void);
         |                    ^~~~~~~~
   In file included from arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h:12,
                    from arch/mips/lantiq/early_printk.c:8:
   arch/mips/lantiq/early_printk.c: In function 'prom_putchar':
>> arch/mips/include/asm/mach-lantiq/lantiq.h:14:33: error: implicit declaration of function '__raw_readl'; did you mean '__raw_emt'? [-Werror=implicit-function-declaration]
      14 | #define ltq_r32(reg)            __raw_readl(reg)
         |                                 ^~~~~~~~~~~
   arch/mips/lantiq/early_printk.c:26:24: note: in expansion of macro 'ltq_r32'
      26 |         do { } while ((ltq_r32(LTQ_ASC_FSTAT) & TXMASK) >> TXOFFSET);
         |                        ^~~~~~~
>> arch/mips/include/asm/mach-lantiq/lantiq.h:19:33: error: implicit declaration of function '__raw_writeb' [-Werror=implicit-function-declaration]
      19 | #define ltq_w8(val, reg)        __raw_writeb(val, reg)
         |                                 ^~~~~~~~~~~~
   arch/mips/lantiq/early_printk.c:28:17: note: in expansion of macro 'ltq_w8'
      28 |                 ltq_w8('\r', LTQ_ASC_TBUF);
         |                 ^~~~~~
   cc1: some warnings being treated as errors
--
   In file included from arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h:12,
                    from arch/mips/lantiq/xway/dcdc.c:12:
   arch/mips/lantiq/xway/dcdc.c: In function 'dcdc_probe':
>> arch/mips/include/asm/mach-lantiq/lantiq.h:18:33: error: implicit declaration of function '__raw_readb'; did you mean '__raw_emt'? [-Werror=implicit-function-declaration]
      18 | #define ltq_r8(reg)             __raw_readb(reg)
         |                                 ^~~~~~~~~~~
   arch/mips/lantiq/xway/dcdc.c:20:25: note: in expansion of macro 'ltq_r8'
      20 | #define dcdc_r8(x)      ltq_r8(dcdc_membase + (x))
         |                         ^~~~~~
   include/linux/dev_printk.h:114:37: note: in expansion of macro 'dcdc_r8'
     114 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   include/linux/dev_printk.h:154:9: note: in expansion of macro 'dev_printk_index_wrap'
     154 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/lantiq/xway/dcdc.c:33:9: note: in expansion of macro 'dev_info'
      33 |         dev_info(&pdev->dev, "Core Voltage : %d mV\n",
         |         ^~~~~~~~
   arch/mips/lantiq/xway/dcdc.c: At top level:
   arch/mips/lantiq/xway/dcdc.c:52:12: warning: no previous prototype for 'dcdc_init' [-Wmissing-prototypes]
      52 | int __init dcdc_init(void)
         |            ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +14 arch/mips/include/asm/mach-lantiq/lantiq.h

171bb2f19ed6f3 John Crispin 2011-03-30   8  
171bb2f19ed6f3 John Crispin 2011-03-30  @9  #include <linux/irq.h>
287e3f3f4e68ca John Crispin 2012-04-17  10  #include <linux/device.h>
287e3f3f4e68ca John Crispin 2012-04-17  11  #include <linux/clk.h>
171bb2f19ed6f3 John Crispin 2011-03-30  12  
171bb2f19ed6f3 John Crispin 2011-03-30  13  /* generic reg access functions */
171bb2f19ed6f3 John Crispin 2011-03-30 @14  #define ltq_r32(reg)		__raw_readl(reg)
171bb2f19ed6f3 John Crispin 2011-03-30  15  #define ltq_w32(val, reg)	__raw_writel(val, reg)
171bb2f19ed6f3 John Crispin 2011-03-30  16  #define ltq_w32_mask(clear, set, reg)	\
171bb2f19ed6f3 John Crispin 2011-03-30  17  	ltq_w32((ltq_r32(reg) & ~(clear)) | (set), reg)
171bb2f19ed6f3 John Crispin 2011-03-30 @18  #define ltq_r8(reg)		__raw_readb(reg)
171bb2f19ed6f3 John Crispin 2011-03-30 @19  #define ltq_w8(val, reg)	__raw_writeb(val, reg)
171bb2f19ed6f3 John Crispin 2011-03-30  20  

:::::: The code at line 14 was first introduced by commit
:::::: 171bb2f19ed6f3627f4f783f658f2f475b2fbd50 MIPS: Lantiq: Add initial support for Lantiq SoCs

:::::: TO: John Crispin <blogic@openwrt.org>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

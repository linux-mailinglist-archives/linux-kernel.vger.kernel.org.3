Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A0E4C2541
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiBXILv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiBXILs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:11:48 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D9520BCD5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645690278; x=1677226278;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B33AJ7iUj2kTidnDH/M+Fm7R0cxyn03PrezJi+a4Wlk=;
  b=cLtmIuHmcJIottE6/uiQ0vpYVFzwVjN4RlG2PPZ2/+HvbMzrVug+3c9O
   aSd5WMqQIQL9DNbkms4UBA20hPqG06L7rPR1hKTUyBmjp7kj5Z8FMQHgx
   U2M9X6rKlXcboyZuw+pS14TgHKz4qPWYAI7cCSlC3ncjVeDcbLeubcjo7
   SqWwZgFsurDOwDfbv81gveJjPmdzyt8oF+lw+Z7wL0TeoDQ5h3G4AJ/XH
   ijZOYNjaUPi4xokKMsoTqHthqFr6RmIhPvOp0UlfPU4pzB/Ggo9fBMoy9
   QX4C5e3r4TPgd08wOE8ul7S+/dVn2DqJ4oWXMMhOhJxoEuT2/SPTEhv9O
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="251005355"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="251005355"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 00:11:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="506233015"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Feb 2022 00:11:16 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN9DX-0002th-HJ; Thu, 24 Feb 2022 08:11:15 +0000
Date:   Thu, 24 Feb 2022 16:10:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2200/2340]
 arch/mips/include/asm/mach-lantiq/lantiq.h:15:33: error: implicit
 declaration of function '__raw_writel'
Message-ID: <202202241608.GjG8zfIj-lkp@intel.com>
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
commit: 3828a1a70a61b6a815d092a41ce8bc2af2eb3d92 [2200/2340] headers/deps: irq: Optimize <linux/interrupt.h> dependencies
config: mips-xway_defconfig (https://download.01.org/0day-ci/archive/20220224/202202241608.GjG8zfIj-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=3828a1a70a61b6a815d092a41ce8bc2af2eb3d92
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 3828a1a70a61b6a815d092a41ce8bc2af2eb3d92
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h:12,
                    from arch/mips/lantiq/xway/gptu.c:16:
   arch/mips/lantiq/xway/gptu.c: In function 'timer_irq_handler':
>> arch/mips/include/asm/mach-lantiq/lantiq.h:15:33: error: implicit declaration of function '__raw_writel' [-Werror=implicit-function-declaration]
      15 | #define ltq_w32(val, reg)       __raw_writel(val, reg)
         |                                 ^~~~~~~~~~~~
   arch/mips/lantiq/xway/gptu.c:60:25: note: in expansion of macro 'ltq_w32'
      60 | #define gptu_w32(x, y)  ltq_w32((x), gptu_membase + (y))
         |                         ^~~~~~~
   arch/mips/lantiq/xway/gptu.c:78:9: note: in expansion of macro 'gptu_w32'
      78 |         gptu_w32(1 << timer, GPTU_IRNCR);
         |         ^~~~~~~~
   arch/mips/lantiq/xway/gptu.c: In function 'gptu_enable':
   arch/mips/include/asm/mach-lantiq/lantiq.h:14:33: error: implicit declaration of function '__raw_readl'; did you mean '__raw_emt'? [-Werror=implicit-function-declaration]
      14 | #define ltq_r32(reg)            __raw_readl(reg)
         |                                 ^~~~~~~~~~~
   arch/mips/include/asm/mach-lantiq/lantiq.h:15:46: note: in definition of macro 'ltq_w32'
      15 | #define ltq_w32(val, reg)       __raw_writel(val, reg)
         |                                              ^~~
   arch/mips/lantiq/xway/gptu.c:108:9: note: in expansion of macro 'gptu_w32'
     108 |         gptu_w32(gptu_r32(GPTU_IRNEN) | BIT(clk->bits), GPTU_IRNEN);
         |         ^~~~~~~~
   arch/mips/lantiq/xway/gptu.c:61:25: note: in expansion of macro 'ltq_r32'
      61 | #define gptu_r32(x)     ltq_r32(gptu_membase + (x))
         |                         ^~~~~~~
   arch/mips/lantiq/xway/gptu.c:108:18: note: in expansion of macro 'gptu_r32'
     108 |         gptu_w32(gptu_r32(GPTU_IRNEN) | BIT(clk->bits), GPTU_IRNEN);
         |                  ^~~~~~~~
   arch/mips/lantiq/xway/gptu.c: At top level:
   arch/mips/lantiq/xway/gptu.c:199:12: warning: no previous prototype for 'gptu_init' [-Wmissing-prototypes]
     199 | int __init gptu_init(void)
         |            ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/__raw_writel +15 arch/mips/include/asm/mach-lantiq/lantiq.h

171bb2f19ed6f3 John Crispin 2011-03-30  12  
171bb2f19ed6f3 John Crispin 2011-03-30  13  /* generic reg access functions */
171bb2f19ed6f3 John Crispin 2011-03-30  14  #define ltq_r32(reg)		__raw_readl(reg)
171bb2f19ed6f3 John Crispin 2011-03-30 @15  #define ltq_w32(val, reg)	__raw_writel(val, reg)
171bb2f19ed6f3 John Crispin 2011-03-30  16  #define ltq_w32_mask(clear, set, reg)	\
171bb2f19ed6f3 John Crispin 2011-03-30  17  	ltq_w32((ltq_r32(reg) & ~(clear)) | (set), reg)
171bb2f19ed6f3 John Crispin 2011-03-30  18  #define ltq_r8(reg)		__raw_readb(reg)
171bb2f19ed6f3 John Crispin 2011-03-30  19  #define ltq_w8(val, reg)	__raw_writeb(val, reg)
171bb2f19ed6f3 John Crispin 2011-03-30  20  

:::::: The code at line 15 was first introduced by commit
:::::: 171bb2f19ed6f3627f4f783f658f2f475b2fbd50 MIPS: Lantiq: Add initial support for Lantiq SoCs

:::::: TO: John Crispin <blogic@openwrt.org>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

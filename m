Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869EC4BF1EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 07:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiBVGLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 01:11:25 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiBVGLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 01:11:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E88C3331
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 22:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645510255; x=1677046255;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9ilr9rbsDwfjmR9iFtIV52yKRpeR9y4HwxI7wXpXrB8=;
  b=GWMOSDK/DfO4k5DLJgwPk1L8wQ9Qy94hEawHDFHqwDC0u0reP1WTJiib
   n8jVaq8nEC/Va7oHBUDA7umPjExjNDn7uUYh9xezwQyOzjkGb6ngKWpk7
   xo6gAmWtWnOVDR00sQDHV3CLVke6PEXWAtv3XC317RYB2bUAslV6dvSJF
   ll0viYGpxbSNEDc+pV7phDFrHObqf4ragHrZYv2JeF6nr4XxacUjTSMXm
   8IxaU0C1GrrQQwvljHteJdnPUlUURS9WwHGWy/WdzPhEPiwLXNQyhKTCY
   nFlMK3ozwU0z+W65IVmqu1jRGjnpjpF7QhYRMIzW4w1NbBbjfDLHyZ5DE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="276217983"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="276217983"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 22:10:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="532099330"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 21 Feb 2022 22:10:54 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMONx-0002Oa-CP; Tue, 22 Feb 2022 06:10:53 +0000
Date:   Tue, 22 Feb 2022 14:10:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2122/2541]
 arch/s390/include/asm/processor.h:307:13: error: use of undeclared
 identifier '_THIS_IP_'
Message-ID: <202202221415.RGRWi3xN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   601144c0da5edfa67a9654158370da19c67e17e2
commit: 58809689cf88dc9300f57d8a653053ae3d36acbd [2122/2541] headers/deps: Add header dependencies to .h files: <linux/xarray_api.h>
config: s390-randconfig-r044-20220221 (https://download.01.org/0day-ci/archive/20220222/202202221415.RGRWi3xN-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=58809689cf88dc9300f57d8a653053ae3d36acbd
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 58809689cf88dc9300f57d8a653053ae3d36acbd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:6:
   In file included from include/linux/xarray_api.h:15:
   In file included from include/linux/lockdep_api.h:27:
   In file included from include/linux/smp_api.h:15:
   In file included from arch/s390/include/asm/smp.h:13:
>> arch/s390/include/asm/processor.h:307:13: error: use of undeclared identifier '_THIS_IP_'
           psw.addr = _THIS_IP_;
                      ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:6:
   In file included from include/linux/xarray_api.h:15:
   In file included from include/linux/lockdep_api.h:27:
   In file included from include/linux/smp_api.h:15:
   arch/s390/include/asm/smp.h:20:30: error: expected ';' after top level declarator
   extern __vector128 __initdata boot_cpu_vector_save_area[__NUM_VXRS];
                                ^
                                ;
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:6:
   In file included from include/linux/xarray_api.h:19:
   In file included from include/linux/rcupdate.h:35:
   include/linux/sched/per_task.h:48:11: fatal error: 'generated/asm-offsets.h' file not found
   # include <generated/asm-offsets.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~
   3 errors generated.
   make[2]: *** [scripts/Makefile.build:121: arch/s390/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/_THIS_IP_ +307 arch/s390/include/asm/processor.h

ccf45cafb08059 arch/s390/include/asm/processor.h Martin Schwidefsky 2011-10-30  298  
^1da177e4c3f41 include/asm-s390/processor.h      Linus Torvalds     2005-04-16  299  /*
^1da177e4c3f41 include/asm-s390/processor.h      Linus Torvalds     2005-04-16  300   * Function to drop a processor into disabled wait state
^1da177e4c3f41 include/asm-s390/processor.h      Linus Torvalds     2005-04-16  301   */
c2e06e15ad92ba arch/s390/include/asm/processor.h Vasily Gorbik      2019-11-22  302  static __always_inline void __noreturn disabled_wait(void)
^1da177e4c3f41 include/asm-s390/processor.h      Linus Torvalds     2005-04-16  303  {
f9e6edfb9cf780 arch/s390/include/asm/processor.h Heiko Carstens     2015-10-12  304  	psw_t psw;
^1da177e4c3f41 include/asm-s390/processor.h      Linus Torvalds     2005-04-16  305  
f9e6edfb9cf780 arch/s390/include/asm/processor.h Heiko Carstens     2015-10-12  306  	psw.mask = PSW_MASK_BASE | PSW_MASK_WAIT | PSW_MASK_BA | PSW_MASK_EA;
98587c2d894c34 arch/s390/include/asm/processor.h Martin Schwidefsky 2019-04-30 @307  	psw.addr = _THIS_IP_;
f9e6edfb9cf780 arch/s390/include/asm/processor.h Heiko Carstens     2015-10-12  308  	__load_psw(psw);
edd5378740fe77 arch/s390/include/asm/processor.h Heiko Carstens     2008-12-25  309  	while (1);
^1da177e4c3f41 include/asm-s390/processor.h      Linus Torvalds     2005-04-16  310  }
^1da177e4c3f41 include/asm-s390/processor.h      Linus Torvalds     2005-04-16  311  

:::::: The code at line 307 was first introduced by commit
:::::: 98587c2d894c34c9af5cd84ca169e1cd493aa692 s390: simplify disabled_wait

:::::: TO: Martin Schwidefsky <schwidefsky@de.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

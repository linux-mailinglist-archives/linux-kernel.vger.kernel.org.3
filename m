Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96ADA4BD21E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 22:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbiBTVyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 16:54:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiBTVyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 16:54:17 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA4A45042
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 13:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645394035; x=1676930035;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LEL1b7/tuy5ceRYvQ++4pYP3b52TQMK4mxMVw+e3fPs=;
  b=RauJz5wvqFhC/bJX0fAGizuJPQtUQoHJ2iMo6PFYTiZtcvc0ugvHx9SZ
   YCthLbhkSgAVDWPSD65wKfMNpGtbZpqyXDAkFNcgD4rl6jqB0e2F8Qqww
   SKB3H29BK/StisnMFcYMpZgRvDKC5kLFce5o1X+35DU2tFLu3Qwj8drcX
   KDqEfuZFpABVY7V+ddTBz3DiUHaMjySZF5vmWcCUXRERzWnGjIrzi7yWI
   mZMdt+ltkhAemSXbeWlRptuSGXSFfFUDFNZI2cOV/+ylrxBP99BUkoZX3
   txgQwu7iBRto3pI4rfI+AkWAaJ9C59DZSOT9M8Q8nZ8URbCqXPOXNjMyO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="337836940"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="337836940"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 13:53:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="542429454"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Feb 2022 13:53:54 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLu9R-0000tX-U1; Sun, 20 Feb 2022 21:53:53 +0000
Date:   Mon, 21 Feb 2022 05:53:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2139/2574]
 arch/s390/include/asm/processor.h:307:20: error: '_THIS_IP_' undeclared
Message-ID: <202202210504.E38I3DPN-lkp@intel.com>
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
head:   39e8a0edc8fae20758051dadf7846849edc18b88
commit: 527f0e93e404425f87af25a12814598872904167 [2139/2574] headers/deps: Add header dependencies to .h files: <linux/xarray_api.h>
config: s390-randconfig-r044-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210504.E38I3DPN-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=527f0e93e404425f87af25a12814598872904167
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 527f0e93e404425f87af25a12814598872904167
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/s390/include/asm/smp.h:13,
                    from include/linux/smp_api.h:15,
                    from include/linux/lockdep_api.h:27,
                    from include/linux/xarray_api.h:15,
                    from include/linux/kvm_host.h:6,
                    from arch/s390/kernel/asm-offsets.c:11:
   arch/s390/include/asm/processor.h: In function 'disabled_wait':
>> arch/s390/include/asm/processor.h:307:20: error: '_THIS_IP_' undeclared (first use in this function)
     307 |         psw.addr = _THIS_IP_;
         |                    ^~~~~~~~~
   arch/s390/include/asm/processor.h:307:20: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/smp_api.h:15,
                    from include/linux/lockdep_api.h:27,
                    from include/linux/xarray_api.h:15,
                    from include/linux/kvm_host.h:6,
                    from arch/s390/kernel/asm-offsets.c:11:
   arch/s390/include/asm/smp.h: At top level:
   arch/s390/include/asm/smp.h:20:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'boot_cpu_vector_save_area'
      20 | extern __vector128 __initdata boot_cpu_vector_save_area[__NUM_VXRS];
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/rcupdate.h:35,
                    from include/linux/xarray_api.h:19,
                    from include/linux/kvm_host.h:6,
                    from arch/s390/kernel/asm-offsets.c:11:
   include/linux/sched/per_task.h:48:11: fatal error: generated/asm-offsets.h: No such file or directory
      48 | # include <generated/asm-offsets.h>
         |           ^~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:121: arch/s390/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/_THIS_IP_ +307 arch/s390/include/asm/processor.h

ccf45cafb080597 arch/s390/include/asm/processor.h Martin Schwidefsky 2011-10-30  298  
^1da177e4c3f415 include/asm-s390/processor.h      Linus Torvalds     2005-04-16  299  /*
^1da177e4c3f415 include/asm-s390/processor.h      Linus Torvalds     2005-04-16  300   * Function to drop a processor into disabled wait state
^1da177e4c3f415 include/asm-s390/processor.h      Linus Torvalds     2005-04-16  301   */
c2e06e15ad92bad arch/s390/include/asm/processor.h Vasily Gorbik      2019-11-22  302  static __always_inline void __noreturn disabled_wait(void)
^1da177e4c3f415 include/asm-s390/processor.h      Linus Torvalds     2005-04-16  303  {
f9e6edfb9cf780e arch/s390/include/asm/processor.h Heiko Carstens     2015-10-12  304  	psw_t psw;
^1da177e4c3f415 include/asm-s390/processor.h      Linus Torvalds     2005-04-16  305  
f9e6edfb9cf780e arch/s390/include/asm/processor.h Heiko Carstens     2015-10-12  306  	psw.mask = PSW_MASK_BASE | PSW_MASK_WAIT | PSW_MASK_BA | PSW_MASK_EA;
98587c2d894c34c arch/s390/include/asm/processor.h Martin Schwidefsky 2019-04-30 @307  	psw.addr = _THIS_IP_;
f9e6edfb9cf780e arch/s390/include/asm/processor.h Heiko Carstens     2015-10-12  308  	__load_psw(psw);
edd5378740fe771 arch/s390/include/asm/processor.h Heiko Carstens     2008-12-25  309  	while (1);
^1da177e4c3f415 include/asm-s390/processor.h      Linus Torvalds     2005-04-16  310  }
^1da177e4c3f415 include/asm-s390/processor.h      Linus Torvalds     2005-04-16  311  

:::::: The code at line 307 was first introduced by commit
:::::: 98587c2d894c34c9af5cd84ca169e1cd493aa692 s390: simplify disabled_wait

:::::: TO: Martin Schwidefsky <schwidefsky@de.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

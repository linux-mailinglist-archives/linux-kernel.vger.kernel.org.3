Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C46047F52E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 06:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhLZFVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 00:21:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:35145 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhLZFVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 00:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640496094; x=1672032094;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zaySb8wm+mdG8FyNCb+IWh6TWBPfyn6Pm9Yk0WzPLIA=;
  b=S5NXJBdR+e8eYlGrBIYEt4VxnTvscK3OialF3xAanwZiA1MFWzpfnRfa
   VPc2YnZzZdowln4S/5k1gp43sMu1qqcq2ZdWO1n4QOn7laKN0uH2rpq0E
   wZsw9u2vrza3MdgK/wrVh5VN8YUs5EBSD/LTivnZc2IQu6EEsfTBh718T
   Rm/xIppiXt0nnBeAYkXiiMMIi0N81PsQzGHcmCCpxIgDEjg9hjHOJZcR1
   x3aOr9eqtNKJkQ9t0iJDO2smtbBElD6Faxex6S+OLbVpixNCuZCxVCGD/
   5cLXrsORsxqRGxseI+lgJXRsClZxOjmCN3yS4aUDX5Y6rR1vXJ9aXPEA9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="241037726"
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="241037726"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 21:21:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="467558673"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Dec 2021 21:21:32 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1LyO-00056S-5h; Sun, 26 Dec 2021 05:21:32 +0000
Date:   Sun, 26 Dec 2021 13:20:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Axtens <dja@axtens.net>
Subject: [linux-stable-rc:queue/4.9 7215/9999]
 arch/powerpc/kernel/setup_64.c:763:6: error: no previous declaration for
 'uaccess_flush_enable'
Message-ID: <202112261356.iId9eLe9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.9
head:   df4b9763cd1e19cb238b3ea65d3257f1e10357c3
commit: d67c5c60a4225d98e24381f2da8f449e50733e81 [7215/9999] powerpc/64s: flush L1D after user accesses
config: powerpc64-allnoconfig (https://download.01.org/0day-ci/archive/20211226/202112261356.iId9eLe9-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=d67c5c60a4225d98e24381f2da8f449e50733e81
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/4.9
        git checkout d67c5c60a4225d98e24381f2da8f449e50733e81
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the linux-stable-rc/queue/4.9 HEAD df4b9763cd1e19cb238b3ea65d3257f1e10357c3 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/kup.h:10:0,
                    from arch/powerpc/include/asm/uaccess.h:12,
                    from include/asm-generic/termios-base.h:7,
                    from arch/powerpc/include/asm/termios.h:20,
                    from include/uapi/linux/termios.h:5,
                    from include/linux/tty.h:6,
                    from arch/powerpc/kernel/setup_64.c:27:
   arch/powerpc/include/asm/book3s/64/kup-radix.h:5:1: error: data definition has no type or storage class [-Werror]
    DECLARE_STATIC_KEY_FALSE(uaccess_flush_key);
    ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/kup-radix.h:5:1: error: type defaults to 'int' in declaration of 'DECLARE_STATIC_KEY_FALSE' [-Werror=implicit-int]
   arch/powerpc/include/asm/book3s/64/kup-radix.h:5:1: error: parameter names (without types) in function declaration [-Werror]
   arch/powerpc/include/asm/book3s/64/kup-radix.h: In function 'prevent_user_access':
   arch/powerpc/include/asm/book3s/64/kup-radix.h:18:6: error: implicit declaration of function 'static_branch_unlikely' [-Werror=implicit-function-declaration]
     if (static_branch_unlikely(&uaccess_flush_key))
         ^~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/kup-radix.h:18:30: error: 'uaccess_flush_key' undeclared (first use in this function); did you mean 'do_uaccess_flush'?
     if (static_branch_unlikely(&uaccess_flush_key))
                                 ^~~~~~~~~~~~~~~~~
                                 do_uaccess_flush
   arch/powerpc/include/asm/book3s/64/kup-radix.h:18:30: note: each undeclared identifier is reported only once for each function it appears in
   In file included from arch/powerpc/include/asm/bug.h:127:0,
                    from include/linux/bug.h:4,
                    from include/linux/thread_info.h:11,
                    from include/asm-generic/preempt.h:4,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/uapi/linux/timex.h:56,
                    from include/linux/timex.h:56,
                    from include/linux/sched.h:19,
                    from arch/powerpc/kernel/setup_64.c:17:
   include/linux/dma-mapping.h: In function 'dma_map_resource':
   arch/powerpc/include/asm/page.h:129:32: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
    #define pfn_valid(pfn)  ((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
                                   ^
   include/asm-generic/bug.h:155:36: note: in definition of macro 'BUG_ON'
    #define BUG_ON(condition) do { if (condition) BUG(); } while (0)
                                       ^~~~~~~~~
   include/linux/dma-mapping.h:284:9: note: in expansion of macro 'pfn_valid'
     BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
            ^~~~~~~~~
   arch/powerpc/kernel/setup_64.c: At top level:
   arch/powerpc/kernel/setup_64.c:281:13: error: no previous declaration for 'early_setup' [-Werror=missing-declarations]
    void __init early_setup(unsigned long dt_ptr)
                ^~~~~~~~~~~
   arch/powerpc/kernel/setup_64.c:421:13: error: no previous declaration for 'initialize_cache_info' [-Werror=missing-declarations]
    void __init initialize_cache_info(void)
                ^~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/setup_64.c:514:13: error: no previous declaration for 'irqstack_early_init' [-Werror=missing-declarations]
    void __init irqstack_early_init(void)
                ^~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/setup_64.c:563:13: error: no previous declaration for 'emergency_stack_init' [-Werror=missing-declarations]
    void __init emergency_stack_init(void)
                ^~~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/setup_64.c:751:6: error: no previous declaration for 'entry_flush_enable' [-Werror=missing-declarations]
    void entry_flush_enable(bool enable)
         ^~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/setup_64.c:763:6: error: no previous declaration for 'uaccess_flush_enable' [-Werror=missing-declarations]
    void uaccess_flush_enable(bool enable)
         ^~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/serial_8250.h:14:0,
                    from arch/powerpc/kernel/setup_64.c:33:
   include/linux/serial_core.h:387:19: error: 'earlycon_init_is_deferred' defined but not used [-Werror=unused-const-variable=]
    static const bool earlycon_init_is_deferred;
                      ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/uaccess_flush_enable +763 arch/powerpc/kernel/setup_64.c

   762	
 > 763	void uaccess_flush_enable(bool enable)
   764	{
   765		if (enable) {
   766			do_uaccess_flush_fixups(enabled_flush_types);
   767			static_branch_enable(&uaccess_flush_key);
   768			on_each_cpu(do_nothing, NULL, 1);
   769		} else {
   770			static_branch_disable(&uaccess_flush_key);
   771			do_uaccess_flush_fixups(L1D_FLUSH_NONE);
   772		}
   773	
   774		uaccess_flush = enable;
   775	}
   776	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

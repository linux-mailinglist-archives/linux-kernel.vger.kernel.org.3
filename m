Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BBC47F505
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 04:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhLZD3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 22:29:32 -0500
Received: from mga11.intel.com ([192.55.52.93]:22301 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhLZD3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 22:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640489371; x=1672025371;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5ElQq4gpAVPALai+j0BM0iv/S75vjYqlUstawFtXNh4=;
  b=SY3t5tG1lFABufKZ1uh5XgxbzW7+HXCuacb0op5MHB83SMobY68BCEW6
   JrRwIszYvvVCjsrhv74twLDAvX/ZLX0iBUWUEkIuHMGoMzfXEJuRgd5zi
   XXPY0Uc7lZGxWUvUYGUl/vPUpbwLnEYRrWmOfGtOoclfL/7y33+ydhOKB
   qICyVTnkJPNNEyC2qhvPW7NRWgUThNEJP1gyJk815ojlGXT4YETuDurBu
   WbzYOg53DrRJubhNT7krTOegkgD2c22MCB69i5UwM/bIauwm1QXIkgPPx
   U9sVXzw3JDbnQP6a5WXhyAFpwxlqJHYvKSNavCx2mdKbeUmnNnWPF1iaa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="238619072"
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="238619072"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 19:29:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="685957085"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Dec 2021 19:29:29 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1KDw-0004zN-Vg; Sun, 26 Dec 2021 03:29:28 +0000
Date:   Sun, 26 Dec 2021 11:29:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Axtens <dja@axtens.net>
Subject: [linux-stable-rc:queue/4.9 7210/9999]
 arch/powerpc/kernel/setup_64.c:739:6: error: no previous declaration for
 'entry_flush_enable'
Message-ID: <202112261104.AZtG9CvC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.9
head:   df4b9763cd1e19cb238b3ea65d3257f1e10357c3
commit: fa4bf9f38184ed7ca4916eb64f8c767d1e279c1f [7210/9999] powerpc/64s: flush L1D on kernel entry
config: powerpc64-allnoconfig (https://download.01.org/0day-ci/archive/20211226/202112261104.AZtG9CvC-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=fa4bf9f38184ed7ca4916eb64f8c767d1e279c1f
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/4.9
        git checkout fa4bf9f38184ed7ca4916eb64f8c767d1e279c1f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the linux-stable-rc/queue/4.9 HEAD df4b9763cd1e19cb238b3ea65d3257f1e10357c3 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

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
>> arch/powerpc/kernel/setup_64.c:739:6: error: no previous declaration for 'entry_flush_enable' [-Werror=missing-declarations]
    void entry_flush_enable(bool enable)
         ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/serial_8250.h:14:0,
                    from arch/powerpc/kernel/setup_64.c:33:
   include/linux/serial_core.h:387:19: error: 'earlycon_init_is_deferred' defined but not used [-Werror=unused-const-variable=]
    static const bool earlycon_init_is_deferred;
                      ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/entry_flush_enable +739 arch/powerpc/kernel/setup_64.c

   738	
 > 739	void entry_flush_enable(bool enable)
   740	{
   741		if (enable) {
   742			do_entry_flush_fixups(enabled_flush_types);
   743			on_each_cpu(do_nothing, NULL, 1);
   744		} else {
   745			do_entry_flush_fixups(L1D_FLUSH_NONE);
   746		}
   747	
   748		entry_flush = enable;
   749	}
   750	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

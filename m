Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE6B4B154E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245759AbiBJSfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:35:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiBJSfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:35:06 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789FC195
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644518106; x=1676054106;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9GWiOlqBELONBFdDSp3YdMGj2rAPPUNrkye0GUuhEZE=;
  b=JFv76xbBR2Ka3gdl6ZwqiYuPiH/nXCVPrJkER6ubrw5Twft0ime3poTs
   VULIr/03xFx3gDKk2vDtci0NoaZgZLTxFnYtv7thWTG/ZXvjDha+Ss3TG
   gvX3ke8EPrGkPKv5j708bu5961qE1uvTQBCCPZjcUj2YXwWIYiX34jcHG
   QbP/RVLJbD68ZJVwpDvvzbBXfV0+PkQoT3LI0CZzvfM0Fqh5G3acQ2QE7
   j/RAND2pBrK9hdPJ0vIv9tvAOPSevy+w8tf39LwsEZoMUhfXLlJrEpDjC
   15NgMsdT75HPwPaoYMT8sJI9MvmP15yIqlbHuQ41XJyGCLVfP56TwipT1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="335980127"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="335980127"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 10:35:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="482869793"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 Feb 2022 10:35:03 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIEHW-0003at-SD; Thu, 10 Feb 2022 18:35:02 +0000
Date:   Fri, 11 Feb 2022 02:34:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [csky-linux:riscv_compat_v6_svpbmt-v6 35/35]
 arch/riscv/include/asm/pgtable.h:167:35: error: '_PAGE_PMA' undeclared
Message-ID: <202202110244.QjvpBb6X-lkp@intel.com>
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

tree:   https://github.com/c-sky/csky-linux riscv_compat_v6_svpbmt-v6
head:   54acb36c958fc990cc59889f79c8ddca7386c295
commit: 54acb36c958fc990cc59889f79c8ddca7386c295 [35/35] riscv: xtpbmt: Fixup T-HEAD CPU _PAGE_KERNEL quirks
config: riscv-randconfig-r026-20220209 (https://download.01.org/0day-ci/archive/20220211/202202110244.QjvpBb6X-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/c-sky/csky-linux/commit/54acb36c958fc990cc59889f79c8ddca7386c295
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v6_svpbmt-v6
        git checkout 54acb36c958fc990cc59889f79c8ddca7386c295
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/pgtable.h:6,
                    from arch/riscv/include/asm/io.h:15,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from ./arch/riscv/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from arch/riscv/kernel/irq.c:8:
   include/asm-generic/io.h: In function 'ioremap':
>> arch/riscv/include/asm/pgtable.h:167:35: error: '_PAGE_PMA' undeclared (first use in this function)
     167 |                                 | _PAGE_PMA \
         |                                   ^~~~~~~~~
   arch/riscv/include/asm/pgtable.h:178:27: note: in expansion of macro '_PAGE_KERNEL'
     178 | #define _PAGE_IOREMAP   ((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
         |                           ^~~~~~~~~~~~
   include/asm-generic/io.h:973:41: note: in expansion of macro '_PAGE_IOREMAP'
     973 |         return ioremap_prot(addr, size, _PAGE_IOREMAP);
         |                                         ^~~~~~~~~~~~~
   arch/riscv/include/asm/pgtable.h:167:35: note: each undeclared identifier is reported only once for each function it appears in
     167 |                                 | _PAGE_PMA \
         |                                   ^~~~~~~~~
   arch/riscv/include/asm/pgtable.h:178:27: note: in expansion of macro '_PAGE_KERNEL'
     178 | #define _PAGE_IOREMAP   ((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
         |                           ^~~~~~~~~~~~
   include/asm-generic/io.h:973:41: note: in expansion of macro '_PAGE_IOREMAP'
     973 |         return ioremap_prot(addr, size, _PAGE_IOREMAP);
         |                                         ^~~~~~~~~~~~~
--
   In file included from include/linux/pgtable.h:6,
                    from include/linux/mm.h:33,
                    from arch/riscv/kernel/setup.c:12:
   include/asm-generic/io.h: In function 'ioremap':
>> arch/riscv/include/asm/pgtable.h:167:35: error: '_PAGE_PMA' undeclared (first use in this function)
     167 |                                 | _PAGE_PMA \
         |                                   ^~~~~~~~~
   arch/riscv/include/asm/pgtable.h:178:27: note: in expansion of macro '_PAGE_KERNEL'
     178 | #define _PAGE_IOREMAP   ((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
         |                           ^~~~~~~~~~~~
   include/asm-generic/io.h:973:41: note: in expansion of macro '_PAGE_IOREMAP'
     973 |         return ioremap_prot(addr, size, _PAGE_IOREMAP);
         |                                         ^~~~~~~~~~~~~
   arch/riscv/include/asm/pgtable.h:167:35: note: each undeclared identifier is reported only once for each function it appears in
     167 |                                 | _PAGE_PMA \
         |                                   ^~~~~~~~~
   arch/riscv/include/asm/pgtable.h:178:27: note: in expansion of macro '_PAGE_KERNEL'
     178 | #define _PAGE_IOREMAP   ((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
         |                           ^~~~~~~~~~~~
   include/asm-generic/io.h:973:41: note: in expansion of macro '_PAGE_IOREMAP'
     973 |         return ioremap_prot(addr, size, _PAGE_IOREMAP);
         |                                         ^~~~~~~~~~~~~
   In file included from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from arch/riscv/kernel/setup.c:12:
   arch/riscv/kernel/setup.c: In function 'setup_arch':
>> arch/riscv/include/asm/pgtable.h:167:35: error: '_PAGE_PMA' undeclared (first use in this function)
     167 |                                 | _PAGE_PMA \
         |                                   ^~~~~~~~~
   arch/riscv/include/asm/page.h:80:27: note: in definition of macro 'pgprot_val'
      80 | #define pgprot_val(x)   ((x).pgprot)
         |                           ^
   arch/riscv/include/asm/pgtable.h:170:33: note: in expansion of macro '__pgprot'
     170 | #define PAGE_KERNEL             __pgprot(_PAGE_KERNEL)
         |                                 ^~~~~~~~
   arch/riscv/include/asm/pgtable.h:170:42: note: in expansion of macro '_PAGE_KERNEL'
     170 | #define PAGE_KERNEL             __pgprot(_PAGE_KERNEL)
         |                                          ^~~~~~~~~~~~
   include/linux/printk.h:418:33: note: in expansion of macro 'PAGE_KERNEL'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
     446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~~~~~~
   arch/riscv/kernel/setup.c:270:1: note: in expansion of macro 'printk'
     270 | printk("%s: _PAGE_KERNEL: 0x%lx\n", __func__, pgprot_val(PAGE_KERNEL));
         | ^~~~~~
   In file included from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from arch/riscv/kernel/setup.c:12:
>> arch/riscv/kernel/setup.c:271:8: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'int' [-Wformat=]
     271 | printk("%s: _PAGE_IO: 0x%llx\n", __func__, _PAGE_IO);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   arch/riscv/kernel/setup.c:271:1: note: in expansion of macro 'printk'
     271 | printk("%s: _PAGE_IO: 0x%llx\n", __func__, _PAGE_IO);
         | ^~~~~~
   arch/riscv/kernel/setup.c:271:28: note: format string is defined here
     271 | printk("%s: _PAGE_IO: 0x%llx\n", __func__, _PAGE_IO);
         |                         ~~~^
         |                            |
         |                            long long unsigned int
         |                         %x
   In file included from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from arch/riscv/kernel/setup.c:12:
   arch/riscv/kernel/setup.c:272:8: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'int' [-Wformat=]
     272 | printk("%s: _PAGE_NOCACHE: 0x%llx\n", __func__, _PAGE_NOCACHE);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   arch/riscv/kernel/setup.c:272:1: note: in expansion of macro 'printk'
     272 | printk("%s: _PAGE_NOCACHE: 0x%llx\n", __func__, _PAGE_NOCACHE);
         | ^~~~~~
   arch/riscv/kernel/setup.c:272:33: note: format string is defined here
     272 | printk("%s: _PAGE_NOCACHE: 0x%llx\n", __func__, _PAGE_NOCACHE);
         |                              ~~~^
         |                                 |
         |                                 long long unsigned int
         |                              %x
--
   In file included from arch/riscv/include/asm/uaccess.h:12,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/compat.h:17,
                    from arch/riscv/kernel/signal.c:9:
   include/asm-generic/io.h: In function 'ioremap':
>> arch/riscv/include/asm/pgtable.h:167:35: error: '_PAGE_PMA' undeclared (first use in this function)
     167 |                                 | _PAGE_PMA \
         |                                   ^~~~~~~~~
   arch/riscv/include/asm/pgtable.h:178:27: note: in expansion of macro '_PAGE_KERNEL'
     178 | #define _PAGE_IOREMAP   ((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
         |                           ^~~~~~~~~~~~
   include/asm-generic/io.h:973:41: note: in expansion of macro '_PAGE_IOREMAP'
     973 |         return ioremap_prot(addr, size, _PAGE_IOREMAP);
         |                                         ^~~~~~~~~~~~~
   arch/riscv/include/asm/pgtable.h:167:35: note: each undeclared identifier is reported only once for each function it appears in
     167 |                                 | _PAGE_PMA \
         |                                   ^~~~~~~~~
   arch/riscv/include/asm/pgtable.h:178:27: note: in expansion of macro '_PAGE_KERNEL'
     178 | #define _PAGE_IOREMAP   ((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
         |                           ^~~~~~~~~~~~
   include/asm-generic/io.h:973:41: note: in expansion of macro '_PAGE_IOREMAP'
     973 |         return ioremap_prot(addr, size, _PAGE_IOREMAP);
         |                                         ^~~~~~~~~~~~~
   arch/riscv/kernel/signal.c: At top level:
   arch/riscv/kernel/signal.c:320:27: warning: no previous prototype for 'do_notify_resume' [-Wmissing-prototypes]
     320 | asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
         |                           ^~~~~~~~~~~~~~~~
--
   In file included from arch/riscv/include/asm/fixmap.h:55,
                    from arch/riscv/kernel/patch.c:13:
   arch/riscv/kernel/patch.c: In function 'patch_map':
>> arch/riscv/include/asm/pgtable.h:167:35: error: '_PAGE_PMA' undeclared (first use in this function)
     167 |                                 | _PAGE_PMA \
         |                                   ^~~~~~~~~
   include/asm-generic/fixmap.h:77:33: note: in definition of macro '__set_fixmap_offset'
      77 |         __set_fixmap(idx, phys, flags);                                 \
         |                                 ^~~~~
   arch/riscv/include/asm/pgtable.h:170:33: note: in expansion of macro '__pgprot'
     170 | #define PAGE_KERNEL             __pgprot(_PAGE_KERNEL)
         |                                 ^~~~~~~~
   arch/riscv/include/asm/pgtable.h:170:42: note: in expansion of macro '_PAGE_KERNEL'
     170 | #define PAGE_KERNEL             __pgprot(_PAGE_KERNEL)
         |                                          ^~~~~~~~~~~~
   include/asm-generic/fixmap.h:48:28: note: in expansion of macro 'PAGE_KERNEL'
      48 | #define FIXMAP_PAGE_NORMAL PAGE_KERNEL
         |                            ^~~~~~~~~~~
   include/asm-generic/fixmap.h:83:40: note: in expansion of macro 'FIXMAP_PAGE_NORMAL'
      83 |         __set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL)
         |                                        ^~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/patch.c:42:24: note: in expansion of macro 'set_fixmap_offset'
      42 |         return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
         |                        ^~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/pgtable.h:167:35: note: each undeclared identifier is reported only once for each function it appears in
     167 |                                 | _PAGE_PMA \
         |                                   ^~~~~~~~~
   include/asm-generic/fixmap.h:77:33: note: in definition of macro '__set_fixmap_offset'
      77 |         __set_fixmap(idx, phys, flags);                                 \
         |                                 ^~~~~
   arch/riscv/include/asm/pgtable.h:170:33: note: in expansion of macro '__pgprot'
     170 | #define PAGE_KERNEL             __pgprot(_PAGE_KERNEL)
         |                                 ^~~~~~~~
   arch/riscv/include/asm/pgtable.h:170:42: note: in expansion of macro '_PAGE_KERNEL'
     170 | #define PAGE_KERNEL             __pgprot(_PAGE_KERNEL)
         |                                          ^~~~~~~~~~~~
   include/asm-generic/fixmap.h:48:28: note: in expansion of macro 'PAGE_KERNEL'
      48 | #define FIXMAP_PAGE_NORMAL PAGE_KERNEL
         |                            ^~~~~~~~~~~
   include/asm-generic/fixmap.h:83:40: note: in expansion of macro 'FIXMAP_PAGE_NORMAL'
      83 |         __set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL)
         |                                        ^~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/patch.c:42:24: note: in expansion of macro 'set_fixmap_offset'
      42 |         return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
         |                        ^~~~~~~~~~~~~~~~~


vim +/_PAGE_PMA +167 arch/riscv/include/asm/pgtable.h

   161	
   162	#define _PAGE_KERNEL		(_PAGE_READ \
   163					| _PAGE_WRITE \
   164					| _PAGE_PRESENT \
   165					| _PAGE_ACCESSED \
   166					| _PAGE_DIRTY \
 > 167					| _PAGE_PMA \
   168					| _PAGE_GLOBAL)
   169	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

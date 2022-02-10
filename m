Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904CB4B16A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbiBJT5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:57:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240562AbiBJT5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:57:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06975F4D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 11:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644523028; x=1676059028;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6l1NuGDEgyOu0Gjn1hdPBVC3wyFXZLjKFhzlZFDEPsU=;
  b=BFrZhhoktvJnOAynBJ67w/eZSg2bOdqM/hWhuNmRj5XgQqtkNOmX9UWq
   lEguaSbBxcPov/MsaojiJjqqWQvETKydCCEmbjd/p5q42LFHZLn5yfBPM
   rBis+tBQn3iWv3ZWewX1C0sUA+/rNoBvf8McFLcpOJbuXViBZeSQU5eG5
   uG+iZblU+yZ/Gz5hsYUCqyk2uL6kEmL0hWXvrvEUnf/fFbTuuDQ/bcavi
   QYWPew/FgdV8kJDjp42BiwxizrjoNheFcLvpAOSlvrbaz8C2+ykO6afEh
   PLAjKb1gFe7ebvYu8Szcwwo32LjbUK/dOYbRqRjbXSJhxKUB4qeauyuIZ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249333271"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="249333271"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 11:57:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="485878537"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 10 Feb 2022 11:57:06 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIFYw-0003gs-19; Thu, 10 Feb 2022 19:57:06 +0000
Date:   Fri, 11 Feb 2022 03:56:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [csky-linux:riscv_compat_v6_svpbmt-v6 35/35]
 include/asm-generic/io.h:973:34: error: use of undeclared identifier
 '_PAGE_PMA'
Message-ID: <202202110318.nlUr3nQu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v6_svpbmt-v6
head:   54acb36c958fc990cc59889f79c8ddca7386c295
commit: 54acb36c958fc990cc59889f79c8ddca7386c295 [35/35] riscv: xtpbmt: Fixup T-HEAD CPU _PAGE_KERNEL quirks
config: riscv-randconfig-r042-20220208 (https://download.01.org/0day-ci/archive/20220211/202202110318.nlUr3nQu-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project aa845d7a245d85c441d0bd44fc7b6c3be8f3de8d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/c-sky/csky-linux/commit/54acb36c958fc990cc59889f79c8ddca7386c295
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v6_svpbmt-v6
        git checkout 54acb36c958fc990cc59889f79c8ddca7386c295
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/ arch/riscv/mm/ drivers/base/firmware_loader/ drivers/pci/ drivers/target/ fs/erofs/ fs/pstore/ kernel/ mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/riscv/kernel/irq.c:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:973:34: error: use of undeclared identifier '_PAGE_PMA'
           return ioremap_prot(addr, size, _PAGE_IOREMAP);
                                           ^
   arch/riscv/include/asm/pgtable.h:178:25: note: expanded from macro '_PAGE_IOREMAP'
   #define _PAGE_IOREMAP   ((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
                             ^
   arch/riscv/include/asm/pgtable.h:167:7: note: expanded from macro '_PAGE_KERNEL'
                                   | _PAGE_PMA \
                                     ^
   1 error generated.
--
   In file included from arch/riscv/kernel/setup.c:21:
   In file included from include/linux/efi.h:20:
   In file included from include/linux/rtc.h:17:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:973:34: error: use of undeclared identifier '_PAGE_PMA'
           return ioremap_prot(addr, size, _PAGE_IOREMAP);
                                           ^
   arch/riscv/include/asm/pgtable.h:178:25: note: expanded from macro '_PAGE_IOREMAP'
   #define _PAGE_IOREMAP   ((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
                             ^
   arch/riscv/include/asm/pgtable.h:167:7: note: expanded from macro '_PAGE_KERNEL'
                                   | _PAGE_PMA \
                                     ^
>> arch/riscv/kernel/setup.c:270:58: error: use of undeclared identifier '_PAGE_PMA'
   printk("%s: _PAGE_KERNEL: 0x%lx\n", __func__, pgprot_val(PAGE_KERNEL));
                                                            ^
>> arch/riscv/kernel/setup.c:271:44: warning: format specifies type 'unsigned long long' but the argument has type 'int' [-Wformat]
   printk("%s: _PAGE_IO: 0x%llx\n", __func__, _PAGE_IO);
                           ~~~~               ^~~~~~~~
                           %x
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   arch/riscv/include/asm/pgtable-32.h:28:19: note: expanded from macro '_PAGE_IO'
   #define _PAGE_IO                0
                                   ^
   arch/riscv/kernel/setup.c:272:49: warning: format specifies type 'unsigned long long' but the argument has type 'int' [-Wformat]
   printk("%s: _PAGE_NOCACHE: 0x%llx\n", __func__, _PAGE_NOCACHE);
                                ~~~~               ^~~~~~~~~~~~~
                                %x
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   arch/riscv/include/asm/pgtable-32.h:27:24: note: expanded from macro '_PAGE_NOCACHE'
   #define _PAGE_NOCACHE           0
                                   ^
   2 warnings and 2 errors generated.
--
   In file included from arch/riscv/kernel/signal.c:12:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:973:34: error: use of undeclared identifier '_PAGE_PMA'
           return ioremap_prot(addr, size, _PAGE_IOREMAP);
                                           ^
   arch/riscv/include/asm/pgtable.h:178:25: note: expanded from macro '_PAGE_IOREMAP'
   #define _PAGE_IOREMAP   ((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
                             ^
   arch/riscv/include/asm/pgtable.h:167:7: note: expanded from macro '_PAGE_KERNEL'
                                   | _PAGE_PMA \
                                     ^
   arch/riscv/kernel/signal.c:320:27: warning: no previous prototype for function 'do_notify_resume' [-Wmissing-prototypes]
   asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
                             ^
   arch/riscv/kernel/signal.c:320:22: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
                        ^
                        static 
   1 warning and 1 error generated.
--
>> arch/riscv/kernel/patch.c:42:17: error: use of undeclared identifier '_PAGE_PMA'
           return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
                          ^
   include/asm-generic/fixmap.h:83:33: note: expanded from macro 'set_fixmap_offset'
           __set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL)
                                          ^
   include/asm-generic/fixmap.h:48:28: note: expanded from macro 'FIXMAP_PAGE_NORMAL'
   #define FIXMAP_PAGE_NORMAL PAGE_KERNEL
                              ^
   arch/riscv/include/asm/pgtable.h:170:31: note: expanded from macro 'PAGE_KERNEL'
   #define PAGE_KERNEL             __pgprot(_PAGE_KERNEL)
                                            ^
   arch/riscv/include/asm/pgtable.h:167:7: note: expanded from macro '_PAGE_KERNEL'
                                   | _PAGE_PMA \
                                     ^
   1 error generated.
--
   In file included from arch/riscv/mm/init.c:13:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:973:34: error: use of undeclared identifier '_PAGE_PMA'
           return ioremap_prot(addr, size, _PAGE_IOREMAP);
                                           ^
   arch/riscv/include/asm/pgtable.h:178:25: note: expanded from macro '_PAGE_IOREMAP'
   #define _PAGE_IOREMAP   ((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
                             ^
   arch/riscv/include/asm/pgtable.h:167:7: note: expanded from macro '_PAGE_KERNEL'
                                   | _PAGE_PMA \
                                     ^
>> arch/riscv/mm/init.c:264:18: error: use of undeclared identifier '_PAGE_PMA'
           return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
                           ^
   include/asm-generic/fixmap.h:83:33: note: expanded from macro 'set_fixmap_offset'
           __set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL)
                                          ^
   include/asm-generic/fixmap.h:48:28: note: expanded from macro 'FIXMAP_PAGE_NORMAL'
   #define FIXMAP_PAGE_NORMAL PAGE_KERNEL
                              ^
   arch/riscv/include/asm/pgtable.h:170:31: note: expanded from macro 'PAGE_KERNEL'
   #define PAGE_KERNEL             __pgprot(_PAGE_KERNEL)
                                            ^
   arch/riscv/include/asm/pgtable.h:167:7: note: expanded from macro '_PAGE_KERNEL'
                                   | _PAGE_PMA \
                                     ^
   arch/riscv/mm/init.c:569:10: error: use of undeclared identifier '_PAGE_PMA'
                   return PAGE_KERNEL;
                          ^
   arch/riscv/include/asm/pgtable.h:170:31: note: expanded from macro 'PAGE_KERNEL'
   #define PAGE_KERNEL             __pgprot(_PAGE_KERNEL)
                                            ^
   arch/riscv/include/asm/pgtable.h:167:7: note: expanded from macro '_PAGE_KERNEL'
                                   | _PAGE_PMA \
                                     ^
   arch/riscv/mm/init.c:571:9: error: use of undeclared identifier '_PAGE_PMA'
           return PAGE_KERNEL_EXEC;
                  ^
   arch/riscv/include/asm/pgtable.h:172:35: note: expanded from macro 'PAGE_KERNEL_EXEC'
   #define PAGE_KERNEL_EXEC        __pgprot(_PAGE_KERNEL | _PAGE_EXEC)
                                            ^
   arch/riscv/include/asm/pgtable.h:167:7: note: expanded from macro '_PAGE_KERNEL'
                                   | _PAGE_PMA \
                                     ^
   arch/riscv/mm/init.c:675:6: error: use of undeclared identifier '_PAGE_PMA'
                                           PAGE_KERNEL_EXEC : pgprot_from_va(va));
                                           ^
   arch/riscv/include/asm/pgtable.h:172:35: note: expanded from macro 'PAGE_KERNEL_EXEC'
   #define PAGE_KERNEL_EXEC        __pgprot(_PAGE_KERNEL | _PAGE_EXEC)
                                            ^
   arch/riscv/include/asm/pgtable.h:167:7: note: expanded from macro '_PAGE_KERNEL'
                                   | _PAGE_PMA \
                                     ^
   arch/riscv/mm/init.c:692:47: error: use of undeclared identifier '_PAGE_PMA'
                              IS_ENABLED(CONFIG_64BIT) ? PAGE_TABLE : PAGE_KERNEL);
                                                                      ^
   arch/riscv/include/asm/pgtable.h:170:31: note: expanded from macro 'PAGE_KERNEL'
   #define PAGE_KERNEL             __pgprot(_PAGE_KERNEL)
                                            ^
   arch/riscv/include/asm/pgtable.h:167:7: note: expanded from macro '_PAGE_KERNEL'
                                   | _PAGE_PMA \
                                     ^
   arch/riscv/mm/init.c:724:13: warning: no previous prototype for function 'pt_ops_set_early' [-Wmissing-prototypes]
   void __init pt_ops_set_early(void)
               ^
   arch/riscv/mm/init.c:724:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init pt_ops_set_early(void)
   ^
   static 
   arch/riscv/mm/init.c:744:13: warning: no previous prototype for function 'pt_ops_set_fixmap' [-Wmissing-prototypes]
   void __init pt_ops_set_fixmap(void)
               ^
   arch/riscv/mm/init.c:744:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init pt_ops_set_fixmap(void)
   ^
   static 
   arch/riscv/mm/init.c:760:13: warning: no previous prototype for function 'pt_ops_set_late' [-Wmissing-prototypes]
   void __init pt_ops_set_late(void)
               ^
   arch/riscv/mm/init.c:760:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init pt_ops_set_late(void)
   ^
   static 
   arch/riscv/mm/init.c:852:41: error: use of undeclared identifier '_PAGE_PMA'
                              kernel_map.phys_addr, PGDIR_SIZE, PAGE_KERNEL_EXEC);
                                                                ^
   arch/riscv/include/asm/pgtable.h:172:35: note: expanded from macro 'PAGE_KERNEL_EXEC'
   #define PAGE_KERNEL_EXEC        __pgprot(_PAGE_KERNEL | _PAGE_EXEC)
                                            ^
   arch/riscv/include/asm/pgtable.h:167:7: note: expanded from macro '_PAGE_KERNEL'
                                   | _PAGE_PMA \
                                     ^
   3 warnings and 7 errors generated.
--
>> arch/riscv/mm/pageattr.c:182:15: error: use of undeclared identifier '_PAGE_PMA'
                   .set_mask = PAGE_KERNEL,
                               ^
   arch/riscv/include/asm/pgtable.h:170:31: note: expanded from macro 'PAGE_KERNEL'
   #define PAGE_KERNEL             __pgprot(_PAGE_KERNEL)
                                            ^
   arch/riscv/include/asm/pgtable.h:167:7: note: expanded from macro '_PAGE_KERNEL'
                                   | _PAGE_PMA \
                                     ^
   1 error generated.
--
   In file included from kernel/kallsyms.c:25:
   In file included from include/linux/filter.h:12:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:973:34: error: use of undeclared identifier '_PAGE_PMA'
           return ioremap_prot(addr, size, _PAGE_IOREMAP);
                                           ^
   arch/riscv/include/asm/pgtable.h:178:25: note: expanded from macro '_PAGE_IOREMAP'
   #define _PAGE_IOREMAP   ((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
                             ^
   arch/riscv/include/asm/pgtable.h:167:7: note: expanded from macro '_PAGE_KERNEL'
                                   | _PAGE_PMA \
                                     ^
   kernel/kallsyms.c:587:12: warning: no previous prototype for function 'arch_get_kallsym' [-Wmissing-prototypes]
   int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
              ^
   kernel/kallsyms.c:587:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
   ^
   static 
   1 warning and 1 error generated.
--
>> kernel/relay.c:129:47: error: use of undeclared identifier '_PAGE_PMA'
           mem = vmap(buf->page_array, n_pages, VM_MAP, PAGE_KERNEL);
                                                        ^
   arch/riscv/include/asm/pgtable.h:170:31: note: expanded from macro 'PAGE_KERNEL'
   #define PAGE_KERNEL             __pgprot(_PAGE_KERNEL)
                                            ^
   arch/riscv/include/asm/pgtable.h:167:7: note: expanded from macro '_PAGE_KERNEL'
                                   | _PAGE_PMA \
                                     ^
   1 error generated.
--
   In file included from kernel/iomem.c:4:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:973:34: error: use of undeclared identifier '_PAGE_PMA'
           return ioremap_prot(addr, size, _PAGE_IOREMAP);
                                           ^
   arch/riscv/include/asm/pgtable.h:178:25: note: expanded from macro '_PAGE_IOREMAP'
   #define _PAGE_IOREMAP   ((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
                             ^
   arch/riscv/include/asm/pgtable.h:167:7: note: expanded from macro '_PAGE_KERNEL'
                                   | _PAGE_PMA \
                                     ^
   kernel/iomem.c:9:22: warning: no previous prototype for function 'ioremap_cache' [-Wmissing-prototypes]
   __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
                        ^
   kernel/iomem.c:9:8: note: declare 'static' if the function is not intended to be used outside of this translation unit
   __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
          ^
          static 
   1 warning and 1 error generated.
--
   In file included from kernel/fork.c:34:
   In file included from include/linux/mempolicy.h:15:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:973:34: error: use of undeclared identifier '_PAGE_PMA'
           return ioremap_prot(addr, size, _PAGE_IOREMAP);
                                           ^
   arch/riscv/include/asm/pgtable.h:178:25: note: expanded from macro '_PAGE_IOREMAP'
   #define _PAGE_IOREMAP   ((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
                             ^
   arch/riscv/include/asm/pgtable.h:167:7: note: expanded from macro '_PAGE_KERNEL'
                                   | _PAGE_PMA \
                                     ^
   In file included from kernel/fork.c:41:
   include/linux/mman.h:158:9: warning: division by zero is undefined [-Wdivision-by-zero]
                  _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
      : ((x) & (bit1)) / ((bit1) / (bit2))))
                       ^ ~~~~~~~~~~~~~~~~~
   kernel/fork.c:162:13: warning: no previous prototype for function 'arch_release_task_struct' [-Wmissing-prototypes]
   void __weak arch_release_task_struct(struct task_struct *tsk)
               ^
   kernel/fork.c:162:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __weak arch_release_task_struct(struct task_struct *tsk)
   ^
   static 
   kernel/fork.c:764:20: warning: no previous prototype for function 'arch_task_cache_init' [-Wmissing-prototypes]
   void __init __weak arch_task_cache_init(void) { }
                      ^
   kernel/fork.c:764:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak arch_task_cache_init(void) { }
   ^
   static 
   3 warnings and 1 error generated.
..


vim +/_PAGE_PMA +973 include/asm-generic/io.h

80b0ca98f91ddbc Christoph Hellwig 2019-08-13  969  
80b0ca98f91ddbc Christoph Hellwig 2019-08-13  970  static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
80b0ca98f91ddbc Christoph Hellwig 2019-08-13  971  {
80b0ca98f91ddbc Christoph Hellwig 2019-08-13  972  	/* _PAGE_IOREMAP needs to be supplied by the architecture */
80b0ca98f91ddbc Christoph Hellwig 2019-08-13 @973  	return ioremap_prot(addr, size, _PAGE_IOREMAP);
80b0ca98f91ddbc Christoph Hellwig 2019-08-13  974  }
80b0ca98f91ddbc Christoph Hellwig 2019-08-13  975  #endif /* !CONFIG_MMU || CONFIG_GENERIC_IOREMAP */
97c9801a15e5b0c Christoph Hellwig 2019-08-11  976  

:::::: The code at line 973 was first introduced by commit
:::::: 80b0ca98f91ddbc09828aff5a00af1c73837713e lib: provide a simple generic ioremap implementation

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Christoph Hellwig <hch@lst.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

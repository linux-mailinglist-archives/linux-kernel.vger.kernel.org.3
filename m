Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3153B4D7195
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 00:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiCLXj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 18:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiCLXjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 18:39:52 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C7250E11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 15:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647128325; x=1678664325;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QJ/+PqpVljbt/f8lPpUL8qGsxRK349auSqBF7OwuQKQ=;
  b=WaSVlrkVcB2ALxCHvKFuHv1E5+JtA6TZj1NP5Lc4oZXR0V+iiO3hZQ/F
   ZZKdiCoDQTzDVLIIjGqAM7iD2mfjXvAPZOpr0yRz19d5eQa/TaPlWcyxn
   gTglCXYJn1Jdy4GEgOqjcoocTL1v4c41rzOO6MTLpjwRniD86f29Z53Ks
   gZDWbJzodcjmjmj6iO7ul9i7CXYQIxq3wudBsTu7d+uIhJbZh5djOrx7Y
   jVR5Mp3ACCpK5uEmUqiujE7VOFNui4iOGg9GX9kATZCABNTowLagdxidh
   bVY3yNm2GIcFUXGbvQ/+PxqyJ8eWjdGS8Lyy2XTYX89N2B+M1n3954Q/A
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="342252954"
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="342252954"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 15:38:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="514966658"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Mar 2022 15:38:43 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTBJq-0008MR-Jx; Sat, 12 Mar 2022 23:38:42 +0000
Date:   Sun, 13 Mar 2022 07:37:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [cel:nfsd-courteous-server 29/39] ebda.c:(.text+0x0): multiple
 definition of `locks_owner_has_blockers';
 arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
Message-ID: <202203130754.dGEnD5ty-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux nfsd-courteous-server
head:   ca4d8c00bb753707519f438e5286b2349af53054
commit: 3a59c0f1c4d6cb882410bfc086ad81458d4cbcaa [29/39] fs/lock: add helper locks_owner_has_blockers to check for blockers
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220313/202203130754.dGEnD5ty-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=3a59c0f1c4d6cb882410bfc086ad81458d4cbcaa
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel nfsd-courteous-server
        git checkout 3a59c0f1c4d6cb882410bfc086ad81458d4cbcaa
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   ld: arch/x86/kernel/ebda.o: in function `locks_owner_has_blockers':
>> ebda.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: init/main.o: in function `locks_owner_has_blockers':
   main.c:(.text+0x32): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: init/do_mounts.o: in function `locks_owner_has_blockers':
   do_mounts.c:(.text+0x5): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: init/noinitramfs.o: in function `locks_owner_has_blockers':
   noinitramfs.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: init/init_task.o: in function `locks_owner_has_blockers':
   init_task.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/entry/syscall_32.o: in function `locks_owner_has_blockers':
   syscall_32.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/entry/common.o: in function `locks_owner_has_blockers':
   common.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/entry/vdso/vma.o: in function `locks_owner_has_blockers':
   vma.c:(.text+0x1d0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/entry/vdso/extable.o: in function `locks_owner_has_blockers':
   extable.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/core.o: in function `locks_owner_has_blockers':
   core.c:(.text+0x903): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/amd/core.o: in function `locks_owner_has_blockers':
   core.c:(.text+0x70b): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/core.o: in function `locks_owner_has_blockers':
   core.c:(.text+0x1cbc): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/bts.o: in function `locks_owner_has_blockers':
   bts.c:(.text+0x6b2): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/ds.o: in function `locks_owner_has_blockers':
   ds.c:(.text+0x14ad): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/knc.o: in function `locks_owner_has_blockers':
   knc.c:(.text+0x2b1): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/lbr.o: in function `locks_owner_has_blockers':
   lbr.c:(.text+0x6cd): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/p4.o: in function `locks_owner_has_blockers':
   p4.c:(.text+0x5f8): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/p6.o: in function `locks_owner_has_blockers':
   p6.c:(.text+0xc4): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/pt.o: in function `locks_owner_has_blockers':
   pt.c:(.text+0x641): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/zhaoxin/core.o: in function `locks_owner_has_blockers':
   core.c:(.text+0x460): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/realmode/init.o: in function `locks_owner_has_blockers':
   init.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/process_32.o: in function `locks_owner_has_blockers':
   process_32.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/signal.o: in function `locks_owner_has_blockers':
   signal.c:(.text+0x5b4): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/traps.o: in function `locks_owner_has_blockers':
   traps.c:(.text+0x288): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/idt.o: in function `locks_owner_has_blockers':
   idt.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/irq.o: in function `locks_owner_has_blockers':
   irq.c:(.text+0x4f): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/irq_32.o: in function `locks_owner_has_blockers':
   irq_32.c:(.text+0x1): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/dumpstack_32.o: in function `locks_owner_has_blockers':
   dumpstack_32.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/ioport.o: in function `locks_owner_has_blockers':
   ioport.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/dumpstack.o: in function `locks_owner_has_blockers':
   dumpstack.c:(.text+0x11e): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/nmi.o: in function `locks_owner_has_blockers':
   nmi.c:(.text+0x74): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/setup.o: in function `locks_owner_has_blockers':
   setup.c:(.text+0x3): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/x86_init.o: in function `locks_owner_has_blockers':
   x86_init.c:(.text+0x39): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/irqinit.o: in function `locks_owner_has_blockers':
   irqinit.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/irq_work.o: in function `locks_owner_has_blockers':
   irq_work.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/probe_roms.o: in function `locks_owner_has_blockers':
   probe_roms.c:(.text+0x1a3): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/sys_ia32.o: in function `locks_owner_has_blockers':
   sys_ia32.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/bootflag.o: in function `locks_owner_has_blockers':
   bootflag.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/e820.o: in function `locks_owner_has_blockers':
   e820.c:(.text+0xbf): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/pci-dma.o: in function `locks_owner_has_blockers':
   pci-dma.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/quirks.o: in function `locks_owner_has_blockers':
   quirks.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/kdebugfs.o: in function `locks_owner_has_blockers':
   kdebugfs.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/alternative.o: in function `locks_owner_has_blockers':
   alternative.c:(.text+0x320): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/hw_breakpoint.o: in function `locks_owner_has_blockers':
   hw_breakpoint.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/rtc.o: in function `locks_owner_has_blockers':
   rtc.c:(.text+0x41): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/pci-iommu_table.o: in function `locks_owner_has_blockers':
   pci-iommu_table.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/process.o: in function `locks_owner_has_blockers':
   process.c:(.text+0xcf): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/fpu/init.o: in function `locks_owner_has_blockers':
   init.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/fpu/core.o: in function `locks_owner_has_blockers':
   core.c:(.text+0x3a): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/fpu/regset.o: in function `locks_owner_has_blockers':
   regset.c:(.text+0x198): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/fpu/signal.o: in function `locks_owner_has_blockers':
   signal.c:(.text+0x42d): multiple definition of `locks_owner_has_blockers'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
--
   In file included from include/linux/cgroup.h:17,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
>> include/linux/fs.h:1340:13: warning: no previous prototype for 'locks_owner_has_blockers' [-Wmissing-prototypes]
    1340 | extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/proc_fs.h:10,
                    from init/main.c:18:
>> include/linux/fs.h:1340:13: warning: no previous prototype for 'locks_owner_has_blockers' [-Wmissing-prototypes]
    1340 | extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:768:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     768 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:780:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     780 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:697,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from include/linux/tracehook.h:47,
                    from include/linux/entry-common.h:6,
                    from arch/x86/entry/common.c:13:
>> include/linux/fs.h:1340:13: warning: no previous prototype for 'locks_owner_has_blockers' [-Wmissing-prototypes]
    1340 | extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/entry/common.c:119:24: warning: no previous prototype for 'do_int80_syscall_32' [-Wmissing-prototypes]
     119 | __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
         |                        ^~~~~~~~~~~~~~~~~~~
   arch/x86/entry/common.c:186:24: warning: no previous prototype for 'do_fast_syscall_32' [-Wmissing-prototypes]
     186 | __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
         |                        ^~~~~~~~~~~~~~~~~~
   arch/x86/entry/common.c:238:24: warning: no previous prototype for 'do_SYSENTER_32' [-Wmissing-prototypes]
     238 | __visible noinstr long do_SYSENTER_32(struct pt_regs *regs)
         |                        ^~~~~~~~~~~~~~
--
   In file included from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:697,
                    from arch/x86/kernel/head32.c:11:
>> include/linux/fs.h:1340:13: warning: no previous prototype for 'locks_owner_has_blockers' [-Wmissing-prototypes]
    1340 | extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/head32.c:72:13: warning: no previous prototype for 'mk_early_pgtbl_32' [-Wmissing-prototypes]
      72 | void __init mk_early_pgtbl_32(void)
         |             ^~~~~~~~~~~~~~~~~
--
   In file included from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:697,
                    from arch/x86/kernel/process.c:6:
>> include/linux/fs.h:1340:13: warning: no previous prototype for 'locks_owner_has_blockers' [-Wmissing-prototypes]
    1340 | extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/process.c:887:13: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     887 | void __init arch_post_acpi_subsys_init(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:697,
                    from arch/x86/kernel/doublefault_32.c:2:
>> include/linux/fs.h:1340:13: warning: no previous prototype for 'locks_owner_has_blockers' [-Wmissing-prototypes]
    1340 | extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/doublefault_32.c:23:36: warning: no previous prototype for 'doublefault_shim' [-Wmissing-prototypes]
      23 | asmlinkage noinstr void __noreturn doublefault_shim(void)
         |                                    ^~~~~~~~~~~~~~~~
   arch/x86/kernel/doublefault_32.c:114:6: warning: no previous prototype for 'doublefault_init_cpu_tss' [-Wmissing-prototypes]
     114 | void doublefault_init_cpu_tss(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:697,
                    from arch/x86/entry/vdso/vma.c:7:
>> include/linux/fs.h:1340:13: warning: no previous prototype for 'locks_owner_has_blockers' [-Wmissing-prototypes]
    1340 | extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/entry/vdso/vma.c:35:19: warning: no previous prototype for 'arch_get_vdso_data' [-Wmissing-prototypes]
      35 | struct vdso_data *arch_get_vdso_data(void *vvar_page)
         |                   ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:697,
                    from arch/x86/include/asm/pci.h:5,
                    from include/linux/pci.h:1901,
                    from arch/x86/kernel/cpu/cacheinfo.c:17:
>> include/linux/fs.h:1340:13: warning: no previous prototype for 'locks_owner_has_blockers' [-Wmissing-prototypes]
    1340 | extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/cacheinfo.c: In function 'init_intel_cacheinfo':
   arch/x86/kernel/cpu/cacheinfo.c:727:26: warning: variable 'l3_id' set but not used [-Wunused-but-set-variable]
     727 |  unsigned int l2_id = 0, l3_id = 0, num_threads_sharing, index_msb;
         |                          ^~~~~
   arch/x86/kernel/cpu/cacheinfo.c:727:15: warning: variable 'l2_id' set but not used [-Wunused-but-set-variable]
     727 |  unsigned int l2_id = 0, l3_id = 0, num_threads_sharing, index_msb;
         |               ^~~~~
--
   In file included from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:697,
                    from include/linux/kallsyms.h:13,
                    from include/linux/ftrace.h:12,
                    from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from kernel/panic.c:15:
>> include/linux/fs.h:1340:13: warning: no previous prototype for 'locks_owner_has_blockers' [-Wmissing-prototypes]
    1340 | extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/panic.c:558:6: warning: no previous prototype for '__warn' [-Wmissing-prototypes]
     558 | void __warn(const char *file, int line, void *caller, unsigned taint,
         |      ^~~~~~
   kernel/panic.c: In function '__warn':
   kernel/panic.c:572:3: warning: function '__warn' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     572 |   vprintk(args->fmt, args->args);
         |   ^~~~~~~
   kernel/panic.c: At top level:
   kernel/panic.c:623:6: warning: no previous prototype for '__warn_printk' [-Wmissing-prototypes]
     623 | void __warn_printk(const char *fmt, ...)
         |      ^~~~~~~~~~~~~
   kernel/panic.c: In function '__warn_printk':
   kernel/panic.c:630:2: warning: function '__warn_printk' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     630 |  vprintk(fmt, args);
         |  ^~~~~~~
--
   In file included from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:697,
                    from kernel/exit.c:8:
>> include/linux/fs.h:1340:13: warning: no previous prototype for 'locks_owner_has_blockers' [-Wmissing-prototypes]
    1340 | extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/exit.c:1824:13: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
    1824 | __weak void abort(void)
         |             ^~~~~
..

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

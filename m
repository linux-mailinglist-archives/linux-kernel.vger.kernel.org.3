Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824F057BFFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 00:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiGTWVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 18:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTWVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:21:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7F843E76
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658355669; x=1689891669;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QeWgjFjDDmMVMBvpszl7oNlWaKywKqvscVZiEFZ2NVQ=;
  b=IeGSCnCXRjWyEE2lcJw8eqEnrb6XjPbmz3iAS5ZIE5zV1JdBd47xaexL
   Jvghgze8vCn24Y0ZCYSd3CpsncABDninJD8Vr8kY64Ys7lVq+d6KA1A+P
   95maVhp9NWI6IawYB+OT4zMSTUdVBQQlRjQ+434AfJBA7sl8/H8ptPK6d
   tvd9NSlbbJCNTxPrll1x3p8GEPzqpbXowTk/rZAQeghFJPRnc+9FmyL9+
   803+oiMQiU69TVtnF73ARevg01jm+zs+RvIA82AGa3NS6FOkqZRqS76U7
   ADifnRiWEWJFXPMJqhtxP0So7uwi5Y3+RN4ViupmTS0tVZZ2i4vybComO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="285661299"
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="285661299"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 15:21:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="630936812"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Jul 2022 15:21:07 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oEI42-0000zN-LM;
        Wed, 20 Jul 2022 22:21:06 +0000
Date:   Thu, 21 Jul 2022 06:20:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 9/45]
 arch/x86/include/asm/linkage.h:47:5: warning: "CONFIG_FUNCTION_ALIGNMENT" is
 not defined, evaluates to 0
Message-ID: <202207210600.RqM29G9b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/depthtracking
head:   714d29e3e7e3faac27142424ae2533163ddd3a46
commit: 0f16b390911e1b97d5e93a76427880ebb6a8bed6 [9/45] x86/asm: Ensure function alignment
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220721/202207210600.RqM29G9b-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/0f16b390911e1b97d5e93a76427880ebb6a8bed6
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/depthtracking
        git checkout 0f16b390911e1b97d5e93a76427880ebb6a8bed6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/linkage.h:8,
                    from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
>> arch/x86/include/asm/linkage.h:47:5: warning: "CONFIG_FUNCTION_ALIGNMENT" is not defined, evaluates to 0 [-Wundef]
      47 | #if CONFIG_FUNCTION_ALIGNMENT == 16
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/linkage.h:8,
                    from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/um/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:3,
                    from arch/um/kernel/asm-offsets.c:1:
>> arch/x86/include/asm/linkage.h:47:5: warning: "CONFIG_FUNCTION_ALIGNMENT" is not defined, evaluates to 0 [-Wundef]
      47 | #if CONFIG_FUNCTION_ALIGNMENT == 16
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/um/kernel/asm-offsets.c:1:
   arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
       9 | void foo(void)
         |      ^~~
--
   In file included from include/linux/linkage.h:8,
                    from include/linux/kernel.h:17,
                    from include/linux/cpumask.h:10,
                    from arch/um/kernel/irq.c:10:
>> arch/x86/include/asm/linkage.h:47:5: warning: "CONFIG_FUNCTION_ALIGNMENT" is not defined, evaluates to 0 [-Wundef]
      47 | #if CONFIG_FUNCTION_ALIGNMENT == 16
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/um/kernel/irq.c:646:13: warning: no previous prototype for 'init_IRQ' [-Wmissing-prototypes]
     646 | void __init init_IRQ(void)
         |             ^~~~~~~~
--
   In file included from include/linux/linkage.h:8,
                    from include/linux/kernel.h:17,
                    from include/linux/cpumask.h:10,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from arch/um/kernel/mem.c:7:
>> arch/x86/include/asm/linkage.h:47:5: warning: "CONFIG_FUNCTION_ALIGNMENT" is not defined, evaluates to 0 [-Wundef]
      47 | #if CONFIG_FUNCTION_ALIGNMENT == 16
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/um/kernel/mem.c:183:8: warning: no previous prototype for 'pgd_alloc' [-Wmissing-prototypes]
     183 | pgd_t *pgd_alloc(struct mm_struct *mm)
         |        ^~~~~~~~~
   arch/um/kernel/mem.c:196:7: warning: no previous prototype for 'uml_kmalloc' [-Wmissing-prototypes]
     196 | void *uml_kmalloc(int size, int flags)
         |       ^~~~~~~~~~~
--
   In file included from include/linux/linkage.h:8,
                    from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/percpu.h:5,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from arch/um/kernel/process.c:11:
>> arch/x86/include/asm/linkage.h:47:5: warning: "CONFIG_FUNCTION_ALIGNMENT" is not defined, evaluates to 0 [-Wundef]
      47 | #if CONFIG_FUNCTION_ALIGNMENT == 16
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:50:5: warning: no previous prototype for 'pid_to_processor_id' [-Wmissing-prototypes]
      50 | int pid_to_processor_id(int pid)
         |     ^~~~~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:86:7: warning: no previous prototype for '__switch_to' [-Wmissing-prototypes]
      86 | void *__switch_to(struct task_struct *from, struct task_struct *to)
         |       ^~~~~~~~~~~
   arch/um/kernel/process.c: In function 'new_thread_handler':
   arch/um/kernel/process.c:121:28: warning: variable 'n' set but not used [-Wunused-but-set-variable]
     121 |         int (*fn)(void *), n;
         |                            ^
   arch/um/kernel/process.c: At top level:
   arch/um/kernel/process.c:139:6: warning: no previous prototype for 'fork_handler' [-Wmissing-prototypes]
     139 | void fork_handler(void)
         |      ^~~~~~~~~~~~
   arch/um/kernel/process.c:216:6: warning: no previous prototype for 'arch_cpu_idle' [-Wmissing-prototypes]
     216 | void arch_cpu_idle(void)
         |      ^~~~~~~~~~~~~
   arch/um/kernel/process.c:253:5: warning: no previous prototype for 'copy_to_user_proc' [-Wmissing-prototypes]
     253 | int copy_to_user_proc(void __user *to, void *from, int size)
         |     ^~~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:263:5: warning: no previous prototype for 'clear_user_proc' [-Wmissing-prototypes]
     263 | int clear_user_proc(void __user *buf, int size)
         |     ^~~~~~~~~~~~~~~
   arch/um/kernel/process.c:316:12: warning: no previous prototype for 'make_proc_sysemu' [-Wmissing-prototypes]
     316 | int __init make_proc_sysemu(void)
         |            ^~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:356:15: warning: no previous prototype for 'arch_align_stack' [-Wmissing-prototypes]
     356 | unsigned long arch_align_stack(unsigned long sp)
         |               ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/linkage.h:8,
                    from include/linux/preempt.h:10,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from arch/um/kernel/reboot.c:6:
>> arch/x86/include/asm/linkage.h:47:5: warning: "CONFIG_FUNCTION_ALIGNMENT" is not defined, evaluates to 0 [-Wundef]
      47 | #if CONFIG_FUNCTION_ALIGNMENT == 16
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/um/kernel/reboot.c:45:6: warning: no previous prototype for 'machine_restart' [-Wmissing-prototypes]
      45 | void machine_restart(char * __unused)
         |      ^~~~~~~~~~~~~~~
   arch/um/kernel/reboot.c:51:6: warning: no previous prototype for 'machine_power_off' [-Wmissing-prototypes]
      51 | void machine_power_off(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/um/kernel/reboot.c:57:6: warning: no previous prototype for 'machine_halt' [-Wmissing-prototypes]
      57 | void machine_halt(void)
         |      ^~~~~~~~~~~~
--
   In file included from include/linux/linkage.h:8,
                    from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/ktime.h:26,
                    from include/linux/timer.h:6,
                    from include/linux/clocksource.h:17,
                    from include/linux/clockchips.h:14,
                    from arch/um/kernel/time.c:10:
>> arch/x86/include/asm/linkage.h:47:5: warning: "CONFIG_FUNCTION_ALIGNMENT" is not defined, evaluates to 0 [-Wundef]
      47 | #if CONFIG_FUNCTION_ALIGNMENT == 16
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/um/kernel/time.c:778:13: warning: no previous prototype for 'time_init' [-Wmissing-prototypes]
     778 | void __init time_init(void)
         |             ^~~~~~~~~
--
   In file included from include/linux/linkage.h:8,
                    from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from arch/um/kernel/tlb.c:6:
>> arch/x86/include/asm/linkage.h:47:5: warning: "CONFIG_FUNCTION_ALIGNMENT" is not defined, evaluates to 0 [-Wundef]
      47 | #if CONFIG_FUNCTION_ALIGNMENT == 16
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/um/kernel/tlb.c:317:6: warning: no previous prototype for 'fix_range_common' [-Wmissing-prototypes]
     317 | void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
         |      ^~~~~~~~~~~~~~~~
   arch/um/kernel/tlb.c:579:6: warning: no previous prototype for 'flush_tlb_mm_range' [-Wmissing-prototypes]
     579 | void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
         |      ^~~~~~~~~~~~~~~~~~
   arch/um/kernel/tlb.c:595:6: warning: no previous prototype for 'force_flush_all' [-Wmissing-prototypes]
     595 | void force_flush_all(void)
         |      ^~~~~~~~~~~~~~~
--
   In file included from include/linux/linkage.h:8,
                    from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/um/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/delay.h:23,
                    from arch/um/kernel/um_arch.c:6:
>> arch/x86/include/asm/linkage.h:47:5: warning: "CONFIG_FUNCTION_ALIGNMENT" is not defined, evaluates to 0 [-Wundef]
      47 | #if CONFIG_FUNCTION_ALIGNMENT == 16
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/um/kernel/um_arch.c:402:19: warning: no previous prototype for 'read_initrd' [-Wmissing-prototypes]
     402 | int __init __weak read_initrd(void)
         |                   ^~~~~~~~~~~
   arch/um/kernel/um_arch.c:421:13: warning: no previous prototype for 'check_bugs' [-Wmissing-prototypes]
     421 | void __init check_bugs(void)
         |             ^~~~~~~~~~
   arch/um/kernel/um_arch.c:443:7: warning: no previous prototype for 'text_poke' [-Wmissing-prototypes]
     443 | void *text_poke(void *addr, const void *opcode, size_t len)
         |       ^~~~~~~~~
   arch/um/kernel/um_arch.c:455:6: warning: no previous prototype for 'text_poke_sync' [-Wmissing-prototypes]
     455 | void text_poke_sync(void)
         |      ^~~~~~~~~~~~~~
--
   In file included from include/linux/linkage.h:8,
                    from include/linux/preempt.h:10,
                    from include/linux/spinlock.h:55,
                    from arch/um/kernel/kmsg_dump.c:3:
>> arch/x86/include/asm/linkage.h:47:5: warning: "CONFIG_FUNCTION_ALIGNMENT" is not defined, evaluates to 0 [-Wundef]
      47 | #if CONFIG_FUNCTION_ALIGNMENT == 16
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/um/kernel/kmsg_dump.c:54:12: warning: no previous prototype for 'kmsg_dumper_stdout_init' [-Wmissing-prototypes]
      54 | int __init kmsg_dumper_stdout_init(void)
         |            ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/linkage.h:8,
                    from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from arch/um/kernel/skas/mmu.c:7:
>> arch/x86/include/asm/linkage.h:47:5: warning: "CONFIG_FUNCTION_ALIGNMENT" is not defined, evaluates to 0 [-Wundef]
      47 | #if CONFIG_FUNCTION_ALIGNMENT == 16
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/um/kernel/skas/mmu.c:17:5: warning: no previous prototype for 'init_new_context' [-Wmissing-prototypes]
      17 | int init_new_context(struct task_struct *task, struct mm_struct *mm)
         |     ^~~~~~~~~~~~~~~~
   arch/um/kernel/skas/mmu.c:60:6: warning: no previous prototype for 'destroy_context' [-Wmissing-prototypes]
      60 | void destroy_context(struct mm_struct *mm)
         |      ^~~~~~~~~~~~~~~
..


vim +/CONFIG_FUNCTION_ALIGNMENT +47 arch/x86/include/asm/linkage.h

    46	
  > 47	#if CONFIG_FUNCTION_ALIGNMENT == 16
    48	# define __FUNC_ALIGN		.p2align 4, 0x90;
    49	# define ASM_FUNC_ALIGN		".p2align 4, 0x90;"
    50	# define SYM_F_ALIGN		__FUNC_ALIGN
    51	#else
    52	# define ASM_FUNC_ALIGN		""
    53	# define SYM_F_ALIGN		SYM_A_ALIGN
    54	#endif
    55	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

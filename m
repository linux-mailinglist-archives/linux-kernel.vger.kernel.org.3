Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2DC504CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 08:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbiDRG47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 02:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiDRG44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 02:56:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40381261A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650264857; x=1681800857;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LO0jpx7ym3NgYfKx2/ExFTYFtIrbp9tOSpSJefGCbIE=;
  b=eqquplV+00gpcn/upvq9GpFq0AeitgcTWetLTcO5lxYLxcReuTPxKSDf
   YhKJUUBe2E3iJh7zNri0UPPl2VurmwtzJhjGyjEIfuFddPbrrXaf/Sd+Y
   7Yz0X2aC36ZgHeS5tqJKhCCEehkTdYtR26IhQtVc8idguTodgNvyhdLUh
   k1Zhd/TzKy8ILLc4qfct7YfCWNnq35P0CVkyVlaVtqIvcCNiOmrdF0EHB
   xjeaFBuih+aT/lyozJ+8qbWpetMeALDuJ4+O9npzdOg23EmZ0Xf7on34o
   vRqxs51r6mU8X+05szAjf85EgkvA99fFrL9AQ2Nfw+f0xeqyWGIrePZo3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="262926455"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="262926455"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 23:54:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="701725683"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 17 Apr 2022 23:54:15 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngLH5-0004QV-54;
        Mon, 18 Apr 2022 06:54:15 +0000
Date:   Mon, 18 Apr 2022 14:53:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:bitmap 45/47] include/linux/bitmap.h:305:25: warning: cast to
 pointer from integer of different size
Message-ID: <202204181455.Fc3fM9NR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap
head:   45a9e3feb171ccf077979b7ff6a0c6a732cfc17b
commit: 1a21df17d726b4f3c19a148e10d09ec632603f1c [45/47] lib: add bitmap_{from,to}_arr64
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220418/202204181455.Fc3fM9NR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/norov/linux/commit/1a21df17d726b4f3c19a148e10d09ec632603f1c
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap
        git checkout 1a21df17d726b4f3c19a148e10d09ec632603f1c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:3,
                    from arch/um/kernel/asm-offsets.c:1:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:305:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     305 |                         (const unsigned long *) (buf), (nbits))
         |                         ^
   include/linux/bitmap.h:615:16: note: in expansion of macro 'bitmap_from_arr64'
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                ^~~~~~~~~~~~~~~~~
   In file included from arch/um/kernel/asm-offsets.c:1:
   arch/x86/um/shared/sysdep/kernel-offsets.h: At top level:
   arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
       9 | void foo(void)
         |      ^~~
--
   In file included from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from arch/um/kernel/exec.c:7:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:305:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     305 |                         (const unsigned long *) (buf), (nbits))
         |                         ^
   include/linux/bitmap.h:615:16: note: in expansion of macro 'bitmap_from_arr64'
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                ^~~~~~~~~~~~~~~~~
--
   In file included from include/linux/cpumask.h:12,
                    from arch/um/kernel/irq.c:10:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:305:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     305 |                         (const unsigned long *) (buf), (nbits))
         |                         ^
   include/linux/bitmap.h:615:16: note: in expansion of macro 'bitmap_from_arr64'
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                ^~~~~~~~~~~~~~~~~
   arch/um/kernel/irq.c: At top level:
   arch/um/kernel/irq.c:646:13: warning: no previous prototype for 'init_IRQ' [-Wmissing-prototypes]
     646 | void __init init_IRQ(void)
         |             ^~~~~~~~
--
   In file included from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from arch/um/kernel/mem.c:7:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:305:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     305 |                         (const unsigned long *) (buf), (nbits))
         |                         ^
   include/linux/bitmap.h:615:16: note: in expansion of macro 'bitmap_from_arr64'
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                ^~~~~~~~~~~~~~~~~
   arch/um/kernel/mem.c: At top level:
   arch/um/kernel/mem.c:183:8: warning: no previous prototype for 'pgd_alloc' [-Wmissing-prototypes]
     183 | pgd_t *pgd_alloc(struct mm_struct *mm)
         |        ^~~~~~~~~
   arch/um/kernel/mem.c:196:7: warning: no previous prototype for 'uml_kmalloc' [-Wmissing-prototypes]
     196 | void *uml_kmalloc(int size, int flags)
         |       ^~~~~~~~~~~
--
   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/percpu.h:7,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from arch/um/kernel/process.c:11:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:305:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     305 |                         (const unsigned long *) (buf), (nbits))
         |                         ^
   include/linux/bitmap.h:615:16: note: in expansion of macro 'bitmap_from_arr64'
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                ^~~~~~~~~~~~~~~~~
   arch/um/kernel/process.c: At top level:
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
   arch/um/kernel/process.c:215:6: warning: no previous prototype for 'arch_cpu_idle' [-Wmissing-prototypes]
     215 | void arch_cpu_idle(void)
         |      ^~~~~~~~~~~~~
   arch/um/kernel/process.c:252:5: warning: no previous prototype for 'copy_to_user_proc' [-Wmissing-prototypes]
     252 | int copy_to_user_proc(void __user *to, void *from, int size)
         |     ^~~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:262:5: warning: no previous prototype for 'clear_user_proc' [-Wmissing-prototypes]
     262 | int clear_user_proc(void __user *buf, int size)
         |     ^~~~~~~~~~~~~~~
   arch/um/kernel/process.c:315:12: warning: no previous prototype for 'make_proc_sysemu' [-Wmissing-prototypes]
     315 | int __init make_proc_sysemu(void)
         |            ^~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:355:15: warning: no previous prototype for 'arch_align_stack' [-Wmissing-prototypes]
     355 | unsigned long arch_align_stack(unsigned long sp)
         |               ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from arch/um/kernel/reboot.c:6:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:305:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     305 |                         (const unsigned long *) (buf), (nbits))
         |                         ^
   include/linux/bitmap.h:615:16: note: in expansion of macro 'bitmap_from_arr64'
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                ^~~~~~~~~~~~~~~~~
   arch/um/kernel/reboot.c: At top level:
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
   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/debugobjects.h:6,
                    from include/linux/timer.h:8,
                    from include/linux/clocksource.h:17,
                    from include/linux/clockchips.h:14,
                    from arch/um/kernel/time.c:10:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:305:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     305 |                         (const unsigned long *) (buf), (nbits))
         |                         ^
   include/linux/bitmap.h:615:16: note: in expansion of macro 'bitmap_from_arr64'
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                ^~~~~~~~~~~~~~~~~
   arch/um/kernel/time.c: At top level:
   arch/um/kernel/time.c:778:13: warning: no previous prototype for 'time_init' [-Wmissing-prototypes]
     778 | void __init time_init(void)
         |             ^~~~~~~~~
--
   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/um/kernel/tlb.c:6:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:305:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     305 |                         (const unsigned long *) (buf), (nbits))
         |                         ^
   include/linux/bitmap.h:615:16: note: in expansion of macro 'bitmap_from_arr64'
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                ^~~~~~~~~~~~~~~~~
   arch/um/kernel/tlb.c: At top level:
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
   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/delay.h:23,
                    from arch/um/kernel/um_arch.c:6:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:305:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     305 |                         (const unsigned long *) (buf), (nbits))
         |                         ^
   include/linux/bitmap.h:615:16: note: in expansion of macro 'bitmap_from_arr64'
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                ^~~~~~~~~~~~~~~~~
   arch/um/kernel/um_arch.c: At top level:
   arch/um/kernel/um_arch.c:402:19: warning: no previous prototype for 'read_initrd' [-Wmissing-prototypes]
     402 | int __init __weak read_initrd(void)
         |                   ^~~~~~~~~~~
   arch/um/kernel/um_arch.c:421:13: warning: no previous prototype for 'check_bugs' [-Wmissing-prototypes]
     421 | void __init check_bugs(void)
         |             ^~~~~~~~~~
   arch/um/kernel/um_arch.c:439:7: warning: no previous prototype for 'text_poke' [-Wmissing-prototypes]
     439 | void *text_poke(void *addr, const void *opcode, size_t len)
         |       ^~~~~~~~~
   arch/um/kernel/um_arch.c:451:6: warning: no previous prototype for 'text_poke_sync' [-Wmissing-prototypes]
     451 | void text_poke_sync(void)
         |      ^~~~~~~~~~~~~~
--
   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from arch/um/kernel/kmsg_dump.c:3:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:305:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     305 |                         (const unsigned long *) (buf), (nbits))
         |                         ^
   include/linux/bitmap.h:615:16: note: in expansion of macro 'bitmap_from_arr64'
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                ^~~~~~~~~~~~~~~~~
   arch/um/kernel/kmsg_dump.c: At top level:
   arch/um/kernel/kmsg_dump.c:54:12: warning: no previous prototype for 'kmsg_dumper_stdout_init' [-Wmissing-prototypes]
      54 | int __init kmsg_dumper_stdout_init(void)
         |            ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/um/kernel/skas/mmu.c:7:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:305:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     305 |                         (const unsigned long *) (buf), (nbits))
         |                         ^
   include/linux/bitmap.h:615:16: note: in expansion of macro 'bitmap_from_arr64'
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                ^~~~~~~~~~~~~~~~~
   arch/um/kernel/skas/mmu.c: At top level:
   arch/um/kernel/skas/mmu.c:17:5: warning: no previous prototype for 'init_new_context' [-Wmissing-prototypes]
      17 | int init_new_context(struct task_struct *task, struct mm_struct *mm)
         |     ^~~~~~~~~~~~~~~~
   arch/um/kernel/skas/mmu.c:60:6: warning: no previous prototype for 'destroy_context' [-Wmissing-prototypes]
      60 | void destroy_context(struct mm_struct *mm)
         |      ^~~~~~~~~~~~~~~
..


vim +305 include/linux/bitmap.h

   292	
   293	/*
   294	 * On 64-bit systems bitmaps are represented as u64 arrays internally. On LE32
   295	 * machines the order of hi and lo parts of nubmers match the bitmap structure.
   296	 * In both cases conversion is not needed when copying data from/to arrays of
   297	 * u64.
   298	 */
   299	#if (BITS_PER_LONG == 32) && defined (__BIG_ENDIAN)
   300	void bitmap_from_arr64(unsigned long *bitmap, const u64 *buf, unsigned int nbits);
   301	void bitmap_to_arr64(u64 *buf, const unsigned long *bitmap, unsigned int nbits);
   302	#else
   303	#define bitmap_from_arr64(bitmap, buf, nbits)			\
   304		bitmap_copy_clear_tail((unsigned long *) (bitmap),	\
 > 305				(const unsigned long *) (buf), (nbits))
   306	#define bitmap_to_arr64(buf, bitmap, nbits)			\
   307		bitmap_copy_clear_tail((unsigned long *) (buf),		\
   308				(const unsigned long *) (bitmap), (nbits))
   309	#endif
   310	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F3A49A925
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1322202AbiAYDVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:21:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:64615 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1318867AbiAYDHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643080043; x=1674616043;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v2xxbI6hbMj0QR+rZGtw8cQFlI1Tcw8KnZWwPn8YpsE=;
  b=GQOnYG8jW3udhkg/Es/EokgYS6NRCW2XCUZ5wQjEsF3BUt4EI+ablDea
   WKQx25aLMclgOpALoQO+5JahBsGVZR76UzLEBs7paXNNGiFWs/h2i7Cqw
   MtZG+AWbSwNJDetqWZG7DI8MBMWvVZIMtAuugSvgjG0Xu1E+fQXU7NtvE
   +XAIEuALq9CFD7mH/PGQ/7F6bFZ71XK+m4AVoQnIcBbFkQgg6b36ZYAM5
   4WWakbokypyeIawVAuhm+hjXSmLAvAOs15FfGGPFSc9cqCu9FPPYrWQYF
   f21ROktj1Bhpxnnspu4VOn3lmGYRTOhNxiIC8pta+ufUCFj6moX50H1BV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246150809"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="246150809"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 19:07:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="476950982"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2022 19:07:20 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCCAy-000JGp-2L; Tue, 25 Jan 2022 03:07:20 +0000
Date:   Tue, 25 Jan 2022 11:06:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: kernel/sched/psi.c:1193:6: warning: no previous prototype for
 function 'psi_trigger_destroy'
Message-ID: <202201251121.19DMWalx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: a06247c6804f1a7c86a2e5398a4c1f1db1471848 psi: Fix uaf issue when psi trigger is destroyed while being polled
date:   7 days ago
config: s390-randconfig-r044-20220124 (https://download.01.org/0day-ci/archive/20220125/202201251121.19DMWalx-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2e58a18910867ba6795066e044293e6daf89edf5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a06247c6804f1a7c86a2e5398a4c1f1db1471848
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a06247c6804f1a7c86a2e5398a4c1f1db1471848
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/psi.c:153:
   In file included from kernel/sched/sched.h:17:
   In file included from include/linux/sched/isolation.h:6:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from kernel/sched/psi.c:153:
   In file included from kernel/sched/sched.h:17:
   In file included from include/linux/sched/isolation.h:6:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from kernel/sched/psi.c:153:
   In file included from kernel/sched/sched.h:17:
   In file included from include/linux/sched/isolation.h:6:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   kernel/sched/psi.c:1123:21: warning: no previous prototype for function 'psi_trigger_create' [-Wmissing-prototypes]
   struct psi_trigger *psi_trigger_create(struct psi_group *group,
                       ^
   kernel/sched/psi.c:1123:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct psi_trigger *psi_trigger_create(struct psi_group *group,
   ^
   static 
>> kernel/sched/psi.c:1193:6: warning: no previous prototype for function 'psi_trigger_destroy' [-Wmissing-prototypes]
   void psi_trigger_destroy(struct psi_trigger *t)
        ^
   kernel/sched/psi.c:1193:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void psi_trigger_destroy(struct psi_trigger *t)
   ^
   static 
   kernel/sched/psi.c:1260:10: warning: no previous prototype for function 'psi_trigger_poll' [-Wmissing-prototypes]
   __poll_t psi_trigger_poll(void **trigger_ptr,
            ^
   kernel/sched/psi.c:1260:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   __poll_t psi_trigger_poll(void **trigger_ptr,
   ^
   static 
   15 warnings generated.


vim +/psi_trigger_destroy +1193 kernel/sched/psi.c

  1192	
> 1193	void psi_trigger_destroy(struct psi_trigger *t)
  1194	{
  1195		struct psi_group *group;
  1196		struct task_struct *task_to_destroy = NULL;
  1197	
  1198		/*
  1199		 * We do not check psi_disabled since it might have been disabled after
  1200		 * the trigger got created.
  1201		 */
  1202		if (!t)
  1203			return;
  1204	
  1205		group = t->group;
  1206		/*
  1207		 * Wakeup waiters to stop polling. Can happen if cgroup is deleted
  1208		 * from under a polling process.
  1209		 */
  1210		wake_up_interruptible(&t->event_wait);
  1211	
  1212		mutex_lock(&group->trigger_lock);
  1213	
  1214		if (!list_empty(&t->node)) {
  1215			struct psi_trigger *tmp;
  1216			u64 period = ULLONG_MAX;
  1217	
  1218			list_del(&t->node);
  1219			group->nr_triggers[t->state]--;
  1220			if (!group->nr_triggers[t->state])
  1221				group->poll_states &= ~(1 << t->state);
  1222			/* reset min update period for the remaining triggers */
  1223			list_for_each_entry(tmp, &group->triggers, node)
  1224				period = min(period, div_u64(tmp->win.size,
  1225						UPDATES_PER_WINDOW));
  1226			group->poll_min_period = period;
  1227			/* Destroy poll_task when the last trigger is destroyed */
  1228			if (group->poll_states == 0) {
  1229				group->polling_until = 0;
  1230				task_to_destroy = rcu_dereference_protected(
  1231						group->poll_task,
  1232						lockdep_is_held(&group->trigger_lock));
  1233				rcu_assign_pointer(group->poll_task, NULL);
  1234				del_timer(&group->poll_timer);
  1235			}
  1236		}
  1237	
  1238		mutex_unlock(&group->trigger_lock);
  1239	
  1240		/*
  1241		 * Wait for psi_schedule_poll_work RCU to complete its read-side
  1242		 * critical section before destroying the trigger and optionally the
  1243		 * poll_task.
  1244		 */
  1245		synchronize_rcu();
  1246		/*
  1247		 * Stop kthread 'psimon' after releasing trigger_lock to prevent a
  1248		 * deadlock while waiting for psi_poll_work to acquire trigger_lock
  1249		 */
  1250		if (task_to_destroy) {
  1251			/*
  1252			 * After the RCU grace period has expired, the worker
  1253			 * can no longer be found through group->poll_task.
  1254			 */
  1255			kthread_stop(task_to_destroy);
  1256		}
  1257		kfree(t);
  1258	}
  1259	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

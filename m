Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14514504F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbiDRK6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiDRK6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:58:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6896F15FEF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650279325; x=1681815325;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=llwcnFLx36bN1ZmcQDa7xMt2LunjsAua0nmOtxR10c4=;
  b=Nb7svxvtaCHagn9ZnarJodisKNoOKW4R1tiDnije3aDEJLa7tEn66SDd
   r5Fi+jm0IwaSlV7Ocp3Cvv8stlZFv6T7tRjrQbct9xm2roH8w+ZC655uA
   MVY6oVQxDwvb0R3B81UAADM8HQUuLx1PNDENHSGXzOmj+UwJ++U6D66Ow
   XRV+8KokmoCNNjSuql7kfih6/xpTVl6B0XEiqWJkgWcdknmK3Z71p2VBM
   cfkAulP2sFs6+r3AayegB114a4IriXwKDyGqC2ipR1xRT2vyS2B8Fm2JE
   kLpZmzelkusyH4tOLr34sqYiDcjz9OEg6CGRxLLLHWfFOr65dZTY+1STd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="326397817"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="326397817"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 03:55:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="646829638"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Apr 2022 03:55:23 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngP2Q-0004Z5-FV;
        Mon, 18 Apr 2022 10:55:22 +0000
Date:   Mon, 18 Apr 2022 18:54:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nemanja Rakovic <nemanja.rakovic@syrmia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: mips64-linux-ld: warning: orphan section `.ctors.65436' from
 `init/main.o' being placed in section `.ctors.65436'
Message-ID: <202204181801.r3MMkwJv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   59250f8a7f3a60a2661b84cbafc1e0eb5d05ec9b
commit: e0a8b93efa2382d370be44bf289157de7e5dacb4 mips: Enable KCSAN
date:   2 months ago
config: mips-randconfig-r015-20220414 (https://download.01.org/0day-ci/archive/20220418/202204181801.r3MMkwJv-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e0a8b93efa2382d370be44bf289157de7e5dacb4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e0a8b93efa2382d370be44bf289157de7e5dacb4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `init/main.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `init/version.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `init/do_mounts.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `init/do_mounts_initrd.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `init/initramfs.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `init/calibrate.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `init/init_task.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/sgi-ip22/ip22-mc.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/sgi-ip22/ip22-hpc.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/sgi-ip22/ip22-int.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/sgi-ip22/ip22-time.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/sgi-ip22/ip22-nvram.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/sgi-ip22/ip22-platform.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/sgi-ip22/ip22-reset.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/sgi-ip22/ip22-setup.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/sgi-ip22/ip22-gio.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/sgi-ip22/ip28-berr.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/sgi-ip22/ip22-eisa.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/branch.o' being placed in section `.ctors.65436'
>> mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/cmpxchg.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/elf.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/idle.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/irq.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/process.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/prom.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/ptrace.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/reset.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/setup.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/signal.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/syscall.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/time.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/topology.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/traps.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/unaligned.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/watch.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/vdso.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/cacheinfo.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/cpu-probe.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/cevt-r4k.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/csrc-r4k.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/segment.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/stacktrace.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/module.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/ftrace.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/fpu-probe.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/kprobes.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/proc.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/sysrq.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/i8253.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/machine_kexec.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/crash.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/crash_dump.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/early_printk.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/spinlock_test.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/jump_label.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/kernel/pm.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/mm/cache.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/mm/context.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/mm/extable.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/mm/fault.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/mm/init.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/mm/mmap.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/mm/page.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/mm/pgtable.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/mm/tlbex.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/mm/uasm-mips.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/mm/maccess.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/mm/ioremap64.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/mm/pgtable-64.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/mm/hugetlbpage.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/mm/dma-noncoherent.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/mm/c-r4k.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/mm/tlb-r4k.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/mm/sc-debugfs.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/net/bpf_jit_comp.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/net/bpf_jit_comp64.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/fork.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/exec_domain.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/panic.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/cpu.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/exit.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/resource.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/sysctl.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/capability.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/ptrace.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/user.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/signal.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/sys.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/umh.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/workqueue.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/pid.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/task_work.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/extable.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/params.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/kthread.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/sys_ni.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/nsproxy.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/notifier.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/ksysfs.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/cred.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/reboot.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/async.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/range.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/smpboot.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/ucount.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/regset.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/kmod.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/groups.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/locking/mutex.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/locking/semaphore.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/locking/rwsem.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/locking/percpu-rwsem.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/locking/irqflag-debug.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/locking/mutex-debug.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/locking/lockdep_proc.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/locking/spinlock.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/locking/rtmutex_api.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/locking/spinlock_debug.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/locking/test-ww_mutex.o' being placed in section `.ctors.65436'
   mips64-linux-ld: warning: orphan section `.ctors.65436' from `kernel/locking/lock_events.o' being placed in section `.ctors.65436'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

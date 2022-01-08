Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAE3488461
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 17:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbiAHQKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 11:10:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:4911 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbiAHQKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 11:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641658201; x=1673194201;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=F38uMkKC7FTtu/pUQn7z+wsPRVs0fu8hYEbKgGgfa78=;
  b=PJ1sd8mSe85C7WV6pS1h/H9lIS2MTZhQ5/+GeYZgX5SPJMH2mdXMHctZ
   izgE3R5e/fomzclWR39Ck7ORNWGDdJIe+uUWp55zJiUMarTcWZa8IWZDd
   redZQGtf/ee3u6XnZry0m1vZ/wO0+thRcnfU7V5auNCINDdTRuT2a69ce
   DOXx7j/nuuGdrTL57mGzszijTaQySbQvvmy8xL2RShPy7qLKCxLKFKkHg
   mVH4PmZFb4OT9pdHLmV4PE9MQkK0IIvlfEbOT1U92u3rFO0vxbT7P7YgK
   SOF/m/JEaODs50B2srXEzwa2/eqwW1VY1e2bzTMyp8FWZzO4+J9Ih8BkM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="223722977"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="223722977"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 08:10:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="473666208"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Jan 2022 08:09:59 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6EI3-0000ml-9x; Sat, 08 Jan 2022 16:09:59 +0000
Date:   Sun, 09 Jan 2022 00:09:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.01.04a] BUILD REGRESSION
 64595d0dff992756e8c6d53c0e9f1e3e50c451f7
Message-ID: <61d9b73a.i2ILLl6sdO4AN9+0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.01.04a
branch HEAD: 64595d0dff992756e8c6d53c0e9f1e3e50c451f7  squash! EXP timers: Non-nohz_full last-resort jiffies update on IRQ entry

Error/Warning reports:

https://lore.kernel.org/lkml/202201080834.rGuSv2SS-lkp@intel.com
https://lore.kernel.org/lkml/202201081127.geEljsMv-lkp@intel.com
https://lore.kernel.org/lkml/202201081735.gNXE7dpe-lkp@intel.com
https://lore.kernel.org/lkml/202201082041.wv0NluSe-lkp@intel.com

Error/Warning in current branch:

kernel/stop_machine.c:207:13: warning: variable 't' set but not used [-Wunused-but-set-variable]
kernel/stop_machine.c:207:6: warning: variable 't' set but not used [-Wunused-but-set-variable]
kernel/time/timer.c:1776:6: warning: no previous prototype for 'tick_setup_sched_timer_dump' [-Wmissing-prototypes]
kernel/time/timer.c:1776:6: warning: no previous prototype for function 'tick_setup_sched_timer_dump' [-Wmissing-prototypes]

possible Error/Warning in current branch (please contact us if interested):

(.text.cpu_hp_check_delay+0x200): undefined reference to `__udivdi3'
(.text.cpu_hp_start_now+0x94): undefined reference to `__udivdi3'
(.text.cpu_hp_stop_now+0xf4): undefined reference to `__udivdi3'
arch/x86/kernel/kvm.c:318:2: error: implicit declaration of function 'cpu_hp_check_delay' [-Werror,-Wimplicit-function-declaration]
arch/x86/kernel/kvm.c:319:2: error: implicit declaration of function 'cpu_hp_stop_now' [-Werror,-Wimplicit-function-declaration]
arch/x86/kernel/kvmclock.c:194:2: error: implicit declaration of function 'cpu_hp_start_now' [-Werror,-Wimplicit-function-declaration]
kernel/cpu.c:145:6: warning: no previous prototype for function 'cpu_hp_start_now' [-Wmissing-prototypes]
kernel/cpu.c:154:6: warning: no previous prototype for function 'cpu_hp_stop_now' [-Wmissing-prototypes]
kernel/cpu.c:166:6: warning: no previous prototype for function 'cpu_hp_check_delay' [-Wmissing-prototypes]
kernel/stop_machine.c:209:2: error: implicit declaration of function 'tick_setup_sched_timer_dump' [-Werror,-Wimplicit-function-declaration]
kernel/stop_machine.c:255:7: error: implicit declaration of function 'cpu_hp_check_delay' [-Werror,-Wimplicit-function-declaration]
kernel/stop_machine.c:256:4: error: implicit declaration of function 'tick_setup_sched_timer_dump' [-Werror,-Wimplicit-function-declaration]
kernel/stop_machine.c:290:7: error: implicit declaration of function 'cpu_hp_check_delay' [-Werror,-Wimplicit-function-declaration]
mips-linux-ld: (.text.cpu_hp_stop_now+0x120): undefined reference to `__udivdi3'
mips-linux-ld: cpu.c:(.text+0x15e0): undefined reference to `__udivdi3'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- alpha-buildonly-randconfig-r004-20220108
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- alpha-defconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- arc-allyesconfig
|   |-- kernel-stop_machine.c:warning:variable-t-set-but-not-used
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- arc-defconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- arc-randconfig-r006-20220108
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- arc-randconfig-r023-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- arc-randconfig-r043-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- arm-allmodconfig
|   `-- kernel-stop_machine.c:warning:variable-t-set-but-not-used
|-- arm-allyesconfig
|   `-- kernel-stop_machine.c:warning:variable-t-set-but-not-used
|-- arm-defconfig
|   `-- kernel-stop_machine.c:warning:variable-t-set-but-not-used
|-- arm-randconfig-c002-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- arm64-allyesconfig
|   `-- kernel-stop_machine.c:warning:variable-t-set-but-not-used
|-- arm64-defconfig
|   `-- kernel-stop_machine.c:warning:variable-t-set-but-not-used
|-- csky-defconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- h8300-allyesconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- h8300-randconfig-r021-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- i386-randconfig-a002-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- i386-randconfig-a004-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- i386-randconfig-a005-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- i386-randconfig-a006-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- m68k-allmodconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- m68k-allyesconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- m68k-buildonly-randconfig-r002-20220108
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- m68k-defconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- microblaze-randconfig-r012-20220108
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- mips-allmodconfig
|   |-- (.text.cpu_hp_check_delay):undefined-reference-to-__udivdi3
|   |-- (.text.cpu_hp_start_now):undefined-reference-to-__udivdi3
|   |-- (.text.cpu_hp_stop_now):undefined-reference-to-__udivdi3
|   `-- mips-linux-ld:(.text.cpu_hp_stop_now):undefined-reference-to-__udivdi3
|-- mips-bmips_be_defconfig
|   `-- mips-linux-ld:cpu.c:(.text):undefined-reference-to-__udivdi3
|-- nds32-allyesconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- nds32-defconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- nios2-allyesconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- nios2-buildonly-randconfig-r001-20220108
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- openrisc-randconfig-r026-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- openrisc-randconfig-r035-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- parisc-randconfig-r001-20220108
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- parisc-randconfig-r015-20220108
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- powerpc-randconfig-r036-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- powerpc-sam440ep_defconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- riscv-allnoconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- riscv-nommu_k210_defconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- riscv-nommu_k210_sdcard_defconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- riscv-nommu_virt_defconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- s390-buildonly-randconfig-r005-20220108
|   `-- kernel-stop_machine.c:warning:variable-t-set-but-not-used
|-- sh-allmodconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- sparc-defconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- sparc64-randconfig-r025-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- um-allnoconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- um-i386_defconfig
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- x86_64-allyesconfig
|   `-- kernel-stop_machine.c:warning:variable-t-set-but-not-used
|-- x86_64-defconfig
|   `-- kernel-stop_machine.c:warning:variable-t-set-but-not-used
|-- x86_64-kexec
|   `-- kernel-stop_machine.c:warning:variable-t-set-but-not-used
|-- x86_64-randconfig-a001-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- x86_64-randconfig-a003-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- x86_64-randconfig-a004-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- x86_64-randconfig-a005-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- x86_64-randconfig-a006-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- x86_64-randconfig-m001-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump
|-- x86_64-rhel-8.3
|   `-- kernel-stop_machine.c:warning:variable-t-set-but-not-used
|-- x86_64-rhel-8.3-func
|   `-- kernel-stop_machine.c:warning:variable-t-set-but-not-used
`-- xtensa-allyesconfig
    `-- kernel-time-timer.c:warning:no-previous-prototype-for-tick_setup_sched_timer_dump

clang_recent_errors
|-- arm-randconfig-r034-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-function-tick_setup_sched_timer_dump
|-- arm64-randconfig-r024-20220107
|   |-- kernel-cpu.c:warning:no-previous-prototype-for-function-cpu_hp_check_delay
|   |-- kernel-cpu.c:warning:no-previous-prototype-for-function-cpu_hp_start_now
|   |-- kernel-cpu.c:warning:no-previous-prototype-for-function-cpu_hp_stop_now
|   |-- kernel-stop_machine.c:error:implicit-declaration-of-function-cpu_hp_check_delay-Werror-Wimplicit-function-declaration
|   `-- kernel-stop_machine.c:error:implicit-declaration-of-function-tick_setup_sched_timer_dump-Werror-Wimplicit-function-declaration
|-- hexagon-randconfig-r011-20220108
|   |-- kernel-cpu.c:warning:no-previous-prototype-for-function-cpu_hp_check_delay
|   |-- kernel-cpu.c:warning:no-previous-prototype-for-function-cpu_hp_start_now
|   |-- kernel-cpu.c:warning:no-previous-prototype-for-function-cpu_hp_stop_now
|   |-- kernel-stop_machine.c:error:implicit-declaration-of-function-cpu_hp_check_delay-Werror-Wimplicit-function-declaration
|   |-- kernel-stop_machine.c:error:implicit-declaration-of-function-tick_setup_sched_timer_dump-Werror-Wimplicit-function-declaration
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-function-tick_setup_sched_timer_dump
|-- hexagon-randconfig-r023-20220107
|   |-- kernel-cpu.c:warning:no-previous-prototype-for-function-cpu_hp_check_delay
|   |-- kernel-cpu.c:warning:no-previous-prototype-for-function-cpu_hp_start_now
|   |-- kernel-cpu.c:warning:no-previous-prototype-for-function-cpu_hp_stop_now
|   |-- kernel-stop_machine.c:error:implicit-declaration-of-function-cpu_hp_check_delay-Werror-Wimplicit-function-declaration
|   `-- kernel-stop_machine.c:error:implicit-declaration-of-function-tick_setup_sched_timer_dump-Werror-Wimplicit-function-declaration
|-- hexagon-randconfig-r041-20220107
|   |-- kernel-cpu.c:warning:no-previous-prototype-for-function-cpu_hp_check_delay
|   |-- kernel-cpu.c:warning:no-previous-prototype-for-function-cpu_hp_start_now
|   |-- kernel-cpu.c:warning:no-previous-prototype-for-function-cpu_hp_stop_now
|   |-- kernel-stop_machine.c:error:implicit-declaration-of-function-cpu_hp_check_delay-Werror-Wimplicit-function-declaration
|   |-- kernel-stop_machine.c:error:implicit-declaration-of-function-tick_setup_sched_timer_dump-Werror-Wimplicit-function-declaration
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-function-tick_setup_sched_timer_dump
|-- hexagon-randconfig-r045-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-function-tick_setup_sched_timer_dump
|-- riscv-randconfig-r042-20220107
|   |-- kernel-cpu.c:warning:no-previous-prototype-for-function-cpu_hp_check_delay
|   |-- kernel-cpu.c:warning:no-previous-prototype-for-function-cpu_hp_start_now
|   |-- kernel-cpu.c:warning:no-previous-prototype-for-function-cpu_hp_stop_now
|   |-- kernel-stop_machine.c:error:implicit-declaration-of-function-cpu_hp_check_delay-Werror-Wimplicit-function-declaration
|   |-- kernel-stop_machine.c:error:implicit-declaration-of-function-tick_setup_sched_timer_dump-Werror-Wimplicit-function-declaration
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-function-tick_setup_sched_timer_dump
|-- s390-randconfig-r026-20220107
|   `-- kernel-stop_machine.c:warning:variable-t-set-but-not-used
|-- x86_64-randconfig-a013-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-function-tick_setup_sched_timer_dump
|-- x86_64-randconfig-a015-20220107
|   |-- arch-x86-kernel-kvm.c:error:implicit-declaration-of-function-cpu_hp_check_delay-Werror-Wimplicit-function-declaration
|   |-- arch-x86-kernel-kvm.c:error:implicit-declaration-of-function-cpu_hp_stop_now-Werror-Wimplicit-function-declaration
|   |-- arch-x86-kernel-kvmclock.c:error:implicit-declaration-of-function-cpu_hp_start_now-Werror-Wimplicit-function-declaration
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-function-tick_setup_sched_timer_dump
|-- x86_64-randconfig-a016-20220107
|   `-- kernel-time-timer.c:warning:no-previous-prototype-for-function-tick_setup_sched_timer_dump
`-- x86_64-randconfig-r002-20220108
    `-- kernel-time-timer.c:warning:no-previous-prototype-for-function-tick_setup_sched_timer_dump

elapsed time: 1062m

configs tested: 80
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
powerpc                    sam440ep_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                  randconfig-c002-20220107
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a001-20220107
x86_64               randconfig-a002-20220107
x86_64               randconfig-a003-20220107
x86_64               randconfig-a005-20220107
x86_64               randconfig-a004-20220107
x86_64               randconfig-a006-20220107
i386                 randconfig-a003-20220107
i386                 randconfig-a005-20220107
i386                 randconfig-a004-20220107
i386                 randconfig-a006-20220107
i386                 randconfig-a002-20220107
i386                 randconfig-a001-20220107
arc                  randconfig-r043-20220107
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a012-20220107
x86_64               randconfig-a013-20220107
x86_64               randconfig-a011-20220107
x86_64               randconfig-a016-20220107
x86_64               randconfig-a015-20220107
x86_64               randconfig-a014-20220107
hexagon              randconfig-r041-20220107
hexagon              randconfig-r045-20220107
riscv                randconfig-r042-20220107
s390                 randconfig-r044-20220107

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C654713C8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 13:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhLKMcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 07:32:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:15904 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbhLKMcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 07:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639225962; x=1670761962;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PI3eayuVmxYtcDyWx7+JuoAwp4QNZM+j2EKf4FOJfFM=;
  b=RhISLw78RrPz5erxNprFZLBn+8Xo5YIPfq4B0kLFj+Xd4NUy3wVX/GOM
   xjm9U5nCu2NrxrQcv+WHH7f9PaeEBersXM7SBpM0WULCZcyh2MZiv2H1w
   LCoQyjB81Z1WSThTGMxhauEkyOBSiuBnSlE9LITTemiOeOEpLQi+8Hbmy
   41ew08Q+oTK5FjFcr6wGMU6fe9E4lKtB/Htoqlfs2g2y1ERGOzF9KnyVK
   /1CT3/FvfFG7WEj3gYa1nuUcsoKLvcDkPPCp9GozinCpIOlzVLA7XBprl
   5mwNrX1o7XSalhzbLhgLZXh/bQvIpGm3emvqBPq4z56Mx5RSrbl8Kbead
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="262645374"
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="262645374"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 04:32:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="565752619"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 11 Dec 2021 04:32:40 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mw1YO-0004a5-3O; Sat, 11 Dec 2021 12:32:40 +0000
Date:   Sat, 11 Dec 2021 20:32:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2021.12.07a] BUILD SUCCESS WITH WARNING
 89ddc546d3ad541bc89ec553c92036c98aef57a6
Message-ID: <61b49a48.RqiqbYQAe60YZ+vz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.12.07a
branch HEAD: 89ddc546d3ad541bc89ec553c92036c98aef57a6  rcu: Add mutex for rcu boost kthread spawning and affinity setting

Warning reports:

https://lore.kernel.org/llvm/202112101543.wHvqhgYk-lkp@intel.com

Warning in current branch:

kernel/rcu/tree.c:4312:45: warning: variable 'flags' is uninitialized when used here [-Wuninitialized]

possible Warning in current branch (please contact us if interested):

kernel/rcu/tree.c:4312 rcu_cpu_starting() error: uninitialized symbol 'flags'.

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-m021-20211210
|   `-- kernel-rcu-tree.c-rcu_cpu_starting()-error:uninitialized-symbol-flags-.
|-- ia64-randconfig-m031-20211210
|   `-- kernel-rcu-tree.c-rcu_cpu_starting()-error:uninitialized-symbol-flags-.
`-- x86_64-randconfig-m001-20211210
    `-- kernel-rcu-tree.c-rcu_cpu_starting()-error:uninitialized-symbol-flags-.

clang_recent_errors
|-- arm-randconfig-r003-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- arm64-randconfig-r012-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- arm64-randconfig-r014-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- arm64-randconfig-r021-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- hexagon-buildonly-randconfig-r001-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- hexagon-randconfig-r006-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- hexagon-randconfig-r021-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- hexagon-randconfig-r041-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- i386-randconfig-a012-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- i386-randconfig-a013-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- i386-randconfig-a014-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- i386-randconfig-a015-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- i386-randconfig-a016-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- mips-buildonly-randconfig-r002-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- riscv-buildonly-randconfig-r005-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- x86_64-randconfig-a011-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- x86_64-randconfig-a012-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- x86_64-randconfig-a013-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- x86_64-randconfig-a014-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- x86_64-randconfig-a015-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- x86_64-randconfig-a016-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
|-- x86_64-randconfig-r011-20211210
|   `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here
`-- x86_64-randconfig-r014-20211210
    `-- kernel-rcu-tree.c:warning:variable-flags-is-uninitialized-when-used-here

elapsed time: 2091m

configs tested: 126
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211210
sh                          r7780mp_defconfig
powerpc                          g5_defconfig
arm                  colibri_pxa270_defconfig
m68k                                defconfig
arm                             ezx_defconfig
ia64                      gensparse_defconfig
arm                          pxa168_defconfig
mips                  cavium_octeon_defconfig
mips                     cu1830-neo_defconfig
sh                           se7343_defconfig
arm                           tegra_defconfig
powerpc                     tqm8548_defconfig
mips                     loongson2k_defconfig
um                             i386_defconfig
powerpc                     sequoia_defconfig
arm                         lpc32xx_defconfig
microblaze                      mmu_defconfig
sh                        edosk7705_defconfig
sh                      rts7751r2d1_defconfig
powerpc                   motionpro_defconfig
m68k                         amcore_defconfig
parisc                generic-32bit_defconfig
powerpc                     kmeter1_defconfig
arm                        trizeps4_defconfig
arm                          moxart_defconfig
arm                        mini2440_defconfig
mips                       rbtx49xx_defconfig
arm                           sunxi_defconfig
sh                           se7780_defconfig
sh                        sh7763rdp_defconfig
powerpc                    amigaone_defconfig
powerpc                    socrates_defconfig
powerpc                        fsp2_defconfig
xtensa                              defconfig
xtensa                  cadence_csp_defconfig
arm                       imx_v4_v5_defconfig
powerpc                  mpc866_ads_defconfig
m68k                          amiga_defconfig
m68k                          sun3x_defconfig
arm                           h5000_defconfig
parisc                           allyesconfig
xtensa                  audio_kc705_defconfig
powerpc                 mpc837x_mds_defconfig
arc                          axs103_defconfig
arm                  randconfig-c002-20211210
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211210
x86_64               randconfig-a005-20211210
x86_64               randconfig-a001-20211210
x86_64               randconfig-a002-20211210
x86_64               randconfig-a003-20211210
x86_64               randconfig-a004-20211210
i386                 randconfig-a001-20211210
i386                 randconfig-a002-20211210
i386                 randconfig-a005-20211210
i386                 randconfig-a003-20211210
i386                 randconfig-a006-20211210
i386                 randconfig-a004-20211210
arc                  randconfig-r043-20211210
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20211210
x86_64               randconfig-a012-20211210
x86_64               randconfig-a014-20211210
x86_64               randconfig-a013-20211210
x86_64               randconfig-a015-20211210
x86_64               randconfig-a016-20211210
i386                 randconfig-a013-20211210
i386                 randconfig-a011-20211210
i386                 randconfig-a016-20211210
i386                 randconfig-a014-20211210
i386                 randconfig-a015-20211210
i386                 randconfig-a012-20211210
hexagon              randconfig-r045-20211210
riscv                randconfig-r042-20211210
s390                 randconfig-r044-20211210
hexagon              randconfig-r041-20211210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

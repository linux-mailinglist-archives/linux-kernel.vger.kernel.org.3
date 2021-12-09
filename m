Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985A646E0C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhLICRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:17:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:22739 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229909AbhLICRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:17:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="218021727"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="218021727"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 18:14:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="463033937"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 08 Dec 2021 18:14:03 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mv8wc-0001Ki-GK; Thu, 09 Dec 2021 02:14:02 +0000
Date:   Thu, 09 Dec 2021 10:13:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 77993b595ada5731e513eb06a0f4bf4b9f1e9532
Message-ID: <61b16637.PoyDH3tUEZsvTqVi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 77993b595ada5731e513eb06a0f4bf4b9f1e9532  locking: Allow to include asm/spinlock_types.h from linux/spinlock_types_raw.h

possible Warning in current branch (please contact us if interested):

include/linux/syscalls.h:155:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
include/linux/syscalls.h:242:20: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
include/linux/syscalls.h:243:20: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- mips-allmodconfig
|   `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|-- mips-allyesconfig
|   `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|-- mips-ath25_defconfig
|   `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|-- mips-bmips_stb_defconfig
|   `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|-- mips-cu1000-neo_defconfig
|   `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|-- mips-decstation_64_defconfig
|   `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|-- mips-gpr_defconfig
|   `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|-- mips-jazz_defconfig
|   `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|-- mips-jmr3927_defconfig
|   `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|-- mips-lemote2f_defconfig
|   `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|-- mips-loongson1c_defconfig
|   `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|-- mips-maltasmvp_defconfig
|   `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|-- mips-maltaup_defconfig
|   `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|-- mips-pic32mzda_defconfig
|   `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|-- mips-qi_lb60_defconfig
|   `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|-- mips-randconfig-r022-20211207
|   `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|-- mips-randconfig-r023-20211207
|   `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code
|-- mips-rs90_defconfig
|   `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code
`-- mips-xway_defconfig
    `-- include-linux-syscalls.h:warning:ISO-C90-forbids-mixed-declarations-and-code

elapsed time: 2067m

configs tested: 173
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211207
i386                 randconfig-c001-20211208
m68k                             alldefconfig
arc                           tb10x_defconfig
arm                           tegra_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                        edosk7760_defconfig
riscv                            alldefconfig
arm                            xcep_defconfig
sh                           se7750_defconfig
arm                        shmobile_defconfig
powerpc                 mpc832x_rdb_defconfig
nios2                         3c120_defconfig
arm                           corgi_defconfig
arm                       cns3420vb_defconfig
arm                        cerfcube_defconfig
powerpc                     mpc512x_defconfig
h8300                            allyesconfig
h8300                     edosk2674_defconfig
sh                        sh7763rdp_defconfig
csky                             alldefconfig
arc                        nsim_700_defconfig
sparc                       sparc64_defconfig
riscv                    nommu_k210_defconfig
powerpc                 mpc8272_ads_defconfig
arc                              alldefconfig
powerpc                 mpc834x_mds_defconfig
arc                          axs103_defconfig
arm                         nhk8815_defconfig
sh                      rts7751r2d1_defconfig
powerpc                    socrates_defconfig
arm                   milbeaut_m10v_defconfig
arm                          iop32x_defconfig
arm                       versatile_defconfig
arm                        spear3xx_defconfig
nios2                               defconfig
powerpc                      chrp32_defconfig
arc                    vdk_hs38_smp_defconfig
arm                         lpc18xx_defconfig
arm                            hisi_defconfig
powerpc                        icon_defconfig
arc                     haps_hs_smp_defconfig
m68k                            q40_defconfig
arc                 nsimosci_hs_smp_defconfig
arm64                            alldefconfig
powerpc                       ppc64_defconfig
arc                        nsimosci_defconfig
m68k                          atari_defconfig
sh                           se7780_defconfig
powerpc                   currituck_defconfig
sh                           se7343_defconfig
arm                        neponset_defconfig
arc                     nsimosci_hs_defconfig
arm                         shannon_defconfig
sh                           se7722_defconfig
arm                         lpc32xx_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                           se7619_defconfig
powerpc                     stx_gp3_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                            zeus_defconfig
powerpc                      cm5200_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     powernv_defconfig
arc                      axs103_smp_defconfig
mips                     cu1000-neo_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     ppa8548_defconfig
arm                         hackkit_defconfig
powerpc                      acadia_defconfig
arm                          badge4_defconfig
powerpc                  iss476-smp_defconfig
alpha                               defconfig
xtensa                          iss_defconfig
arm                       aspeed_g4_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                 mpc8540_ads_defconfig
arm                  randconfig-c002-20211207
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
i386                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211207
x86_64               randconfig-a005-20211207
x86_64               randconfig-a001-20211207
x86_64               randconfig-a002-20211207
x86_64               randconfig-a004-20211207
x86_64               randconfig-a003-20211207
i386                 randconfig-a001-20211207
i386                 randconfig-a005-20211207
i386                 randconfig-a002-20211207
i386                 randconfig-a003-20211207
i386                 randconfig-a006-20211207
i386                 randconfig-a004-20211207
x86_64               randconfig-a016-20211208
x86_64               randconfig-a011-20211208
x86_64               randconfig-a013-20211208
x86_64               randconfig-a012-20211208
x86_64               randconfig-a015-20211208
x86_64               randconfig-a014-20211208
arc                  randconfig-r043-20211207
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20211209
x86_64               randconfig-c007-20211209
riscv                randconfig-c006-20211209
i386                 randconfig-c001-20211209
mips                 randconfig-c004-20211209
powerpc              randconfig-c003-20211209
s390                 randconfig-c005-20211209
x86_64               randconfig-a011-20211207
x86_64               randconfig-a013-20211207
x86_64               randconfig-a014-20211207
x86_64               randconfig-a012-20211207
x86_64               randconfig-a016-20211207
x86_64               randconfig-a015-20211207
i386                 randconfig-a016-20211207
i386                 randconfig-a013-20211207
i386                 randconfig-a011-20211207
i386                 randconfig-a014-20211207
i386                 randconfig-a012-20211207
i386                 randconfig-a015-20211207
hexagon              randconfig-r045-20211208
hexagon              randconfig-r041-20211208
hexagon              randconfig-r045-20211207
s390                 randconfig-r044-20211207
riscv                randconfig-r042-20211207
hexagon              randconfig-r041-20211207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

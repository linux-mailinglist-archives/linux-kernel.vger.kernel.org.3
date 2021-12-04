Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88371468808
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 23:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhLDWQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 17:16:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:9221 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhLDWQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 17:16:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="297946311"
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="297946311"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 14:13:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="461363488"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 04 Dec 2021 14:13:03 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtdHD-000JUl-3C; Sat, 04 Dec 2021 22:13:03 +0000
Date:   Sun, 05 Dec 2021 06:12:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2021.12.02a] BUILD SUCCESS WITH WARNING
 d157b802f05bd12cf40bef7a73ca6914b85c865e
Message-ID: <61abe7c5.el8Uw1qA6FDW99UE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.12.02a
branch HEAD: d157b802f05bd12cf40bef7a73ca6914b85c865e  kcsan: selftest: Move test spinlock to static global

Warning reports:

https://lore.kernel.org/lkml/202112041334.X44uWZXf-lkp@intel.com

Warning in current branch:

include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pmd_offset' which is not static
include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pte_offset_kernel' which is not static
include/asm-generic/barrier.h:95:30: warning: 'kcsan_rmb' is static but used in inline function 'pmd_offset' which is not static
include/asm-generic/barrier.h:95:30: warning: 'kcsan_rmb' is static but used in inline function 'pte_offset_kernel' which is not static

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   |-- include-asm-generic-barrier.h:warning:kcsan_rmb-is-static-but-used-in-inline-function-pmd_offset-which-is-not-static
|   `-- include-asm-generic-barrier.h:warning:kcsan_rmb-is-static-but-used-in-inline-function-pte_offset_kernel-which-is-not-static
|-- alpha-allyesconfig
|   |-- include-asm-generic-barrier.h:warning:kcsan_rmb-is-static-but-used-in-inline-function-pmd_offset-which-is-not-static
|   `-- include-asm-generic-barrier.h:warning:kcsan_rmb-is-static-but-used-in-inline-function-pte_offset_kernel-which-is-not-static
`-- alpha-randconfig-r003-20211203
    |-- include-asm-generic-barrier.h:warning:kcsan_rmb-is-static-but-used-in-inline-function-pmd_offset-which-is-not-static
    `-- include-asm-generic-barrier.h:warning:kcsan_rmb-is-static-but-used-in-inline-function-pte_offset_kernel-which-is-not-static

elapsed time: 1189m

configs tested: 231
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
mips                 randconfig-c004-20211203
i386                 randconfig-c001-20211203
arm                        clps711x_defconfig
alpha                            alldefconfig
ia64                         bigsur_defconfig
sh                             shx3_defconfig
powerpc                    adder875_defconfig
m68k                       m5208evb_defconfig
s390                             allyesconfig
powerpc                      arches_defconfig
arm                         shannon_defconfig
powerpc                 mpc8540_ads_defconfig
sh                        edosk7760_defconfig
powerpc                     tqm8555_defconfig
openrisc                    or1ksim_defconfig
arc                          axs101_defconfig
m68k                        m5407c3_defconfig
um                             i386_defconfig
mips                        maltaup_defconfig
sparc                       sparc64_defconfig
mips                        vocore2_defconfig
arc                              allyesconfig
sh                            hp6xx_defconfig
arm                          pxa3xx_defconfig
sh                               alldefconfig
nios2                         10m50_defconfig
powerpc                     ppa8548_defconfig
nios2                               defconfig
powerpc                  mpc866_ads_defconfig
sh                          kfr2r09_defconfig
sparc                            allyesconfig
powerpc                    klondike_defconfig
arm                             rpc_defconfig
mips                          ath79_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          rsk7269_defconfig
arc                        nsim_700_defconfig
arm                         s5pv210_defconfig
arm                       omap2plus_defconfig
arm                         lpc32xx_defconfig
um                           x86_64_defconfig
mips                           xway_defconfig
arm                            xcep_defconfig
powerpc                       holly_defconfig
powerpc                      ppc40x_defconfig
powerpc                     tqm8541_defconfig
mips                      pic32mzda_defconfig
arm                          ep93xx_defconfig
m68k                            mac_defconfig
arm                          badge4_defconfig
arc                     nsimosci_hs_defconfig
powerpc                 linkstation_defconfig
powerpc                     asp8347_defconfig
mips                    maltaup_xpa_defconfig
powerpc                    gamecube_defconfig
mips                            e55_defconfig
arc                         haps_hs_defconfig
sh                           se7712_defconfig
arm                         assabet_defconfig
powerpc                       eiger_defconfig
arm                         axm55xx_defconfig
arm                          gemini_defconfig
mips                       bmips_be_defconfig
powerpc                     mpc83xx_defconfig
sh                         microdev_defconfig
powerpc                 canyonlands_defconfig
arm                      jornada720_defconfig
powerpc                      cm5200_defconfig
arm                         lubbock_defconfig
mips                         mpc30x_defconfig
arm                         bcm2835_defconfig
powerpc                 mpc8272_ads_defconfig
arc                      axs103_smp_defconfig
arm                         palmz72_defconfig
xtensa                       common_defconfig
h8300                       h8s-sim_defconfig
openrisc                  or1klitex_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                       m5249evb_defconfig
m68k                       m5275evb_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                         ap325rxa_defconfig
arm                         socfpga_defconfig
mips                          rm200_defconfig
mips                            gpr_defconfig
h8300                               defconfig
arm                            qcom_defconfig
arm                        mvebu_v5_defconfig
sh                        sh7785lcr_defconfig
arm                            mps2_defconfig
sh                           se7751_defconfig
nios2                            allyesconfig
mips                         bigsur_defconfig
m68k                       bvme6000_defconfig
riscv                          rv32_defconfig
arm                         cm_x300_defconfig
powerpc                    amigaone_defconfig
m68k                           sun3_defconfig
sh                              ul2_defconfig
arm                    vt8500_v6_v7_defconfig
i386                             allyesconfig
arc                     haps_hs_smp_defconfig
m68k                        m5307c3_defconfig
sh                         apsh4a3a_defconfig
m68k                          atari_defconfig
powerpc                          g5_defconfig
sh                            migor_defconfig
arm                           h5000_defconfig
powerpc                     tqm8548_defconfig
sh                     sh7710voipgw_defconfig
arm                  randconfig-c002-20211203
arm                  randconfig-c002-20211205
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211203
x86_64               randconfig-a005-20211203
x86_64               randconfig-a001-20211203
x86_64               randconfig-a002-20211203
x86_64               randconfig-a004-20211203
x86_64               randconfig-a003-20211203
i386                 randconfig-a001-20211203
i386                 randconfig-a005-20211203
i386                 randconfig-a002-20211203
i386                 randconfig-a003-20211203
i386                 randconfig-a006-20211203
i386                 randconfig-a004-20211203
i386                 randconfig-a001-20211205
i386                 randconfig-a005-20211205
i386                 randconfig-a003-20211205
i386                 randconfig-a002-20211205
i386                 randconfig-a006-20211205
i386                 randconfig-a004-20211205
i386                 randconfig-a013-20211204
i386                 randconfig-a016-20211204
i386                 randconfig-a011-20211204
i386                 randconfig-a014-20211204
i386                 randconfig-a012-20211204
i386                 randconfig-a015-20211204
x86_64               randconfig-a006-20211205
x86_64               randconfig-a005-20211205
x86_64               randconfig-a001-20211205
x86_64               randconfig-a002-20211205
x86_64               randconfig-a004-20211205
x86_64               randconfig-a003-20211205
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20211203
x86_64               randconfig-c007-20211203
riscv                randconfig-c006-20211203
mips                 randconfig-c004-20211203
i386                 randconfig-c001-20211203
powerpc              randconfig-c003-20211203
s390                 randconfig-c005-20211203
x86_64               randconfig-c007-20211205
arm                  randconfig-c002-20211205
riscv                randconfig-c006-20211205
mips                 randconfig-c004-20211205
i386                 randconfig-c001-20211205
powerpc              randconfig-c003-20211205
s390                 randconfig-c005-20211205
x86_64               randconfig-a016-20211203
x86_64               randconfig-a011-20211203
x86_64               randconfig-a013-20211203
x86_64               randconfig-a014-20211203
x86_64               randconfig-a015-20211203
x86_64               randconfig-a012-20211203
x86_64               randconfig-a016-20211205
x86_64               randconfig-a011-20211205
x86_64               randconfig-a013-20211205
x86_64               randconfig-a015-20211205
x86_64               randconfig-a012-20211205
x86_64               randconfig-a014-20211205
i386                 randconfig-a016-20211203
i386                 randconfig-a013-20211203
i386                 randconfig-a011-20211203
i386                 randconfig-a014-20211203
i386                 randconfig-a012-20211203
i386                 randconfig-a015-20211203
i386                 randconfig-a013-20211205
i386                 randconfig-a016-20211205
i386                 randconfig-a011-20211205
i386                 randconfig-a014-20211205
i386                 randconfig-a012-20211205
i386                 randconfig-a015-20211205
hexagon              randconfig-r045-20211203
s390                 randconfig-r044-20211203
hexagon              randconfig-r041-20211203
riscv                randconfig-r042-20211203
hexagon              randconfig-r045-20211204
hexagon              randconfig-r041-20211204
hexagon              randconfig-r045-20211205
s390                 randconfig-r044-20211205
riscv                randconfig-r042-20211205
hexagon              randconfig-r041-20211205

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEEC4688F4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 04:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhLEDEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 22:04:46 -0500
Received: from mga12.intel.com ([192.55.52.136]:32116 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229682AbhLEDEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 22:04:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="217182858"
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="217182858"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 19:01:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="514259742"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 04 Dec 2021 19:01:18 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mthm9-000JjJ-Kf; Sun, 05 Dec 2021 03:01:17 +0000
Date:   Sun, 05 Dec 2021 11:00:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 9d8c5461d363a258101e8a7a12e52b5da2e5bbeb
Message-ID: <61ac2b4a.XfQrObGyaYuyFpkI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 9d8c5461d363a258101e8a7a12e52b5da2e5bbeb  Merge x86/urgent into tip/master

elapsed time: 728m

configs tested: 164
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211203
arm                         cm_x300_defconfig
m68k                            q40_defconfig
mips                  maltasmvp_eva_defconfig
arm                          exynos_defconfig
um                                  defconfig
arm                           sunxi_defconfig
powerpc                     mpc5200_defconfig
sh                      rts7751r2d1_defconfig
s390                                defconfig
arm                        clps711x_defconfig
arc                              allyesconfig
sh                            hp6xx_defconfig
mips                          ath79_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                          atari_defconfig
powerpc                     tqm8560_defconfig
sh                     sh7710voipgw_defconfig
arm                       aspeed_g5_defconfig
powerpc                      cm5200_defconfig
powerpc                     skiroot_defconfig
arc                         haps_hs_defconfig
sh                           se7712_defconfig
arm                         assabet_defconfig
powerpc                       eiger_defconfig
powerpc                          g5_defconfig
powerpc                      katmai_defconfig
arm                        neponset_defconfig
arm                      integrator_defconfig
powerpc                     kilauea_defconfig
mips                         rt305x_defconfig
riscv                    nommu_k210_defconfig
powerpc                       holly_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                            migor_defconfig
arm                       spear13xx_defconfig
h8300                       h8s-sim_defconfig
openrisc                  or1klitex_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                       m5249evb_defconfig
m68k                       m5275evb_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                    amigaone_defconfig
powerpc                     mpc83xx_defconfig
m68k                           sun3_defconfig
sh                              ul2_defconfig
sh                         apsh4a3a_defconfig
mips                        vocore2_defconfig
arm                  randconfig-c002-20211205
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
nios2                               defconfig
nds32                             allnoconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
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
x86_64               randconfig-a005-20211203
x86_64               randconfig-a001-20211203
x86_64               randconfig-a002-20211203
x86_64               randconfig-a004-20211203
x86_64               randconfig-a003-20211203
x86_64               randconfig-a006-20211203
i386                 randconfig-a001-20211205
i386                 randconfig-a005-20211205
i386                 randconfig-a003-20211205
i386                 randconfig-a002-20211205
i386                 randconfig-a006-20211205
i386                 randconfig-a004-20211205
i386                 randconfig-a001-20211203
i386                 randconfig-a002-20211203
i386                 randconfig-a003-20211203
i386                 randconfig-a006-20211203
i386                 randconfig-a004-20211203
i386                 randconfig-a005-20211203
x86_64               randconfig-a006-20211205
x86_64               randconfig-a005-20211205
x86_64               randconfig-a001-20211205
x86_64               randconfig-a002-20211205
x86_64               randconfig-a004-20211205
x86_64               randconfig-a003-20211205
arc                  randconfig-r043-20211203
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211205
arm                  randconfig-c002-20211205
riscv                randconfig-c006-20211205
mips                 randconfig-c004-20211205
i386                 randconfig-c001-20211205
powerpc              randconfig-c003-20211205
s390                 randconfig-c005-20211205
x86_64               randconfig-a006-20211204
x86_64               randconfig-a005-20211204
x86_64               randconfig-a001-20211204
x86_64               randconfig-a002-20211204
x86_64               randconfig-a004-20211204
x86_64               randconfig-a003-20211204
x86_64               randconfig-a016-20211205
x86_64               randconfig-a011-20211205
x86_64               randconfig-a013-20211205
x86_64               randconfig-a015-20211205
x86_64               randconfig-a012-20211205
x86_64               randconfig-a014-20211205
i386                 randconfig-a013-20211205
i386                 randconfig-a016-20211205
i386                 randconfig-a011-20211205
i386                 randconfig-a014-20211205
i386                 randconfig-a012-20211205
i386                 randconfig-a015-20211205
i386                 randconfig-a013-20211203
i386                 randconfig-a011-20211203
i386                 randconfig-a012-20211203
i386                 randconfig-a014-20211203
i386                 randconfig-a016-20211203
i386                 randconfig-a015-20211203
hexagon              randconfig-r045-20211205
s390                 randconfig-r044-20211205
riscv                randconfig-r042-20211205
hexagon              randconfig-r041-20211205
hexagon              randconfig-r045-20211203
s390                 randconfig-r044-20211203
hexagon              randconfig-r041-20211203
riscv                randconfig-r042-20211203

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

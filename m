Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD95464D2A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 12:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349010AbhLALqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 06:46:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:8429 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237407AbhLALpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 06:45:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="299830981"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="299830981"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 03:42:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="540794641"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 01 Dec 2021 03:42:26 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msO0H-000EqG-Pa; Wed, 01 Dec 2021 11:42:25 +0000
Date:   Wed, 01 Dec 2021 19:42:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 c494eb366dbfc5095c0f159bbb5c6d4ec3ed37ec
Message-ID: <61a75f8e.33V2lXU9XJHSJupM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: c494eb366dbfc5095c0f159bbb5c6d4ec3ed37ec  x86/sev-es: Use insn_decode_mmio() for MMIO implementation

elapsed time: 730m

configs tested: 226
configs skipped: 68

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211128
i386                 randconfig-c001-20211201
sh                           se7750_defconfig
powerpc                      pasemi_defconfig
sh                               alldefconfig
arm                       imx_v6_v7_defconfig
powerpc                      acadia_defconfig
m68k                        m5272c3_defconfig
sh                          polaris_defconfig
powerpc                    adder875_defconfig
sh                        edosk7760_defconfig
powerpc                       holly_defconfig
arm                      footbridge_defconfig
xtensa                  cadence_csp_defconfig
powerpc                       maple_defconfig
sh                           se7722_defconfig
sh                            titan_defconfig
mips                    maltaup_xpa_defconfig
arm                  colibri_pxa270_defconfig
mips                           rs90_defconfig
arm                       netwinder_defconfig
arm                       versatile_defconfig
arm                        magician_defconfig
powerpc                   currituck_defconfig
h8300                            allyesconfig
sh                          rsk7264_defconfig
sh                ecovec24-romimage_defconfig
arm                            mmp2_defconfig
arm                           tegra_defconfig
mips                           ci20_defconfig
sh                           se7206_defconfig
sh                         apsh4a3a_defconfig
parisc                generic-32bit_defconfig
arm                         s3c2410_defconfig
powerpc                      ep88xc_defconfig
nios2                         10m50_defconfig
sparc                               defconfig
mips                       lemote2f_defconfig
x86_64                              defconfig
arm                           corgi_defconfig
s390                             alldefconfig
arm                       multi_v4t_defconfig
mips                  cavium_octeon_defconfig
openrisc                            defconfig
arm                            dove_defconfig
arm                          lpd270_defconfig
powerpc                          g5_defconfig
powerpc64                        alldefconfig
openrisc                    or1ksim_defconfig
powerpc                  iss476-smp_defconfig
powerpc                     akebono_defconfig
arm                          pxa3xx_defconfig
xtensa                          iss_defconfig
powerpc                mpc7448_hpc2_defconfig
um                               alldefconfig
arm                          simpad_defconfig
arc                        vdk_hs38_defconfig
arm                         bcm2835_defconfig
s390                             allyesconfig
sh                            shmin_defconfig
mips                        workpad_defconfig
nios2                            alldefconfig
arm                         socfpga_defconfig
mips                     decstation_defconfig
arm                         vf610m4_defconfig
arm                             mxs_defconfig
powerpc                      makalu_defconfig
powerpc                      ppc44x_defconfig
arm                       mainstone_defconfig
powerpc                     pq2fads_defconfig
alpha                            alldefconfig
powerpc                 mpc8313_rdb_defconfig
mips                          rm200_defconfig
m68k                          hp300_defconfig
powerpc                    amigaone_defconfig
powerpc64                           defconfig
m68k                        mvme16x_defconfig
powerpc                      cm5200_defconfig
arm                        vexpress_defconfig
arm                  randconfig-c002-20211128
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211201
x86_64               randconfig-a005-20211201
x86_64               randconfig-a001-20211201
x86_64               randconfig-a002-20211201
x86_64               randconfig-a004-20211201
x86_64               randconfig-a003-20211201
i386                 randconfig-a002-20211130
i386                 randconfig-a004-20211130
i386                 randconfig-a003-20211130
i386                 randconfig-a001-20211130
i386                 randconfig-a005-20211130
i386                 randconfig-a006-20211130
i386                 randconfig-a001-20211129
i386                 randconfig-a002-20211129
i386                 randconfig-a006-20211129
i386                 randconfig-a005-20211129
i386                 randconfig-a004-20211129
i386                 randconfig-a003-20211129
i386                 randconfig-a001-20211201
i386                 randconfig-a005-20211201
i386                 randconfig-a003-20211201
i386                 randconfig-a002-20211201
i386                 randconfig-a006-20211201
i386                 randconfig-a004-20211201
x86_64               randconfig-a011-20211128
x86_64               randconfig-a014-20211128
x86_64               randconfig-a012-20211128
x86_64               randconfig-a016-20211128
x86_64               randconfig-a013-20211128
x86_64               randconfig-a015-20211128
i386                 randconfig-a015-20211128
i386                 randconfig-a016-20211128
i386                 randconfig-a013-20211128
i386                 randconfig-a012-20211128
i386                 randconfig-a014-20211128
i386                 randconfig-a011-20211128
arc                  randconfig-r043-20211128
s390                 randconfig-r044-20211128
riscv                randconfig-r042-20211128
riscv                    nommu_k210_defconfig
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
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20211128
i386                 randconfig-c001-20211128
riscv                randconfig-c006-20211128
arm                  randconfig-c002-20211128
powerpc              randconfig-c003-20211128
x86_64               randconfig-c007-20211128
mips                 randconfig-c004-20211128
arm                  randconfig-c002-20211201
x86_64               randconfig-c007-20211201
riscv                randconfig-c006-20211201
mips                 randconfig-c004-20211201
i386                 randconfig-c001-20211201
powerpc              randconfig-c003-20211201
s390                 randconfig-c005-20211201
x86_64               randconfig-a001-20211128
x86_64               randconfig-a006-20211128
x86_64               randconfig-a003-20211128
x86_64               randconfig-a005-20211128
x86_64               randconfig-a004-20211128
x86_64               randconfig-a002-20211128
i386                 randconfig-a001-20211128
i386                 randconfig-a002-20211128
i386                 randconfig-a006-20211128
i386                 randconfig-a005-20211128
i386                 randconfig-a004-20211128
i386                 randconfig-a003-20211128
x86_64               randconfig-a016-20211201
x86_64               randconfig-a011-20211201
x86_64               randconfig-a013-20211201
x86_64               randconfig-a015-20211201
x86_64               randconfig-a012-20211201
x86_64               randconfig-a014-20211201
x86_64               randconfig-a014-20211130
x86_64               randconfig-a016-20211130
x86_64               randconfig-a013-20211130
x86_64               randconfig-a012-20211130
x86_64               randconfig-a015-20211130
x86_64               randconfig-a011-20211130
i386                 randconfig-a011-20211130
i386                 randconfig-a015-20211130
i386                 randconfig-a012-20211130
i386                 randconfig-a013-20211130
i386                 randconfig-a014-20211130
i386                 randconfig-a016-20211130
i386                 randconfig-a013-20211201
i386                 randconfig-a016-20211201
i386                 randconfig-a011-20211201
i386                 randconfig-a014-20211201
i386                 randconfig-a012-20211201
i386                 randconfig-a015-20211201
i386                 randconfig-a015-20211129
i386                 randconfig-a016-20211129
i386                 randconfig-a013-20211129
i386                 randconfig-a012-20211129
i386                 randconfig-a014-20211129
i386                 randconfig-a011-20211129
hexagon              randconfig-r045-20211129
hexagon              randconfig-r041-20211129
s390                 randconfig-r044-20211129
riscv                randconfig-r042-20211129

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

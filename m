Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EDC479E09
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 23:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhLRWvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 17:51:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:38502 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhLRWvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 17:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639867866; x=1671403866;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ruXyFglRj9dcXmCUgtCaAt3vyl0Fsqu9Hm0IIpVeCMk=;
  b=a1wLu1lRt1UbrRhXZhCwZddDe3fI7pgHmRViou5FcNBmaedWSZJZ8COu
   ra1KvQVbEj5cdJD4EvW9MzOAHB3dFT+fm01UR8fi0Puaw+z4KPPcvSNGb
   W01+LL7Q574HAeXfCc4mRRiStswA/3nrw8eCjdawqCqfSv9YjD2rR4YEy
   WnLysfEX7qNWEPvzwpojeVM67509CaCGhDGa1KnLX7oeiJvDgh7wRxyY0
   Bs/beSiKbcbyxVkunY3URdZOROvBohnL/fAhDeay5xu9FdVw/QxWk+l61
   tmB1WZZ7F7p5YNRj8SY7OWVUQTo9djz05gRh5j2sXPHKQYS3hhbXoWaDP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10202"; a="264136706"
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="264136706"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 14:51:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="683790113"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Dec 2021 14:51:04 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myiXf-0006Te-UW; Sat, 18 Dec 2021 22:51:03 +0000
Date:   Sun, 19 Dec 2021 06:50:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 8f556a326c93213927e683fc32bbf5be1b62540a
Message-ID: <61be65a7.MwS+Kf3dCHHhmERF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: 8f556a326c93213927e683fc32bbf5be1b62540a  locking/rtmutex: Fix incorrect condition in rtmutex_spin_on_owner()

elapsed time: 725m

configs tested: 199
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211218
powerpc                       maple_defconfig
nds32                               defconfig
arm                          simpad_defconfig
mips                        bcm63xx_defconfig
sh                           se7724_defconfig
mips                     loongson1b_defconfig
openrisc                            defconfig
powerpc                   motionpro_defconfig
powerpc                    socrates_defconfig
powerpc                      arches_defconfig
powerpc                          g5_defconfig
powerpc                 canyonlands_defconfig
arm                        trizeps4_defconfig
powerpc                      chrp32_defconfig
nios2                         10m50_defconfig
arm                          lpd270_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                   sb1250_swarm_defconfig
m68k                        m5307c3_defconfig
mips                      malta_kvm_defconfig
um                             i386_defconfig
sparc64                             defconfig
arm                        mvebu_v7_defconfig
mips                malta_qemu_32r6_defconfig
mips                             allmodconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                    ge_imp3a_defconfig
alpha                            alldefconfig
arc                        nsim_700_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      katmai_defconfig
arm                        vexpress_defconfig
powerpc                      mgcoge_defconfig
powerpc                     powernv_defconfig
arm                      pxa255-idp_defconfig
h8300                            alldefconfig
arm                       spear13xx_defconfig
mips                         cobalt_defconfig
mips                           ip28_defconfig
powerpc                      pasemi_defconfig
nds32                             allnoconfig
powerpc                        fsp2_defconfig
nios2                            alldefconfig
m68k                        m5407c3_defconfig
ia64                          tiger_defconfig
arm                       netwinder_defconfig
powerpc                      pmac32_defconfig
m68k                             alldefconfig
mips                         tb0219_defconfig
sparc                       sparc64_defconfig
m68k                        mvme147_defconfig
arm                  colibri_pxa270_defconfig
sh                         ecovec24_defconfig
m68k                         apollo_defconfig
m68k                         amcore_defconfig
mips                        bcm47xx_defconfig
h8300                    h8300h-sim_defconfig
mips                             allyesconfig
sh                   sh7770_generic_defconfig
arm                         mv78xx0_defconfig
powerpc                     tqm8560_defconfig
powerpc                    adder875_defconfig
m68k                            q40_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                         s5pv210_defconfig
mips                  decstation_64_defconfig
mips                  cavium_octeon_defconfig
m68k                          hp300_defconfig
xtensa                generic_kc705_defconfig
sh                          rsk7269_defconfig
arm                          pxa168_defconfig
powerpc                     taishan_defconfig
powerpc                      acadia_defconfig
xtensa                  nommu_kc705_defconfig
arm                       aspeed_g4_defconfig
sh                             espt_defconfig
parisc                           allyesconfig
powerpc                      makalu_defconfig
arc                     haps_hs_smp_defconfig
mips                          rb532_defconfig
h8300                            allyesconfig
powerpc                 linkstation_defconfig
m68k                           sun3_defconfig
openrisc                    or1ksim_defconfig
h8300                     edosk2674_defconfig
powerpc64                           defconfig
powerpc                        warp_defconfig
arm                          ixp4xx_defconfig
powerpc                     tqm8540_defconfig
powerpc                         ps3_defconfig
parisc                           alldefconfig
m68k                       m5208evb_defconfig
powerpc                     tqm5200_defconfig
arm                  randconfig-c002-20211218
arm                  randconfig-c002-20211219
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
alpha                               defconfig
alpha                            allyesconfig
csky                                defconfig
nios2                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
xtensa                           allyesconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20211216
x86_64               randconfig-a002-20211216
x86_64               randconfig-a003-20211216
x86_64               randconfig-a004-20211216
x86_64               randconfig-a006-20211216
x86_64               randconfig-a005-20211216
x86_64               randconfig-a006-20211218
x86_64               randconfig-a005-20211218
x86_64               randconfig-a001-20211218
x86_64               randconfig-a003-20211218
x86_64               randconfig-a002-20211218
x86_64               randconfig-a004-20211218
i386                 randconfig-a001-20211216
i386                 randconfig-a002-20211216
i386                 randconfig-a005-20211216
i386                 randconfig-a003-20211216
i386                 randconfig-a006-20211216
i386                 randconfig-a004-20211216
i386                 randconfig-a002-20211218
i386                 randconfig-a005-20211218
i386                 randconfig-a003-20211218
i386                 randconfig-a006-20211218
i386                 randconfig-a004-20211218
x86_64               randconfig-a011-20211217
x86_64               randconfig-a013-20211217
x86_64               randconfig-a012-20211217
x86_64               randconfig-a016-20211217
x86_64               randconfig-a015-20211217
x86_64               randconfig-a014-20211217
x86_64               randconfig-a011-20211219
x86_64               randconfig-a013-20211219
x86_64               randconfig-a012-20211219
x86_64               randconfig-a014-20211219
x86_64               randconfig-a015-20211219
x86_64               randconfig-a016-20211219
i386                 randconfig-a013-20211219
i386                 randconfig-a011-20211219
i386                 randconfig-a016-20211219
i386                 randconfig-a015-20211219
i386                 randconfig-a014-20211219
i386                 randconfig-a012-20211219
arc                  randconfig-r043-20211218
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func

clang tested configs:
i386                 randconfig-a002-20211219
i386                 randconfig-a001-20211219
i386                 randconfig-a005-20211219
i386                 randconfig-a003-20211219
i386                 randconfig-a006-20211219
i386                 randconfig-a004-20211219
hexagon              randconfig-r045-20211216
s390                 randconfig-r044-20211216
riscv                randconfig-r042-20211216
hexagon              randconfig-r041-20211216
hexagon              randconfig-r045-20211218
s390                 randconfig-r044-20211218
hexagon              randconfig-r041-20211218
riscv                randconfig-r042-20211218

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

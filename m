Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED7449C4CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbiAZH5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:57:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:7760 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbiAZH5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643183860; x=1674719860;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=buxkbY9elRhXQDv1a1o+owFupy8Nn7GB/j1XfAKFzlo=;
  b=Ttfc42yXm3kxAcQk4kqrIh2YmDgu+0yst7qS1h70vpaMgs8FLx30lGIu
   J8oX/BCXAGXsO8i/0EWyF2niT4BTkp3zt/juLc6r4+0eKrU8lIuSqK+y3
   JUVRWy+tR1cwu0HSwFN5yQzXENUh991l2MiGTuS4dKFIGfq8hmONLLMqc
   /ScWZeFa4bggPQSCitPvHnXQvgR5+rjd/RVoFP/dvzMsARycWT7ZQTdI/
   K43l8A4rexo+wb4VNaYcCbkqOYpt0N07xdFcnEPTM4fWP9VxtPO6fkB1S
   YtM1hlHh31OykwwQJvDWajZZjpxQWD/g6rd59OSV/flA6aZJFHHLc22fX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="270951895"
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="270951895"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 23:57:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="520711565"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Jan 2022 23:57:38 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCdBR-000Kxf-P8; Wed, 26 Jan 2022 07:57:37 +0000
Date:   Wed, 26 Jan 2022 15:56:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.01.23a] BUILD SUCCESS
 5e669ade3e10f8716ed0bf4644819a25d5de04c9
Message-ID: <61f0fec2.qV8RcjGYkePaNcs0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.01.23a
branch HEAD: 5e669ade3e10f8716ed0bf4644819a25d5de04c9  fixup! squash! srcu: Make Tree SRCU able to operate without snp_node array

elapsed time: 722m

configs tested: 158
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
arm                        spear6xx_defconfig
powerpc64                           defconfig
ia64                          tiger_defconfig
sparc                       sparc64_defconfig
sh                           se7206_defconfig
powerpc                     redwood_defconfig
powerpc                mpc7448_hpc2_defconfig
riscv                    nommu_k210_defconfig
m68k                        m5407c3_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     rainier_defconfig
powerpc                         ps3_defconfig
nios2                            alldefconfig
sh                 kfr2r09-romimage_defconfig
sh                          urquell_defconfig
mips                         cobalt_defconfig
arm                     eseries_pxa_defconfig
sh                            titan_defconfig
s390                             allmodconfig
openrisc                  or1klitex_defconfig
arc                         haps_hs_defconfig
sh                        apsh4ad0a_defconfig
arm                        trizeps4_defconfig
sh                           se7780_defconfig
mips                            ar7_defconfig
mips                        vocore2_defconfig
arm                      jornada720_defconfig
mips                         db1xxx_defconfig
s390                             allyesconfig
xtensa                  audio_kc705_defconfig
sh                           se7724_defconfig
arm                       aspeed_g5_defconfig
mips                           xway_defconfig
sh                            hp6xx_defconfig
sh                         apsh4a3a_defconfig
um                               alldefconfig
sh                           se7721_defconfig
powerpc                     pq2fads_defconfig
sh                           se7343_defconfig
sparc                               defconfig
arm                            zeus_defconfig
sh                         ap325rxa_defconfig
nios2                         10m50_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          sdk7780_defconfig
arc                            hsdk_defconfig
arm                        mini2440_defconfig
mips                  decstation_64_defconfig
xtensa                           alldefconfig
arc                                 defconfig
powerpc                       ppc64_defconfig
mips                            gpr_defconfig
alpha                               defconfig
mips                      fuloong2e_defconfig
arm                  randconfig-c002-20220124
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a001-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
i386                 randconfig-a002-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a006-20220124
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                  randconfig-r043-20220124
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
arm                  randconfig-c002-20220124
riscv                randconfig-c006-20220124
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220124
x86_64               randconfig-c007-20220124
powerpc                      katmai_defconfig
powerpc                   lite5200b_defconfig
arm                           omap1_defconfig
powerpc                      ppc64e_defconfig
arm                        vexpress_defconfig
arm                          pxa168_defconfig
powerpc                    socrates_defconfig
arm                         orion5x_defconfig
mips                          malta_defconfig
powerpc                     mpc512x_defconfig
powerpc                     kmeter1_defconfig
arm                         shannon_defconfig
mips                           ip27_defconfig
powerpc                        fsp2_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
riscv                randconfig-r042-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r041-20220124
s390                 randconfig-r044-20220124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

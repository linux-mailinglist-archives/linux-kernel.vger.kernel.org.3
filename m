Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A474468294
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 07:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbhLDGHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 01:07:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:19654 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233865AbhLDGHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 01:07:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="323354685"
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="323354685"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 22:03:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="478562612"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 03 Dec 2021 22:03:39 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtO94-000IYk-D7; Sat, 04 Dec 2021 06:03:38 +0000
Date:   Sat, 04 Dec 2021 14:03:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 e1cd82a339024beda8439fb2e20718363ee989a8
Message-ID: <61ab04b0.TvFh8l51t3d22uda%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: e1cd82a339024beda8439fb2e20718363ee989a8  x86/mm: Add missing <asm/cpufeatures.h> dependency to <asm/page_64.h>

elapsed time: 723m

configs tested: 144
configs skipped: 69

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                 randconfig-c004-20211203
i386                 randconfig-c001-20211203
xtensa                generic_kc705_defconfig
nds32                               defconfig
mips                      pic32mzda_defconfig
arm64                            alldefconfig
powerpc                          g5_defconfig
arm                        clps711x_defconfig
alpha                            alldefconfig
ia64                         bigsur_defconfig
sh                             shx3_defconfig
arm                          pxa3xx_defconfig
sh                               alldefconfig
nios2                         10m50_defconfig
powerpc                     ppa8548_defconfig
nios2                               defconfig
powerpc                  mpc866_ads_defconfig
sh                          kfr2r09_defconfig
mips                           mtx1_defconfig
powerpc                     tqm8555_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          rsk7269_defconfig
arc                        nsim_700_defconfig
arm                         s5pv210_defconfig
um                           x86_64_defconfig
mips                           xway_defconfig
arm                            xcep_defconfig
powerpc                       holly_defconfig
powerpc                      ppc40x_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         at91_dt_defconfig
powerpc                     powernv_defconfig
powerpc                      cm5200_defconfig
sh                         microdev_defconfig
powerpc                 canyonlands_defconfig
arm                      jornada720_defconfig
mips                         tb0226_defconfig
arm                       multi_v4t_defconfig
sh                            migor_defconfig
arm                          simpad_defconfig
sh                         ap325rxa_defconfig
arm                         socfpga_defconfig
mips                          rm200_defconfig
mips                            gpr_defconfig
h8300                               defconfig
sh                           se7751_defconfig
m68k                       m5208evb_defconfig
arm                          ep93xx_defconfig
powerpc                       eiger_defconfig
arm                       aspeed_g4_defconfig
sparc                            alldefconfig
mips                          malta_defconfig
powerpc                        warp_defconfig
microblaze                          defconfig
arm                  randconfig-c002-20211203
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
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
parisc                           allyesconfig
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
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
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
x86_64               randconfig-a016-20211203
x86_64               randconfig-a011-20211203
x86_64               randconfig-a013-20211203
x86_64               randconfig-a014-20211203
x86_64               randconfig-a015-20211203
x86_64               randconfig-a012-20211203
i386                 randconfig-a016-20211203
i386                 randconfig-a013-20211203
i386                 randconfig-a011-20211203
i386                 randconfig-a014-20211203
i386                 randconfig-a012-20211203
i386                 randconfig-a015-20211203
x86_64               randconfig-a006-20211204
x86_64               randconfig-a005-20211204
x86_64               randconfig-a001-20211204
x86_64               randconfig-a002-20211204
x86_64               randconfig-a004-20211204
x86_64               randconfig-a003-20211204
hexagon              randconfig-r045-20211203
s390                 randconfig-r044-20211203
hexagon              randconfig-r041-20211203
riscv                randconfig-r042-20211203

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

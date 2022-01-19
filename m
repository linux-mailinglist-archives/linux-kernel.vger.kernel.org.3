Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC06349333C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351138AbiASC51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:57:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:18435 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345120AbiASC5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642561037; x=1674097037;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ibRyU8B8lLtGwomqLV2WPb2SmlVdFHNhOyJOMpb5zWo=;
  b=e6itff9aDEi/NGnoyRptbFQWhHA4FVksT+EeRlQt2waA5/WO1qkhd00z
   XUZUxa06CJnHKFBxh/ViQOKGZP3uhLyogAFf7YObVGf1jcp+SZiGiiEWl
   PzPx1vk2Jzzi2LdaeFx3s0zLk4r1/kHre0tcidWLe+5dHNPs3dM8FRF4D
   8PBmQ6dICxaeOoLMiyqIdJe2S9S8GfwGPNRwKXFkfDsOHXk/OObRepVQo
   9Cyx+ucoPPQC2bwh8Zt2qqY/lb64HHnphA3ekdDtHP/x8trO1G1ho0CLc
   re0jno5DISiZs9UtiZk6kTvvN7RQ0pjDvyWqW0+qeqElPFB13zfbL4E9V
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="232331194"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="232331194"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 18:57:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="672038995"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jan 2022 18:57:14 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA19u-000DAu-BI; Wed, 19 Jan 2022 02:57:14 +0000
Date:   Wed, 19 Jan 2022 10:56:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 8c16dc047b5dd8f7b3bf4584fa75733ea0dde7dc
Message-ID: <61e77ddd.+gCXBOvMOsnv2ddQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 8c16dc047b5dd8f7b3bf4584fa75733ea0dde7dc  x86/perf: Avoid warning for Arch LBR without XSAVE

elapsed time: 725m

configs tested: 151
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220117
mips                 randconfig-c004-20220117
sh                                  defconfig
mips                            ar7_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     asp8347_defconfig
powerpc                 mpc834x_mds_defconfig
sh                           se7721_defconfig
m68k                          atari_defconfig
mips                  decstation_64_defconfig
sh                          sdk7786_defconfig
arm                      footbridge_defconfig
powerpc                  iss476-smp_defconfig
mips                        bcm47xx_defconfig
sh                            shmin_defconfig
h8300                    h8300h-sim_defconfig
sh                          rsk7201_defconfig
arm                         cm_x300_defconfig
sh                          polaris_defconfig
openrisc                  or1klitex_defconfig
powerpc                      ep88xc_defconfig
powerpc                     rainier_defconfig
powerpc                   currituck_defconfig
arm                            qcom_defconfig
arm                            hisi_defconfig
riscv                               defconfig
m68k                       m5475evb_defconfig
sh                   secureedge5410_defconfig
sparc                       sparc32_defconfig
s390                                defconfig
sh                      rts7751r2d1_defconfig
arm                         vf610m4_defconfig
alpha                            allyesconfig
arm                       imx_v6_v7_defconfig
arm                           tegra_defconfig
xtensa                    smp_lx200_defconfig
csky                                defconfig
powerpc                           allnoconfig
powerpc                       eiger_defconfig
sh                     magicpanelr2_defconfig
arm                  randconfig-c002-20220116
arm                  randconfig-c002-20220117
arm                  randconfig-c002-20220118
arm                  randconfig-c002-20220119
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a016-20220117
x86_64               randconfig-a012-20220117
x86_64               randconfig-a013-20220117
x86_64               randconfig-a011-20220117
x86_64               randconfig-a014-20220117
x86_64               randconfig-a015-20220117
i386                 randconfig-a012-20220117
i386                 randconfig-a016-20220117
i386                 randconfig-a014-20220117
i386                 randconfig-a015-20220117
i386                 randconfig-a011-20220117
i386                 randconfig-a013-20220117
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220117
arc                  randconfig-r043-20220116
arc                  randconfig-r043-20220117
s390                 randconfig-r044-20220117
arc                  randconfig-r043-20220118
riscv                randconfig-r042-20220119
s390                 randconfig-r044-20220119
arc                  randconfig-r043-20220119
riscv                            allyesconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220116
x86_64                        randconfig-c007
arm                  randconfig-c002-20220118
riscv                randconfig-c006-20220116
powerpc              randconfig-c003-20220116
powerpc              randconfig-c003-20220118
i386                          randconfig-c001
s390                 randconfig-c005-20220118
mips                 randconfig-c004-20220118
mips                 randconfig-c004-20220116
s390                 randconfig-c005-20220116
riscv                randconfig-c006-20220118
powerpc                     kilauea_defconfig
i386                             allyesconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     mpc5200_defconfig
arm                         lpc32xx_defconfig
mips                      pic32mzda_defconfig
mips                        omega2p_defconfig
mips                        bcm63xx_defconfig
x86_64               randconfig-a005-20220117
x86_64               randconfig-a004-20220117
x86_64               randconfig-a001-20220117
x86_64               randconfig-a006-20220117
x86_64               randconfig-a002-20220117
x86_64               randconfig-a003-20220117
i386                 randconfig-a005-20220117
i386                 randconfig-a001-20220117
i386                 randconfig-a006-20220117
i386                 randconfig-a004-20220117
i386                 randconfig-a002-20220117
i386                 randconfig-a003-20220117
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

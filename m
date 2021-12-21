Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB3147B6FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 02:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhLUByk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 20:54:40 -0500
Received: from mga01.intel.com ([192.55.52.88]:46239 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229891AbhLUByk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 20:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640051680; x=1671587680;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=60cm8cQTeffTpKbWxgOJ9BjWJjk6sGD/4mWiOOSrwRs=;
  b=XvHB2jUcF48gr3CkT6MWZ07G0J8vBStT95jQZJdYUEFyy3XN6nbWzeaY
   Y/eVXt+dwbD1xNbxmSUJ5XbS3+vhj4AW8WnK6Hs4u14xIoRaaTv2afrAl
   2sF/2Jl8vFzazhH8T0ixkprlvUarOFcBVTaYMN1/X6xvZT0ikBXydVH2Y
   bxv8eAzymc00ITZJNZWxKQ38ZgqEi1CxWnOVGJ5S1Cg/tjmrOtNRNNGT5
   sfsTdD2Ibo8bXeqUiMd80gs7DTUZILVpWkDDRrVTU7EzhRYFpN3YhC+mY
   kXEe0eH3+3mddHHeWcbfIz4yda1F+3TT+vr49T/lU7WEcxpUrlIXmD0hm
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="264491354"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="264491354"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 17:54:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="570053035"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 20 Dec 2021 17:54:38 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzUMP-0008XS-UJ; Tue, 21 Dec 2021 01:54:37 +0000
Date:   Tue, 21 Dec 2021 09:53:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 1acd85feba81084fcef00b73fc1601e42b77c5d8
Message-ID: <61c133b0.nVwN9YTFGAPY1/5z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 1acd85feba81084fcef00b73fc1601e42b77c5d8  x86/mce: Check regs before accessing it

elapsed time: 720m

configs tested: 167
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 mpc8272_ads_defconfig
arm                         s3c6400_defconfig
powerpc                      arches_defconfig
arm                          badge4_defconfig
arm                         s3c2410_defconfig
sh                      rts7751r2d1_defconfig
arc                     haps_hs_smp_defconfig
sh                ecovec24-romimage_defconfig
ia64                        generic_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                       maple_defconfig
arm                       imx_v4_v5_defconfig
sh                           se7712_defconfig
arm                        vexpress_defconfig
mips                       bmips_be_defconfig
mips                             allmodconfig
arm                        cerfcube_defconfig
h8300                    h8300h-sim_defconfig
xtensa                              defconfig
arm                       spear13xx_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     sequoia_defconfig
powerpc                      chrp32_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                          moxart_defconfig
mips                      pic32mzda_defconfig
riscv                             allnoconfig
powerpc                      ppc40x_defconfig
powerpc                 mpc832x_mds_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                 canyonlands_defconfig
powerpc                      ppc44x_defconfig
powerpc                           allnoconfig
mips                           jazz_defconfig
arc                         haps_hs_defconfig
powerpc                          g5_defconfig
arm                            xcep_defconfig
powerpc                 mpc836x_mds_defconfig
openrisc                  or1klitex_defconfig
powerpc                     tqm5200_defconfig
arm                           omap1_defconfig
arm                     davinci_all_defconfig
sh                          rsk7269_defconfig
arm                            mmp2_defconfig
h8300                            alldefconfig
arm                         hackkit_defconfig
parisc                generic-64bit_defconfig
powerpc                       eiger_defconfig
sh                            hp6xx_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                             sh03_defconfig
sh                           se7750_defconfig
arm                         lubbock_defconfig
alpha                               defconfig
powerpc                   currituck_defconfig
arm                          exynos_defconfig
sh                     magicpanelr2_defconfig
m68k                          amiga_defconfig
arm                        mvebu_v5_defconfig
arm                     am200epdkit_defconfig
mips                          rb532_defconfig
openrisc                 simple_smp_defconfig
arm                        clps711x_defconfig
m68k                         apollo_defconfig
arm                          pcm027_defconfig
mips                 decstation_r4k_defconfig
arm                         nhk8815_defconfig
powerpc                      ep88xc_defconfig
arm                       versatile_defconfig
arm                        neponset_defconfig
s390                          debug_defconfig
arm                          pxa3xx_defconfig
sh                           se7724_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                   lite5200b_defconfig
sparc                       sparc32_defconfig
sh                         ecovec24_defconfig
powerpc                      makalu_defconfig
arm                  randconfig-c002-20211220
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
h8300                            allyesconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a001-20211220
x86_64               randconfig-a003-20211220
x86_64               randconfig-a006-20211220
x86_64               randconfig-a004-20211220
x86_64               randconfig-a002-20211220
i386                 randconfig-a004-20211220
i386                 randconfig-a002-20211220
i386                 randconfig-a003-20211220
i386                 randconfig-a005-20211220
i386                 randconfig-a006-20211220
i386                 randconfig-a001-20211220
x86_64               randconfig-a013-20211221
x86_64               randconfig-a015-20211221
x86_64               randconfig-a014-20211221
x86_64               randconfig-a011-20211221
x86_64               randconfig-a012-20211221
x86_64               randconfig-a016-20211221
x86_64               randconfig-a005-20211220
i386                 randconfig-a015-20211219
arc                  randconfig-r043-20211220
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig

clang tested configs:
x86_64               randconfig-a015-20211220
x86_64               randconfig-a014-20211220
x86_64               randconfig-a012-20211220
x86_64               randconfig-a011-20211220
x86_64               randconfig-a016-20211220
x86_64               randconfig-a013-20211220
i386                 randconfig-a011-20211220
i386                 randconfig-a014-20211220
i386                 randconfig-a012-20211220
i386                 randconfig-a016-20211220
i386                 randconfig-a015-20211220
i386                 randconfig-a013-20211220
hexagon              randconfig-r045-20211219
s390                 randconfig-r044-20211220
hexagon              randconfig-r045-20211220
riscv                randconfig-r042-20211220
hexagon              randconfig-r041-20211220

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

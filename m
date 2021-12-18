Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0968479A07
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 10:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhLRJwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 04:52:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:48474 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231405AbhLRJwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 04:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639821162; x=1671357162;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=w8EiBJ/ruvxIQnzlO0eGQtzm0je7Q7IWOH92GzFXUtk=;
  b=JwyAH2L4B9t4BACdbegY759Y8PEVUshEbkwe3OyZWm7dD0DT1hhyqmLY
   ub/sCsITdRtVBoqomJTSp0miYzUux1lfshhpCiA+9Smq5xxwoU0UVAB1x
   M0Fpg/n3dUNw0jmYWy3R3dL5KPsjlvYox/V7WJF7QFg8G/OgqRHhm8wra
   GEBTen43Eoc8//f/KtD8c31HYZeUpDoKtZqt90epbbKCEZT9KZ14pv9Iu
   i9zuQhSwbCJEL1ApOuKN0NbTI293MWUs8zP78AEy4b7W5IKASsaruERtL
   MI2lqU/pqsJ2fJFGPavK3hxugBZQla9Kb8bhIC/zV4u58w1EmNUBXSx8b
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="238650997"
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="238650997"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 01:52:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="520891858"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 18 Dec 2021 01:52:40 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myWOO-0005qb-4C; Sat, 18 Dec 2021 09:52:40 +0000
Date:   Sat, 18 Dec 2021 17:52:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 4d4207b2910cbc83b887b8f93a3f8ecd8949f53f
Message-ID: <61bdaf4b.eK+Xnor2m0j/ftQ7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 4d4207b2910cbc83b887b8f93a3f8ecd8949f53f  Merge irq/msi into tip/master

elapsed time: 2050m

configs tested: 192
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                 randconfig-c001-20211216
arm                         lubbock_defconfig
arm                        magician_defconfig
arm                         s3c2410_defconfig
m68k                       m5475evb_defconfig
sh                           se7712_defconfig
ia64                            zx1_defconfig
mips                         rt305x_defconfig
sh                      rts7751r2d1_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                      bamboo_defconfig
powerpc                     ppa8548_defconfig
sh                           se7780_defconfig
powerpc                     mpc5200_defconfig
powerpc                      tqm8xx_defconfig
mips                      bmips_stb_defconfig
powerpc                     taishan_defconfig
mips                          rb532_defconfig
mips                            ar7_defconfig
powerpc                 mpc8560_ads_defconfig
m68k                       bvme6000_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                              alldefconfig
x86_64                           allyesconfig
arm                           sama5_defconfig
sh                   secureedge5410_defconfig
h8300                    h8300h-sim_defconfig
arm                          collie_defconfig
m68k                          atari_defconfig
sh                        dreamcast_defconfig
arm                           sunxi_defconfig
arc                                 defconfig
sparc                               defconfig
arm                       imx_v6_v7_defconfig
powerpc                      cm5200_defconfig
arm                   milbeaut_m10v_defconfig
arm                        multi_v7_defconfig
mips                  cavium_octeon_defconfig
powerpc                 mpc832x_mds_defconfig
mips                    maltaup_xpa_defconfig
m68k                        stmark2_defconfig
powerpc                      makalu_defconfig
arc                        vdk_hs38_defconfig
sh                            titan_defconfig
arm                           stm32_defconfig
arm                        neponset_defconfig
powerpc                     tqm8540_defconfig
mips                        bcm63xx_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7724_defconfig
powerpc                 linkstation_defconfig
powerpc                        cell_defconfig
arm                         axm55xx_defconfig
parisc                           alldefconfig
m68k                          amiga_defconfig
m68k                        mvme147_defconfig
sh                        sh7757lcr_defconfig
sparc                            allyesconfig
ia64                        generic_defconfig
mips                          malta_defconfig
microblaze                      mmu_defconfig
sh                     magicpanelr2_defconfig
mips                        bcm47xx_defconfig
h8300                            allyesconfig
arm                       omap2plus_defconfig
powerpc                    adder875_defconfig
parisc                generic-32bit_defconfig
arm                         s3c6400_defconfig
mips                      pic32mzda_defconfig
powerpc                    mvme5100_defconfig
arm                          iop32x_defconfig
arm                         vf610m4_defconfig
arm                         assabet_defconfig
sparc                       sparc64_defconfig
sparc64                          alldefconfig
powerpc                     skiroot_defconfig
arm                  randconfig-c002-20211216
arm                  randconfig-c002-20211218
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
alpha                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211216
x86_64               randconfig-a005-20211216
x86_64               randconfig-a001-20211216
x86_64               randconfig-a002-20211216
x86_64               randconfig-a003-20211216
x86_64               randconfig-a004-20211216
i386                 randconfig-a002-20211218
i386                 randconfig-a005-20211218
i386                 randconfig-a003-20211218
i386                 randconfig-a006-20211218
i386                 randconfig-a004-20211218
i386                 randconfig-a001-20211216
i386                 randconfig-a002-20211216
i386                 randconfig-a005-20211216
i386                 randconfig-a003-20211216
i386                 randconfig-a006-20211216
i386                 randconfig-a004-20211216
x86_64               randconfig-a011-20211217
x86_64               randconfig-a014-20211217
x86_64               randconfig-a012-20211217
x86_64               randconfig-a013-20211217
x86_64               randconfig-a016-20211217
x86_64               randconfig-a015-20211217
i386                 randconfig-a013-20211217
i386                 randconfig-a011-20211217
i386                 randconfig-a016-20211217
i386                 randconfig-a014-20211217
i386                 randconfig-a015-20211217
i386                 randconfig-a012-20211217
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20211217
x86_64               randconfig-a005-20211217
x86_64               randconfig-a001-20211217
x86_64               randconfig-a002-20211217
x86_64               randconfig-a003-20211217
x86_64               randconfig-a004-20211217
i386                 randconfig-a002-20211217
i386                 randconfig-a003-20211217
i386                 randconfig-a004-20211217
i386                 randconfig-a001-20211217
i386                 randconfig-a006-20211217
i386                 randconfig-a005-20211217
x86_64               randconfig-a011-20211216
x86_64               randconfig-a014-20211216
x86_64               randconfig-a012-20211216
x86_64               randconfig-a013-20211216
x86_64               randconfig-a016-20211216
x86_64               randconfig-a015-20211216
x86_64               randconfig-a011-20211214
x86_64               randconfig-a014-20211214
x86_64               randconfig-a012-20211214
x86_64               randconfig-a013-20211214
x86_64               randconfig-a016-20211214
x86_64               randconfig-a015-20211214
i386                 randconfig-a013-20211216
i386                 randconfig-a011-20211216
i386                 randconfig-a016-20211216
i386                 randconfig-a014-20211216
i386                 randconfig-a015-20211216
i386                 randconfig-a012-20211216
hexagon              randconfig-r045-20211216
s390                 randconfig-r044-20211216
riscv                randconfig-r042-20211216
hexagon              randconfig-r041-20211216
hexagon              randconfig-r045-20211217
hexagon              randconfig-r041-20211217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

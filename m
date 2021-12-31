Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BFB4825C9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 21:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhLaUnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 15:43:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:52371 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230182AbhLaUnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 15:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640983394; x=1672519394;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=J7VlfynJKree1r/eDvrk4j2jjJ9us2mffpFFtnbJZ4A=;
  b=eSdASA9k5XHwS0MpWgXwriRJOidjyBNlWRq/0DG+9FVd7ngROPkKEedB
   EcT17xPEkdLYDgJggSgEc5y3OyR/7A9hPqtc2lQFfAfDCS0mT4m4NjHm6
   QvPqHjdnHwGafW1SlYofG4hf5lSHTj4RIEww+mG+knx2jOkEReOgb9gOO
   FRcj4fHqO+1jQBqbvXMN7A/oFpJmpiBRk6PK+ut4UVRCSYj4dZ3ErEDjY
   QpAqzgY71EyrqGBorgqtCptmV5UGT/v5OI5z5hos2vMLlgl+zKWV3fRB8
   TW7NU3EU1aBfDlIyky1MZT0G9t7tOIGzYualx7POe05MsvflgmdBz8AfQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="302594597"
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="302594597"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 12:43:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="469147822"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 31 Dec 2021 12:43:12 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3Ok3-000BfJ-RA; Fri, 31 Dec 2021 20:43:11 +0000
Date:   Sat, 01 Jan 2022 04:42:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5f72d76bb7ee3bdf9aa61925c59579733cf834a9
Message-ID: <61cf6b4c.+x0+zjYtSpYczpZN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 5f72d76bb7ee3bdf9aa61925c59579733cf834a9  Merge branch into tip/master: 'x86/vdso'

elapsed time: 721m

configs tested: 126
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm64                               defconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                                 defconfig
i386                 randconfig-c001-20211231
powerpc                   motionpro_defconfig
arm                       omap2plus_defconfig
arc                     haps_hs_smp_defconfig
powerpc                     asp8347_defconfig
arm                     am200epdkit_defconfig
sh                        dreamcast_defconfig
arm                            lart_defconfig
parisc                generic-64bit_defconfig
arm                            mps2_defconfig
arm                         shannon_defconfig
mips                         tb0287_defconfig
powerpc                 mpc832x_mds_defconfig
mips                           ci20_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                        realview_defconfig
arm                           omap1_defconfig
mips                         mpc30x_defconfig
sh                            shmin_defconfig
sh                           se7705_defconfig
sh                             sh03_defconfig
powerpc                       eiger_defconfig
powerpc                   currituck_defconfig
m68k                          multi_defconfig
arm                            qcom_defconfig
mips                     loongson1b_defconfig
powerpc                       holly_defconfig
m68k                       bvme6000_defconfig
arm                        oxnas_v6_defconfig
sh                              ul2_defconfig
microblaze                      mmu_defconfig
sparc                       sparc64_defconfig
arm                           sama5_defconfig
sh                   secureedge5410_defconfig
arm                       netwinder_defconfig
m68k                            mac_defconfig
mips                      pic32mzda_defconfig
arm                  randconfig-c002-20211231
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
sparc                               defconfig
i386                   debian-10.3-kselftests
sparc                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20211231
x86_64               randconfig-a001-20211231
x86_64               randconfig-a003-20211231
x86_64               randconfig-a006-20211231
x86_64               randconfig-a004-20211231
x86_64               randconfig-a005-20211231
i386                 randconfig-a001-20211231
i386                 randconfig-a004-20211231
i386                 randconfig-a002-20211231
i386                 randconfig-a006-20211231
i386                 randconfig-a003-20211231
i386                 randconfig-a005-20211231
arc                  randconfig-r043-20211231
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
powerpc                   lite5200b_defconfig
powerpc                          allmodconfig
arm                         orion5x_defconfig
mips                     cu1830-neo_defconfig
powerpc                     skiroot_defconfig
powerpc                     tqm5200_defconfig
x86_64               randconfig-a013-20211231
x86_64               randconfig-a015-20211231
x86_64               randconfig-a012-20211231
x86_64               randconfig-a011-20211231
x86_64               randconfig-a016-20211231
x86_64               randconfig-a014-20211231
i386                 randconfig-a011-20211231
i386                 randconfig-a012-20211231
i386                 randconfig-a013-20211231
i386                 randconfig-a014-20211231
i386                 randconfig-a015-20211231
i386                 randconfig-a016-20211231
hexagon              randconfig-r041-20211231
hexagon              randconfig-r045-20211231
riscv                randconfig-r042-20211231
s390                 randconfig-r044-20211231

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

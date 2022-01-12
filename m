Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2E348C531
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353753AbiALNxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:53:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:23395 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353747AbiALNxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641995630; x=1673531630;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=N6D+qdfRvrfBawsvcXOVpGZOEyQ1qeUWtqLbbm20rqM=;
  b=Htvwz3mY3kFU94WNJjoIhfS8icYBfEVwiY/PPcq3tdP/5IO9QBo4YEZG
   P7EuhthmEXI0qC3oXi2C52Y3JabPDzNTIukRBuMdMyJYRY7AAIP3EN2FE
   5uqAyJuAamnArHbIo3OSn8pyig2ciTfem98KOTGAXRslD08SOE22CV8As
   RZKxjpdPYesqgaMztWR762tGC48haw2ICv8RoNbhM6Gay0vN5qAyRaXjw
   bApTDP1G7jqUohRP7bZTPP8pJMkdOdk5/V/4XNqPjMZYUjrxyIszi8c0t
   d0y08xIEH1LK7vO1Gt3wzmAjbV8U3yTafrN7/qoWNPXhl63rtWGJTnLqN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243692315"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="243692315"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 05:53:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="576555488"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jan 2022 05:53:48 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7e4R-0005tB-St; Wed, 12 Jan 2022 13:53:47 +0000
Date:   Wed, 12 Jan 2022 21:53:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f752214046a95ab5b8c1dedb1266e3532c735414
Message-ID: <61dedd3f.iWnfqi13M7uRQfS9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f752214046a95ab5b8c1dedb1266e3532c735414  Merge branch into tip/master: 'x86/build'

elapsed time: 5145m

configs tested: 149
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
m68k                             alldefconfig
powerpc                 mpc8540_ads_defconfig
um                                  defconfig
mips                      fuloong2e_defconfig
csky                             alldefconfig
powerpc                       ppc64_defconfig
powerpc                     taishan_defconfig
sh                           se7780_defconfig
nds32                            alldefconfig
arc                          axs101_defconfig
arc                     nsimosci_hs_defconfig
sparc64                             defconfig
powerpc                     tqm8541_defconfig
i386                             alldefconfig
alpha                               defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                        stmark2_defconfig
h8300                       h8s-sim_defconfig
sh                           se7722_defconfig
openrisc                            defconfig
sh                            shmin_defconfig
powerpc                      ppc40x_defconfig
x86_64                           alldefconfig
sh                        sh7757lcr_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      cm5200_defconfig
powerpc                    sam440ep_defconfig
sh                ecovec24-romimage_defconfig
x86_64                              defconfig
powerpc                      chrp32_defconfig
m68k                            q40_defconfig
sh                         ecovec24_defconfig
sh                           se7750_defconfig
arm                           u8500_defconfig
mips                             allmodconfig
microblaze                      mmu_defconfig
arm                  randconfig-c002-20220109
arm                  randconfig-c002-20220111
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20220109
i386                 randconfig-a001-20220109
i386                 randconfig-a002-20220109
i386                 randconfig-a006-20220109
i386                 randconfig-a004-20220109
i386                 randconfig-a005-20220109
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64               randconfig-a005-20220109
x86_64               randconfig-a001-20220109
x86_64               randconfig-a004-20220109
x86_64               randconfig-a006-20220109
x86_64               randconfig-a003-20220109
x86_64               randconfig-a002-20220109
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                randconfig-r042-20220111
arc                  randconfig-r043-20220111
s390                 randconfig-r044-20220111
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
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           allyesconfig

clang tested configs:
arm                  randconfig-c002-20220109
mips                 randconfig-c004-20220109
i386                 randconfig-c001-20220109
riscv                randconfig-c006-20220109
powerpc              randconfig-c003-20220109
x86_64               randconfig-c007-20220109
s390                 randconfig-c005-20220109
arm                  randconfig-c002-20220111
x86_64                        randconfig-c007
riscv                randconfig-c006-20220111
powerpc              randconfig-c003-20220111
i386                          randconfig-c001
s390                 randconfig-c005-20220111
mips                 randconfig-c004-20220111
powerpc                     mpc512x_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     loongson1c_defconfig
arm                            mmp2_defconfig
arm                       versatile_defconfig
arm                         mv78xx0_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a015-20220109
x86_64               randconfig-a012-20220109
x86_64               randconfig-a014-20220109
x86_64               randconfig-a013-20220109
x86_64               randconfig-a011-20220109
x86_64               randconfig-a016-20220109
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a012-20220109
i386                 randconfig-a016-20220109
i386                 randconfig-a015-20220109
i386                 randconfig-a014-20220109
i386                 randconfig-a011-20220109
i386                 randconfig-a013-20220109
hexagon              randconfig-r041-20220109
riscv                randconfig-r042-20220109
hexagon              randconfig-r045-20220109

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

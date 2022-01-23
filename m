Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A565496F3F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 01:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiAWAZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 19:25:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:33627 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbiAWAZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 19:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642897508; x=1674433508;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=K9eJfTlC21D8Kj0ZN1gbGCM7m4PZTEi0A/WUFz69ung=;
  b=LQvvaEkdFb9foxmaWrQbI9IUQpNJCFsusdMMFWvsVs5XAA2W556KwTbz
   v6mJjskROS6JwFXXel0YqBButlLJ/2kYqLb/0NKEwx+NJXO4PXH811k7A
   iVcjId4WF8oURbscqUpoM2A4Q35yINUrf9we28+Be0kDB4Yp39/02YA1d
   TBgoGs0kh2p6MAPMV1d0FrbB1xXuEt/WipDUPXLlKYlCa3cpBL5X+aEuC
   KZlQp7qq48v/zNFltK4u+tXDBeYYXyQ/XZmhsKmKAfKtxXwnLz5jeT4nV
   VXfty6EbJJ5LlSkfWIAKupOW2K4dHuybKjsFf2x1QMHSppzUpuflg2JA3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10235"; a="270289704"
X-IronPort-AV: E=Sophos;i="5.88,309,1635231600"; 
   d="scan'208";a="270289704"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 16:25:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,309,1635231600"; 
   d="scan'208";a="533746153"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Jan 2022 16:25:06 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBQgr-000Gqw-SA; Sun, 23 Jan 2022 00:25:05 +0000
Date:   Sun, 23 Jan 2022 08:24:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 94985da003a421dc9c808d12e00d52b274ab92c4
Message-ID: <61eca05a.h/TkuLd5I6rG2RvQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 94985da003a421dc9c808d12e00d52b274ab92c4  Merge branch into tip/master: 'irq/urgent'

elapsed time: 720m

configs tested: 190
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220120
sh                                  defconfig
sh                           se7722_defconfig
sh                          sdk7786_defconfig
ia64                      gensparse_defconfig
m68k                        stmark2_defconfig
powerpc                     pq2fads_defconfig
powerpc                    amigaone_defconfig
mips                         cobalt_defconfig
sh                        sh7763rdp_defconfig
arm                           stm32_defconfig
s390                             allmodconfig
arc                          axs103_defconfig
arm                         cm_x300_defconfig
powerpc                      pasemi_defconfig
arm                          badge4_defconfig
arm                         lpc18xx_defconfig
arm                          exynos_defconfig
mips                         tb0226_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                        keystone_defconfig
powerpc                        cell_defconfig
parisc                           allyesconfig
m68k                       m5475evb_defconfig
powerpc                    klondike_defconfig
arm64                            alldefconfig
powerpc                  iss476-smp_defconfig
sh                           se7206_defconfig
ia64                          tiger_defconfig
arm                         nhk8815_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                       m5208evb_defconfig
arm                            lart_defconfig
xtensa                              defconfig
xtensa                    xip_kc705_defconfig
arm                           viper_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        multi_v7_defconfig
sh                           se7724_defconfig
arm                       multi_v4t_defconfig
sh                             shx3_defconfig
mips                           gcw0_defconfig
nios2                         10m50_defconfig
arm                           h5000_defconfig
sh                          urquell_defconfig
sparc64                             defconfig
powerpc                   currituck_defconfig
h8300                    h8300h-sim_defconfig
sh                        edosk7705_defconfig
mips                            ar7_defconfig
mips                           ip32_defconfig
sh                            shmin_defconfig
powerpc64                        alldefconfig
arm                      integrator_defconfig
openrisc                 simple_smp_defconfig
powerpc                     mpc83xx_defconfig
sh                           se7619_defconfig
arm                           u8500_defconfig
arm                        oxnas_v6_defconfig
xtensa                  cadence_csp_defconfig
nios2                         3c120_defconfig
arm                        shmobile_defconfig
arm                            xcep_defconfig
mips                      loongson3_defconfig
xtensa                  nommu_kc705_defconfig
arm                  randconfig-c002-20220122
arm                  randconfig-c002-20220120
arm                  randconfig-c002-20220123
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220123
arc                  randconfig-r043-20220123
s390                 randconfig-r044-20220123
riscv                randconfig-r042-20220121
arc                  randconfig-r043-20220122
arc                  randconfig-r043-20220121
s390                 randconfig-r044-20220121
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
arm                  randconfig-c002-20220122
powerpc              randconfig-c003-20220122
mips                 randconfig-c004-20220122
i386                          randconfig-c001
s390                 randconfig-c005-20220122
riscv                randconfig-c006-20220122
arm                  randconfig-c002-20220120
riscv                randconfig-c006-20220120
powerpc              randconfig-c003-20220120
mips                 randconfig-c004-20220120
arm                  randconfig-c002-20220123
riscv                randconfig-c006-20220123
powerpc              randconfig-c003-20220123
mips                 randconfig-c004-20220123
powerpc                          allmodconfig
powerpc                      obs600_defconfig
powerpc                      acadia_defconfig
mips                            e55_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                          g5_defconfig
arm                       versatile_defconfig
arm                        magician_defconfig
x86_64               randconfig-a005-20220117
x86_64               randconfig-a004-20220117
x86_64               randconfig-a001-20220117
x86_64               randconfig-a006-20220117
x86_64               randconfig-a002-20220117
x86_64               randconfig-a003-20220117
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a005-20220117
i386                 randconfig-a001-20220117
i386                 randconfig-a006-20220117
i386                 randconfig-a004-20220117
i386                 randconfig-a002-20220117
i386                 randconfig-a003-20220117
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
riscv                randconfig-r042-20220122
hexagon              randconfig-r045-20220122
hexagon              randconfig-r041-20220122
hexagon              randconfig-r045-20220123
hexagon              randconfig-r041-20220123
s390                 randconfig-r044-20220122
hexagon              randconfig-r045-20220121
hexagon              randconfig-r041-20220121
riscv                randconfig-r042-20220120
hexagon              randconfig-r045-20220120
hexagon              randconfig-r041-20220120

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

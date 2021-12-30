Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CFD481B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbhL3K64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:58:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:52004 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235057AbhL3K6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640861935; x=1672397935;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ioJgxKN11gPMPsPcqWTnlaCr0oCCo5bRmopzqw7v8e0=;
  b=QRdQznUzYMgRkSYe6amOgrOuwRI7XgmIGNDSSdYgDZXz/cyPJMgM78L2
   QSwxpTGKSlGx3aCWDvafNPhoqSS8yuYXMyKspWx/RMegxjqzPg6qPOnPT
   lq7XNX5K+HWh/GNpYSm9KDTgEzVwx77PyPEOcvphr3fd7CorlKtM/87tV
   16dZgqNSsSz3+sL3UM30Zc7EykYmPU0leDLs355pWqwuG2Y6IBX8I19o4
   EysmC3BXpTI/gJ9+ISx4Fa/IxVE5nJWa7rDZbM50N3Kgmo20b5JDJDap8
   kdO13cINexV3AkQ3m9X6Wrj+Ev0HDgoxzp7d6mrTUVBUWi1CN3RX79x/m
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="222326925"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="222326925"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 02:58:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="687187864"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 30 Dec 2021 02:58:53 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2t92-000A15-IH; Thu, 30 Dec 2021 10:58:52 +0000
Date:   Thu, 30 Dec 2021 18:57:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 d6f12f83989bb356ac6880a954f62c7667e35066
Message-ID: <61cd90af.bUN8AUtsenSMOYuW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: d6f12f83989bb356ac6880a954f62c7667e35066  x86/build: Use the proper name CONFIG_FW_LOADER

elapsed time: 727m

configs tested: 198
configs skipped: 53

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211229
i386                 randconfig-c001-20211228
i386                 randconfig-c001-20211230
mips                 randconfig-c004-20211230
arm                        mvebu_v5_defconfig
mips                        qi_lb60_defconfig
sh                        apsh4ad0a_defconfig
sh                            hp6xx_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc834x_mds_defconfig
nios2                               defconfig
powerpc                      pasemi_defconfig
arm                        shmobile_defconfig
powerpc                 linkstation_defconfig
mips                         bigsur_defconfig
powerpc                 mpc832x_mds_defconfig
arm                  colibri_pxa300_defconfig
mips                           ip28_defconfig
arm                      tct_hammer_defconfig
arm                         s3c6400_defconfig
powerpc                     pseries_defconfig
arm                         lpc18xx_defconfig
arm                     eseries_pxa_defconfig
arc                     nsimosci_hs_defconfig
sh                        edosk7705_defconfig
s390                          debug_defconfig
mips                       capcella_defconfig
powerpc                         wii_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     akebono_defconfig
arc                          axs101_defconfig
arm                       imx_v4_v5_defconfig
powerpc                    ge_imp3a_defconfig
sh                         ap325rxa_defconfig
arm                        oxnas_v6_defconfig
mips                        workpad_defconfig
alpha                            alldefconfig
mips                      pic32mzda_defconfig
powerpc                        fsp2_defconfig
powerpc                  iss476-smp_defconfig
powerpc                      pcm030_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     ep8248e_defconfig
ia64                            zx1_defconfig
arm                          moxart_defconfig
powerpc                     pq2fads_defconfig
sh                          sdk7786_defconfig
arc                            hsdk_defconfig
arm                        multi_v7_defconfig
arm                         at91_dt_defconfig
arc                      axs103_smp_defconfig
mips                           xway_defconfig
powerpc                 mpc837x_rdb_defconfig
i386                             alldefconfig
arm                            qcom_defconfig
sh                             sh03_defconfig
powerpc                    klondike_defconfig
m68k                                defconfig
sh                          polaris_defconfig
powerpc                      obs600_defconfig
powerpc                       holly_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                       eiger_defconfig
xtensa                          iss_defconfig
arm                       spear13xx_defconfig
mips                   sb1250_swarm_defconfig
powerpc                    adder875_defconfig
arc                        nsim_700_defconfig
arm                           omap1_defconfig
arm                          ixp4xx_defconfig
arm                           sunxi_defconfig
nios2                         10m50_defconfig
arm                           sama5_defconfig
mips                            ar7_defconfig
xtensa                       common_defconfig
powerpc                  mpc866_ads_defconfig
parisc                           alldefconfig
mips                       rbtx49xx_defconfig
mips                       bmips_be_defconfig
arm                             pxa_defconfig
arm                        vexpress_defconfig
powerpc                          allmodconfig
m68k                          atari_defconfig
arm                         s5pv210_defconfig
arm                        mvebu_v7_defconfig
mips                         tb0226_defconfig
m68k                        stmark2_defconfig
arc                        nsimosci_defconfig
powerpc                      cm5200_defconfig
mips                           rs90_defconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     tqm8560_defconfig
arm                  randconfig-c002-20211229
arm                  randconfig-c002-20211230
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
i386                   debian-10.3-kselftests
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20211228
i386                 randconfig-a004-20211228
i386                 randconfig-a002-20211228
i386                 randconfig-a003-20211228
i386                 randconfig-a001-20211228
i386                 randconfig-a005-20211228
x86_64               randconfig-a013-20211230
x86_64               randconfig-a015-20211230
x86_64               randconfig-a012-20211230
x86_64               randconfig-a011-20211230
x86_64               randconfig-a016-20211230
x86_64               randconfig-a014-20211230
i386                 randconfig-a016-20211230
i386                 randconfig-a011-20211230
i386                 randconfig-a012-20211230
i386                 randconfig-a013-20211230
i386                 randconfig-a014-20211230
i386                 randconfig-a015-20211230
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
riscv                randconfig-c006-20211228
mips                 randconfig-c004-20211228
powerpc              randconfig-c003-20211228
arm                  randconfig-c002-20211228
x86_64               randconfig-c007-20211228
i386                 randconfig-c001-20211228
x86_64               randconfig-a005-20211229
x86_64               randconfig-a001-20211229
x86_64               randconfig-a003-20211229
x86_64               randconfig-a006-20211229
x86_64               randconfig-a004-20211229
x86_64               randconfig-a002-20211229
x86_64               randconfig-a002-20211230
x86_64               randconfig-a001-20211230
x86_64               randconfig-a003-20211230
x86_64               randconfig-a006-20211230
x86_64               randconfig-a004-20211230
x86_64               randconfig-a005-20211230
i386                 randconfig-a001-20211230
i386                 randconfig-a005-20211230
i386                 randconfig-a004-20211230
i386                 randconfig-a002-20211230
i386                 randconfig-a006-20211230
i386                 randconfig-a003-20211230
x86_64               randconfig-a014-20211228
x86_64               randconfig-a013-20211228
x86_64               randconfig-a012-20211228
x86_64               randconfig-a011-20211228
x86_64               randconfig-a015-20211228
x86_64               randconfig-a016-20211228
hexagon              randconfig-r041-20211228
riscv                randconfig-r042-20211228
s390                 randconfig-r044-20211228
hexagon              randconfig-r045-20211228
hexagon              randconfig-r041-20211230
hexagon              randconfig-r045-20211230

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

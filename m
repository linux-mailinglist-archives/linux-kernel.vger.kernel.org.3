Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114AE48176F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 00:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhL2XFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 18:05:35 -0500
Received: from mga12.intel.com ([192.55.52.136]:61726 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232785AbhL2XFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 18:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640819134; x=1672355134;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RX0G2NYLKheWm+fAViaN5VK0X0qgjIGj54g/UQtmSO8=;
  b=Oe3FT1AHv9wKx+Zd3aKUhkc9irU9+UHgdqll84R/ZXhu8Lwx5e1x/4qT
   3DE1cNWXyE8C2KnQxBp1MCrYwQa3ow2dCyD/ZSaD8aow7FtUGk4t8x5mX
   mjA89I/NVsO5c9sq55mQ8H4j7a7tI/lRsY8OVSUPAvc9BzwHq1nbDx8gE
   yANzvrbd9cVPsrhmaiC4FvllNcCbmY4siumGKODYQtsTrvmG4PBrhkF1b
   byGWvMQBYDhtSnptBOuciKbEK23udTaNY7CSAAmGIuNw8z8JRkuY/mOUd
   qdIEdX7R9N/bMfmZ86Xz3iyrgZ2ZJsyLgBtcmycYeUIKoZ+LtkPScGEJ+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="221579680"
X-IronPort-AV: E=Sophos;i="5.88,246,1635231600"; 
   d="scan'208";a="221579680"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 15:05:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,246,1635231600"; 
   d="scan'208";a="687040369"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Dec 2021 15:05:20 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2i0V-0009UE-W5; Wed, 29 Dec 2021 23:05:19 +0000
Date:   Thu, 30 Dec 2021 07:04:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 fb1b8c9e763da42cbc98abf4cc318408350cbb07
Message-ID: <61cce97c./3CVFbnS/7N8+iqA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: fb1b8c9e763da42cbc98abf4cc318408350cbb07  Merge branch into tip/master: 'core/core'

elapsed time: 720m

configs tested: 198
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
i386                 randconfig-c001-20211229
powerpc              randconfig-c003-20211229
i386                 randconfig-c001-20211230
arc                     haps_hs_smp_defconfig
arm                             mxs_defconfig
arm                          simpad_defconfig
mips                         db1xxx_defconfig
arm                        mvebu_v5_defconfig
mips                        qi_lb60_defconfig
sh                        apsh4ad0a_defconfig
sh                            hp6xx_defconfig
powerpc                 mpc834x_mds_defconfig
arm                       aspeed_g4_defconfig
arm                         at91_dt_defconfig
powerpc                       holly_defconfig
xtensa                  audio_kc705_defconfig
mips                 decstation_r4k_defconfig
mips                        workpad_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                           ip32_defconfig
powerpc                     mpc5200_defconfig
mips                     decstation_defconfig
parisc                generic-32bit_defconfig
h8300                    h8300h-sim_defconfig
arm                         nhk8815_defconfig
arm                       versatile_defconfig
parisc                generic-64bit_defconfig
s390                          debug_defconfig
mips                       capcella_defconfig
powerpc                         wii_defconfig
powerpc                     akebono_defconfig
arc                          axs101_defconfig
arm                       imx_v4_v5_defconfig
powerpc                    ge_imp3a_defconfig
sh                         ap325rxa_defconfig
arm                        oxnas_v6_defconfig
powerpc                      pcm030_defconfig
powerpc                 mpc832x_rdb_defconfig
ia64                            zx1_defconfig
sh                          urquell_defconfig
arm                      pxa255-idp_defconfig
csky                                defconfig
powerpc                     kmeter1_defconfig
powerpc                 linkstation_defconfig
mips                      pic32mzda_defconfig
mips                           rs90_defconfig
m68k                        m5272c3_defconfig
mips                  cavium_octeon_defconfig
i386                                defconfig
mips                         cobalt_defconfig
i386                             alldefconfig
sh                             sh03_defconfig
powerpc                    klondike_defconfig
powerpc                       maple_defconfig
mips                     loongson2k_defconfig
mips                        maltaup_defconfig
arm                            xcep_defconfig
mips                          ath79_defconfig
sh                           se7750_defconfig
mips                         tb0219_defconfig
mips                    maltaup_xpa_defconfig
powerpc                    adder875_defconfig
arc                        nsim_700_defconfig
arm                           omap1_defconfig
arm                          ixp4xx_defconfig
arm                           sunxi_defconfig
m68k                        m5307c3_defconfig
m68k                          multi_defconfig
arm                           sama5_defconfig
mips                            ar7_defconfig
xtensa                       common_defconfig
powerpc                     tqm5200_defconfig
powerpc                     sequoia_defconfig
powerpc                 mpc836x_mds_defconfig
arm                        shmobile_defconfig
arc                    vdk_hs38_smp_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                      cm5200_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     tqm8560_defconfig
arm                  randconfig-c002-20211228
arm                  randconfig-c002-20211229
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                               defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                              debian-10.3
sparc                               defconfig
i386                   debian-10.3-kselftests
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20211228
x86_64               randconfig-a003-20211228
x86_64               randconfig-a006-20211228
x86_64               randconfig-a015-20211229
x86_64               randconfig-a014-20211229
x86_64               randconfig-a013-20211229
x86_64               randconfig-a011-20211229
x86_64               randconfig-a012-20211229
x86_64               randconfig-a016-20211229
i386                 randconfig-a012-20211229
i386                 randconfig-a011-20211229
i386                 randconfig-a014-20211229
i386                 randconfig-a016-20211229
i386                 randconfig-a013-20211229
i386                 randconfig-a015-20211229
i386                 randconfig-a016-20211230
i386                 randconfig-a011-20211230
i386                 randconfig-a012-20211230
i386                 randconfig-a013-20211230
i386                 randconfig-a014-20211230
i386                 randconfig-a015-20211230
arc                  randconfig-r043-20211228
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func

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
x86_64               randconfig-a004-20211229
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
i386                 randconfig-a002-20211229
i386                 randconfig-a003-20211229
i386                 randconfig-a001-20211229
x86_64               randconfig-a015-20211228
x86_64               randconfig-a013-20211228
x86_64               randconfig-a012-20211228
x86_64               randconfig-a011-20211228
x86_64               randconfig-a016-20211228
i386                 randconfig-a012-20211228
i386                 randconfig-a013-20211228
i386                 randconfig-a015-20211228
i386                 randconfig-a011-20211228
i386                 randconfig-a014-20211228
i386                 randconfig-a016-20211228
hexagon              randconfig-r041-20211229
hexagon              randconfig-r045-20211229
hexagon              randconfig-r045-20211230
riscv                randconfig-r042-20211228
s390                 randconfig-r044-20211228
hexagon              randconfig-r045-20211228
hexagon              randconfig-r041-20211228

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

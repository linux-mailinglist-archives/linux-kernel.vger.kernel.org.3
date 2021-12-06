Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A9D46A92F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350182AbhLFVNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:13:52 -0500
Received: from mga18.intel.com ([134.134.136.126]:40645 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350153AbhLFVNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:13:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="224278135"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="224278135"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 13:10:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="599784846"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Dec 2021 13:10:19 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muLFb-000Lka-76; Mon, 06 Dec 2021 21:10:19 +0000
Date:   Tue, 07 Dec 2021 05:10:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 7f32a31b0a34625039ff2080e28ab890d8e8dbe2
Message-ID: <61ae7c30.pDnfJzJ/myRUKEm3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 7f32a31b0a34625039ff2080e28ab890d8e8dbe2  Merge branch into tip/master: 'core/entry'

elapsed time: 723m

configs tested: 132
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211206
sh                          r7780mp_defconfig
powerpc                     tqm5200_defconfig
powerpc                     asp8347_defconfig
arm                            xcep_defconfig
sh                           se7750_defconfig
powerpc                      chrp32_defconfig
sh                          urquell_defconfig
sh                           se7751_defconfig
um                             i386_defconfig
mips                            gpr_defconfig
arm                         socfpga_defconfig
arm                       aspeed_g5_defconfig
sh                         microdev_defconfig
arm                         lpc32xx_defconfig
mips                         rt305x_defconfig
mips                         tb0287_defconfig
arm                       cns3420vb_defconfig
sparc64                             defconfig
m68k                            mac_defconfig
arm                        multi_v5_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v4_v5_defconfig
arm                           sama7_defconfig
arm                            zeus_defconfig
sh                               alldefconfig
arm                         vf610m4_defconfig
arm                      integrator_defconfig
arm                        multi_v7_defconfig
arc                      axs103_smp_defconfig
microblaze                          defconfig
powerpc                     ep8248e_defconfig
xtensa                generic_kc705_defconfig
parisc                generic-64bit_defconfig
arm                           corgi_defconfig
sh                   sh7724_generic_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                           sama5_defconfig
h8300                    h8300h-sim_defconfig
sh                           se7705_defconfig
um                           x86_64_defconfig
arm                            mps2_defconfig
openrisc                  or1klitex_defconfig
powerpc                      ep88xc_defconfig
arm                         bcm2835_defconfig
powerpc                      pasemi_defconfig
powerpc                 mpc8560_ads_defconfig
mips                        qi_lb60_defconfig
arc                     haps_hs_smp_defconfig
m68k                       m5275evb_defconfig
powerpc                     mpc512x_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                  randconfig-c002-20211206
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
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
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
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a016-20211206
x86_64               randconfig-a011-20211206
x86_64               randconfig-a013-20211206
x86_64               randconfig-a014-20211206
x86_64               randconfig-a012-20211206
x86_64               randconfig-a015-20211206
i386                 randconfig-a016-20211206
i386                 randconfig-a013-20211206
i386                 randconfig-a011-20211206
i386                 randconfig-a014-20211206
i386                 randconfig-a012-20211206
i386                 randconfig-a015-20211206
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20211206
x86_64               randconfig-a005-20211206
x86_64               randconfig-a001-20211206
x86_64               randconfig-a002-20211206
x86_64               randconfig-a004-20211206
x86_64               randconfig-a003-20211206
i386                 randconfig-a001-20211206
i386                 randconfig-a005-20211206
i386                 randconfig-a002-20211206
i386                 randconfig-a003-20211206
i386                 randconfig-a006-20211206
i386                 randconfig-a004-20211206
hexagon              randconfig-r045-20211206
hexagon              randconfig-r041-20211206

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

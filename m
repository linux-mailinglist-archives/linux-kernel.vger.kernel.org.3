Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF50F46B956
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhLGKqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:46:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:15484 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234315AbhLGKqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:46:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="261616388"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="261616388"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 02:42:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="679399010"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2021 02:42:53 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muXvw-000MT1-Gm; Tue, 07 Dec 2021 10:42:52 +0000
Date:   Tue, 07 Dec 2021 18:42:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 71d5049b053876afbde6c3273250b76935494ab2
Message-ID: <61af3a79.SbTJ7EnWmnS3iKTo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 71d5049b053876afbde6c3273250b76935494ab2  x86/mm: Flush global TLB when switching to trampoline page-table

elapsed time: 727m

configs tested: 154
configs skipped: 82

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
i386                 randconfig-c001-20211207
powerpc                     tqm8541_defconfig
mips                     decstation_defconfig
parisc                           allyesconfig
powerpc                 mpc837x_rdb_defconfig
arm                       omap2plus_defconfig
sh                                  defconfig
sh                             sh03_defconfig
arm                       cns3420vb_defconfig
mips                           rs90_defconfig
powerpc                     skiroot_defconfig
m68k                        m5307c3_defconfig
m68k                         apollo_defconfig
m68k                          atari_defconfig
arm                       multi_v4t_defconfig
xtensa                  nommu_kc705_defconfig
mips                      malta_kvm_defconfig
riscv                    nommu_virt_defconfig
powerpc                     taishan_defconfig
arm                          iop32x_defconfig
arm                         mv78xx0_defconfig
arc                     nsimosci_hs_defconfig
arm                             pxa_defconfig
sh                          sdk7780_defconfig
arc                    vdk_hs38_smp_defconfig
arm                         bcm2835_defconfig
sh                        apsh4ad0a_defconfig
arm                         vf610m4_defconfig
sh                          lboxre2_defconfig
powerpc                  mpc885_ads_defconfig
mips                     cu1000-neo_defconfig
csky                             alldefconfig
sh                   sh7770_generic_defconfig
arm                        cerfcube_defconfig
arm                        trizeps4_defconfig
arm                         shannon_defconfig
powerpc                 mpc8540_ads_defconfig
sh                            titan_defconfig
m68k                             allmodconfig
arm                             rpc_defconfig
mips                    maltaup_xpa_defconfig
arm                            zeus_defconfig
powerpc                      pasemi_defconfig
mips                            ar7_defconfig
sparc                            alldefconfig
mips                        jmr3927_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         lpc32xx_defconfig
h8300                    h8300h-sim_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                   motionpro_defconfig
openrisc                         alldefconfig
powerpc                   lite5200b_defconfig
mips                         mpc30x_defconfig
m68k                                defconfig
nds32                            alldefconfig
powerpc                    adder875_defconfig
powerpc                   microwatt_defconfig
arm                        vexpress_defconfig
powerpc                     pq2fads_defconfig
mips                        omega2p_defconfig
arm                        keystone_defconfig
sh                           se7705_defconfig
powerpc                     tqm5200_defconfig
arm                            mps2_defconfig
mips                  cavium_octeon_defconfig
mips                           mtx1_defconfig
alpha                               defconfig
arm                      jornada720_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                       common_defconfig
sh                             shx3_defconfig
arm                  randconfig-c002-20211207
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
x86_64               randconfig-a006-20211207
x86_64               randconfig-a005-20211207
x86_64               randconfig-a001-20211207
x86_64               randconfig-a002-20211207
x86_64               randconfig-a004-20211207
x86_64               randconfig-a003-20211207
i386                 randconfig-a001-20211207
i386                 randconfig-a005-20211207
i386                 randconfig-a002-20211207
i386                 randconfig-a003-20211207
i386                 randconfig-a006-20211207
i386                 randconfig-a004-20211207
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
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
x86_64               randconfig-c007-20211207
arm                  randconfig-c002-20211207
riscv                randconfig-c006-20211207
mips                 randconfig-c004-20211207
i386                 randconfig-c001-20211207
powerpc              randconfig-c003-20211207
s390                 randconfig-c005-20211207
x86_64               randconfig-a016-20211207
x86_64               randconfig-a011-20211207
x86_64               randconfig-a013-20211207
x86_64               randconfig-a014-20211207
x86_64               randconfig-a015-20211207
x86_64               randconfig-a012-20211207
i386                 randconfig-a016-20211207
i386                 randconfig-a013-20211207
i386                 randconfig-a011-20211207
i386                 randconfig-a014-20211207
i386                 randconfig-a012-20211207
i386                 randconfig-a015-20211207
hexagon              randconfig-r045-20211207
s390                 randconfig-r044-20211207
riscv                randconfig-r042-20211207
hexagon              randconfig-r041-20211207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

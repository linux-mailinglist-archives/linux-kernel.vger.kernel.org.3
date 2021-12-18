Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB08479A00
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 10:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhLRJlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 04:41:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:36376 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232538AbhLRJlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 04:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639820502; x=1671356502;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2U6HujGz5zASRG+ANSHEawy7lWuz2WagLFLW0KbIulU=;
  b=QjNMJoXd1ZF9TbKUTGQCAE4lViIU5UPKSajAkVmUJC5Nxh/SQVO50FIB
   qcHNavNp4g0a/qt+QL+2ye92iFRiyVDAdfbNzY1bhGGP0mscUF/BLmzo0
   03wXvM8B30pjv3oxGweqhwa5qR8Ne/XAUyaL4yRUEIpdSX/kgAmbg1Tq6
   LxBnHbIRQmU263PeHKdjZZv5fq/jMelRj7V6oms0yRCGcPTqqftEs2yid
   WMAoJ9GsiBOHZnqPvkNPBc6dC1N11l9PbH9AhA0UaJZ4eFLWuZnKTbhfT
   TxnqR8IvKsFvOw5DqVdC+gUTZIVn05aIDIcyShWRZixgVg/jLoDCjgzGk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="303282289"
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="303282289"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 01:41:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="507075584"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2021 01:41:40 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myWDj-0005q1-Vu; Sat, 18 Dec 2021 09:41:39 +0000
Date:   Sat, 18 Dec 2021 17:40:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/msi] BUILD SUCCESS
 cd6cf06590b9792340dceaa285138777f3cc4d90
Message-ID: <61bdaca1.i0+DahMbWtSNvLb0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi
branch HEAD: cd6cf06590b9792340dceaa285138777f3cc4d90  genirq/msi: Convert storage to xarray

elapsed time: 2039m

configs tested: 214
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211216
m68k                       m5475evb_defconfig
sh                           se7712_defconfig
arm                         lubbock_defconfig
arm                        magician_defconfig
arm                         s3c2410_defconfig
ia64                            zx1_defconfig
mips                         rt305x_defconfig
sh                      rts7751r2d1_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                      bamboo_defconfig
powerpc                     ppa8548_defconfig
sh                           se7780_defconfig
sh                          rsk7203_defconfig
powerpc                    amigaone_defconfig
arm                            lart_defconfig
arc                         haps_hs_defconfig
sh                            titan_defconfig
powerpc                     mpc5200_defconfig
powerpc                      tqm8xx_defconfig
mips                      bmips_stb_defconfig
powerpc                     taishan_defconfig
mips                          rb532_defconfig
xtensa                         virt_defconfig
powerpc                       ppc64_defconfig
powerpc                      ppc6xx_defconfig
microblaze                      mmu_defconfig
arc                        nsimosci_defconfig
sh                        edosk7760_defconfig
mips                        maltaup_defconfig
arm                         s5pv210_defconfig
arm                          iop32x_defconfig
powerpc                     kmeter1_defconfig
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
powerpc                       maple_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                        jmr3927_defconfig
arm                  colibri_pxa270_defconfig
mips                         tb0219_defconfig
nds32                             allnoconfig
mips                           rs90_defconfig
arc                           tb10x_defconfig
i386                             alldefconfig
powerpc                     powernv_defconfig
m68k                         apollo_defconfig
m68k                        m5407c3_defconfig
mips                       capcella_defconfig
mips                  cavium_octeon_defconfig
powerpc                 mpc832x_mds_defconfig
mips                    maltaup_xpa_defconfig
m68k                        stmark2_defconfig
powerpc                      makalu_defconfig
riscv                          rv32_defconfig
arc                        vdk_hs38_defconfig
arm                           stm32_defconfig
arm                        neponset_defconfig
powerpc                     tqm8540_defconfig
mips                        bcm63xx_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      walnut_defconfig
mips                        omega2p_defconfig
sh                           se7721_defconfig
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
sh                     magicpanelr2_defconfig
mips                        bcm47xx_defconfig
h8300                            allyesconfig
arm                       omap2plus_defconfig
powerpc                    adder875_defconfig
parisc                generic-32bit_defconfig
arm                         s3c6400_defconfig
mips                      pic32mzda_defconfig
powerpc                    mvme5100_defconfig
arm                         vf610m4_defconfig
arm                         assabet_defconfig
powerpc                     skiroot_defconfig
sparc                       sparc64_defconfig
sparc64                          alldefconfig
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
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
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
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
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
i386                 randconfig-a011-20211216
i386                 randconfig-a014-20211216
i386                 randconfig-a012-20211216
i386                 randconfig-a013-20211216
i386                 randconfig-a015-20211216
i386                 randconfig-a016-20211216
hexagon              randconfig-r045-20211216
s390                 randconfig-r044-20211216
riscv                randconfig-r042-20211216
hexagon              randconfig-r041-20211216
hexagon              randconfig-r045-20211217
hexagon              randconfig-r041-20211217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

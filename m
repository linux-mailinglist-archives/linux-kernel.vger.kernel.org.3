Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A627497CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbiAXKGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:06:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:4583 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231433AbiAXKGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643018791; x=1674554791;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hYFbw9RPKNhnB6iWWcyjydhdd6Z9j2hgyTunqj9wCu8=;
  b=dUIlQw5K/UDWFj16mR38GsMWTJ9stpcj29+1UjCqbqsboiplwPYmbhB/
   /vptt30VFKJBCwKhM7sFhlLoCqkWsyhcv2BKQ6jR9kUyNGF+KqPrJ4QKl
   QPOgxKqt8UR/dkwGybjuUERlTjNi31eI29iyIjh9Ysrbj/fEpcf0QAzpS
   hrLO1NWlWGr6NJP6BjopzFbXOOpQDo80x41zSsK38nbR/RxYoljLNluoB
   kY/VoMouMRoj49XVSdmK1saF0y8aYRCPd3/lhihrwLPxIsJAoz6FzsMRn
   fpV5BcskOME3zQ8ZPr438b3OEefFSHjIglmI6eSOI2N4QUj2GMeja37RW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245793590"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245793590"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 02:06:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627442485"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 02:06:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBwF3-000IAM-8F; Mon, 24 Jan 2022 10:06:29 +0000
Date:   Mon, 24 Jan 2022 18:05:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.01.18a] BUILD SUCCESS
 1385139340b7a1c8f35cb7a52af221096cdef86e
Message-ID: <61ee7a07.No4TT8Shsd/vcrXB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.01.18a
branch HEAD: 1385139340b7a1c8f35cb7a52af221096cdef86e  srcu: Dynamically allocate srcu_node array

elapsed time: 3444m

configs tested: 294
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
i386                 randconfig-c001-20220124
mips                 randconfig-c004-20220120
powerpc              randconfig-c003-20220120
sh                          polaris_defconfig
nds32                             allnoconfig
sh                        apsh4ad0a_defconfig
sh                        dreamcast_defconfig
powerpc                 mpc837x_rdb_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                       imx_v6_v7_defconfig
xtensa                       common_defconfig
m68k                          multi_defconfig
i386                                defconfig
s390                             allyesconfig
sh                             espt_defconfig
arm                        keystone_defconfig
openrisc                 simple_smp_defconfig
mips                         bigsur_defconfig
arm                           h3600_defconfig
h8300                       h8s-sim_defconfig
arc                        vdk_hs38_defconfig
mips                     loongson1b_defconfig
powerpc                      bamboo_defconfig
mips                        bcm47xx_defconfig
sh                          landisk_defconfig
sh                          r7780mp_defconfig
parisc                              defconfig
powerpc                       eiger_defconfig
m68k                            q40_defconfig
powerpc                  storcenter_defconfig
arc                     nsimosci_hs_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7751_defconfig
sh                         microdev_defconfig
powerpc                     stx_gp3_defconfig
sh                           se7750_defconfig
powerpc                      cm5200_defconfig
sparc64                          alldefconfig
sh                        sh7763rdp_defconfig
arm                           stm32_defconfig
s390                             allmodconfig
arc                          axs103_defconfig
arm                         cm_x300_defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc837x_mds_defconfig
sh                          rsk7269_defconfig
arm                         vf610m4_defconfig
sh                            shmin_defconfig
arm                         lpc18xx_defconfig
arm                          exynos_defconfig
mips                         tb0226_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                                defconfig
parisc                           alldefconfig
powerpc                 mpc85xx_cds_defconfig
sparc                       sparc32_defconfig
s390                          debug_defconfig
nios2                            alldefconfig
powerpc                        cell_defconfig
parisc                           allyesconfig
m68k                         apollo_defconfig
x86_64                           alldefconfig
arm                           tegra_defconfig
sh                           se7206_defconfig
ia64                          tiger_defconfig
arm                         nhk8815_defconfig
xtensa                           allyesconfig
nds32                            alldefconfig
powerpc                     taishan_defconfig
xtensa                  audio_kc705_defconfig
powerpc                      ppc40x_defconfig
sh                           se7619_defconfig
sh                           se7705_defconfig
um                             i386_defconfig
mips                           ci20_defconfig
i386                             alldefconfig
sh                           se7780_defconfig
xtensa                    xip_kc705_defconfig
arm                           viper_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        multi_v7_defconfig
sh                         ap325rxa_defconfig
arc                         haps_hs_defconfig
powerpc                     mpc83xx_defconfig
h8300                            alldefconfig
mips                           gcw0_defconfig
nios2                         10m50_defconfig
mips                             allyesconfig
arm                           h5000_defconfig
arm                       omap2plus_defconfig
powerpc                     rainier_defconfig
h8300                               defconfig
ia64                             alldefconfig
mips                        vocore2_defconfig
arm                         at91_dt_defconfig
sh                          sdk7780_defconfig
ia64                            zx1_defconfig
powerpc                     tqm8541_defconfig
mips                            gpr_defconfig
microblaze                      mmu_defconfig
mips                         cobalt_defconfig
powerpc64                        alldefconfig
arm                      integrator_defconfig
mips                  maltasmvp_eva_defconfig
arm                      footbridge_defconfig
sh                     sh7710voipgw_defconfig
mips                      maltasmvp_defconfig
arm                         lubbock_defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                         wii_defconfig
arm                         s3c6400_defconfig
arm                  randconfig-c002-20220123
arm                  randconfig-c002-20220124
arm                  randconfig-c002-20220116
arm                  randconfig-c002-20220117
arm                  randconfig-c002-20220118
arm                  randconfig-c002-20220119
arm                  randconfig-c002-20220120
arm                  randconfig-c002-20220122
arm                  randconfig-c002-20220121
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a001-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
i386                 randconfig-a002-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a006-20220124
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64               randconfig-a016-20220117
x86_64               randconfig-a012-20220117
x86_64               randconfig-a013-20220117
x86_64               randconfig-a011-20220117
x86_64               randconfig-a014-20220117
x86_64               randconfig-a015-20220117
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220123
arc                  randconfig-r043-20220124
riscv                randconfig-r042-20220123
s390                 randconfig-r044-20220123
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
arm                  randconfig-c002-20220120
riscv                randconfig-c006-20220120
powerpc              randconfig-c003-20220120
mips                 randconfig-c004-20220120
i386                          randconfig-c001
arm                  randconfig-c002-20220123
riscv                randconfig-c006-20220123
powerpc              randconfig-c003-20220123
mips                 randconfig-c004-20220123
arm                  randconfig-c002-20220124
riscv                randconfig-c006-20220124
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220124
x86_64               randconfig-c007-20220124
arm                  randconfig-c002-20220122
riscv                randconfig-c006-20220122
powerpc              randconfig-c003-20220122
mips                 randconfig-c004-20220122
arm                  randconfig-c002-20220121
riscv                randconfig-c006-20220121
powerpc              randconfig-c003-20220121
mips                 randconfig-c004-20220121
powerpc                     tqm5200_defconfig
arm                          imote2_defconfig
arm                         shannon_defconfig
powerpc                   bluestone_defconfig
arm                        vexpress_defconfig
powerpc                       ebony_defconfig
mips                       rbtx49xx_defconfig
arm                        spear3xx_defconfig
powerpc                          allmodconfig
mips                        maltaup_defconfig
arm                           omap1_defconfig
powerpc                     skiroot_defconfig
mips                           rs90_defconfig
powerpc                     tqm8540_defconfig
powerpc                      pmac32_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     mpc512x_defconfig
mips                           ip22_defconfig
mips                   sb1250_swarm_defconfig
riscv                            alldefconfig
arm                  colibri_pxa270_defconfig
riscv                          rv32_defconfig
powerpc                      ppc64e_defconfig
arm                     am200epdkit_defconfig
powerpc                     tqm8560_defconfig
arm                       spear13xx_defconfig
powerpc                    mvme5100_defconfig
powerpc                  mpc885_ads_defconfig
mips                     cu1000-neo_defconfig
arm                         lpc32xx_defconfig
arm                        multi_v5_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a005-20220117
i386                 randconfig-a001-20220117
i386                 randconfig-a006-20220117
i386                 randconfig-a004-20220117
i386                 randconfig-a002-20220117
i386                 randconfig-a003-20220117
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a005-20220117
x86_64               randconfig-a004-20220117
x86_64               randconfig-a001-20220117
x86_64               randconfig-a006-20220117
x86_64               randconfig-a002-20220117
x86_64               randconfig-a003-20220117
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r041-20220124
riscv                randconfig-r042-20220122
hexagon              randconfig-r045-20220122
hexagon              randconfig-r041-20220122
hexagon              randconfig-r045-20220123
hexagon              randconfig-r041-20220123
riscv                randconfig-r042-20220118
hexagon              randconfig-r045-20220116
hexagon              randconfig-r045-20220117
hexagon              randconfig-r045-20220118
hexagon              randconfig-r045-20220119
riscv                randconfig-r042-20220116
hexagon              randconfig-r041-20220118
hexagon              randconfig-r041-20220119
hexagon              randconfig-r041-20220116
hexagon              randconfig-r041-20220117
riscv                randconfig-r042-20220120
hexagon              randconfig-r045-20220120
hexagon              randconfig-r041-20220120
s390                 randconfig-r044-20220124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

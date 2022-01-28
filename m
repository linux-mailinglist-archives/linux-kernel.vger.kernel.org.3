Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF1749F86C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbiA1LkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:40:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:61633 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237846AbiA1LkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643370017; x=1674906017;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=49ssLdElGLe3D6sL1BxJV3OuhqLdAjBt83buXikwV44=;
  b=VtylgbCXBmHLM2HR7WrMZh+0hBPGljRJR4GiW6B2a26d6m/48dREHaIR
   EivQdrev6Iwvf9u0JtlWhUyQRAKKHPGQxNSy6pU6bzu1pXBPNzhIs3N/z
   eu5HgxarGCPgJe+qOgbfMCiLRHXC6pYSPTvlFdlRJYa0Aesx4NqBtgMgI
   i4jwST96WNAle8Ec6UrH5dcZum3rhXLXtKIt3odZESe2EnDioeGqqZtKN
   Mf1nUGkfwi/IJ/A7p9UXAvYOsQHKnpK/1Y6z+VMGqYkA79pyybeO/b5Ii
   AHxiUKOYz46vMVtpXey6+5rsTPvcmFQBwPRdf4xYBGsWiIkmju3uluQpx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="245946173"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="245946173"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 03:40:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="533478566"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jan 2022 03:40:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDPby-000NnL-Un; Fri, 28 Jan 2022 11:40:14 +0000
Date:   Fri, 28 Jan 2022 19:39:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 96a9263ec15daa8ac3d242963447dbcc0651c6a2
Message-ID: <61f3d5ff.ToDhwBPy6WB9kV0D%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 96a9263ec15daa8ac3d242963447dbcc0651c6a2  srcu: Use invalid initial value for srcu_node GP sequence numbers

elapsed time: 1796m

configs tested: 244
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
powerpc                 mpc834x_itx_defconfig
arm                         at91_dt_defconfig
mips                         mpc30x_defconfig
xtensa                              defconfig
mips                        vocore2_defconfig
arc                      axs103_smp_defconfig
arm                       imx_v6_v7_defconfig
m68k                       m5275evb_defconfig
um                             i386_defconfig
h8300                    h8300h-sim_defconfig
arm                         s3c6400_defconfig
m68k                        mvme147_defconfig
mips                 decstation_r4k_defconfig
nios2                         10m50_defconfig
xtensa                  audio_kc705_defconfig
powerpc                      ppc40x_defconfig
powerpc                 mpc837x_mds_defconfig
arm                         nhk8815_defconfig
sparc64                          alldefconfig
powerpc                      mgcoge_defconfig
mips                            ar7_defconfig
arm                           tegra_defconfig
mips                         rt305x_defconfig
arm                            zeus_defconfig
sh                   secureedge5410_defconfig
sh                           sh2007_defconfig
sh                           se7721_defconfig
parisc                generic-64bit_defconfig
sparc                       sparc64_defconfig
mips                        bcm47xx_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
s390                       zfcpdump_defconfig
arm                            pleb_defconfig
m68k                          hp300_defconfig
sh                ecovec24-romimage_defconfig
m68k                       m5249evb_defconfig
arm                             rpc_defconfig
sh                               allmodconfig
powerpc                  storcenter_defconfig
arm                        keystone_defconfig
sh                     sh7710voipgw_defconfig
arm                        clps711x_defconfig
arm                      footbridge_defconfig
powerpc                      ep88xc_defconfig
powerpc                      pasemi_defconfig
sh                 kfr2r09-romimage_defconfig
parisc                generic-32bit_defconfig
arm                           viper_defconfig
sh                         ecovec24_defconfig
riscv                            allmodconfig
arm                            xcep_defconfig
sh                            shmin_defconfig
ia64                      gensparse_defconfig
arm                         lubbock_defconfig
riscv                            allyesconfig
powerpc                     rainier_defconfig
mips                    maltaup_xpa_defconfig
sh                        sh7763rdp_defconfig
arm                          pxa910_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                          pxa3xx_defconfig
m68k                       m5208evb_defconfig
arm                        oxnas_v6_defconfig
arm                       omap2plus_defconfig
arm                           h5000_defconfig
powerpc                     tqm8541_defconfig
mips                           xway_defconfig
powerpc                      ppc6xx_defconfig
arc                              alldefconfig
arc                        nsimosci_defconfig
arm                             pxa_defconfig
s390                          debug_defconfig
arm                         assabet_defconfig
h8300                            alldefconfig
powerpc                      tqm8xx_defconfig
sparc                            alldefconfig
arm                             ezx_defconfig
h8300                               defconfig
arm                           corgi_defconfig
powerpc                  iss476-smp_defconfig
h8300                     edosk2674_defconfig
nios2                         3c120_defconfig
xtensa                    xip_kc705_defconfig
sh                         apsh4a3a_defconfig
mips                           ci20_defconfig
arm                  randconfig-c002-20220127
arm                  randconfig-c002-20220124
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
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
mips                             allyesconfig
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
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                  randconfig-r043-20220124
arc                  randconfig-r043-20220126
riscv                randconfig-r042-20220127
arc                  randconfig-r043-20220127
s390                 randconfig-r044-20220127
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220124
riscv                randconfig-c006-20220124
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220124
x86_64               randconfig-c007-20220124
x86_64                        randconfig-c007
arm                  randconfig-c002-20220125
riscv                randconfig-c006-20220125
powerpc              randconfig-c003-20220125
mips                 randconfig-c004-20220125
i386                          randconfig-c001
s390                 randconfig-c005-20220125
powerpc                     powernv_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                  cavium_octeon_defconfig
powerpc                    ge_imp3a_defconfig
mips                         tb0219_defconfig
powerpc                 mpc836x_mds_defconfig
mips                          malta_defconfig
powerpc                 mpc8560_ads_defconfig
arm                       netwinder_defconfig
arm                         orion5x_defconfig
powerpc                   bluestone_defconfig
mips                           ip27_defconfig
powerpc                      ppc44x_defconfig
powerpc                    socrates_defconfig
powerpc                      obs600_defconfig
arm                            mmp2_defconfig
mips                   sb1250_swarm_defconfig
arm                     davinci_all_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                          allmodconfig
arm                                 defconfig
powerpc                 mpc8315_rdb_defconfig
mips                     loongson2k_defconfig
arm                        neponset_defconfig
powerpc                     kmeter1_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                          g5_defconfig
powerpc                      acadia_defconfig
arm                        magician_defconfig
mips                     cu1830-neo_defconfig
mips                          rm200_defconfig
arm                         s5pv210_defconfig
powerpc                        fsp2_defconfig
i386                             allyesconfig
powerpc                      walnut_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      katmai_defconfig
arm                          pxa168_defconfig
arm                       cns3420vb_defconfig
arm                     am200epdkit_defconfig
arm                          ixp4xx_defconfig
arm                         bcm2835_defconfig
powerpc                       ebony_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
riscv                randconfig-r042-20220124
s390                 randconfig-r044-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r045-20220127
hexagon              randconfig-r041-20220124
hexagon              randconfig-r041-20220127
riscv                randconfig-r042-20220126
s390                 randconfig-r044-20220126
hexagon              randconfig-r045-20220126
hexagon              randconfig-r041-20220126
hexagon              randconfig-r045-20220125
hexagon              randconfig-r041-20220125

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

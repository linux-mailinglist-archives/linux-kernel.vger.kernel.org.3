Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C0E48176E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 00:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhL2XFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 18:05:24 -0500
Received: from mga06.intel.com ([134.134.136.31]:2647 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhL2XFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 18:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640819122; x=1672355122;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yMNM6IEgs2DRJFj0/GDkADu8rEggYaMunQMl/bbc3Gs=;
  b=RnIPgDcRUyQOAad7MDvLQguSniRmifSxm+tyQGbxW9VG85PAe6pcmFh8
   Ox3H8eCVPsJGloN2dVOLOuSORQ9laH2qkIVI1XoL8CXJd90W6shnN26E5
   bG5mSmpA6d4+kuIp24YOhnWnCWYK94u0R/EfcYtM5Wa6+WABZDllEUuzp
   KWNJ+1aB4/5N0jBH/mXIp2sC75qYntjCszGrEwoQ5C+MmcezxEPlaQMVV
   MWTfuWmyPZWK4PC/hi40TsIA38K8wkP9NT5Yn4IF9SD3xyEsDbCFk/N30
   NoE4KhhozY+9jgjzhVwAHc2/KFRoHhLN2r1/PCvN2VG1SFZwrVdRcyfAE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="302335831"
X-IronPort-AV: E=Sophos;i="5.88,246,1635231600"; 
   d="scan'208";a="302335831"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 15:05:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,246,1635231600"; 
   d="scan'208";a="572725507"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 Dec 2021 15:05:20 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2i0W-0009UI-13; Wed, 29 Dec 2021 23:05:20 +0000
Date:   Thu, 30 Dec 2021 07:04:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/core] BUILD SUCCESS
 5abb065dca7301de90b7c44bbcdc378e49e4d362
Message-ID: <61cce979.e4fLRQR7BctzWbyO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/core
branch HEAD: 5abb065dca7301de90b7c44bbcdc378e49e4d362  notifier: Return an error when a callback has already been registered

elapsed time: 721m

configs tested: 244
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
i386                 randconfig-c001-20211228
powerpc              randconfig-c003-20211229
i386                 randconfig-c001-20211229
i386                 randconfig-c001-20211230
arm                             mxs_defconfig
arm                          simpad_defconfig
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
powerpc                      pasemi_defconfig
arm                        shmobile_defconfig
powerpc                 linkstation_defconfig
mips                         bigsur_defconfig
powerpc                 mpc832x_mds_defconfig
mips                        workpad_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                           ip32_defconfig
mips                           gcw0_defconfig
arm                        clps711x_defconfig
mips                       lemote2f_defconfig
arm                  colibri_pxa300_defconfig
mips                           ip28_defconfig
arm                      tct_hammer_defconfig
arm                         s3c6400_defconfig
powerpc                     pseries_defconfig
powerpc                     mpc5200_defconfig
mips                     decstation_defconfig
parisc                generic-32bit_defconfig
h8300                    h8300h-sim_defconfig
arm                         nhk8815_defconfig
arc                     haps_hs_smp_defconfig
mips                      malta_kvm_defconfig
arm                            pleb_defconfig
mips                        omega2p_defconfig
xtensa                  cadence_csp_defconfig
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
mips                malta_qemu_32r6_defconfig
arm                           sama7_defconfig
arm                      jornada720_defconfig
powerpc                      pcm030_defconfig
powerpc                 mpc832x_rdb_defconfig
ia64                            zx1_defconfig
sh                          urquell_defconfig
arm                      pxa255-idp_defconfig
csky                                defconfig
powerpc                     kmeter1_defconfig
sh                                  defconfig
s390                             allmodconfig
mips                            e55_defconfig
mips                         cobalt_defconfig
arm                         axm55xx_defconfig
mips                          rm200_defconfig
riscv                            allyesconfig
arc                      axs103_smp_defconfig
mips                           xway_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                      pic32mzda_defconfig
mips                           rs90_defconfig
m68k                        m5272c3_defconfig
mips                  cavium_octeon_defconfig
i386                                defconfig
mips                            ar7_defconfig
powerpc                      cm5200_defconfig
ia64                          tiger_defconfig
i386                             alldefconfig
sh                             sh03_defconfig
powerpc                    klondike_defconfig
arm                            qcom_defconfig
m68k                                defconfig
powerpc                      obs600_defconfig
arm                     eseries_pxa_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                            lart_defconfig
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
xtensa                       common_defconfig
powerpc                     tqm5200_defconfig
powerpc                     sequoia_defconfig
powerpc                 mpc836x_mds_defconfig
mips                       rbtx49xx_defconfig
powerpc                  mpc866_ads_defconfig
parisc                           alldefconfig
mips                       bmips_be_defconfig
arc                    vdk_hs38_smp_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                      arches_defconfig
powerpc                      ppc44x_defconfig
xtensa                  nommu_kc705_defconfig
arm                       cns3420vb_defconfig
powerpc                     mpc83xx_defconfig
arm                        spear3xx_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     tqm8560_defconfig
arm                  randconfig-c002-20211228
arm                  randconfig-c002-20211229
arm                  randconfig-c002-20211230
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
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
i386                 randconfig-a012-20211229
i386                 randconfig-a011-20211229
i386                 randconfig-a014-20211229
i386                 randconfig-a016-20211229
i386                 randconfig-a013-20211229
i386                 randconfig-a015-20211229
x86_64               randconfig-a005-20211228
x86_64               randconfig-a004-20211228
x86_64               randconfig-a002-20211228
riscv                    nommu_k210_defconfig
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
x86_64               randconfig-a014-20211228
i386                 randconfig-a012-20211228
i386                 randconfig-a013-20211228
i386                 randconfig-a015-20211228
hexagon              randconfig-r041-20211229
hexagon              randconfig-r045-20211229
riscv                randconfig-r042-20211228
s390                 randconfig-r044-20211228
hexagon              randconfig-r045-20211228
hexagon              randconfig-r041-20211228
hexagon              randconfig-r045-20211230

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

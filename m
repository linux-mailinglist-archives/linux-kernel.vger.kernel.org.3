Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD544818BA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 03:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhL3Cif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 21:38:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:17234 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbhL3Cie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 21:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640831914; x=1672367914;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+2hlzuY2Sw/rIz1kvcj9PXzTN5f/31i4XX/03BIqcPM=;
  b=dlF8zR4aUkhqDzABg32o0pgysJ/9T+m7IO2EM99qmRHYugNJreeVq61x
   5Dx+nV5GvheJyj5UVBMT18f/7pG5RVQLntSFS/Vo5KsHmZqhdZz/fcOt7
   HuHDd8YpS2sJYBeqQyN8jBOQA5ibYGJup/Lv+FvAfjcw5eRFxK+ui+Ut6
   ZBrnunbZ+EKcK09yl2xpWapdUnFbprO8CMVOtglQrHBrT4VoWO05BhFVU
   09KWqrKgT0BD3o9u/bUNvyT0cb+skRV/6ACgxa6aOXrsemFdX2zoeZO1q
   U8x53qqIILIITfEURhH0d4SptcaRBZgHeikLIfSH6Pl6fW8acWqeQjc1p
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="222275483"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="222275483"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 18:38:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="470516996"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Dec 2021 18:38:32 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2lKp-0009eY-Ft; Thu, 30 Dec 2021 02:38:31 +0000
Date:   Thu, 30 Dec 2021 10:37:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 244122b4d2e5221e6abd6e21d6a58170104db781
Message-ID: <61cd1b83.orPMJlnN1mr/ntfi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 244122b4d2e5221e6abd6e21d6a58170104db781  x86/lib: Add fast-short-rep-movs check to copy_user_enhanced_fast_string()

elapsed time: 722m

configs tested: 224
configs skipped: 60

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
i386                 randconfig-c001-20211230
mips                 randconfig-c004-20211230
arm                        mvebu_v5_defconfig
mips                        qi_lb60_defconfig
sh                        apsh4ad0a_defconfig
sh                            hp6xx_defconfig
powerpc                 mpc834x_mds_defconfig
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
arc                     haps_hs_smp_defconfig
mips                      malta_kvm_defconfig
arm                            pleb_defconfig
mips                        omega2p_defconfig
xtensa                  cadence_csp_defconfig
sh                           se7724_defconfig
parisc                generic-64bit_defconfig
arm                          exynos_defconfig
xtensa                       common_defconfig
powerpc                     mpc512x_defconfig
arm                          pxa168_defconfig
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
sh                                  defconfig
s390                             allmodconfig
mips                            e55_defconfig
mips                         cobalt_defconfig
arm                         at91_dt_defconfig
arc                      axs103_smp_defconfig
mips                           xway_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                      pic32mzda_defconfig
mips                           rs90_defconfig
m68k                        m5272c3_defconfig
i386                             alldefconfig
sh                             sh03_defconfig
powerpc                    klondike_defconfig
arm                            qcom_defconfig
m68k                                defconfig
mips                         tb0287_defconfig
m68k                         apollo_defconfig
sh                ecovec24-romimage_defconfig
arm                      integrator_defconfig
m68k                        stmark2_defconfig
sh                          lboxre2_defconfig
powerpc                      obs600_defconfig
powerpc                       holly_defconfig
powerpc                       maple_defconfig
mips                     loongson2k_defconfig
mips                        maltaup_defconfig
arm                            xcep_defconfig
mips                          ath79_defconfig
powerpc                    adder875_defconfig
arc                        nsim_700_defconfig
arm                           omap1_defconfig
arm                          ixp4xx_defconfig
arm                           sunxi_defconfig
arm                           sama5_defconfig
mips                            ar7_defconfig
arm                        clps711x_defconfig
arm                             ezx_defconfig
sh                        edosk7705_defconfig
powerpc                      mgcoge_defconfig
arm                  colibri_pxa270_defconfig
h8300                               defconfig
arm                        trizeps4_defconfig
mips                       rbtx49xx_defconfig
powerpc                  mpc866_ads_defconfig
parisc                           alldefconfig
mips                       bmips_be_defconfig
powerpc                      arches_defconfig
powerpc                      ppc44x_defconfig
xtensa                  nommu_kc705_defconfig
sparc                       sparc64_defconfig
powerpc                   microwatt_defconfig
powerpc                      cm5200_defconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     tqm8560_defconfig
arm                  randconfig-c002-20211228
arm                  randconfig-c002-20211230
arm                  randconfig-c002-20211229
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
parisc                              defconfig
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
x86_64               randconfig-a001-20211228
x86_64               randconfig-a003-20211228
x86_64               randconfig-a006-20211228
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
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-a002-20211230
x86_64               randconfig-a001-20211230
x86_64               randconfig-a003-20211230
x86_64               randconfig-a006-20211230
x86_64               randconfig-a004-20211230
x86_64               randconfig-a005-20211230
x86_64               randconfig-a005-20211229
x86_64               randconfig-a001-20211229
x86_64               randconfig-a003-20211229
x86_64               randconfig-a004-20211229
x86_64               randconfig-a002-20211229
x86_64               randconfig-a006-20211229
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
x86_64               randconfig-a014-20211228
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
riscv                randconfig-r042-20211228
s390                 randconfig-r044-20211228
hexagon              randconfig-r045-20211228
hexagon              randconfig-r041-20211228
hexagon              randconfig-r045-20211230

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

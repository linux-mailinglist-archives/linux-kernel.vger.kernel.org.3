Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3962B483B48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 05:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiADE0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 23:26:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:4815 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232837AbiADE0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 23:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641270383; x=1672806383;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KWrVN3bpLP91BTJv5xKyzB6RXpcoZH84m5Ex+bhO0ro=;
  b=SpVE6e/t3Dp14/vBLODKPDcIUwprE41PXWUqcy0/+cJRgmhBa1xsR5cP
   gfcnpcXlswQnHJiWwDrh9pGMO6yZ4KQVtfiqDB15rSVUeJVH1a4F51Cz0
   Kd9y5pWPjxFwly8Db5EvgCt29voVa6Ip93HmJTxu0gwun4JTdIs7OFCUv
   CazLrM/0bKdU5ASazsgrHAmKXkskcrfOHrRooAhyflMrcZyR67lYBoi2g
   kgPFWcS/SDFUax3gJwnV5Ub8mhJCv+sASNiav+AxWFIhIZKarM2Rg5tdl
   QG5+/SyQ8PP8dfNdvkwql9H0bYNfXCdGDcjsEYByDKsCvUVshRJYZGVqd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="328495738"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="328495738"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 20:26:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="556046508"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Jan 2022 20:26:21 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4bOv-000Ed8-51; Tue, 04 Jan 2022 04:26:21 +0000
Date:   Tue, 04 Jan 2022 12:26:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 262d811276ae5eb6b3e33f08b7326ba09cc5d13c
Message-ID: <61d3cc62.n6huEIwGAgikDQCC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 262d811276ae5eb6b3e33f08b7326ba09cc5d13c  squash! rcu: Use a single ->barrier_lock for all CPUs

elapsed time: 4602m

configs tested: 259
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                            shmin_defconfig
xtensa                       common_defconfig
openrisc                         alldefconfig
nios2                            alldefconfig
arm                            qcom_defconfig
sh                        dreamcast_defconfig
arm                            mps2_defconfig
sh                         ap325rxa_defconfig
sh                          rsk7264_defconfig
xtensa                    smp_lx200_defconfig
x86_64                           alldefconfig
arm                        oxnas_v6_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                            lart_defconfig
parisc                generic-64bit_defconfig
sh                           se7750_defconfig
arm                        clps711x_defconfig
powerpc                       eiger_defconfig
m68k                         apollo_defconfig
powerpc                     tqm8555_defconfig
arm                          pxa910_defconfig
powerpc                       ppc64_defconfig
mips                         mpc30x_defconfig
arm                           h5000_defconfig
xtensa                          iss_defconfig
powerpc                     tqm8548_defconfig
microblaze                      mmu_defconfig
xtensa                         virt_defconfig
powerpc                     ep8248e_defconfig
mips                           ci20_defconfig
arc                        nsim_700_defconfig
arm                            hisi_defconfig
powerpc                   currituck_defconfig
sh                          rsk7201_defconfig
arm                     eseries_pxa_defconfig
nds32                             allnoconfig
sh                        edosk7760_defconfig
powerpc                     stx_gp3_defconfig
m68k                          sun3x_defconfig
m68k                       m5208evb_defconfig
powerpc                      ppc6xx_defconfig
arm                       multi_v4t_defconfig
sh                          lboxre2_defconfig
powerpc                      ep88xc_defconfig
arm                       aspeed_g5_defconfig
m68k                         amcore_defconfig
mips                         cobalt_defconfig
sh                   sh7724_generic_defconfig
powerpc                      mgcoge_defconfig
ia64                         bigsur_defconfig
arm                          lpd270_defconfig
sh                             sh03_defconfig
powerpc                      makalu_defconfig
arm                         nhk8815_defconfig
nios2                         3c120_defconfig
parisc                           alldefconfig
sh                               j2_defconfig
powerpc                      chrp32_defconfig
arm                            xcep_defconfig
sh                            hp6xx_defconfig
m68k                            q40_defconfig
sh                          kfr2r09_defconfig
arc                              alldefconfig
arc                          axs103_defconfig
mips                           gcw0_defconfig
arc                        vdk_hs38_defconfig
arm64                            alldefconfig
ia64                        generic_defconfig
um                             i386_defconfig
m68k                          multi_defconfig
sh                           se7751_defconfig
sh                           sh2007_defconfig
arm                           viper_defconfig
mips                         rt305x_defconfig
mips                        vocore2_defconfig
csky                                defconfig
powerpc                    adder875_defconfig
um                                  defconfig
sh                           se7705_defconfig
mips                         tb0226_defconfig
sh                         ecovec24_defconfig
powerpc                   motionpro_defconfig
ia64                                defconfig
ia64                          tiger_defconfig
mips                      loongson3_defconfig
sh                           se7721_defconfig
mips                           ip32_defconfig
powerpc                  iss476-smp_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                      gensparse_defconfig
parisc                           allyesconfig
powerpc                     taishan_defconfig
arc                      axs103_smp_defconfig
arm                           u8500_defconfig
powerpc                      ppc40x_defconfig
ia64                             alldefconfig
m68k                       m5275evb_defconfig
arm                         axm55xx_defconfig
xtensa                generic_kc705_defconfig
sh                          polaris_defconfig
sparc                       sparc32_defconfig
arm                        shmobile_defconfig
arm                  randconfig-c002-20220102
arm                  randconfig-c002-20220103
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
x86_64               randconfig-a005-20220101
x86_64               randconfig-a001-20220101
x86_64               randconfig-a004-20220101
x86_64               randconfig-a006-20220101
x86_64               randconfig-a003-20220101
x86_64               randconfig-a002-20220101
x86_64               randconfig-a005-20220103
x86_64               randconfig-a001-20220103
x86_64               randconfig-a004-20220103
x86_64               randconfig-a006-20220103
x86_64               randconfig-a002-20220103
x86_64               randconfig-a003-20220103
i386                 randconfig-a003-20220103
i386                 randconfig-a005-20220103
i386                 randconfig-a004-20220103
i386                 randconfig-a006-20220103
i386                 randconfig-a001-20220103
i386                 randconfig-a002-20220103
x86_64               randconfig-a015-20220102
x86_64               randconfig-a012-20220102
x86_64               randconfig-a014-20220102
x86_64               randconfig-a013-20220102
x86_64               randconfig-a011-20220102
x86_64               randconfig-a016-20220102
i386                 randconfig-a012-20220102
i386                 randconfig-a016-20220102
i386                 randconfig-a014-20220102
i386                 randconfig-a015-20220102
i386                 randconfig-a011-20220102
i386                 randconfig-a013-20220102
s390                 randconfig-r044-20220102
arc                  randconfig-r043-20220102
riscv                randconfig-r042-20220102
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220102
mips                 randconfig-c004-20220102
i386                 randconfig-c001-20220102
riscv                randconfig-c006-20220102
powerpc              randconfig-c003-20220102
x86_64               randconfig-c007-20220102
s390                 randconfig-c005-20220102
arm64                            allyesconfig
mips                     cu1000-neo_defconfig
mips                      bmips_stb_defconfig
arm                        multi_v5_defconfig
mips                          ath79_defconfig
powerpc                        icon_defconfig
arm                          pcm027_defconfig
powerpc                   bluestone_defconfig
powerpc                       ebony_defconfig
arm                      pxa255-idp_defconfig
mips                        omega2p_defconfig
powerpc                          allmodconfig
arm                                 defconfig
mips                       lemote2f_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                            mmp2_defconfig
arm                        mvebu_v5_defconfig
hexagon                             defconfig
mips                      malta_kvm_defconfig
mips                           ip22_defconfig
arm                       spear13xx_defconfig
arm                    vt8500_v6_v7_defconfig
x86_64                           allyesconfig
arm                           omap1_defconfig
arm                       aspeed_g4_defconfig
mips                           ip27_defconfig
arm                          collie_defconfig
arm                       versatile_defconfig
mips                        qi_lb60_defconfig
powerpc                      obs600_defconfig
x86_64               randconfig-a005-20220102
x86_64               randconfig-a001-20220102
x86_64               randconfig-a004-20220102
x86_64               randconfig-a006-20220102
x86_64               randconfig-a002-20220102
x86_64               randconfig-a003-20220102
i386                 randconfig-a001-20220102
i386                 randconfig-a003-20220102
i386                 randconfig-a004-20220102
i386                 randconfig-a002-20220102
i386                 randconfig-a005-20220102
i386                 randconfig-a006-20220102
x86_64               randconfig-a015-20220103
x86_64               randconfig-a012-20220103
x86_64               randconfig-a013-20220103
x86_64               randconfig-a011-20220103
x86_64               randconfig-a016-20220103
x86_64               randconfig-a011-20211231
x86_64               randconfig-a013-20211231
x86_64               randconfig-a015-20211231
x86_64               randconfig-a012-20211231
x86_64               randconfig-a014-20211231
x86_64               randconfig-a016-20211231
x86_64               randconfig-a014-20220103
i386                 randconfig-a012-20220103
i386                 randconfig-a016-20220103
i386                 randconfig-a014-20220103
i386                 randconfig-a015-20220103
i386                 randconfig-a011-20220103
i386                 randconfig-a013-20220103
i386                 randconfig-a016-20211231
i386                 randconfig-a011-20211231
i386                 randconfig-a012-20211231
i386                 randconfig-a013-20211231
i386                 randconfig-a014-20211231
i386                 randconfig-a015-20211231
hexagon              randconfig-r041-20220102
hexagon              randconfig-r045-20220102
hexagon              randconfig-r041-20220103
hexagon              randconfig-r045-20220103
riscv                randconfig-r042-20220103

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

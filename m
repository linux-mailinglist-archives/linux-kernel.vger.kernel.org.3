Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CB751F28F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 03:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiEIBz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 21:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiEIBxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 21:53:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F33940A2E
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 18:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652060968; x=1683596968;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dmu4xavnXeAZTi/O/LTWt/8dZsQ1SzTfqu+cuWojN10=;
  b=KNoQ5q+abi+cj8Kc4ne6VI2YT9a+eqg6jccbn9C3GjGNwI455LCPWqpB
   JtcJ77NgQ42o/fy2m7HlXdSvMzPz9HvG/JwgXAc1INFuhWTByeW+q4e/6
   J86dUgXuyxyh0UeKn8N3tdenRhO2w8q9tKYgGQkSF/03yTHh2yyh0ZcMa
   GRG5a2Y1SsaO6hswl5Xn72U6R8VaRt8P7OrX2JZsg469IyVkUiukm4l53
   bwSbcprEbg1r9n8yi8+PL1JPD4Ur4fcBDt23LzEfJ2AH74NSk+qCItjFS
   nxfah0WnErr+LyCSBu8ZfQzf6nI6lcJqIlUQngWjbJ0anHFD1SemkMM4G
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="250946867"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="250946867"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 18:49:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="550775029"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 May 2022 18:49:26 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnsWc-000G5e-2Z;
        Mon, 09 May 2022 01:49:26 +0000
Date:   Mon, 09 May 2022 09:48:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 f4b62e1e1137507268c2c63dc4e6da279dc58e9f
Message-ID: <627872f2.SmpGexX7alsYKmf9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git timers/core
branch HEAD: f4b62e1e1137507268c2c63dc4e6da279dc58e9f  time/sched_clock: Fix formatting of frequency reporting code

elapsed time: 9388m

configs tested: 267
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                         ps3_defconfig
arc                     haps_hs_smp_defconfig
arc                            hsdk_defconfig
arm                         vf610m4_defconfig
powerpc                     ep8248e_defconfig
nios2                            allyesconfig
parisc                              defconfig
sh                         microdev_defconfig
powerpc                     taishan_defconfig
m68k                           sun3_defconfig
powerpc                      pcm030_defconfig
parisc                           allyesconfig
arm                       aspeed_g5_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                    xip_kc705_defconfig
m68k                         apollo_defconfig
sh                               j2_defconfig
sh                        apsh4ad0a_defconfig
mips                             allyesconfig
powerpc                mpc7448_hpc2_defconfig
sh                         ap325rxa_defconfig
x86_64                              defconfig
m68k                          hp300_defconfig
ia64                          tiger_defconfig
m68k                          atari_defconfig
powerpc                           allnoconfig
powerpc                     tqm8555_defconfig
mips                           jazz_defconfig
um                               alldefconfig
xtensa                    smp_lx200_defconfig
openrisc                    or1ksim_defconfig
m68k                       m5275evb_defconfig
sparc                       sparc64_defconfig
sh                          polaris_defconfig
arm                      jornada720_defconfig
xtensa                              defconfig
parisc                generic-64bit_defconfig
sh                          lboxre2_defconfig
sparc64                             defconfig
arm                           sunxi_defconfig
powerpc                       maple_defconfig
m68k                       m5249evb_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                           ip32_defconfig
powerpc                     asp8347_defconfig
sh                            shmin_defconfig
alpha                            alldefconfig
arc                     nsimosci_hs_defconfig
arc                           tb10x_defconfig
ia64                        generic_defconfig
mips                       bmips_be_defconfig
i386                                defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      cm5200_defconfig
arm                         nhk8815_defconfig
arm                        clps711x_defconfig
arm                            zeus_defconfig
powerpc                       holly_defconfig
csky                                defconfig
arc                        vdk_hs38_defconfig
m68k                        mvme16x_defconfig
arc                        nsimosci_defconfig
powerpc64                           defconfig
powerpc                    klondike_defconfig
sh                   sh7724_generic_defconfig
sh                        sh7785lcr_defconfig
powerpc                     redwood_defconfig
arm                       multi_v4t_defconfig
arm                        realview_defconfig
arc                         haps_hs_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                         cobalt_defconfig
openrisc                  or1klitex_defconfig
powerpc                     sequoia_defconfig
sh                          sdk7786_defconfig
arm                         lpc18xx_defconfig
powerpc                      chrp32_defconfig
mips                     decstation_defconfig
powerpc                         wii_defconfig
powerpc                 mpc8540_ads_defconfig
s390                             allyesconfig
arm                            lart_defconfig
microblaze                          defconfig
sh                                  defconfig
arm                         at91_dt_defconfig
arm                        mvebu_v7_defconfig
sh                     magicpanelr2_defconfig
powerpc                      tqm8xx_defconfig
arm                           imxrt_defconfig
m68k                             alldefconfig
arm                            qcom_defconfig
s390                          debug_defconfig
sh                        sh7763rdp_defconfig
m68k                             allmodconfig
arm                        oxnas_v6_defconfig
ia64                             alldefconfig
mips                         bigsur_defconfig
sh                           se7721_defconfig
sh                           se7705_defconfig
sh                             sh03_defconfig
arm                        mini2440_defconfig
m68k                       m5475evb_defconfig
mips                        bcm47xx_defconfig
m68k                        stmark2_defconfig
arm                            mps2_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220501
arm                  randconfig-c002-20220506
x86_64               randconfig-c001-20220502
i386                 randconfig-c001-20220502
arm                  randconfig-c002-20220502
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc64                            defconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a006-20220502
x86_64               randconfig-a001-20220502
x86_64               randconfig-a003-20220502
x86_64               randconfig-a002-20220502
x86_64               randconfig-a004-20220502
x86_64               randconfig-a005-20220502
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                 randconfig-a004-20220502
i386                 randconfig-a006-20220502
i386                 randconfig-a002-20220502
i386                 randconfig-a003-20220502
i386                 randconfig-a001-20220502
i386                 randconfig-a005-20220502
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220501
arc                  randconfig-r043-20220502
arc                  randconfig-r043-20220501
s390                 randconfig-r044-20220501
arc                  randconfig-r043-20220505
s390                 randconfig-r044-20220505
riscv                randconfig-r042-20220505
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220501
riscv                randconfig-c006-20220501
mips                 randconfig-c004-20220501
arm                  randconfig-c002-20220501
powerpc              randconfig-c003-20220508
riscv                randconfig-c006-20220508
mips                 randconfig-c004-20220508
arm                  randconfig-c002-20220508
s390                 randconfig-c005-20220506
powerpc              randconfig-c003-20220506
riscv                randconfig-c006-20220506
mips                 randconfig-c004-20220506
arm                  randconfig-c002-20220506
powerpc              randconfig-c003-20220505
riscv                randconfig-c006-20220505
arm                  randconfig-c002-20220505
mips                     loongson2k_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                    ge_imp3a_defconfig
arm                           omap1_defconfig
arm                          moxart_defconfig
arm                          collie_defconfig
powerpc                    socrates_defconfig
mips                     cu1830-neo_defconfig
mips                      pic32mzda_defconfig
riscv                    nommu_virt_defconfig
powerpc                  mpc866_ads_defconfig
mips                  cavium_octeon_defconfig
arm                          ep93xx_defconfig
arm                        neponset_defconfig
powerpc                 mpc832x_mds_defconfig
mips                        qi_lb60_defconfig
arm                  colibri_pxa270_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      ppc44x_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      pmac32_defconfig
powerpc                     ksi8560_defconfig
powerpc                      katmai_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     tqm8540_defconfig
arm                            mmp2_defconfig
arm                     davinci_all_defconfig
arm                            dove_defconfig
riscv                          rv32_defconfig
mips                          ath25_defconfig
arm                        multi_v5_defconfig
powerpc                     kmeter1_defconfig
arm                      tct_hammer_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a011-20220502
x86_64               randconfig-a014-20220502
x86_64               randconfig-a012-20220502
x86_64               randconfig-a013-20220502
x86_64               randconfig-a015-20220502
x86_64               randconfig-a016-20220502
i386                 randconfig-a011-20220502
i386                 randconfig-a013-20220502
i386                 randconfig-a016-20220502
i386                 randconfig-a015-20220502
i386                 randconfig-a014-20220502
i386                 randconfig-a012-20220502
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220502
hexagon              randconfig-r045-20220501
hexagon              randconfig-r041-20220501
s390                 randconfig-r044-20220502
riscv                randconfig-r042-20220502
hexagon              randconfig-r041-20220502
hexagon              randconfig-r045-20220506
riscv                randconfig-r042-20220506
hexagon              randconfig-r041-20220506

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

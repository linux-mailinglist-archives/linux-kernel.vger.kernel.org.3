Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C6D4EBDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244892AbiC3JnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244152AbiC3JnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:43:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40029265E90
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648633280; x=1680169280;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uqKwL70CX+YvtFu942wsAvoem4+ggArdmfOYxWY4qGA=;
  b=E/3jRUYbp3BUw/ySPnqOl5yYaV/QU8PuHqRQEKG2KrXfAlGbkAFin0iv
   vMKpXaDowoX/mntFWfmBbSlgAnhgYrqYYXpS6pgbDVOKos+lJshOlYJkJ
   38MIgzP3uduDdUmwBdzQsSilgzkUvD9GPOud9bU2IrLZgsp2AIrZjkR95
   27g9IPq3wzmt3L7Oh6rGqNx9Rt78qq/kYLcwwRV9JOfY/mGFn4MytS7XL
   NzIWLp2D52DD0rcmzRjJyzlELBIWOAz2tIYCLBij68/IWDdPHhskDB1Od
   8a2O0GzOvRuQ5Eg3m7pRjtn3JwVul4DBwhAQsOR8R0iL3vsFpiTiwO+95
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="258332175"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="258332175"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 02:41:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="837201437"
Received: from lkp-server02.sh.intel.com (HELO 7a008980c4ea) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 30 Mar 2022 02:41:18 -0700
Received: from kbuild by 7a008980c4ea with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZUpJ-0000FJ-Lz; Wed, 30 Mar 2022 09:41:17 +0000
Date:   Wed, 30 Mar 2022 17:40:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.03.16a] BUILD SUCCESS
 e98cff27b002d7c30e8e51eacd5d95f1ac303b23
Message-ID: <6244258e.YDmRGqVpDDXV0pX/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.03.16a
branch HEAD: e98cff27b002d7c30e8e51eacd5d95f1ac303b23  squash! rcu: Make the TASKS_RCU Kconfig option be selected

elapsed time: 7900m

configs tested: 242
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
m68k                          sun3x_defconfig
m68k                        mvme147_defconfig
powerpc                  iss476-smp_defconfig
m68k                            q40_defconfig
sh                          r7780mp_defconfig
arm                           h3600_defconfig
ia64                            zx1_defconfig
arm                        mini2440_defconfig
powerpc                     taishan_defconfig
mips                     decstation_defconfig
riscv                            allyesconfig
sh                             espt_defconfig
powerpc                     tqm8548_defconfig
sh                     magicpanelr2_defconfig
ia64                             allmodconfig
ia64                        generic_defconfig
mips                      maltasmvp_defconfig
xtensa                  cadence_csp_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                  maltasmvp_eva_defconfig
arm                           sama5_defconfig
arm                       aspeed_g5_defconfig
powerpc                  storcenter_defconfig
xtensa                  audio_kc705_defconfig
sh                          polaris_defconfig
powerpc                    amigaone_defconfig
arm                            hisi_defconfig
sh                         ap325rxa_defconfig
alpha                            alldefconfig
arm                           imxrt_defconfig
powerpc                      ppc6xx_defconfig
arc                        nsim_700_defconfig
parisc                generic-32bit_defconfig
mips                             allmodconfig
powerpc                   motionpro_defconfig
arc                      axs103_smp_defconfig
arm                      integrator_defconfig
sh                           se7619_defconfig
powerpc64                        alldefconfig
nios2                         10m50_defconfig
sparc                            alldefconfig
sh                            shmin_defconfig
arm                           sunxi_defconfig
powerpc                       maple_defconfig
m68k                       m5475evb_defconfig
m68k                       m5249evb_defconfig
nios2                               defconfig
sh                         microdev_defconfig
arm                           u8500_defconfig
arm                          exynos_defconfig
powerpc                      chrp32_defconfig
m68k                        mvme16x_defconfig
m68k                       m5275evb_defconfig
arm                           h5000_defconfig
m68k                       m5208evb_defconfig
m68k                                defconfig
xtensa                  nommu_kc705_defconfig
sparc                               defconfig
powerpc                      arches_defconfig
mips                         mpc30x_defconfig
arm                          pxa3xx_defconfig
openrisc                  or1klitex_defconfig
arm                            qcom_defconfig
arm                         s3c6400_defconfig
sh                           se7343_defconfig
h8300                            alldefconfig
arc                         haps_hs_defconfig
riscv             nommu_k210_sdcard_defconfig
arc                              allyesconfig
x86_64                           alldefconfig
arm                           viper_defconfig
sh                          rsk7203_defconfig
arm                     eseries_pxa_defconfig
sh                         ecovec24_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                      pasemi_defconfig
m68k                        m5307c3_defconfig
arm                       multi_v4t_defconfig
m68k                        stmark2_defconfig
arm                         assabet_defconfig
mips                       bmips_be_defconfig
xtensa                              defconfig
riscv                    nommu_k210_defconfig
sh                               j2_defconfig
mips                     loongson1b_defconfig
sh                             sh03_defconfig
arc                          axs101_defconfig
arm                        mvebu_v7_defconfig
parisc64                         alldefconfig
m68k                        m5272c3_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                   currituck_defconfig
sh                          sdk7780_defconfig
ia64                             alldefconfig
mips                        vocore2_defconfig
sh                        sh7757lcr_defconfig
mips                           gcw0_defconfig
m68k                          multi_defconfig
arm                         cm_x300_defconfig
sh                        sh7785lcr_defconfig
powerpc                     tqm8541_defconfig
arm                          gemini_defconfig
s390                             allyesconfig
mips                         rt305x_defconfig
powerpc                     pq2fads_defconfig
powerpc                      bamboo_defconfig
xtensa                           alldefconfig
arm                  randconfig-c002-20220324
arm                  randconfig-c002-20220325
arm                  randconfig-c002-20220327
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64               randconfig-a001-20220328
x86_64               randconfig-a003-20220328
x86_64               randconfig-a004-20220328
x86_64               randconfig-a002-20220328
x86_64               randconfig-a005-20220328
x86_64               randconfig-a006-20220328
riscv                randconfig-r042-20220325
s390                 randconfig-r044-20220325
arc                  randconfig-r043-20220325
arc                  randconfig-r043-20220324
riscv                randconfig-r042-20220327
s390                 randconfig-r044-20220327
arc                  randconfig-r043-20220327
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
mips                 randconfig-c004-20220327
arm                  randconfig-c002-20220327
riscv                randconfig-c006-20220327
powerpc              randconfig-c003-20220327
i386                          randconfig-c001
mips                 randconfig-c004-20220324
arm                  randconfig-c002-20220324
riscv                randconfig-c006-20220324
powerpc              randconfig-c003-20220324
mips                 randconfig-c004-20220328
arm                  randconfig-c002-20220328
x86_64               randconfig-c007-20220328
powerpc              randconfig-c003-20220328
riscv                randconfig-c006-20220328
i386                 randconfig-c001-20220328
powerpc                 mpc832x_rdb_defconfig
powerpc                          allmodconfig
arm                  colibri_pxa270_defconfig
arm                         s3c2410_defconfig
mips                       lemote2f_defconfig
arm                     davinci_all_defconfig
powerpc                      ppc64e_defconfig
arm                      tct_hammer_defconfig
arm                           sama7_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          collie_defconfig
powerpc                       ebony_defconfig
arm                         mv78xx0_defconfig
mips                           ip22_defconfig
hexagon                             defconfig
mips                        bcm63xx_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                        multi_v5_defconfig
arm                         socfpga_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a016-20220328
x86_64               randconfig-a012-20220328
x86_64               randconfig-a011-20220328
x86_64               randconfig-a014-20220328
x86_64               randconfig-a013-20220328
x86_64               randconfig-a015-20220328
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a015-20220328
i386                 randconfig-a016-20220328
i386                 randconfig-a011-20220328
i386                 randconfig-a012-20220328
i386                 randconfig-a014-20220328
i386                 randconfig-a013-20220328
hexagon              randconfig-r045-20220324
hexagon              randconfig-r041-20220325
hexagon              randconfig-r041-20220324
s390                 randconfig-r044-20220324
riscv                randconfig-r042-20220324
hexagon              randconfig-r045-20220325

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

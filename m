Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D6F4ECA64
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349196AbiC3RQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349197AbiC3RQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:16:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78EB37A90
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648660464; x=1680196464;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=W5yQqBmtkaV5Wi8b5CbkHQUX8E5uxzBK3uRL4cfye3g=;
  b=kwFZapPenxam4w7AEuaMvNEJ/vJRzJzs0/LzbJUq6WYPlQ0lmN7XqDrk
   wc073t1/Hvu+LdEHtLfm2vj2GBTxJZ2rndAw3gHM0RlSxpE3fws0AxJXq
   6EJxIHw5KuCSBGjfptwAnHRm6qvbLxqh9IOJ/cF+IApnQK3zUuqYWel7L
   fefEK97pGUs3pl48FVK6HlbzbhSq5TLhNBVvXT/Q8LY95+eiM/R+jhzAH
   v/SxoMLTquKE6GNjNdg5aYFBit/9ytMam8lLS760vyk3+ZSB2gFuTk32Y
   0vt/CnsKMmSnKmkaCYGHiOiGo43WPnK4P+sXzCruULTm/qa0246dfGDVy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="322781114"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="322781114"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 10:14:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="586075536"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Mar 2022 10:14:22 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZbtm-0000Dw-3H;
        Wed, 30 Mar 2022 17:14:22 +0000
Date:   Thu, 31 Mar 2022 01:13:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp] BUILD SUCCESS
 452d059ea2b6252f6743de3e9e81950d05ed8b18
Message-ID: <62448fbb.3lFXQNfjpZ/F8Dzn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp
branch HEAD: 452d059ea2b6252f6743de3e9e81950d05ed8b18  drm/amd/display: Fix Wstringop-overflow warnings in dc_link_dp.c

elapsed time: 3503m

configs tested: 236
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
i386                 randconfig-c001-20220328
i386                          randconfig-c001
powerpc64                           defconfig
m68k                            mac_defconfig
h8300                    h8300h-sim_defconfig
sh                           se7619_defconfig
sh                          urquell_defconfig
powerpc                     pq2fads_defconfig
ia64                          tiger_defconfig
mips                       capcella_defconfig
powerpc                       ppc64_defconfig
alpha                            alldefconfig
powerpc                      bamboo_defconfig
mips                         mpc30x_defconfig
sh                           sh2007_defconfig
nios2                         3c120_defconfig
sh                          rsk7269_defconfig
m68k                       m5275evb_defconfig
m68k                            q40_defconfig
m68k                        mvme147_defconfig
arm                            zeus_defconfig
csky                                defconfig
arm                           sama5_defconfig
m68k                       bvme6000_defconfig
xtensa                              defconfig
powerpc                       maple_defconfig
arm                          badge4_defconfig
ia64                      gensparse_defconfig
sh                         ap325rxa_defconfig
arc                                 defconfig
arm                           imxrt_defconfig
powerpc                      ppc6xx_defconfig
sh                         apsh4a3a_defconfig
arm                          exynos_defconfig
arm                          simpad_defconfig
parisc                           alldefconfig
arm                            pleb_defconfig
sparc                       sparc64_defconfig
powerpc                     stx_gp3_defconfig
powerpc                  iss476-smp_defconfig
arc                         haps_hs_defconfig
mips                            ar7_defconfig
mips                           ci20_defconfig
sh                      rts7751r2d1_defconfig
m68k                         apollo_defconfig
parisc64                            defconfig
arc                        nsim_700_defconfig
arm                        mvebu_v7_defconfig
arc                          axs101_defconfig
arc                            hsdk_defconfig
nios2                               defconfig
powerpc                      tqm8xx_defconfig
arm64                            alldefconfig
powerpc                         wii_defconfig
mips                           gcw0_defconfig
nios2                            allyesconfig
arm                             pxa_defconfig
powerpc                     ep8248e_defconfig
xtensa                       common_defconfig
nios2                         10m50_defconfig
mips                             allyesconfig
arm                         assabet_defconfig
mips                     loongson1b_defconfig
sh                          r7785rp_defconfig
arm                            hisi_defconfig
sh                           se7206_defconfig
sh                          sdk7780_defconfig
m68k                         amcore_defconfig
um                               alldefconfig
sh                          r7780mp_defconfig
m68k                       m5208evb_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                      pasemi_defconfig
m68k                          atari_defconfig
arm                             rpc_defconfig
microblaze                      mmu_defconfig
arm                           sunxi_defconfig
m68k                             alldefconfig
sh                               j2_defconfig
sh                           se7750_defconfig
arm                         s3c6400_defconfig
arm                        realview_defconfig
arm                         lpc18xx_defconfig
arm                           stm32_defconfig
um                                  defconfig
arm                     eseries_pxa_defconfig
powerpc                     redwood_defconfig
sh                            hp6xx_defconfig
m68k                          multi_defconfig
s390                       zfcpdump_defconfig
powerpc                   motionpro_defconfig
arm                           h3600_defconfig
m68k                       m5249evb_defconfig
sh                             espt_defconfig
powerpc                 mpc837x_rdb_defconfig
h8300                       h8s-sim_defconfig
m68k                        mvme16x_defconfig
arm                          pxa3xx_defconfig
sh                           se7343_defconfig
sh                          landisk_defconfig
sh                          rsk7264_defconfig
csky                             alldefconfig
s390                                defconfig
arm                        multi_v7_defconfig
powerpc                  storcenter_defconfig
arm                         axm55xx_defconfig
powerpc                   currituck_defconfig
arm                           tegra_defconfig
xtensa                           alldefconfig
arm                  randconfig-c002-20220327
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
alpha                               defconfig
alpha                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a001-20220328
x86_64               randconfig-a003-20220328
x86_64               randconfig-a004-20220328
x86_64               randconfig-a002-20220328
x86_64               randconfig-a005-20220328
x86_64               randconfig-a006-20220328
i386                 randconfig-a001-20220328
i386                 randconfig-a003-20220328
i386                 randconfig-a006-20220328
i386                 randconfig-a005-20220328
i386                 randconfig-a004-20220328
i386                 randconfig-a002-20220328
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
riscv                randconfig-r042-20220327
s390                 randconfig-r044-20220327
arc                  randconfig-r043-20220327
arc                  randconfig-r043-20220328
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
mips                 randconfig-c004-20220327
arm                  randconfig-c002-20220327
riscv                randconfig-c006-20220327
powerpc              randconfig-c003-20220327
i386                          randconfig-c001
s390                 randconfig-c005-20220327
mips                 randconfig-c004-20220328
arm                  randconfig-c002-20220328
x86_64               randconfig-c007-20220328
powerpc              randconfig-c003-20220328
riscv                randconfig-c006-20220328
i386                 randconfig-c001-20220328
s390                 randconfig-c005-20220328
arm                  colibri_pxa300_defconfig
powerpc                      acadia_defconfig
x86_64                           allyesconfig
powerpc                     tqm8540_defconfig
arm                        neponset_defconfig
mips                           ip22_defconfig
mips                           ip27_defconfig
powerpc                      walnut_defconfig
arm                         s3c2410_defconfig
mips                malta_qemu_32r6_defconfig
arm                        magician_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                        multi_v5_defconfig
arm                       imx_v4_v5_defconfig
arm                           omap1_defconfig
arm                       spear13xx_defconfig
arm                          imote2_defconfig
mips                       rbtx49xx_defconfig
powerpc                     ksi8560_defconfig
powerpc                        icon_defconfig
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
riscv                randconfig-r042-20220328
hexagon              randconfig-r045-20220328
hexagon              randconfig-r041-20220328
hexagon              randconfig-r045-20220327
hexagon              randconfig-r041-20220327
s390                 randconfig-r044-20220328

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

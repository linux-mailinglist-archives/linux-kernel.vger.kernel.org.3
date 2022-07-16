Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1215771EF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 00:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiGPWjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 18:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPWi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 18:38:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99B7F582
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 15:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658011138; x=1689547138;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/wqSAkyYRXMbf5WbLaFtlDIFoQFv7gNDOg5kXrOmvkg=;
  b=GIBlvLCmme6KiDal0OG1HS8lnPGb7DEXcj2AfXJX4wbSVKjmQJcrGT4b
   EiZrDEiRF+1RvHQsKrYml5NyLs+GllMv1K/JXfQmz049H/HLOxczTUZTM
   iRSCgWNblHxxWuZFN+p9owSqRsFeZ896g41KQ7a9TV/D4zVvdDbHA6Kzs
   mM6aW7cALUjK1UQvTTxa+ykZo+LBm+8Pd9S/6gK+y5dWrJcJ4786f1Mr9
   YmvldjW3GJk3YN+IMTE5MxG/f7D777BihCEOognSBZH27kWuQBUGW2JCS
   GDOlnbJaC+UeD328ct8FOxByccCKiTZrTbWt+8Jw+Jna0szqTG1F9UosC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="283575347"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="283575347"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 15:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="923904340"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jul 2022 15:38:57 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCqR6-0002Fh-ST;
        Sat, 16 Jul 2022 22:38:56 +0000
Date:   Sun, 17 Jul 2022 06:38:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 bcf163150cd37348a0cb59e95c916a83a9344b0e
Message-ID: <62d33df5.WZTtzw/Nq4iRs52V%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: bcf163150cd37348a0cb59e95c916a83a9344b0e  x86/bugs: Remove apostrophe typo

elapsed time: 727m

configs tested: 129
configs skipped: 74

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220717
arm                     eseries_pxa_defconfig
mips                      loongson3_defconfig
x86_64                           alldefconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                       holly_defconfig
arm                        mvebu_v7_defconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-32bit_defconfig
sh                         ap325rxa_defconfig
arm                          gemini_defconfig
arm                           sama5_defconfig
xtensa                              defconfig
xtensa                  nommu_kc705_defconfig
arm                            mps2_defconfig
mips                           jazz_defconfig
arm                          simpad_defconfig
arm                       multi_v4t_defconfig
arm                      integrator_defconfig
openrisc                            defconfig
mips                        vocore2_defconfig
csky                                defconfig
loongarch                           defconfig
sh                               alldefconfig
mips                             allyesconfig
xtensa                    xip_kc705_defconfig
powerpc                     tqm8555_defconfig
sh                        sh7785lcr_defconfig
sh                           se7750_defconfig
arm                        spear6xx_defconfig
powerpc                     tqm8548_defconfig
arm                         lpc18xx_defconfig
sh                          urquell_defconfig
mips                       bmips_be_defconfig
ia64                             alldefconfig
openrisc                 simple_smp_defconfig
sh                           se7721_defconfig
m68k                        mvme147_defconfig
sh                          polaris_defconfig
powerpc                  storcenter_defconfig
arc                            hsdk_defconfig
sh                   secureedge5410_defconfig
powerpc                    sam440ep_defconfig
mips                         tb0226_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a005
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                     tqm5200_defconfig
mips                        qi_lb60_defconfig
powerpc                     kilauea_defconfig
mips                      pic32mzda_defconfig
mips                           mtx1_defconfig
powerpc                      ppc64e_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    mvme5100_defconfig
arm                        multi_v5_defconfig
arm                       imx_v4_v5_defconfig
riscv                          rv32_defconfig
mips                        workpad_defconfig
arm                        mvebu_v5_defconfig
arm                         bcm2835_defconfig
powerpc                    socrates_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                      malta_kvm_defconfig
mips                           ip28_defconfig
mips                     loongson1c_defconfig
arm                         orion5x_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220716
hexagon              randconfig-r045-20220715
s390                 randconfig-r044-20220715
hexagon              randconfig-r041-20220716
hexagon              randconfig-r041-20220715
riscv                randconfig-r042-20220715
hexagon              randconfig-r045-20220717
s390                 randconfig-r044-20220717
hexagon              randconfig-r041-20220717
riscv                randconfig-r042-20220717

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

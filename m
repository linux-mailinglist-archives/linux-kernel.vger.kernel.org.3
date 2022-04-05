Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209364F5257
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiDFCmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577842AbiDEXRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 19:17:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9C719C11
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649195144; x=1680731144;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vuRVGptGWizo7YvjlGmSMHRbnTRmFRpIy9aEIdwsDjg=;
  b=hAE7BTe6TOdYH+Yvgt11h68UyU6t7/atRYhsHEpZM/aKqO/mJpxL46Es
   4yPoj8INh2V2WcOZU4SD3yN/FYN0HAN+XYCzZaWX5qYFMsgWC55dUdVL+
   gS8urdhQNn5mLADwjWpg8kdVQE3I/rgEneV5X1FVQZct0zacnichgL6CH
   l3dv5jzMyCJNu5eYWkt13Ewg1hGxlMOQz4DPsMSlIiA7OMRGx6Klrnfib
   Daer7DQO9veqsrsWoSVyLEQ74szY0j+LnVdqItX+RBfpaDuiBysCfXQx5
   uqNgdHPwXABL6HPXSv7e1Kv9n7/tyd0TNSdc865yfC2cp/ZPz7WxZE32b
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="261045821"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="261045821"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 14:45:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="524173790"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2022 14:45:35 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbqzW-0003mh-M2;
        Tue, 05 Apr 2022 21:45:34 +0000
Date:   Wed, 06 Apr 2022 05:44:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 273ba85b5e8b971ed28eb5c17e1638543be9237d
Message-ID: <624cb847.fPFxn35C8KW7vX+K%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: 273ba85b5e8b971ed28eb5c17e1638543be9237d  Revert "mm/page_alloc: mark pagesets as __maybe_unused"

elapsed time: 720m

configs tested: 148
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                         s3c6400_defconfig
mips                         db1xxx_defconfig
openrisc                 simple_smp_defconfig
arm                         at91_dt_defconfig
m68k                        m5407c3_defconfig
powerpc                     pq2fads_defconfig
sparc64                          alldefconfig
sparc                       sparc32_defconfig
powerpc                  storcenter_defconfig
arc                            hsdk_defconfig
riscv                    nommu_k210_defconfig
arm                      jornada720_defconfig
arm                       imx_v6_v7_defconfig
sh                     magicpanelr2_defconfig
openrisc                  or1klitex_defconfig
mips                        vocore2_defconfig
mips                         cobalt_defconfig
arc                      axs103_smp_defconfig
ia64                            zx1_defconfig
arm                         lpc18xx_defconfig
sh                           se7343_defconfig
sh                         ap325rxa_defconfig
sh                           se7722_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm8548_defconfig
sh                             sh03_defconfig
powerpc                         wii_defconfig
arm                             ezx_defconfig
mips                  maltasmvp_eva_defconfig
m68k                       m5249evb_defconfig
ia64                        generic_defconfig
arm                           viper_defconfig
arm                           stm32_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     tqm8541_defconfig
xtensa                    smp_lx200_defconfig
arm                          exynos_defconfig
openrisc                            defconfig
h8300                            allyesconfig
powerpc                     stx_gp3_defconfig
nios2                         10m50_defconfig
arm                            hisi_defconfig
arm                        keystone_defconfig
powerpc                         ps3_defconfig
arm                        realview_defconfig
m68k                          multi_defconfig
xtensa                       common_defconfig
sh                        edosk7760_defconfig
sparc                       sparc64_defconfig
arm                          iop32x_defconfig
riscv             nommu_k210_sdcard_defconfig
s390                                defconfig
ia64                          tiger_defconfig
arm                       multi_v4t_defconfig
powerpc                        warp_defconfig
xtensa                          iss_defconfig
arm                            qcom_defconfig
m68k                        mvme147_defconfig
ia64                             allyesconfig
arm                             pxa_defconfig
mips                  decstation_64_defconfig
h8300                       h8s-sim_defconfig
arm                           sama5_defconfig
mips                           xway_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220405
ia64                             allmodconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220405
riscv                randconfig-c006-20220405
mips                 randconfig-c004-20220405
arm                  randconfig-c002-20220405
arm                          moxart_defconfig
powerpc                        icon_defconfig
powerpc                   bluestone_defconfig
arm                      tct_hammer_defconfig
powerpc                  mpc885_ads_defconfig
arm                     am200epdkit_defconfig
arm                       aspeed_g4_defconfig
arm                            mmp2_defconfig
arm                              alldefconfig
riscv                    nommu_virt_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220405
riscv                randconfig-r042-20220405
hexagon              randconfig-r041-20220405

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

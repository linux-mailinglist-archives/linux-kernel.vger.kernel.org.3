Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C5A4B3B3A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 13:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbiBMMEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 07:04:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiBMMD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 07:03:59 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19BA5BD05
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 04:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644753834; x=1676289834;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0DoLI6P4LZ/kGKKztnMBubAEYiWKLSlhqzqDiNxGuQw=;
  b=jpf1Qmk2CswAxhcgm7ID7qudaVbO0S8ToOthlMpuq8+zSjb2+rj0kUDs
   VL0/K8LAyjfIpjRPxi/VCPIIe/ejDy9Ga5x1qm3CN1dXpvW/bna/2PRVH
   f/AUzEURFxljDERAgmn4p7ExbCScqZdTngsd6josxlK62lnu7wwVMqIWg
   /lqjH7kIhejCudk84/wjitK8JdzhsIrTn1Wgpdyxsu1PgLBCnKtOQr1gG
   muDougcEHOVlfyc97Ephu+uQ2Tk8ReSvnkGKr2mq7bc4SkYICJzTmTX2K
   MX7msVoGmAn95Mwncng+sLkX3xvFgGvGszzKPIXgb4xoJRweMU1FPFW9a
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="248774626"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="248774626"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 04:03:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="679925886"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2022 04:03:53 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJDbc-0007Sx-BM; Sun, 13 Feb 2022 12:03:52 +0000
Date:   Sun, 13 Feb 2022 20:03:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 7a935b7ac61b20dd8b56edab2a4f978be64e1e82
Message-ID: <6208f381.+5wEV0lm0mhER7ZY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 7a935b7ac61b20dd8b56edab2a4f978be64e1e82  tools/nolibc/stdlib: implement abort()

elapsed time: 722m

configs tested: 147
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
arm                            qcom_defconfig
xtensa                  audio_kc705_defconfig
m68k                            q40_defconfig
sh                             sh03_defconfig
sparc                       sparc64_defconfig
sh                             espt_defconfig
arm                           u8500_defconfig
arm                      footbridge_defconfig
sh                             shx3_defconfig
sh                              ul2_defconfig
arm                          lpd270_defconfig
powerpc                      tqm8xx_defconfig
h8300                       h8s-sim_defconfig
powerpc                     redwood_defconfig
riscv                               defconfig
sparc                            allyesconfig
arc                            hsdk_defconfig
mips                 decstation_r4k_defconfig
arc                     haps_hs_smp_defconfig
m68k                         apollo_defconfig
powerpc                  storcenter_defconfig
arm                         assabet_defconfig
sh                          polaris_defconfig
arm                           h3600_defconfig
m68k                        stmark2_defconfig
m68k                          hp300_defconfig
arm                       omap2plus_defconfig
x86_64                           alldefconfig
powerpc                     tqm8555_defconfig
mips                       bmips_be_defconfig
xtensa                          iss_defconfig
ia64                             allyesconfig
arm                            mps2_defconfig
mips                        vocore2_defconfig
powerpc                     tqm8541_defconfig
alpha                            alldefconfig
powerpc                    adder875_defconfig
mips                      fuloong2e_defconfig
xtensa                              defconfig
arm                            zeus_defconfig
sh                        edosk7760_defconfig
powerpc                       holly_defconfig
mips                           ci20_defconfig
arm                  randconfig-c002-20220213
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220213
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220213
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220213
i386                          randconfig-c001
mips                 randconfig-c004-20220213
arm                  randconfig-c002-20220213
arm                         s5pv210_defconfig
powerpc                     mpc512x_defconfig
arm                         shannon_defconfig
powerpc                     tqm5200_defconfig
arm                         bcm2835_defconfig
mips                        qi_lb60_defconfig
arm                        neponset_defconfig
riscv                            alldefconfig
powerpc                      ppc64e_defconfig
arm                     am200epdkit_defconfig
powerpc                     ksi8560_defconfig
powerpc                       ebony_defconfig
powerpc                     kmeter1_defconfig
arm                          pcm027_defconfig
arm                           spitz_defconfig
mips                           ip27_defconfig
mips                          ath79_defconfig
arm                              alldefconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r045-20220213
hexagon              randconfig-r041-20220213
riscv                randconfig-r042-20220213
s390                 randconfig-r044-20220213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBA24B38B9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 00:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiBLXzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 18:55:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiBLXzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 18:55:42 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F1D5FF3E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 15:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644710138; x=1676246138;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LRXChDvW78JF33RsPrdMxmZvJU+rYRsWZALTlOmEp/4=;
  b=VgsU1CuK0HjyTF/D6ambzLM/gXDKOBceJIIG4+I8Pq5IDH7yU3LWwaYi
   eKcDzwCX1MBLg5EtjFvb+df7dXFQ2WXxKVXt4qSSr1Ohd8FIts/EkJOA0
   Dx9v8JGvc3uPtcHU0N76fwduBRJurlk4BC/YbPZAGoMqi09csmRk7CcM3
   8lsHr1o0WbqbafZ2PtdgLFJLw0q6CeEo7NxJoP26aEcfk/q9sOZjMCbQb
   9m1x46mynxzu/Co2ZVJXr3ahcuQ+o/+J3xGl41kRop2Dt906YB/pHp1Et
   orifQZN7UKPMjxLJlKWa0V+cGtx/GQI9AFkm7InBsOz2tydDYhdHKBI7h
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="274473449"
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="274473449"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 15:55:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="492087407"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2022 15:55:36 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJ2Ep-0006me-Ug; Sat, 12 Feb 2022 23:55:35 +0000
Date:   Sun, 13 Feb 2022 07:54:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 5f117033243488a0080f837540c27999aa31870e
Message-ID: <620848b8.CZmBNz5WkTKTaLjE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: 5f117033243488a0080f837540c27999aa31870e  x86/head64: Add missing __head annotation to sme_postprocess_startup()

elapsed time: 722m

configs tested: 195
configs skipped: 84

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
sh                             espt_defconfig
arm                           u8500_defconfig
arm                      footbridge_defconfig
sh                             shx3_defconfig
sh                              ul2_defconfig
arm                          lpd270_defconfig
powerpc                       ppc64_defconfig
ia64                        generic_defconfig
xtensa                       common_defconfig
ia64                             alldefconfig
powerpc                      tqm8xx_defconfig
h8300                       h8s-sim_defconfig
powerpc                     redwood_defconfig
riscv                               defconfig
powerpc                    sam440ep_defconfig
riscv                            allyesconfig
powerpc                     mpc83xx_defconfig
sh                           se7721_defconfig
sparc                            allyesconfig
arc                            hsdk_defconfig
mips                 decstation_r4k_defconfig
sh                            titan_defconfig
powerpc                      ppc6xx_defconfig
um                               alldefconfig
powerpc                      makalu_defconfig
powerpc                  iss476-smp_defconfig
alpha                            allyesconfig
mips                           ip32_defconfig
sh                        dreamcast_defconfig
m68k                        stmark2_defconfig
m68k                        m5407c3_defconfig
parisc                generic-64bit_defconfig
arm                             ezx_defconfig
h8300                            allyesconfig
sh                           se7722_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                 mpc834x_mds_defconfig
arm                            mps2_defconfig
arc                     haps_hs_smp_defconfig
m68k                         apollo_defconfig
powerpc                  storcenter_defconfig
arm                         assabet_defconfig
sh                          landisk_defconfig
arm                         cm_x300_defconfig
arm                          pxa3xx_defconfig
powerpc                     tqm8548_defconfig
m68k                        mvme16x_defconfig
mips                       bmips_be_defconfig
sh                          polaris_defconfig
arm                           h3600_defconfig
powerpc                 mpc834x_itx_defconfig
nds32                             allnoconfig
powerpc                      arches_defconfig
mips                           ci20_defconfig
m68k                          hp300_defconfig
arm                       omap2plus_defconfig
x86_64                           alldefconfig
powerpc                     tqm8555_defconfig
nds32                               defconfig
arm                        realview_defconfig
m68k                        mvme147_defconfig
powerpc                     tqm8541_defconfig
alpha                            alldefconfig
powerpc                    adder875_defconfig
mips                      fuloong2e_defconfig
xtensa                              defconfig
sh                      rts7751r2d1_defconfig
powerpc                   motionpro_defconfig
sh                        edosk7760_defconfig
arm                       aspeed_g5_defconfig
arm                           viper_defconfig
arm                         axm55xx_defconfig
sh                                  defconfig
arm                          gemini_defconfig
powerpc                 linkstation_defconfig
arm                         vf610m4_defconfig
ia64                            zx1_defconfig
arm                        clps711x_defconfig
sh                          rsk7264_defconfig
sh                           se7619_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                  randconfig-c002-20220213
arm                  randconfig-c002-20220211
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
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
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220212
arc                  randconfig-r043-20220211
arc                  randconfig-r043-20220212
s390                 randconfig-r044-20220212
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220211
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220211
arm                  randconfig-c002-20220211
i386                          randconfig-c001
mips                 randconfig-c004-20220211
riscv                randconfig-c006-20220213
powerpc              randconfig-c003-20220213
arm                  randconfig-c002-20220213
mips                 randconfig-c004-20220213
powerpc                   bluestone_defconfig
arm                          pcm027_defconfig
hexagon                          alldefconfig
arm                        neponset_defconfig
arm                      tct_hammer_defconfig
powerpc                      ppc64e_defconfig
mips                       lemote2f_defconfig
powerpc                     mpc512x_defconfig
arm                         bcm2835_defconfig
arm                         s3c2410_defconfig
arm                     am200epdkit_defconfig
powerpc                     ksi8560_defconfig
powerpc                      katmai_defconfig
powerpc                      ppc44x_defconfig
powerpc                       ebony_defconfig
powerpc                     kmeter1_defconfig
mips                   sb1250_swarm_defconfig
powerpc                     pseries_defconfig
arm                         palmz72_defconfig
riscv                             allnoconfig
mips                           ip27_defconfig
mips                          ath79_defconfig
arm                              alldefconfig
powerpc                     tqm5200_defconfig
powerpc                 mpc832x_mds_defconfig
arm                          imote2_defconfig
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
hexagon              randconfig-r045-20220213
hexagon              randconfig-r041-20220213
riscv                randconfig-r042-20220213
s390                 randconfig-r044-20220213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

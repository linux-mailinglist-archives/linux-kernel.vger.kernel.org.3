Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B3852754E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 06:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiEOENG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 00:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiEOENC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 00:13:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141082458E
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 21:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652587981; x=1684123981;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nv3c4KkgFEq3HID+noa3U99qbDeu6C5aTmNW1QGKyOM=;
  b=UuSH6wSemNi+Rhn/U03iS7t9cjyoFWCWYBBOZTCgGNzE3krIsLqX6mn5
   FPfvTuqLnrd5wmXOtiqMU9JYdTslU7TGPOU1uS7zVVtEKxlQGYZPXXQGd
   r04U1Rqb+N8Y5e438RzPI9FI9n67Dv6NoTB7yJE7g8FX/INnF4drWxXu9
   0KK1eCMMGlsdOg05SrsL9UysX4R82YJlxZakEv+qhhJQWFYUShcKeURqW
   i5X7NS3FT6yOnYzAKpDY6/9uSvKYAF/0f5PHTBsiK8A2Pov/dai09xPqk
   DyJ5FEsCB8UUaquoD0soxQBUsQISylFHP2lDsVWqpU14uT9WtOUYBr9vj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10347"; a="269418677"
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="269418677"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 21:13:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="699047155"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 May 2022 21:12:58 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nq5cn-0001Hp-92;
        Sun, 15 May 2022 04:12:57 +0000
Date:   Sun, 15 May 2022 12:12:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/merge] BUILD SUCCESS
 a1df7cc57786ff8ec72f7a19a3d0fe305cf7e1a1
Message-ID: <62807dc3.VZdnCC07O/FgRA+1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/merge
branch HEAD: a1df7cc57786ff8ec72f7a19a3d0fe305cf7e1a1  Merge branch 'objtool/core' into x86/merge, to resolve conflicts

elapsed time: 12641m

configs tested: 229
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
m68k                             allmodconfig
xtensa                       common_defconfig
arm                      jornada720_defconfig
arm                        multi_v7_defconfig
powerpc                      mgcoge_defconfig
xtensa                    smp_lx200_defconfig
ia64                      gensparse_defconfig
m68k                       m5249evb_defconfig
m68k                       m5475evb_defconfig
arm                            pleb_defconfig
mips                          rb532_defconfig
riscv                               defconfig
powerpc                     sequoia_defconfig
arc                          axs103_defconfig
sh                          landisk_defconfig
csky                                defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7705_defconfig
s390                       zfcpdump_defconfig
m68k                           sun3_defconfig
arm                          exynos_defconfig
sh                         ap325rxa_defconfig
x86_64                              defconfig
powerpc                     ep8248e_defconfig
sh                             espt_defconfig
arm                       multi_v4t_defconfig
arm                             ezx_defconfig
arm                        mini2440_defconfig
sh                   sh7724_generic_defconfig
xtensa                              defconfig
arm                           sama5_defconfig
mips                           jazz_defconfig
um                               alldefconfig
openrisc                    or1ksim_defconfig
m68k                          hp300_defconfig
sparc                       sparc64_defconfig
sh                          polaris_defconfig
h8300                            allyesconfig
powerpc                     rainier_defconfig
arm                     eseries_pxa_defconfig
powerpc                  storcenter_defconfig
sh                               allmodconfig
arm                           viper_defconfig
arm                         lubbock_defconfig
sh                           se7343_defconfig
parisc                generic-32bit_defconfig
alpha                               defconfig
powerpc                      pasemi_defconfig
mips                           ci20_defconfig
mips                         bigsur_defconfig
sh                   rts7751r2dplus_defconfig
m68k                       m5208evb_defconfig
powerpc                         wii_defconfig
mips                      fuloong2e_defconfig
powerpc                      ep88xc_defconfig
sh                          rsk7269_defconfig
alpha                            alldefconfig
m68k                        m5307c3_defconfig
arm                      integrator_defconfig
nios2                         10m50_defconfig
arm                          gemini_defconfig
arm                        clps711x_defconfig
powerpc                      pcm030_defconfig
arm                            zeus_defconfig
powerpc                       holly_defconfig
m68k                          sun3x_defconfig
powerpc                      chrp32_defconfig
sh                          kfr2r09_defconfig
powerpc                    adder875_defconfig
sparc64                             defconfig
nios2                            allyesconfig
arm                           sunxi_defconfig
sh                        apsh4ad0a_defconfig
powerpc                     redwood_defconfig
powerpc                      cm5200_defconfig
sh                          lboxre2_defconfig
powerpc                      ppc6xx_defconfig
mips                 decstation_r4k_defconfig
arc                           tb10x_defconfig
sh                          sdk7786_defconfig
arm                         lpc18xx_defconfig
arm                         s3c6400_defconfig
arm                         cm_x300_defconfig
arm                             rpc_defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                        stmark2_defconfig
nios2                            alldefconfig
arm                       imx_v6_v7_defconfig
openrisc                 simple_smp_defconfig
powerpc                       eiger_defconfig
mips                        bcm47xx_defconfig
arm                        cerfcube_defconfig
m68k                          multi_defconfig
mips                        vocore2_defconfig
m68k                         amcore_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                          amiga_defconfig
parisc                generic-64bit_defconfig
i386                                defconfig
sparc                               defconfig
sh                        dreamcast_defconfig
powerpc                     pq2fads_defconfig
um                             i386_defconfig
arm                        mvebu_v7_defconfig
sh                     magicpanelr2_defconfig
powerpc                      tqm8xx_defconfig
arm                         at91_dt_defconfig
arc                        nsimosci_defconfig
sh                 kfr2r09-romimage_defconfig
mips                            ar7_defconfig
arc                    vdk_hs38_smp_defconfig
arm                       omap2plus_defconfig
sh                           se7750_defconfig
powerpc                      arches_defconfig
powerpc                     tqm8555_defconfig
arm                       aspeed_g5_defconfig
powerpc                     asp8347_defconfig
arc                              alldefconfig
powerpc                 mpc85xx_cds_defconfig
mips                  maltasmvp_eva_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220506
arm                  randconfig-c002-20220508
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
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
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220507
s390                 randconfig-r044-20220507
riscv                randconfig-r042-20220507
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220506
riscv                randconfig-c006-20220506
mips                 randconfig-c004-20220506
arm                  randconfig-c002-20220506
s390                 randconfig-c005-20220506
powerpc              randconfig-c003-20220508
riscv                randconfig-c006-20220508
mips                 randconfig-c004-20220508
arm                  randconfig-c002-20220508
powerpc              randconfig-c003-20220507
riscv                randconfig-c006-20220507
mips                 randconfig-c004-20220507
arm                  randconfig-c002-20220507
arm                           omap1_defconfig
arm                          moxart_defconfig
arm                          collie_defconfig
mips                         tb0219_defconfig
powerpc                     mpc5200_defconfig
arm                       cns3420vb_defconfig
i386                             allyesconfig
powerpc                     ksi8560_defconfig
mips                          ath25_defconfig
mips                           rs90_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc8560_ads_defconfig
hexagon                             defconfig
arm                            mmp2_defconfig
arm                     davinci_all_defconfig
arm                            dove_defconfig
arm                         lpc32xx_defconfig
arm                          ixp4xx_defconfig
mips                   sb1250_swarm_defconfig
arm                           spitz_defconfig
arm                       aspeed_g4_defconfig
powerpc                   lite5200b_defconfig
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
hexagon              randconfig-r045-20220506
riscv                randconfig-r042-20220506
hexagon              randconfig-r041-20220506

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

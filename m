Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751145A094A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbiHYG5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbiHYG5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:57:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72205A1A6C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661410650; x=1692946650;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lE3/OA431JWZBQm6hZRS2QninmL5R3AuF/0DvRo5AW0=;
  b=XOkZ2xVuwk2k/1vKprJgVLDiY+rHLYCpCArMeNrmK1J/EpMV0VoWW2t8
   FylRtO1J+gfGRfN3hgwC7tl2YcXfEnt6+AuIWIMnFFMjWrUfM3x66L4td
   Nqlr6PqaDrSpzzzfxY2j2NkJNakahjWABEh+9a103FO60aVJ2BPy+0piT
   TCMiI3EaZf8bBhRakqHNnhh35hkbJhwGfXlwDeDu2WPZmLngDHBvMFJ5v
   vOADBQh4mt8uOnUZeOGieCEUxCuhhR898bZm5D1BeZqUKEUIN2hNtZP+U
   a0q2PEy8QojvRXoOeiA4suTcFyH9M3giR0e9ItJY7QmCMxMctwO48elLG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="291732235"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="291732235"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 23:57:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="610058313"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 24 Aug 2022 23:57:28 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oR6nw-0001pn-0T;
        Thu, 25 Aug 2022 06:57:28 +0000
Date:   Thu, 25 Aug 2022 14:57:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 c926087eb38520b268515ae1a842db6db62554cc
Message-ID: <63071d54.f5cd0e7M0HgDOxf4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: c926087eb38520b268515ae1a842db6db62554cc  x86/mm: Print likely CPU at segfault time

elapsed time: 1181m

configs tested: 163
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
sh                               allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20220824
s390                 randconfig-r044-20220824
x86_64                        randconfig-a002
riscv                randconfig-r042-20220824
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                              defconfig
i386                             allyesconfig
x86_64                               rhel-8.3
loongarch                           defconfig
loongarch                         allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
m68k                             allmodconfig
x86_64                           allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arc                              allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                       omap2plus_defconfig
arc                          axs101_defconfig
arc                         haps_hs_defconfig
alpha                            allyesconfig
m68k                             allyesconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
sh                          kfr2r09_defconfig
xtensa                          iss_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                             allnoconfig
microblaze                          defconfig
m68k                        mvme16x_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
sh                        sh7763rdp_defconfig
m68k                          multi_defconfig
arc                      axs103_smp_defconfig
m68k                            mac_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arc                        nsim_700_defconfig
sh                   sh7770_generic_defconfig
arm                          gemini_defconfig
arm                            lart_defconfig
m68k                       m5249evb_defconfig
sh                             espt_defconfig
arm64                               defconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
i386                          randconfig-c001
m68k                            q40_defconfig
ia64                        generic_defconfig
sh                             shx3_defconfig
arc                     nsimosci_hs_defconfig
um                                  defconfig
microblaze                      mmu_defconfig
arm                        realview_defconfig
sh                          r7780mp_defconfig
sh                        edosk7760_defconfig
sh                           se7751_defconfig
powerpc                      arches_defconfig
m68k                        stmark2_defconfig
ia64                          tiger_defconfig
sh                           se7721_defconfig
powerpc                      pcm030_defconfig
arc                    vdk_hs38_smp_defconfig
arm                            zeus_defconfig
s390                          debug_defconfig
ia64                            zx1_defconfig
sh                          rsk7269_defconfig
xtensa                         virt_defconfig
sh                   sh7724_generic_defconfig
powerpc                      makalu_defconfig
arm                            pleb_defconfig
mips                        bcm47xx_defconfig
csky                             alldefconfig
ia64                      gensparse_defconfig
arm                      integrator_defconfig
sh                         apsh4a3a_defconfig
sh                           se7722_defconfig
arm                           viper_defconfig
sh                   secureedge5410_defconfig
sh                         ap325rxa_defconfig
xtensa                    smp_lx200_defconfig
sh                      rts7751r2d1_defconfig
ia64                             allmodconfig
sh                            titan_defconfig
mips                         cobalt_defconfig
powerpc                      tqm8xx_defconfig
mips                    maltaup_xpa_defconfig
sh                         ecovec24_defconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220824
hexagon              randconfig-r045-20220824
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
mips                     cu1000-neo_defconfig
powerpc                    gamecube_defconfig
hexagon              randconfig-r045-20220823
riscv                randconfig-r042-20220823
hexagon              randconfig-r041-20220823
s390                 randconfig-r044-20220823
mips                     decstation_defconfig
mips                           ci20_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-k001
riscv                            alldefconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     tqm8540_defconfig
arm                      pxa255-idp_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

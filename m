Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F7B5368C5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 00:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354670AbiE0WZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 18:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347838AbiE0WZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 18:25:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204D43EB96
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 15:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653690336; x=1685226336;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dUR1PVCRBUeXcmUnx30IpXtiF/6cUmL+c2fNK9cPJqA=;
  b=giW43ja3ddJ5b8ET4DB/DzwjNS5zE8s5+ToHYjcxFdXESCsipf79mukO
   r+01dpIch6rHqzZAHVxoWqQ5vXJPFE+nDwWe93LGOFqnbnSuc6BEkdxDN
   6XbKE/JE9ZE48zzmkzHWmRthpQtQdq2RiWGca/96BCJeVNZI6YmqbXn0K
   b+PHeRqHe32V8pRS3/4GbYx769NlJx1oftzBkx6Lse+5laFNKoZoWRte9
   KNRcA7+y/s486hLtbHJ7iQHiLJbZrNZIlYOx7A1AoX/poD028eb72th9U
   +sxZI+TzZrPbl/Hhh6+idkxUkrfZhs1aAwRxQL/93t92BgNbvEkHSegs8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="262208295"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="262208295"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 15:25:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="604132696"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2022 15:25:34 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuiOj-0005BI-D2;
        Fri, 27 May 2022 22:25:33 +0000
Date:   Sat, 28 May 2022 06:24:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 f7081834b2d5bbc77d67073d8ab490bfeaf3c13b
Message-ID: <62914faf.N9nWrglpxPP6P8Q8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: f7081834b2d5bbc77d67073d8ab490bfeaf3c13b  x86: Fix all occurences of the "the the" typo

elapsed time: 722m

configs tested: 166
configs skipped: 90

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                      pcm030_defconfig
mips                         db1xxx_defconfig
sh                          polaris_defconfig
arm                         assabet_defconfig
arm                            mps2_defconfig
m68k                          sun3x_defconfig
powerpc                      ppc6xx_defconfig
arm                       multi_v4t_defconfig
powerpc64                           defconfig
um                                  defconfig
sh                               alldefconfig
arm                           sama5_defconfig
arm                           imxrt_defconfig
parisc                           alldefconfig
arm                         vf610m4_defconfig
sh                             sh03_defconfig
xtensa                           alldefconfig
arc                     haps_hs_smp_defconfig
powerpc                 mpc8540_ads_defconfig
sh                            hp6xx_defconfig
mips                 decstation_r4k_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     tqm8555_defconfig
sh                            shmin_defconfig
arm                           u8500_defconfig
sh                           se7712_defconfig
powerpc                     ep8248e_defconfig
sh                          sdk7786_defconfig
xtensa                  cadence_csp_defconfig
sh                          kfr2r09_defconfig
ia64                                defconfig
sparc                       sparc32_defconfig
arm                            pleb_defconfig
powerpc                     asp8347_defconfig
powerpc                    adder875_defconfig
sh                          r7780mp_defconfig
m68k                          atari_defconfig
arm                     eseries_pxa_defconfig
sparc                       sparc64_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7343_defconfig
microblaze                          defconfig
m68k                          multi_defconfig
arm                          pxa910_defconfig
arc                      axs103_smp_defconfig
sh                           se7780_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                     magicpanelr2_defconfig
sh                   sh7724_generic_defconfig
arm                      footbridge_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                           sh2007_defconfig
sh                         microdev_defconfig
s390                       zfcpdump_defconfig
arm                        trizeps4_defconfig
arm                        shmobile_defconfig
nios2                         10m50_defconfig
arm                          lpd270_defconfig
arm                  randconfig-c002-20220526
arm                  randconfig-c002-20220524
x86_64                        randconfig-c001
ia64                             allmodconfig
ia64                             allyesconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
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
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220524
s390                 randconfig-r044-20220524
riscv                randconfig-r042-20220524
arc                  randconfig-r043-20220527
arc                  randconfig-r043-20220526
s390                 randconfig-r044-20220526
riscv                randconfig-r042-20220526
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                  randconfig-c002-20220524
x86_64                        randconfig-c007
s390                 randconfig-c005-20220524
i386                          randconfig-c001
powerpc              randconfig-c003-20220524
riscv                randconfig-c006-20220524
mips                 randconfig-c004-20220524
mips                     loongson2k_defconfig
mips                          malta_defconfig
mips                      pic32mzda_defconfig
powerpc                       ebony_defconfig
mips                           ip28_defconfig
arm                        mvebu_v5_defconfig
mips                  cavium_octeon_defconfig
mips                           ip22_defconfig
arm                     am200epdkit_defconfig
powerpc                          allyesconfig
powerpc                    mvme5100_defconfig
arm                      pxa255-idp_defconfig
arm                       aspeed_g4_defconfig
mips                     cu1830-neo_defconfig
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
hexagon              randconfig-r045-20220527
hexagon              randconfig-r041-20220527
s390                 randconfig-r044-20220527
riscv                randconfig-r042-20220527

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

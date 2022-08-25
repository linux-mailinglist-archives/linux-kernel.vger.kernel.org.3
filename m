Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDD05A082B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 06:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiHYEp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 00:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiHYEpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 00:45:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1518474CD
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 21:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661402720; x=1692938720;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Ug28xR625inIu0iyurVHOWjwxNl7V0YoxkMvmuIfSu4=;
  b=PZsQuBSnRZL0ihAkt6OmepT4v40D0yFc5NavoD4gGcRLGY7mTQhpWnAy
   vwyvHTuHLGfCiAlswTvtLsSxnDwkXiU1z3fZG7ZJ16/gcd8CKHF9FKC9x
   fTircKfhleWQBuanDzFgVVGcLr/GLzWq3ov3pjvvUloYoLnX7Ov6/S6jK
   gwQA4Sc8OAHJ2i8RLhlktfEhm3bzWAzfMW0TnROYXlRvbord0Tv2BABH8
   sLD5KEjTXyzno4vmIS/pUh0NN1dGb4qqmoaWPdFc951DQf65OPFIerO3K
   lzAnc+CFx7OWG6suX1hMH3wFepsjcOMGK37fN48BCkV8NWRdprVyt0YJt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="295423027"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="295423027"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 21:45:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="639423363"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2022 21:45:19 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oR4k2-0001ih-2G;
        Thu, 25 Aug 2022 04:45:18 +0000
Date:   Thu, 25 Aug 2022 12:44:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/6.0-rc2-fam1-uapi] BUILD SUCCESS
 3faef920937a9ef7437e3d82bb991baef94bd23a
Message-ID: <6306fe2a.mfPT6SivNxJ2+cUb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/6.0-rc2-fam1-uapi
branch HEAD: 3faef920937a9ef7437e3d82bb991baef94bd23a  ipv6: ioam: Replace zero-length array with flexible-array member

elapsed time: 1604m

configs tested: 177
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                              allyesconfig
x86_64                        randconfig-a004
alpha                            allyesconfig
x86_64                        randconfig-a002
m68k                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allmodconfig
loongarch                           defconfig
loongarch                         allnoconfig
x86_64                        randconfig-a006
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arc                  randconfig-r043-20220823
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                             allyesconfig
i386                                defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                        m5272c3_defconfig
m68k                          atari_defconfig
sh                          sdk7786_defconfig
powerpc                    klondike_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
sh                             shx3_defconfig
powerpc                      tqm8xx_defconfig
m68k                        stmark2_defconfig
sh                        sh7763rdp_defconfig
m68k                          multi_defconfig
arc                      axs103_smp_defconfig
m68k                            mac_defconfig
arm                       omap2plus_defconfig
arc                          axs101_defconfig
arc                         haps_hs_defconfig
i386                          randconfig-c001
sh                          kfr2r09_defconfig
xtensa                          iss_defconfig
arm64                               defconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
sparc                             allnoconfig
microblaze                          defconfig
m68k                        mvme16x_defconfig
m68k                         apollo_defconfig
arm                        shmobile_defconfig
parisc64                         alldefconfig
arm                            hisi_defconfig
ia64                          tiger_defconfig
mips                      loongson3_defconfig
arm                             rpc_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arc                        nsim_700_defconfig
sh                   sh7770_generic_defconfig
arm                          gemini_defconfig
arm                            lart_defconfig
m68k                       m5249evb_defconfig
sh                             espt_defconfig
m68k                            q40_defconfig
ia64                        generic_defconfig
arc                     nsimosci_hs_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220824
um                                  defconfig
microblaze                      mmu_defconfig
arm                        realview_defconfig
sh                          r7780mp_defconfig
sh                        edosk7760_defconfig
sh                           se7751_defconfig
powerpc                      arches_defconfig
ia64                             allmodconfig
arm                            zeus_defconfig
s390                          debug_defconfig
ia64                            zx1_defconfig
sh                           se7721_defconfig
powerpc                      pcm030_defconfig
arc                    vdk_hs38_smp_defconfig
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
riscv                randconfig-r042-20220824
s390                 randconfig-r044-20220824
arc                  randconfig-r043-20220824
sh                   secureedge5410_defconfig
sh                         ap325rxa_defconfig
xtensa                    smp_lx200_defconfig
sh                      rts7751r2d1_defconfig
sh                            titan_defconfig
mips                         cobalt_defconfig
mips                    maltaup_xpa_defconfig
sh                         ecovec24_defconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20220823
hexagon              randconfig-r045-20220823
hexagon              randconfig-r045-20220824
hexagon              randconfig-r041-20220824
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
riscv                randconfig-r042-20220823
s390                 randconfig-r044-20220823
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
mips                     loongson1c_defconfig
powerpc                     ppa8548_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                          g5_defconfig
mips                     cu1000-neo_defconfig
powerpc                    gamecube_defconfig
mips                     decstation_defconfig
mips                           ci20_defconfig
riscv                            alldefconfig
powerpc                      ppc64e_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     tqm8540_defconfig
arm                      pxa255-idp_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

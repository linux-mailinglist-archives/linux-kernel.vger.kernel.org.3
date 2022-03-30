Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632784EC7B3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347776AbiC3PGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344203AbiC3PF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:05:58 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF63D7486A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648652653; x=1680188653;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hnvBsEONxsWdtbMyImEAX0aPZ7hBYblaDL0xJ34iUQM=;
  b=Mfu+yQ3jYakrQZUq4jBUyZ60VkiBORtXEFU1hK46XZ9tnujHaTNktVmF
   PcugZjcgnynkGIxUQqbOtAlsG4kTVlALbEyws9uxkbvkglcir2U0euHm1
   ZWEqa23z0aN0Q/o3orAm1Eb3k6XoXAC1AOww3j4OfGro71Tq5ZllRO5jP
   c/F3Saw3TMemPYRu+airzJvqnqIdnPlTnMhBkCUBJV2882EkwyGC6qlaF
   VyRtM6GqR97JN39A79lvUZ1SUd6EhfO94LF/0KGruVwAmtPeH8InqRv3d
   CG9CF/8RuX7LIaWk01yJEyKpYzjpedQkDwrR3hxegEyB3XOnETV1zo+Q4
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="320263767"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="320263767"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 08:04:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="653863559"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 30 Mar 2022 08:04:11 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZZrm-00006e-UR;
        Wed, 30 Mar 2022 15:04:10 +0000
Date:   Wed, 30 Mar 2022 23:04:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp-misc] BUILD SUCCESS
 ab06f022628cc9c7012a3ffe35f46ec6b67d0752
Message-ID: <62447162.UcksGMSEH4tOc4b7%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp-misc
branch HEAD: ab06f022628cc9c7012a3ffe35f46ec6b67d0752  virt: acrn: Prefer array_size and struct_size over open coded arithmetic

elapsed time: 6520m

configs tested: 228
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                            q40_defconfig
sh                          r7780mp_defconfig
arm                           h3600_defconfig
ia64                            zx1_defconfig
sh                                  defconfig
sh                 kfr2r09-romimage_defconfig
m68k                       m5275evb_defconfig
i386                                defconfig
arm                         assabet_defconfig
powerpc                      tqm8xx_defconfig
sh                           se7722_defconfig
powerpc                     asp8347_defconfig
sh                             shx3_defconfig
arc                        nsim_700_defconfig
arm                      footbridge_defconfig
arm                       multi_v4t_defconfig
sh                           se7619_defconfig
powerpc                    amigaone_defconfig
arm                            hisi_defconfig
powerpc                    klondike_defconfig
m68k                          atari_defconfig
ia64                        generic_defconfig
m68k                                defconfig
sh                               allmodconfig
powerpc                   motionpro_defconfig
arc                      axs103_smp_defconfig
arm                      integrator_defconfig
s390                          debug_defconfig
arm                          pxa3xx_defconfig
powerpc                 mpc8540_ads_defconfig
sh                            shmin_defconfig
alpha                            alldefconfig
sh                           se7724_defconfig
m68k                       m5208evb_defconfig
powerpc                       holly_defconfig
openrisc                            defconfig
mips                  decstation_64_defconfig
powerpc                  iss476-smp_defconfig
sh                      rts7751r2d1_defconfig
m68k                         apollo_defconfig
ia64                                defconfig
parisc64                            defconfig
arm                         at91_dt_defconfig
arm                        mini2440_defconfig
x86_64                              defconfig
nios2                         10m50_defconfig
sparc                            alldefconfig
arm                           sunxi_defconfig
openrisc                  or1klitex_defconfig
mips                            ar7_defconfig
csky                             alldefconfig
powerpc                     taishan_defconfig
powerpc64                           defconfig
arm                          lpd270_defconfig
powerpc                       maple_defconfig
m68k                       m5475evb_defconfig
m68k                       m5249evb_defconfig
powerpc                      ep88xc_defconfig
mips                  maltasmvp_eva_defconfig
arm                           tegra_defconfig
openrisc                    or1ksim_defconfig
arm                        multi_v7_defconfig
arm                           u8500_defconfig
nios2                               defconfig
sh                         microdev_defconfig
xtensa                           allyesconfig
arm                     eseries_pxa_defconfig
m68k                        m5272c3_defconfig
powerpc                      makalu_defconfig
arc                        nsimosci_defconfig
sh                          polaris_defconfig
arm64                            alldefconfig
arc                    vdk_hs38_smp_defconfig
mips                         mpc30x_defconfig
powerpc                      chrp32_defconfig
m68k                        mvme16x_defconfig
arm                           h5000_defconfig
arm                            qcom_defconfig
arm                         s3c6400_defconfig
sh                           se7343_defconfig
h8300                            alldefconfig
m68k                            mac_defconfig
arc                         haps_hs_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc64                        alldefconfig
mips                     loongson1b_defconfig
powerpc                      bamboo_defconfig
sh                   sh7770_generic_defconfig
m68k                        mvme147_defconfig
s390                                defconfig
xtensa                    xip_kc705_defconfig
arm                       aspeed_g5_defconfig
sh                          kfr2r09_defconfig
arm                            lart_defconfig
powerpc                      ppc6xx_defconfig
sh                        apsh4ad0a_defconfig
arm                          simpad_defconfig
powerpc                           allnoconfig
mips                       bmips_be_defconfig
xtensa                              defconfig
powerpc                      arches_defconfig
sh                     magicpanelr2_defconfig
arc                                 defconfig
sh                             sh03_defconfig
arc                          axs101_defconfig
arm                        mvebu_v7_defconfig
parisc64                         alldefconfig
openrisc                 simple_smp_defconfig
sh                               j2_defconfig
mips                           gcw0_defconfig
parisc                              defconfig
m68k                          multi_defconfig
powerpc                     tqm8541_defconfig
arm                          gemini_defconfig
s390                             allyesconfig
mips                         rt305x_defconfig
powerpc                     pq2fads_defconfig
sh                         ecovec24_defconfig
m68k                             allyesconfig
arm                  randconfig-c002-20220324
arm                  randconfig-c002-20220325
arm                  randconfig-c002-20220327
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
riscv                randconfig-r042-20220325
s390                 randconfig-r044-20220325
arc                  randconfig-r043-20220325
arc                  randconfig-r043-20220324
riscv                randconfig-r042-20220327
s390                 randconfig-r044-20220327
arc                  randconfig-r043-20220327
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
mips                 randconfig-c004-20220324
arm                  randconfig-c002-20220324
riscv                randconfig-c006-20220324
powerpc              randconfig-c003-20220324
i386                          randconfig-c001
mips                 randconfig-c004-20220327
arm                  randconfig-c002-20220327
riscv                randconfig-c006-20220327
powerpc              randconfig-c003-20220327
arm                         s3c2410_defconfig
arm                  colibri_pxa300_defconfig
powerpc                      acadia_defconfig
powerpc                     ppa8548_defconfig
arm                          imote2_defconfig
arm                  colibri_pxa270_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                          allmodconfig
arm                          collie_defconfig
powerpc                    ge_imp3a_defconfig
arm                             mxs_defconfig
powerpc                   microwatt_defconfig
arm                          ixp4xx_defconfig
powerpc                      ppc64e_defconfig
hexagon                             defconfig
mips                        bcm63xx_defconfig
powerpc                      pmac32_defconfig
arm                         socfpga_defconfig
arm                        spear3xx_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220324
hexagon              randconfig-r041-20220325
hexagon              randconfig-r041-20220324
s390                 randconfig-r044-20220324
riscv                randconfig-r042-20220324
hexagon              randconfig-r045-20220325
riscv                randconfig-r042-20220326
hexagon              randconfig-r045-20220326
hexagon              randconfig-r041-20220326

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

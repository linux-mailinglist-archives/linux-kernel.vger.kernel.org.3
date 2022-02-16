Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3CA4B846A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiBPJax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:30:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiBPJaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:30:46 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0E8257DF3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645003834; x=1676539834;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=f9Zw4PRz52asxS3RXsHB9BksAGVHXvmDEELRBTdqXzM=;
  b=MpnfJY7d+mN4bMCssZguM5U8vbbCXUi3sMf/qzihc4+M6c6/+jupJSp4
   iCnL3Hx8DlWz5i6fnlolrEdbKFPXutxmYWxVJdrLPdsQGi23WT2nQXZRJ
   +kzAIW5YBIY6HFSzygFP6Buymun9RQYoNofOpw3+ZHxmpCxqhO8q+lEYD
   ZxBUXMgU8JGCQ9zclGbowo7JGPQSaEqzMJNb1OrMI57BxLLQasqN3PKQe
   11rMXvkInk87u7fm9007aJNfCKZW7pBIbLZ7jMxrNSuCGDTOxjLBwdEYL
   3Irr4l8D4MojWUmN+i2S4Ycevgs+WWTWt6AA4s5NTHL/lNoQ2ekGDxu8D
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="234100587"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="234100587"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 01:30:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="498608894"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Feb 2022 01:30:32 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKGdr-000Aen-Ix; Wed, 16 Feb 2022 09:30:31 +0000
Date:   Wed, 16 Feb 2022 17:29:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp-fam0-wireless] BUILD SUCCESS
 c82fb559af1a8569d449357f4a04cebfec84df1a
Message-ID: <620cc405.GPmWx90khPLA/p00%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp-fam0-wireless
branch HEAD: c82fb559af1a8569d449357f4a04cebfec84df1a  tw89: core.h: Replace zero-length array with flexible-array member

elapsed time: 733m

configs tested: 197
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
i386                 randconfig-c001-20220214
mips                 randconfig-c004-20220216
sh                 kfr2r09-romimage_defconfig
mips                        jmr3927_defconfig
m68k                            mac_defconfig
sh                           se7751_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                      fuloong2e_defconfig
sh                        sh7763rdp_defconfig
arm                        realview_defconfig
csky                                defconfig
arm                          iop32x_defconfig
arm                          simpad_defconfig
m68k                       m5208evb_defconfig
arm                            hisi_defconfig
sh                        edosk7705_defconfig
sh                          lboxre2_defconfig
arm                           corgi_defconfig
arc                      axs103_smp_defconfig
xtensa                           alldefconfig
microblaze                      mmu_defconfig
arm                       omap2plus_defconfig
arm                        shmobile_defconfig
sh                             espt_defconfig
nios2                               defconfig
arm                        spear6xx_defconfig
mips                         mpc30x_defconfig
powerpc                     mpc83xx_defconfig
m68k                       m5475evb_defconfig
arc                         haps_hs_defconfig
xtensa                  nommu_kc705_defconfig
sh                             sh03_defconfig
arm                            lart_defconfig
mips                          rb532_defconfig
arm                          badge4_defconfig
sh                           se7750_defconfig
arm                           stm32_defconfig
arm                      integrator_defconfig
arm                           sunxi_defconfig
arm                         cm_x300_defconfig
powerpc                      pcm030_defconfig
ia64                          tiger_defconfig
arc                              alldefconfig
mips                  decstation_64_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      arches_defconfig
arm                          pxa910_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                                  defconfig
arm                          gemini_defconfig
powerpc                     pq2fads_defconfig
arm                           u8500_defconfig
powerpc                     taishan_defconfig
arm                        oxnas_v6_defconfig
parisc                           alldefconfig
arm                           h5000_defconfig
mips                        bcm47xx_defconfig
sh                          kfr2r09_defconfig
arm                            xcep_defconfig
m68k                        stmark2_defconfig
s390                                defconfig
m68k                             alldefconfig
arm                       aspeed_g5_defconfig
arm                           viper_defconfig
arm                            mps2_defconfig
arm                      jornada720_defconfig
openrisc                  or1klitex_defconfig
powerpc                        warp_defconfig
arm                        keystone_defconfig
powerpc                        cell_defconfig
arm                         at91_dt_defconfig
powerpc                    klondike_defconfig
h8300                               defconfig
i386                             alldefconfig
sh                           se7724_defconfig
sh                        edosk7760_defconfig
mips                       capcella_defconfig
arm                        cerfcube_defconfig
mips                      loongson3_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                        mvme16x_defconfig
mips                            gpr_defconfig
powerpc                  iss476-smp_defconfig
arm                  randconfig-c002-20220214
arm                  randconfig-c002-20220216
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
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
x86_64               randconfig-a013-20220214
x86_64               randconfig-a014-20220214
x86_64               randconfig-a012-20220214
x86_64               randconfig-a015-20220214
x86_64               randconfig-a011-20220214
x86_64               randconfig-a016-20220214
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                 randconfig-a013-20220214
i386                 randconfig-a016-20220214
i386                 randconfig-a012-20220214
i386                 randconfig-a015-20220214
i386                 randconfig-a011-20220214
i386                 randconfig-a014-20220214
riscv                randconfig-r042-20220214
arc                  randconfig-r043-20220214
s390                 randconfig-r044-20220214
riscv                randconfig-r042-20220216
arc                  randconfig-r043-20220216
s390                 randconfig-r044-20220216
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
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220216
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220216
arm                  randconfig-c002-20220216
i386                          randconfig-c001
mips                 randconfig-c004-20220216
arm                                 defconfig
riscv                    nommu_virt_defconfig
powerpc                       ebony_defconfig
hexagon                             defconfig
powerpc                     tqm8560_defconfig
powerpc                  mpc885_ads_defconfig
x86_64               randconfig-a002-20220214
x86_64               randconfig-a006-20220214
x86_64               randconfig-a005-20220214
x86_64               randconfig-a004-20220214
x86_64               randconfig-a003-20220214
x86_64               randconfig-a001-20220214
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                 randconfig-a004-20220214
i386                 randconfig-a005-20220214
i386                 randconfig-a006-20220214
i386                 randconfig-a002-20220214
i386                 randconfig-a003-20220214
i386                 randconfig-a001-20220214
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220214
hexagon              randconfig-r041-20220214
hexagon              randconfig-r045-20220216
hexagon              randconfig-r041-20220216

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

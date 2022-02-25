Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DE04C3A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbiBYAuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiBYAuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:50:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C56F253BD2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645750180; x=1677286180;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FJkWpe2vJu4GuhQvBWNNCbVvcTEBLTxo3W/icmMJx2E=;
  b=HadDgEWLJInrUDAwnPCJTnWCAa5A81DNuu9abJ6GiCUlaWAFNcFILO9f
   x5sxcKLmwjrs3QDKkyQ9CUztKh2DlTRH3PCCf59kc7Q2isk0F3tqYnRc2
   K4QS4g9rogo6wiUrfep4NDcajzENVFjjwEdpOixIClAC/MZ3ZNwH3Bvel
   nL2joCurjfdHJyyf9u3YyF3bmYAF2CSq9ikcv0DzcVwou6FH0P7O+En9X
   H/Mpg6EEljfBEQi02oLhivwawEN6+1tXDp+mAeZs3XhIDMkX+oz8e2BaW
   Dh9W4gWhGAobBXAIe4M7Z/KdOcbyPh2HHCJPyFQhpUSr9p0IRP0AGcmQH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252307383"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="252307383"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 16:49:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="533367910"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Feb 2022 16:49:38 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNOni-0003dT-1d; Fri, 25 Feb 2022 00:49:38 +0000
Date:   Fri, 25 Feb 2022 08:49:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cc] BUILD SUCCESS
 1e8c5971c249893ac33ca983c32bafcf5d50c727
Message-ID: <62182793.sR2ekGHif3tGLlq5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cc
branch HEAD: 1e8c5971c249893ac33ca983c32bafcf5d50c727  x86/mm/cpa: Generalize __set_memory_enc_pgtable()

elapsed time: 727m

configs tested: 128
configs skipped: 100

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                 randconfig-c004-20220223
i386                          randconfig-c001
powerpc                    amigaone_defconfig
powerpc                      cm5200_defconfig
powerpc                 mpc837x_mds_defconfig
arm                            zeus_defconfig
powerpc                       maple_defconfig
arm                         axm55xx_defconfig
nios2                            allyesconfig
xtensa                          iss_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                 linkstation_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7780_defconfig
arm                         nhk8815_defconfig
mips                       capcella_defconfig
sh                        sh7785lcr_defconfig
powerpc                      makalu_defconfig
sh                   sh7724_generic_defconfig
arc                     haps_hs_smp_defconfig
powerpc                        cell_defconfig
powerpc                     taishan_defconfig
m68k                        mvme147_defconfig
sh                           se7343_defconfig
arm                           viper_defconfig
sh                   rts7751r2dplus_defconfig
arm                          iop32x_defconfig
powerpc                       eiger_defconfig
arm                          gemini_defconfig
arm                         s3c6400_defconfig
powerpc                     stx_gp3_defconfig
arc                     nsimosci_hs_defconfig
arm                  randconfig-c002-20220224
arm                  randconfig-c002-20220223
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
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
s390                                defconfig
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
i386                          randconfig-a005
i386                          randconfig-a003
i386                          randconfig-a001
s390                 randconfig-r044-20220224
arc                  randconfig-r043-20220224
arc                  randconfig-r043-20220223
riscv                randconfig-r042-20220224
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
powerpc              randconfig-c003-20220224
powerpc              randconfig-c003-20220223
x86_64                        randconfig-c007
arm                  randconfig-c002-20220224
arm                  randconfig-c002-20220223
mips                 randconfig-c004-20220224
mips                 randconfig-c004-20220223
i386                          randconfig-c001
riscv                randconfig-c006-20220223
riscv                randconfig-c006-20220224
mips                      pic32mzda_defconfig
powerpc                    mvme5100_defconfig
riscv                    nommu_virt_defconfig
arm                                 defconfig
arm                         hackkit_defconfig
powerpc                     tqm8560_defconfig
arm                         socfpga_defconfig
mips                           ip22_defconfig
arm                      tct_hammer_defconfig
powerpc                   lite5200b_defconfig
arm                          moxart_defconfig
mips                      bmips_stb_defconfig
arm                            mmp2_defconfig
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

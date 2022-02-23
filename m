Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939554C0FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbiBWJ4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239455AbiBWJz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:55:59 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048FF8A30E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645610127; x=1677146127;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eYlwHPBxui1grAVfhHPVos8YHEU0hltBL5SmdcxOco0=;
  b=Y+KISh+h/OBn8R46zy6NbAjPKxUmizQS+g4q8YJkK2YSLQ3TyrmdzV54
   qn6KzxB/g1K78mUCxSPlg1W7081LyPP1OD1y0InQWtkXF3f7YkwOcDcsG
   Q1PS32LcrUfG69lw/hDZ93/nQVhMBYKgx5ZuO5ighY+2lwwgntfhgNcGW
   Uz9uZFVm7YSOVC7u+37QC2iC6txKeUsyeU5Q13OgDD4FtcZjhyL1ukNDF
   oM+GHJRCqKI8dreM99EXppkheF2IedUMRvfslTydFGE34bq9FyaCA1znu
   4u+H0zORXNN08tDOjdqHPNwL3PuvaYFyp+/FIlwL0qCcglXLasQH73b4W
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="239316698"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="239316698"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 01:55:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="532612252"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Feb 2022 01:55:25 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMoMm-0001Fm-Op; Wed, 23 Feb 2022 09:55:24 +0000
Date:   Wed, 23 Feb 2022 17:54:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/core] BUILD SUCCESS
 0ce055f85335e48bc571114d61a70ae217039362
Message-ID: <62160472.EjJ6AjHbXpsWCDWS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/core
branch HEAD: 0ce055f85335e48bc571114d61a70ae217039362  fork: Use IS_ENABLED() in account_kernel_stack()

elapsed time: 729m

configs tested: 168
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
i386                 randconfig-c001-20220221
mips                            ar7_defconfig
sh                             espt_defconfig
sh                   sh7770_generic_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                     asp8347_defconfig
powerpc                     stx_gp3_defconfig
arc                      axs103_smp_defconfig
arm                            lart_defconfig
ia64                            zx1_defconfig
arm                         nhk8815_defconfig
powerpc                      ep88xc_defconfig
powerpc                         wii_defconfig
powerpc                     sequoia_defconfig
m68k                        m5307c3_defconfig
sparc                               defconfig
mips                         db1xxx_defconfig
arm                          pxa910_defconfig
powerpc                         ps3_defconfig
m68k                       m5475evb_defconfig
m68k                       m5275evb_defconfig
arm                         assabet_defconfig
m68k                             allyesconfig
alpha                            alldefconfig
parisc                              defconfig
sh                            shmin_defconfig
mips                            gpr_defconfig
arc                     haps_hs_smp_defconfig
arm                           stm32_defconfig
um                                  defconfig
arm                           sunxi_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     redwood_defconfig
alpha                               defconfig
powerpc                      makalu_defconfig
m68k                             alldefconfig
powerpc                      ppc6xx_defconfig
sh                          rsk7203_defconfig
mips                         bigsur_defconfig
arm                          badge4_defconfig
arm                       multi_v4t_defconfig
arm                        shmobile_defconfig
x86_64                           alldefconfig
m68k                       bvme6000_defconfig
powerpc                   currituck_defconfig
mips                           ci20_defconfig
arm                       omap2plus_defconfig
arm                           h3600_defconfig
arc                        nsim_700_defconfig
arm                  randconfig-c002-20220221
arm                  randconfig-c002-20220222
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a003-20220221
x86_64               randconfig-a002-20220221
x86_64               randconfig-a005-20220221
x86_64               randconfig-a006-20220221
x86_64               randconfig-a001-20220221
x86_64               randconfig-a004-20220221
i386                 randconfig-a002-20220221
i386                 randconfig-a003-20220221
i386                 randconfig-a001-20220221
i386                 randconfig-a005-20220221
i386                 randconfig-a006-20220221
i386                 randconfig-a004-20220221
arc                  randconfig-r043-20220221
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
powerpc              randconfig-c003-20220222
x86_64                        randconfig-c007
arm                  randconfig-c002-20220222
mips                 randconfig-c004-20220222
i386                          randconfig-c001
riscv                randconfig-c006-20220222
powerpc              randconfig-c003-20220221
x86_64               randconfig-c007-20220221
arm                  randconfig-c002-20220221
mips                 randconfig-c004-20220221
i386                 randconfig-c001-20220221
riscv                randconfig-c006-20220221
powerpc                      katmai_defconfig
arm                          imote2_defconfig
powerpc                  mpc866_ads_defconfig
arm                            dove_defconfig
mips                          ath25_defconfig
mips                          ath79_defconfig
mips                       lemote2f_defconfig
mips                malta_qemu_32r6_defconfig
arm                           omap1_defconfig
arm                      pxa255-idp_defconfig
arm                     am200epdkit_defconfig
arm                          pxa168_defconfig
arm                         s5pv210_defconfig
powerpc                     mpc5200_defconfig
mips                           ip27_defconfig
arm64                            allyesconfig
powerpc                     tqm8540_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a011-20220221
x86_64               randconfig-a015-20220221
x86_64               randconfig-a014-20220221
x86_64               randconfig-a016-20220221
x86_64               randconfig-a013-20220221
x86_64               randconfig-a012-20220221
i386                 randconfig-a016-20220221
i386                 randconfig-a012-20220221
i386                 randconfig-a015-20220221
i386                 randconfig-a011-20220221
i386                 randconfig-a014-20220221
i386                 randconfig-a013-20220221
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220221
hexagon              randconfig-r041-20220221
riscv                randconfig-r042-20220221
s390                 randconfig-r044-20220221

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

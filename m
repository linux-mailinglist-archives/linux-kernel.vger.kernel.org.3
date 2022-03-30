Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52BD4EBD18
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244526AbiC3JCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244522AbiC3JCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:02:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A266E2CE33
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648630829; x=1680166829;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DhQ4z6HXVyNw3WbN+OAFM5ZuUtNhLPLCpTObQ1eGevU=;
  b=EqI24oTktIum0VB9WxsddeQ4WB+fgeqhlX24HXTUeZQbND+BGRJWlJCt
   JafJB4w2MTQBygkxqudjeinrpbOCfM6ktLqgDXyDKmXlepFegSHCey4A5
   iWsVaDPyYsap2DoE+fIf2pDB85kvzCrazJ5gd9orjts15shNWnGY0IQFI
   3PmB1IJKTCUfI3bfomzGR/X932z1SwLkHK5Qr9b545/kXMnomxCKR8/h3
   /aBSVOOjBRLPDXNFXoRUsI+3wizF+plIEeVClWlEMaHVWLL5We10cPzqc
   FXEdBLs30Dew6cAJMUz7715BlOUXQzlxUiHcxUnFq+2omJdW5Lp4KncjI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259674870"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="259674870"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 02:00:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="554588841"
Received: from lkp-server02.sh.intel.com (HELO 7a008980c4ea) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 30 Mar 2022 02:00:17 -0700
Received: from kbuild by 7a008980c4ea with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZUBc-0000BR-Cq; Wed, 30 Mar 2022 09:00:16 +0000
Date:   Wed, 30 Mar 2022 16:59:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 4009a4ac82dd95b8cd2b62bd30019476983f0aff
Message-ID: <62441bf5.2I+ZFoM4osaqgl5s%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 4009a4ac82dd95b8cd2b62bd30019476983f0aff  x86/sev: Unroll string mmio with CC_ATTR_GUEST_UNROLL_STRING_IO

elapsed time: 1015m

configs tested: 185
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                 randconfig-c004-20220329
i386                          randconfig-c001
powerpc              randconfig-c003-20220330
sh                      rts7751r2d1_defconfig
arm                        realview_defconfig
alpha                               defconfig
arm                         assabet_defconfig
arm                         axm55xx_defconfig
sparc                               defconfig
sh                        sh7785lcr_defconfig
xtensa                           allyesconfig
sh                           se7619_defconfig
sh                          lboxre2_defconfig
powerpc                      pasemi_defconfig
arm                       imx_v6_v7_defconfig
parisc64                         alldefconfig
mips                         tb0226_defconfig
h8300                       h8s-sim_defconfig
sh                           se7751_defconfig
sh                            migor_defconfig
arm                      integrator_defconfig
arm                        clps711x_defconfig
arm                            xcep_defconfig
arm                          badge4_defconfig
arm                             pxa_defconfig
ia64                             allmodconfig
arc                                 defconfig
i386                                defconfig
sh                          rsk7203_defconfig
arm                         lubbock_defconfig
riscv             nommu_k210_sdcard_defconfig
sparc                       sparc32_defconfig
m68k                            q40_defconfig
parisc                           alldefconfig
sh                         ecovec24_defconfig
sh                     magicpanelr2_defconfig
s390                          debug_defconfig
sh                           se7722_defconfig
arm                       aspeed_g5_defconfig
alpha                            allyesconfig
powerpc                      ppc40x_defconfig
sh                         ap325rxa_defconfig
arm                            lart_defconfig
arm                          lpd270_defconfig
arm                        cerfcube_defconfig
openrisc                    or1ksim_defconfig
m68k                       m5249evb_defconfig
arm                            qcom_defconfig
mips                         db1xxx_defconfig
sh                          sdk7786_defconfig
powerpc                         wii_defconfig
powerpc                 mpc85xx_cds_defconfig
m68k                          amiga_defconfig
sh                           se7712_defconfig
csky                             alldefconfig
sh                        sh7757lcr_defconfig
arm                  randconfig-c002-20220327
arm                  randconfig-c002-20220329
arm                  randconfig-c002-20220330
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
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
x86_64               randconfig-a001-20220328
x86_64               randconfig-a003-20220328
x86_64               randconfig-a004-20220328
x86_64               randconfig-a002-20220328
x86_64               randconfig-a005-20220328
x86_64               randconfig-a006-20220328
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
i386                 randconfig-a001-20220328
i386                 randconfig-a003-20220328
i386                 randconfig-a006-20220328
i386                 randconfig-a005-20220328
i386                 randconfig-a004-20220328
i386                 randconfig-a002-20220328
arc                  randconfig-r043-20220329
s390                 randconfig-r044-20220327
arc                  randconfig-r043-20220328
arc                  randconfig-r043-20220327
riscv                randconfig-r042-20220329
s390                 randconfig-r044-20220329
riscv                randconfig-r042-20220327
riscv                randconfig-r042-20220330
arc                  randconfig-r043-20220330
s390                 randconfig-r044-20220330
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
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20220329
x86_64                        randconfig-c007
mips                 randconfig-c004-20220327
arm                  randconfig-c002-20220327
arm                  randconfig-c002-20220329
riscv                randconfig-c006-20220327
powerpc              randconfig-c003-20220327
powerpc              randconfig-c003-20220329
riscv                randconfig-c006-20220329
i386                          randconfig-c001
mips                 randconfig-c004-20220330
powerpc              randconfig-c003-20220330
riscv                randconfig-c006-20220330
arm                  randconfig-c002-20220330
mips                 randconfig-c004-20220328
arm                  randconfig-c002-20220328
x86_64               randconfig-c007-20220328
powerpc              randconfig-c003-20220328
riscv                randconfig-c006-20220328
i386                 randconfig-c001-20220328
mips                        workpad_defconfig
powerpc                    socrates_defconfig
mips                           rs90_defconfig
powerpc                   lite5200b_defconfig
powerpc                     kilauea_defconfig
riscv                            alldefconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a016-20220328
x86_64               randconfig-a012-20220328
x86_64               randconfig-a011-20220328
x86_64               randconfig-a014-20220328
x86_64               randconfig-a013-20220328
x86_64               randconfig-a015-20220328
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a015-20220328
i386                 randconfig-a016-20220328
i386                 randconfig-a011-20220328
i386                 randconfig-a012-20220328
i386                 randconfig-a014-20220328
i386                 randconfig-a013-20220328
hexagon              randconfig-r041-20220328
riscv                randconfig-r042-20220328
hexagon              randconfig-r045-20220327
hexagon              randconfig-r045-20220329
hexagon              randconfig-r045-20220328
hexagon              randconfig-r041-20220327
s390                 randconfig-r044-20220328
hexagon              randconfig-r041-20220329
hexagon              randconfig-r045-20220330
hexagon              randconfig-r041-20220330

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

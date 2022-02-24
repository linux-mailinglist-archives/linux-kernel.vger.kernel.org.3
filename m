Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAEF4C229C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiBXDrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiBXDrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:47:32 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1660EF2134
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645674423; x=1677210423;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KodhdAbbNZod9ou3AoHUtlw4o/O32STQ/o5jOLIceTY=;
  b=lE18S+mQlbmZLh7WJI8tG74s9xEdMdaOvDZYwdPlvGeE17fBNzjqI7Yg
   HyPWrPui4NEGMZdHclv17fyZr/v93muMDmRF4zOV9RazbT5NMW7sPXLUF
   r3QZ6tIoZoHiL1FGx9PhPWOd8mAcazE8tnhiNkszgTE++IiWiiBOvc4nc
   OhaTg+0Xt6PMIxlpJ6FW99dzOA8FNy0fr5RZTRaWrxXOBSJKNqbhKydk9
   52cp9b6G2Ks6Y1Jqf5ooL9oexj57E5/4xAh2FkgDBW29yBSM3mAbno4X3
   fgJcicJcm0f1LZO0nzNGKPsTFpU2HsxEZCKM5qVBtZ5RO1erAG647iEoi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="232117468"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="232117468"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 19:47:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="543563792"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Feb 2022 19:47:01 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN55p-0002E5-3x; Thu, 24 Feb 2022 03:47:01 +0000
Date:   Thu, 24 Feb 2022 11:46:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 4509d950a6764d18a99776614513d280cca422d8
Message-ID: <6216ff83.BsJg2w5csrKmw2NT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 4509d950a6764d18a99776614513d280cca422d8  x86/pat: Remove the unused set_pages_array_wt() function

elapsed time: 725m

configs tested: 125
configs skipped: 104

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
arc                              alldefconfig
sh                          rsk7201_defconfig
sh                          rsk7269_defconfig
mips                           jazz_defconfig
mips                           gcw0_defconfig
arm                         s3c6400_defconfig
h8300                    h8300h-sim_defconfig
sh                           sh2007_defconfig
arm                       aspeed_g5_defconfig
powerpc                     tqm8555_defconfig
sh                            migor_defconfig
nios2                         10m50_defconfig
sh                            titan_defconfig
powerpc                      ep88xc_defconfig
ia64                             alldefconfig
arm                           tegra_defconfig
nds32                               defconfig
powerpc                 linkstation_defconfig
sh                   sh7770_generic_defconfig
arm                  randconfig-c002-20220223
arm                  randconfig-c002-20220224
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
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
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
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
powerpc              randconfig-c003-20220223
x86_64                        randconfig-c007
arm                  randconfig-c002-20220223
mips                 randconfig-c004-20220223
i386                          randconfig-c001
riscv                randconfig-c006-20220223
powerpc                      walnut_defconfig
arm                           omap1_defconfig
powerpc                        icon_defconfig
powerpc                      obs600_defconfig
powerpc                     ppa8548_defconfig
arm                          imote2_defconfig
arm                         bcm2835_defconfig
arm                           spitz_defconfig
powerpc                      ppc44x_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                       ebony_defconfig
mips                      bmips_stb_defconfig
powerpc                      acadia_defconfig
mips                           ip27_defconfig
powerpc                   microwatt_defconfig
arm                    vt8500_v6_v7_defconfig
arm                        magician_defconfig
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
hexagon              randconfig-r045-20220223
hexagon              randconfig-r041-20220223
riscv                randconfig-r042-20220223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

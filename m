Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344EA4C229B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiBXDrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiBXDrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:47:47 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6047417DBA8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645674438; x=1677210438;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZWjG69XrOu/QaPlbhLLYxUkOCvFP4gdnaXH5qEokaiY=;
  b=bwDBzjPIfdbj5XOlRI4jP+o11LwzSzycSLIxpe50IsJq+6j8ueqVp92F
   jdKhqWwOP+/taOmT50pWcZrlAPy5JpumpqcL7QFvDuf6bP1eQwgdBAejv
   T60bi4r2s6jWHHo6MXRVajo19NU8gJiXHr+m8j3O6DeEwFM+/2gnhbVSs
   A9CxPOMZeE15InXfFHncotiB+ayP4MkpQyW528cDRzFyTH4rYcuZwYE2f
   r5jN5mKoxHiSZfdmI2RpeavggAeVHncxVB1P/Nx7kBvClFBZmF4zcednz
   G7fJPTjoCd6VIXzqTZa8DnWyjxmJXW+eWGpc+oNXr7iaOJCYRh7R5w2PR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="315368783"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="315368783"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 19:47:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="607288687"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Feb 2022 19:47:01 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN55o-0002Dm-UK; Thu, 24 Feb 2022 03:47:00 +0000
Date:   Thu, 24 Feb 2022 11:46:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 7f1b8e0d6360178e3527d4f14e6921c254a86035
Message-ID: <6216ff7c.Pcoig9XkgVCbxW64%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 7f1b8e0d6360178e3527d4f14e6921c254a86035  x86/mce: Remove the tolerance level control

elapsed time: 725m

configs tested: 121
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                             sh03_defconfig
sh                          sdk7780_defconfig
arm                            pleb_defconfig
powerpc                      bamboo_defconfig
m68k                       bvme6000_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                          polaris_defconfig
mips                           jazz_defconfig
sh                          rsk7269_defconfig
arm                       aspeed_g5_defconfig
powerpc                     tqm8555_defconfig
sh                            migor_defconfig
arc                        nsimosci_defconfig
arm                         assabet_defconfig
sh                           se7724_defconfig
powerpc                      makalu_defconfig
sh                               alldefconfig
mips                  decstation_64_defconfig
powerpc                     redwood_defconfig
powerpc                      pasemi_defconfig
sh                     magicpanelr2_defconfig
powerpc                      ep88xc_defconfig
ia64                             alldefconfig
arm                  randconfig-c002-20220223
arm                  randconfig-c002-20220224
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220223
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
powerpc                      walnut_defconfig
arm                           omap1_defconfig
powerpc                        icon_defconfig
arm                           spitz_defconfig
arm                         bcm2835_defconfig
powerpc                      ppc44x_defconfig
arm                          pcm027_defconfig
arm                         s5pv210_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                      bmips_stb_defconfig
powerpc                     mpc5200_defconfig
arm                        neponset_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                           mtx1_defconfig
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
s390                 randconfig-r044-20220223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

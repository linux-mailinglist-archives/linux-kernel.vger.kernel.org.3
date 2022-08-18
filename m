Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA17597D97
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 06:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243420AbiHREgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 00:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbiHREgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:36:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92825AE210
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 21:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660797395; x=1692333395;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hYgDpKsko/bH4mQKwTOt83QWnTdF8gaa2YnelE+FMPM=;
  b=XB8wXqF1NVpFgpB0EOmAf5m0uwv2yw5rJeD9/Q5URTmPAz+j2TiESMac
   dU0S7r6MpR3wHNPentQ/YyICe73TCq5laBSH79qZ1NzTk2iXmR4LmQhCT
   GC8cVBXfK08Tq+FoZoo5MAHVRHxWNYWK2JgrCsNReDjAM3TzIz+5iJBd6
   WJ89dSUFYoVu0sjNMWATBl6/85zbDXEcgWZci/E/w0xoMlyej204nBcd1
   gdehz5pZnp9cP2T3EdmWw+q7X+LiZaDY6xCIVlb1UlKhwJTu+jm3gKCpu
   TV6NEbVG22fUt/QuUACqjDUe+pSHKEoHEGubqKEISdCeNgZk8GBtpCEIU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="378956165"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="378956165"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 21:36:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="667925990"
Received: from lkp-server01.sh.intel.com (HELO 6cc724e23301) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2022 21:36:28 -0700
Received: from kbuild by 6cc724e23301 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOXGe-00002d-0h;
        Thu, 18 Aug 2022 04:36:28 +0000
Date:   Thu, 18 Aug 2022 12:36:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/urgent] BUILD SUCCESS
 52ad1c24d213f176a2424552dfd0db2f870d96bd
Message-ID: <62fdc1b4.a7qoJPSWPbZgfjri%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/urgent
branch HEAD: 52ad1c24d213f176a2424552dfd0db2f870d96bd  x86/kvm, objtool: Avoid fastop ENDBR from being sealed

elapsed time: 726m

configs tested: 110
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
riscv                randconfig-r042-20220818
s390                 randconfig-r044-20220818
arc                  randconfig-r043-20220818
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm                            zeus_defconfig
nios2                         3c120_defconfig
sh                           se7712_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm                         s3c6400_defconfig
sh                             sh03_defconfig
arm                             ezx_defconfig
mips                        vocore2_defconfig
arm                        oxnas_v6_defconfig
i386                             allyesconfig
i386                                defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arc                          axs101_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                       maple_defconfig
alpha                            alldefconfig
sparc                       sparc32_defconfig
sh                          r7785rp_defconfig
mips                  decstation_64_defconfig
arm                         cm_x300_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
mips                      loongson3_defconfig
sh                          polaris_defconfig
arc                          axs103_defconfig
sh                        edosk7705_defconfig
arm                           tegra_defconfig
mips                           ip32_defconfig
m68k                            mac_defconfig
riscv                    nommu_k210_defconfig
arm                             pxa_defconfig
powerpc                      ppc40x_defconfig
powerpc                      mgcoge_defconfig
powerpc                      cm5200_defconfig
arm                          simpad_defconfig
sh                        edosk7760_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                        m5307c3_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                          pxa3xx_defconfig
arm                            xcep_defconfig
sh                               alldefconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
ia64                         bigsur_defconfig
nios2                            allyesconfig
arm                          exynos_defconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                        multi_v5_defconfig
mips                      pic32mzda_defconfig
riscv                    nommu_virt_defconfig
mips                        qi_lb60_defconfig
powerpc                 mpc8560_ads_defconfig
arm                           spitz_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                          g5_defconfig
arm64                            allyesconfig
arm                          ixp4xx_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832BD4B5F04
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiBOA0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:26:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiBOA0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:26:37 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ECA24082
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644884787; x=1676420787;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bGtCt4b5ncEXfeeJLjIcPS2iiyoPWaiuJ58UxYovSJI=;
  b=m6/Xm7dUCoD7pIDUh6KZKLpjJ4aJYXEbf8LfSY0kf3Xb9tUySW7vsIt5
   cwUidifWmd0LmrChvGNO9Md5It3hwQ2ZIiRawj7X15esK/urj9qOTVy37
   05RGfXaXt3xp2cM/c6sNuhyaHiDNdxR3nRyMeZdlR+k9IcV/hcTmyeEcy
   gf5mSmBQY7Q3ETIdtK1wZSGUvU5S776eAAmJYHRB6wLDPWPnZJ6ixNTis
   9Jd/3xTdY9hhzC7/nZmxxPimIk+F2emnkFpbVnfyJD1LS2ll6d6xGLvHa
   78KkPYdpRCvsh1KN2nhjPhOxLbbbX7S9dq7K48TJO08xSWpEDuJy+iKll
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="249047496"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="249047496"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 16:26:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="775518473"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 14 Feb 2022 16:26:26 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJlfl-00095O-KH; Tue, 15 Feb 2022 00:26:25 +0000
Date:   Tue, 15 Feb 2022 08:26:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 8a3d8d8a3c5544f07776f370b24ba57a097b6e1b
Message-ID: <620af322.8BFyD+zLkRWY6vrA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 8a3d8d8a3c5544f07776f370b24ba57a097b6e1b  Merge locking/core into tip/master

elapsed time: 731m

configs tested: 190
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220214
mips                 randconfig-c004-20220214
nios2                            alldefconfig
sh                          r7780mp_defconfig
sh                            titan_defconfig
ia64                         bigsur_defconfig
m68k                        mvme147_defconfig
sh                            hp6xx_defconfig
powerpc64                        alldefconfig
sh                               alldefconfig
arm                           tegra_defconfig
powerpc                     stx_gp3_defconfig
mips                        vocore2_defconfig
xtensa                         virt_defconfig
arc                     haps_hs_smp_defconfig
xtensa                              defconfig
arm                          lpd270_defconfig
arm                        shmobile_defconfig
m68k                         apollo_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                         lubbock_defconfig
parisc                           allyesconfig
arm                      integrator_defconfig
mips                          rb532_defconfig
m68k                       m5475evb_defconfig
mips                     loongson1b_defconfig
sparc64                             defconfig
sh                             shx3_defconfig
powerpc                       maple_defconfig
powerpc64                           defconfig
arm                        mvebu_v7_defconfig
x86_64                           alldefconfig
ia64                            zx1_defconfig
sparc                               defconfig
arm64                            alldefconfig
mips                         rt305x_defconfig
mips                     decstation_defconfig
powerpc                      cm5200_defconfig
sparc64                          alldefconfig
mips                            gpr_defconfig
sh                           se7705_defconfig
sh                           se7780_defconfig
sh                         ap325rxa_defconfig
arm                         at91_dt_defconfig
arm                           u8500_defconfig
mips                    maltaup_xpa_defconfig
arm                          pxa3xx_defconfig
ia64                          tiger_defconfig
arc                           tb10x_defconfig
sh                        sh7757lcr_defconfig
m68k                          hp300_defconfig
arm                     eseries_pxa_defconfig
arm                            pleb_defconfig
sh                           se7721_defconfig
powerpc                 linkstation_defconfig
sh                ecovec24-romimage_defconfig
powerpc                       ppc64_defconfig
m68k                        stmark2_defconfig
sh                           se7722_defconfig
mips                         db1xxx_defconfig
powerpc                      ppc40x_defconfig
h8300                               defconfig
arm                         lpc18xx_defconfig
powerpc                      bamboo_defconfig
arc                        nsimosci_defconfig
arm                  randconfig-c002-20220214
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a013-20220214
x86_64               randconfig-a014-20220214
x86_64               randconfig-a012-20220214
x86_64               randconfig-a015-20220214
x86_64               randconfig-a011-20220214
x86_64               randconfig-a016-20220214
i386                 randconfig-a013-20220214
i386                 randconfig-a016-20220214
i386                 randconfig-a012-20220214
i386                 randconfig-a015-20220214
i386                 randconfig-a011-20220214
i386                 randconfig-a014-20220214
riscv                randconfig-r042-20220214
arc                  randconfig-r043-20220214
s390                 randconfig-r044-20220214
x86_64                        randconfig-a006
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
riscv                randconfig-c006-20220214
i386                 randconfig-c001-20220214
x86_64               randconfig-c007-20220214
powerpc              randconfig-c003-20220214
arm                  randconfig-c002-20220214
mips                 randconfig-c004-20220214
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220213
i386                          randconfig-c001
mips                 randconfig-c004-20220213
arm                         lpc32xx_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                        workpad_defconfig
arm                         s3c2410_defconfig
powerpc                     ppa8548_defconfig
arm64                            allyesconfig
arm                            dove_defconfig
powerpc                     pseries_defconfig
powerpc                      ppc64e_defconfig
arm                        spear3xx_defconfig
powerpc                     tqm8560_defconfig
powerpc                     kmeter1_defconfig
mips                          ath25_defconfig
powerpc                     mpc5200_defconfig
arm                  colibri_pxa300_defconfig
arm                         bcm2835_defconfig
mips                     cu1830-neo_defconfig
arm                       spear13xx_defconfig
mips                     loongson1c_defconfig
arm                        magician_defconfig
powerpc                     mpc512x_defconfig
arm                          imote2_defconfig
mips                         tb0287_defconfig
arm                          moxart_defconfig
powerpc                    gamecube_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                           rs90_defconfig
mips                          ath79_defconfig
mips                         tb0219_defconfig
mips                     cu1000-neo_defconfig
mips                            e55_defconfig
x86_64               randconfig-a002-20220214
x86_64               randconfig-a006-20220214
x86_64               randconfig-a005-20220214
x86_64               randconfig-a004-20220214
x86_64               randconfig-a003-20220214
x86_64               randconfig-a001-20220214
i386                 randconfig-a004-20220214
i386                 randconfig-a005-20220214
i386                 randconfig-a006-20220214
i386                 randconfig-a002-20220214
i386                 randconfig-a003-20220214
i386                 randconfig-a001-20220214
hexagon              randconfig-r045-20220214
hexagon              randconfig-r041-20220214
hexagon              randconfig-r045-20220213
hexagon              randconfig-r041-20220213
riscv                randconfig-r042-20220213
s390                 randconfig-r044-20220213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

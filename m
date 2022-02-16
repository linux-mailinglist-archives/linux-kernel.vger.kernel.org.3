Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7E94B7CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245589AbiBPBrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:47:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbiBPBrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:47:31 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDCF2BB11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644976040; x=1676512040;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eYUNITBN6R4wn0hwaSp8uqSR8Q2/MSgeFBEFFWfdDBk=;
  b=BKmR61i8OGMmG6wE5IMdmILxwnpFMQ/zKb0cJBruVkAtWltbb1Qq7Wrc
   j25FWAr11aVfQu+Kq4zx95485ZmziN1wFGZxTjCEeEQXjzCWTZfz9Pf2N
   dRzuyA1w2NwD0UF27xf0tuAIawgbHFPF5iX5XZECQGQtagou8xpHiaP3S
   T6C8dtMoBn6umHeFtvfxzdGFePetV4MSSdm2M1uEItMElAgMpmXu4/rsM
   gwG0MkV6wsaxQdDQAR2Lb6/cAvY6WHR+DGu3MnFlels7p76GWfx1kJ3zg
   vP86ETcvhXWhlsPK0kzrlF1Q2h04BCVqWBnrM50H+9h/o9Z78ezHsk1rY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="231127117"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="231127117"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 17:47:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="636255399"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2022 17:47:18 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK9PZ-000AFp-Pt; Wed, 16 Feb 2022 01:47:17 +0000
Date:   Wed, 16 Feb 2022 09:47:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 0ef7c79e43d05936b83f0e6d8e33cc7cfaebaf18
Message-ID: <620c579b.yQC747/kRGRy0S4I%lkp@intel.com>
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
branch HEAD: 0ef7c79e43d05936b83f0e6d8e33cc7cfaebaf18  Merge x86/pasid into tip/master

elapsed time: 727m

configs tested: 154
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
mips                      fuloong2e_defconfig
sh                        sh7763rdp_defconfig
arm                        realview_defconfig
arm                          iop32x_defconfig
arm                          simpad_defconfig
csky                                defconfig
mips                         rt305x_defconfig
sh                           se7206_defconfig
arm                         axm55xx_defconfig
powerpc                     pq2fads_defconfig
mips                         mpc30x_defconfig
nios2                               defconfig
arm                        spear6xx_defconfig
powerpc                     mpc83xx_defconfig
powerpc                 mpc8540_ads_defconfig
arm                       imx_v6_v7_defconfig
sh                            shmin_defconfig
powerpc                      arches_defconfig
arm                          pxa910_defconfig
arm                            pleb_defconfig
mips                           xway_defconfig
mips                          rb532_defconfig
sh                           se7721_defconfig
ia64                             allmodconfig
xtensa                    xip_kc705_defconfig
mips                         db1xxx_defconfig
sh                            titan_defconfig
sparc                               defconfig
arm64                            alldefconfig
arm                        mvebu_v7_defconfig
sh                          kfr2r09_defconfig
arm                            xcep_defconfig
m68k                        stmark2_defconfig
s390                                defconfig
sh                        edosk7705_defconfig
arm                         at91_dt_defconfig
powerpc                    klondike_defconfig
h8300                               defconfig
sh                             espt_defconfig
mips                       capcella_defconfig
arm                        cerfcube_defconfig
mips                      loongson3_defconfig
sh                          rsk7269_defconfig
powerpc                      ppc6xx_defconfig
microblaze                          defconfig
powerpc                         wii_defconfig
powerpc                 mpc837x_mds_defconfig
arc                        nsimosci_defconfig
xtensa                  nommu_kc705_defconfig
arm                  randconfig-c002-20220214
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
parisc64                            defconfig
parisc                           allyesconfig
s390                             allmodconfig
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
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220214
arc                  randconfig-r043-20220214
s390                 randconfig-r044-20220214
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
riscv                randconfig-c006-20220215
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220215
arm                  randconfig-c002-20220215
i386                          randconfig-c001
mips                 randconfig-c004-20220215
arm                        neponset_defconfig
powerpc                      ppc44x_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                          rm200_defconfig
arm                         palmz72_defconfig
arm                         mv78xx0_defconfig
powerpc                     kmeter1_defconfig
powerpc                      obs600_defconfig
powerpc                     tqm8560_defconfig
arm                         lpc32xx_defconfig
mips                     cu1830-neo_defconfig
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9544E479B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiCVUgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiCVUgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:36:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3503B2459E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647981273; x=1679517273;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dgBTfAfS2dZ2ueyDjo++u6Y2dRVbdMTXPUigh1AzmM4=;
  b=Eg4TDcShKtFr0uk6HNVMHz5ibo2MT3kwsZWeaXAjoNDLlLUjoGRuLaJ+
   xO9bV9lOAnd/fgHbYpfCMyMxsFY0gNEPLZj35bmkzK+EGlOl5K2YgxGwb
   m+qx5LlbtKfyGKeTbgRJ7cexZ7QN/DteLC/8vKZfHKZnsx1dGw3NvYmzI
   v3WTxFqdiIMBUxymRhCG4EUnsWhq8HPt01nrhidxlEkUhaQgkfI08R8C/
   ShhdCQJEGp0SPET6eHCMnGiBbCR1K9xYzoNI7xCIgfbSXpoereYOgCbnn
   LEpc5Amckc1BJo4uDhrjWl2pAagpc1z0FOpHtaLIzF87N4QHmFCe4pg2Y
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="282782897"
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="282782897"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 13:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="649161207"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 22 Mar 2022 13:34:31 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWlD4-000JGZ-Rw; Tue, 22 Mar 2022 20:34:30 +0000
Date:   Wed, 23 Mar 2022 04:33:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 ffea9fb319360b9ead8befac6bb2db2b54fd53e6
Message-ID: <623a3298.OFTUR26qEy4DaxV9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: ffea9fb319360b9ead8befac6bb2db2b54fd53e6  sched/headers: ARM needs asm/paravirt_api_clock.h too

elapsed time: 724m

configs tested: 115
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
m68k                             alldefconfig
m68k                       m5475evb_defconfig
riscv                    nommu_k210_defconfig
arc                          axs101_defconfig
mips                     decstation_defconfig
powerpc                     tqm8548_defconfig
nios2                               defconfig
arm                             pxa_defconfig
arc                           tb10x_defconfig
parisc64                            defconfig
powerpc                 mpc834x_itx_defconfig
sh                             sh03_defconfig
powerpc                     rainier_defconfig
arm                         vf610m4_defconfig
sh                        edosk7705_defconfig
mips                           ci20_defconfig
arm                  randconfig-c002-20220321
arm                  randconfig-c002-20220320
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a016-20220321
x86_64               randconfig-a011-20220321
x86_64               randconfig-a012-20220321
x86_64               randconfig-a013-20220321
x86_64               randconfig-a014-20220321
x86_64               randconfig-a015-20220321
i386                 randconfig-a015-20220321
i386                 randconfig-a016-20220321
i386                 randconfig-a011-20220321
i386                 randconfig-a013-20220321
i386                 randconfig-a012-20220321
i386                 randconfig-a014-20220321
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
x86_64                        randconfig-c007
mips                 randconfig-c004-20220320
arm                  randconfig-c002-20220320
powerpc              randconfig-c003-20220320
riscv                randconfig-c006-20220320
i386                          randconfig-c001
arm                  randconfig-c002-20220322
powerpc              randconfig-c003-20220322
riscv                randconfig-c006-20220322
powerpc                     mpc5200_defconfig
arm                         orion5x_defconfig
arm                     am200epdkit_defconfig
arm                        spear3xx_defconfig
mips                         tb0287_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                        omega2p_defconfig
i386                 randconfig-a001-20220321
i386                 randconfig-a006-20220321
i386                 randconfig-a003-20220321
i386                 randconfig-a005-20220321
i386                 randconfig-a004-20220321
i386                 randconfig-a002-20220321
x86_64               randconfig-a001-20220321
x86_64               randconfig-a003-20220321
x86_64               randconfig-a005-20220321
x86_64               randconfig-a004-20220321
x86_64               randconfig-a002-20220321
x86_64               randconfig-a006-20220321
riscv                randconfig-r042-20220320
hexagon              randconfig-r045-20220321
hexagon              randconfig-r045-20220320
hexagon              randconfig-r041-20220321
hexagon              randconfig-r041-20220320

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

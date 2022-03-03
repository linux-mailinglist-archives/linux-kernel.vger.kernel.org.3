Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E7A4CBC06
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiCCLAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiCCLAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:00:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E35C1786B5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 02:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646305192; x=1677841192;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fENlWMf9Jw0avPH6zqg6T2BomxYwR6AQqfpfCSFu7sQ=;
  b=g7XeSk5DLKvQNUH4ShkCUAYmJLVTrgzcF79XgE29sfC6WHZzAx3Jr3SU
   JNMFbVUTOjRqVBOrdc4HMJqw6SmSUlMjYUYKzINkf3B1IvjEfLqSX9apU
   gnrc3KdSWvAOtq4n1WgE7PI05LKBmb1bO/XbDh0DatsUwHqNJ8WPOkRtS
   tVpl5DP4bsvrKt6tJ416CNFEFElFYA0ZceId2hdg+343B8HMhSKbSVrog
   Vx5Iwfd2UoWAYBcct3yQAvumCQme8W2DhiL6AsMhVrOpq56/jW7qGs2xd
   9GcQSZZqONiJkabqZCmXcZ39Lm4/ZZt3qMd9Z00DHAMb7JUxXvUUDRNO0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="278324127"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="278324127"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 02:59:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="630752793"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Mar 2022 02:59:51 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPjBW-0000PT-Bk; Thu, 03 Mar 2022 10:59:50 +0000
Date:   Thu, 03 Mar 2022 18:59:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 ff8dcfebe08dfb2524041116d4afce53ffe0b015
Message-ID: <62209f93.Ie0n4I2MqfM7nGsG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: ff8dcfebe08dfb2524041116d4afce53ffe0b015  staging: greybus: gpio: Use generic_handle_irq_safe().

elapsed time: 741m

configs tested: 119
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
mips                 randconfig-c004-20220303
arm                       omap2plus_defconfig
m68k                       m5249evb_defconfig
arm                          badge4_defconfig
microblaze                          defconfig
sparc64                             defconfig
arm                           sunxi_defconfig
sh                        edosk7705_defconfig
xtensa                           allyesconfig
arc                    vdk_hs38_smp_defconfig
arm                         lubbock_defconfig
nios2                         10m50_defconfig
arc                        nsim_700_defconfig
arm                        cerfcube_defconfig
arc                            hsdk_defconfig
arm                         assabet_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                 decstation_r4k_defconfig
nios2                               defconfig
sh                          urquell_defconfig
arm                            lart_defconfig
arc                        nsimosci_defconfig
arm                           h3600_defconfig
arm                           sama5_defconfig
sparc                            alldefconfig
mips                            gpr_defconfig
sh                           se7705_defconfig
powerpc                       holly_defconfig
powerpc                        warp_defconfig
um                             i386_defconfig
openrisc                  or1klitex_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                             alldefconfig
sh                          sdk7780_defconfig
powerpc                     taishan_defconfig
mips                           ci20_defconfig
arm                  randconfig-c002-20220302
arm                  randconfig-c002-20220303
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
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
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220303
riscv                randconfig-c006-20220303
i386                          randconfig-c001
arm                  randconfig-c002-20220303
mips                 randconfig-c004-20220303
mips                            e55_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220303
riscv                randconfig-r042-20220303
hexagon              randconfig-r041-20220303
hexagon              randconfig-r045-20220302
hexagon              randconfig-r041-20220302
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719F34A8547
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350868AbiBCNcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:32:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:14102 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244416AbiBCNcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643895134; x=1675431134;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kVkbql0zjR75SsvgfKEtovhMYJ0DIWDAmm/mZl/XRIU=;
  b=MbLMmnuhIGqMX4yDcAGIIG+5q/Q83FhZJjUvTzwIwgfgteYe6Glxptxs
   WmbgLT3zPPnPYikMGoOxknpFR8YBIkP6iZ/QE+NhkZ9CRVRwUmfvPG6Xl
   5GjcZZgzxnqrNp/pWYsKU3fZyeRC6tSCwn9tiBfV0Fch2SThplg40fVXj
   XNjW8Tx2giVwsp7U04ymA4pdmasvlZEt9KYFXYvZ2ziszHGe69Td6M3k3
   BqxS7BXbfOAPNUcOPWWZm5HLJ6ofFuat2WtR2ppQgQnm248jihJSg6tny
   UfMdm/GhsxZTB/R6cg81JUPE++9azK6tMTb6K7t5u2qDnMP3uTWCk/kin
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="272638723"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="272638723"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 05:32:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="631341489"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 Feb 2022 05:32:12 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFcDc-000W9Q-9t; Thu, 03 Feb 2022 13:32:12 +0000
Date:   Thu, 03 Feb 2022 21:31:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/irq] BUILD SUCCESS
 449972c67ea78158bcd55d6a5ce6f941f8a4afa0
Message-ID: <61fbd941.gGisq1YDVss4K6Jj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/irq
branch HEAD: 449972c67ea78158bcd55d6a5ce6f941f8a4afa0  x86/PCI: Fix coding style in PIRQ table search functions

elapsed time: 722m

configs tested: 151
configs skipped: 87

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220131
arm                        clps711x_defconfig
sh                           se7724_defconfig
sh                         apsh4a3a_defconfig
arm64                            alldefconfig
mips                           ip32_defconfig
powerpc                     redwood_defconfig
arm                       aspeed_g5_defconfig
arm                            zeus_defconfig
powerpc                     asp8347_defconfig
csky                             alldefconfig
sh                          r7780mp_defconfig
m68k                        stmark2_defconfig
arm                        multi_v7_defconfig
sh                               j2_defconfig
m68k                       bvme6000_defconfig
m68k                             allyesconfig
openrisc                  or1klitex_defconfig
parisc                generic-32bit_defconfig
arm                           viper_defconfig
mips                        vocore2_defconfig
s390                       zfcpdump_defconfig
h8300                       h8s-sim_defconfig
powerpc                      pcm030_defconfig
parisc                generic-64bit_defconfig
sh                           se7721_defconfig
s390                          debug_defconfig
microblaze                          defconfig
mips                           ci20_defconfig
nds32                             allnoconfig
arm                         axm55xx_defconfig
powerpc                       holly_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                        sh7785lcr_defconfig
powerpc                      chrp32_defconfig
mips                     decstation_defconfig
m68k                        mvme147_defconfig
ia64                            zx1_defconfig
arm                           corgi_defconfig
sh                          r7785rp_defconfig
ia64                          tiger_defconfig
m68k                          sun3x_defconfig
microblaze                      mmu_defconfig
sh                          rsk7203_defconfig
arm                         assabet_defconfig
sh                         ecovec24_defconfig
powerpc                    amigaone_defconfig
arm                          pxa910_defconfig
arm                  randconfig-c002-20220202
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
i386                          randconfig-a012
i386                          randconfig-a014
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
riscv                randconfig-c006-20220130
x86_64                        randconfig-c007
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
i386                          randconfig-c001
mips                   sb1250_swarm_defconfig
mips                  cavium_octeon_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                          imote2_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         shannon_defconfig
powerpc                        icon_defconfig
arm                          pxa168_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
i386                 randconfig-a011-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

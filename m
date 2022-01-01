Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADAD4826D2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 08:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiAAHJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 02:09:34 -0500
Received: from mga14.intel.com ([192.55.52.115]:14638 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbiAAHJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 02:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641020972; x=1672556972;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jcZNfRvnhgP5jJ3mWqCGw13FHY0JaSryv6+boOtPvu8=;
  b=Q4wi1d2GXM1a9UCeDzs5GW8Ck/2vzuugIdQ7RdSRp/YZ7EmVb9bytDt+
   /1f582ifSBj+ZRPTIATR72xXeYGdkk1OHZrR/OOyukoDpXWSGtj3Vj7Lr
   sOcC8MF69KzV6y6WAGMu7LFzkBCx12j6VXWdIWYMpPmP77kP+Q0DTIuDu
   4xMWNYin7iUbS1TzeQboB5W2bJooDlaK9v4pFOD1X4Tg/pgSlkEo/Sfaf
   dcSPMtBkR6XczXOkNAggu4wyV+nvZoM5tH6GSUSV/vCk6pX+sWAMzNrCu
   4/cFeTFLKggiAK5foc41kkKOII5CKpjLOX8gcyrylCqsItzMyV/Q3vlhP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="242082446"
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="242082446"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 23:09:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="666950167"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 31 Dec 2021 23:09:31 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3YWA-000C9X-DY; Sat, 01 Jan 2022 07:09:30 +0000
Date:   Sat, 01 Jan 2022 15:09:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 3376136300a00df9a864b88fa969177d6c3be8e5
Message-ID: <61cffe14.Ci5g79rwMv2C+09i%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 3376136300a00df9a864b88fa969177d6c3be8e5  x86/mce: Reduce number of machine checks taken during recovery

elapsed time: 723m

configs tested: 138
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211231
arm                            lart_defconfig
parisc                generic-64bit_defconfig
arm                            mps2_defconfig
mips                         tb0226_defconfig
powerpc64                        alldefconfig
sh                          polaris_defconfig
mips                  maltasmvp_eva_defconfig
openrisc                            defconfig
alpha                               defconfig
sh                           se7751_defconfig
m68k                          sun3x_defconfig
xtensa                          iss_defconfig
sh                           sh2007_defconfig
arm                           viper_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                      makalu_defconfig
sh                           se7705_defconfig
sh                           se7750_defconfig
nios2                            alldefconfig
sh                         ap325rxa_defconfig
sh                         microdev_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7343_defconfig
openrisc                 simple_smp_defconfig
alpha                            allyesconfig
arm                  randconfig-c002-20220101
arm                  randconfig-c002-20211231
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20211231
x86_64               randconfig-a001-20211231
x86_64               randconfig-a003-20211231
x86_64               randconfig-a006-20211231
x86_64               randconfig-a004-20211231
x86_64               randconfig-a005-20211231
x86_64               randconfig-a005-20220101
x86_64               randconfig-a001-20220101
x86_64               randconfig-a004-20220101
x86_64               randconfig-a006-20220101
x86_64               randconfig-a003-20220101
x86_64               randconfig-a002-20220101
i386                 randconfig-a001-20211231
i386                 randconfig-a005-20211231
i386                 randconfig-a004-20211231
i386                 randconfig-a002-20211231
i386                 randconfig-a006-20211231
i386                 randconfig-a003-20211231
i386                 randconfig-a003-20220101
i386                 randconfig-a005-20220101
i386                 randconfig-a004-20220101
i386                 randconfig-a006-20220101
i386                 randconfig-a001-20220101
i386                 randconfig-a002-20220101
arc                  randconfig-r043-20220101
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
powerpc                   lite5200b_defconfig
powerpc                          allmodconfig
arm                         orion5x_defconfig
arm                    vt8500_v6_v7_defconfig
arm                         shannon_defconfig
powerpc                    mvme5100_defconfig
mips                        workpad_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                        spear3xx_defconfig
x86_64               randconfig-a013-20211231
x86_64               randconfig-a015-20211231
x86_64               randconfig-a012-20211231
x86_64               randconfig-a011-20211231
x86_64               randconfig-a016-20211231
x86_64               randconfig-a014-20211231
x86_64               randconfig-a015-20220101
x86_64               randconfig-a012-20220101
x86_64               randconfig-a014-20220101
x86_64               randconfig-a013-20220101
x86_64               randconfig-a011-20220101
x86_64               randconfig-a016-20220101
i386                 randconfig-a011-20211231
i386                 randconfig-a012-20211231
i386                 randconfig-a013-20211231
i386                 randconfig-a014-20211231
i386                 randconfig-a015-20211231
i386                 randconfig-a016-20211231
hexagon              randconfig-r041-20211231
hexagon              randconfig-r045-20211231
riscv                randconfig-r042-20211231
hexagon              randconfig-r041-20220101
hexagon              randconfig-r045-20220101
riscv                randconfig-r042-20220101

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

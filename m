Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF554A8B01
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiBCRze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:55:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:16209 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbiBCRz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643910928; x=1675446928;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8+pFp6mRlrMjrfGrThDOktV4DK2TKtlxaoSLSl8NKv8=;
  b=dHrGrd/PeSRUUKN3p36L2mxZBYn0g6heJzFpH81N5Iv5idM3T4o3BVHg
   eFQLf/bStwVXL5AAqLNUW8Ksg8qQl6m3k5c/Zd3eybz25HLoZYn3IfS+x
   QbGHe4+2y1UJhP8gy+6FT2uMwpOV6Q1VAoMcB43xfE7cT2tMU7bqS38mf
   K3xwLGWMCjY+zLKfS9biyoxUDL6/kXk8Kp0dQi0PirOHumfc6fbTfSaGk
   VJIRDHwERoDziQfY6eRg1/p4tTK3B23uSDcsTcYo4NpucTxPxJuxa9knj
   A6vpW+7WG9yYMqEI3Qr6dLodcz5uZMZgikPnIfoThwUNCEIYIYzvFk1yv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="245796885"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="245796885"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 09:55:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="699400388"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 Feb 2022 09:55:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFgKL-000WTe-JE; Thu, 03 Feb 2022 17:55:25 +0000
Date:   Fri, 04 Feb 2022 01:54:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 eed8820194db885498f16ff61a9da110c5e4fa16
Message-ID: <61fc16e4.b+7/s8V2iy6jHZQp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: eed8820194db885498f16ff61a9da110c5e4fa16  EXP tick: Detect and fix jiffies update stall

elapsed time: 747m

configs tested: 143
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220131
powerpc              randconfig-c003-20220131
m68k                        m5307c3_defconfig
sh                        apsh4ad0a_defconfig
sparc                       sparc32_defconfig
microblaze                      mmu_defconfig
powerpc                   motionpro_defconfig
powerpc                       eiger_defconfig
sh                          r7780mp_defconfig
m68k                        stmark2_defconfig
arm                        multi_v7_defconfig
s390                       zfcpdump_defconfig
h8300                       h8s-sim_defconfig
powerpc                      pcm030_defconfig
parisc                generic-64bit_defconfig
sh                           se7721_defconfig
powerpc                     taishan_defconfig
s390                          debug_defconfig
microblaze                          defconfig
mips                           ci20_defconfig
nds32                             allnoconfig
powerpc                       holly_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                        sh7785lcr_defconfig
mips                           gcw0_defconfig
powerpc                      ppc6xx_defconfig
sh                     sh7710voipgw_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
arm                  randconfig-c002-20220202
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
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
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
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
arm                        mvebu_v5_defconfig
riscv                    nommu_virt_defconfig
arm                         lpc32xx_defconfig
hexagon                             defconfig
powerpc                      obs600_defconfig
mips                           rs90_defconfig
arm                        spear3xx_defconfig
arm                         hackkit_defconfig
arm                           spitz_defconfig
powerpc                      katmai_defconfig
powerpc                     kilauea_defconfig
arm                              alldefconfig
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
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131
hexagon              randconfig-r045-20220203
hexagon              randconfig-r041-20220203

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

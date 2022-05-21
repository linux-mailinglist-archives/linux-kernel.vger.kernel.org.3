Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F5C52FE82
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348930AbiEURJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 13:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346539AbiEURJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 13:09:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40553CA46
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653152989; x=1684688989;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=W7dCT6wpIjtQszcWnBwrrWZfqwKo4tX+g0n5eWV9pMU=;
  b=In7CDylu22xPfkNbHYG6ZF+1In+wB6oku32aKx5YnC/K7q705Ni1WUU+
   jkucnTHp582TxnuVOci2WY8ZOMUvBZtQ1H7cEh9rEObL5yRot6OEr/1jv
   a3Nc1q/6ltgjqq1z5Iy8EaFhlGXKu8TN25Wdyfnxr1DRFKDYp6+F6N1T0
   x4Rl6yiZySvOAKCyv6ujbUdRRVqBKoUb2cIJU5bWmP3KM6+GdU+EoHopD
   RS1qoGHgF/T568vsddg3RYollyBNhZyv1Z+1D5vMB49Z2mX0IHqznQYAF
   tB+DXoV0JGDwM4F++wrnhrjpCvn/W6SpYJ7B+REGn2NJdlzxGsMxYHtAA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="254932901"
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="254932901"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 10:09:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="525149931"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 May 2022 10:09:48 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsSbr-0006UQ-EG;
        Sat, 21 May 2022 17:09:47 +0000
Date:   Sun, 22 May 2022 01:09:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:context-tracking.2022.05.19a] BUILD REGRESSION
 6153dca9e37b244684bf472728f5c3688c5b0aca
Message-ID: <62891cbb.i9z8REu5K9XWbPuw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git context-tracking.2022.05.19a
branch HEAD: 6153dca9e37b244684bf472728f5c3688c5b0aca  MAINTAINERS: Add Paul as context tracking maintainer

Error/Warning reports:

https://lore.kernel.org/lkml/202205200501.17EQ97Fa-lkp@intel.com
https://lore.kernel.org/lkml/202205200530.nX4ZzOAH-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

kernel/context_tracking.c:500:25: error: implicit declaration of function 'ct_kernel_exit'; did you mean 'is_kernel_text'? [-Werror=implicit-function-declaration]
kernel/context_tracking.c:500:4: error: call to undeclared function 'ct_kernel_exit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
kernel/context_tracking.c:502:25: error: implicit declaration of function 'ct_kernel_exit'; did you mean 'is_kernel_text'? [-Werror=implicit-function-declaration]
kernel/context_tracking.c:502:4: error: call to undeclared function 'ct_kernel_exit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
kernel/context_tracking.c:607:25: error: implicit declaration of function 'ct_kernel_enter'; did you mean 'ct_idle_enter'? [-Werror=implicit-function-declaration]
kernel/context_tracking.c:607:4: error: call to undeclared function 'ct_kernel_enter'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
kernel/context_tracking.c:609:25: error: implicit declaration of function 'ct_kernel_enter'; did you mean 'ct_idle_enter'? [-Werror=implicit-function-declaration]
kernel/context_tracking.c:609:4: error: call to undeclared function 'ct_kernel_enter'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-randconfig-m031-20220519
|   |-- kernel-context_tracking.c:error:implicit-declaration-of-function-ct_kernel_enter
|   `-- kernel-context_tracking.c:error:implicit-declaration-of-function-ct_kernel_exit
|-- arm-randconfig-r012-20220519
|   |-- kernel-context_tracking.c:error:implicit-declaration-of-function-ct_kernel_enter
|   `-- kernel-context_tracking.c:error:implicit-declaration-of-function-ct_kernel_exit
|-- arm-randconfig-r015-20220519
|   |-- kernel-context_tracking.c:error:implicit-declaration-of-function-ct_kernel_enter
|   `-- kernel-context_tracking.c:error:implicit-declaration-of-function-ct_kernel_exit
|-- csky-randconfig-r003-20220519
|   |-- kernel-context_tracking.c:error:implicit-declaration-of-function-ct_kernel_enter
|   `-- kernel-context_tracking.c:error:implicit-declaration-of-function-ct_kernel_exit
|-- csky-randconfig-r022-20220519
|   |-- kernel-context_tracking.c:error:implicit-declaration-of-function-ct_kernel_enter
|   `-- kernel-context_tracking.c:error:implicit-declaration-of-function-ct_kernel_exit
|-- mips-randconfig-r014-20220519
|   |-- kernel-context_tracking.c:error:implicit-declaration-of-function-ct_kernel_enter
|   `-- kernel-context_tracking.c:error:implicit-declaration-of-function-ct_kernel_exit
`-- sparc64-randconfig-r013-20220519
    |-- kernel-context_tracking.c:error:implicit-declaration-of-function-ct_kernel_enter
    `-- kernel-context_tracking.c:error:implicit-declaration-of-function-ct_kernel_exit

clang_recent_errors
|-- arm-randconfig-r036-20220519
|   |-- kernel-context_tracking.c:error:call-to-undeclared-function-ct_kernel_enter-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-context_tracking.c:error:call-to-undeclared-function-ct_kernel_exit-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- mips-buildonly-randconfig-r003-20220519
|   |-- kernel-context_tracking.c:error:call-to-undeclared-function-ct_kernel_enter-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-context_tracking.c:error:call-to-undeclared-function-ct_kernel_exit-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- mips-buildonly-randconfig-r006-20220519
|   |-- kernel-context_tracking.c:error:call-to-undeclared-function-ct_kernel_enter-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-context_tracking.c:error:call-to-undeclared-function-ct_kernel_exit-ISO-C99-and-later-do-not-support-implicit-function-declarations
`-- x86_64-randconfig-a001
    |-- kernel-context_tracking.c:error:call-to-undeclared-function-ct_kernel_enter-ISO-C99-and-later-do-not-support-implicit-function-declarations
    `-- kernel-context_tracking.c:error:call-to-undeclared-function-ct_kernel_exit-ISO-C99-and-later-do-not-support-implicit-function-declarations

elapsed time: 3009m

configs tested: 155
configs skipped: 3

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
sh                               j2_defconfig
ia64                        generic_defconfig
powerpc                      chrp32_defconfig
s390                          debug_defconfig
mips                  maltasmvp_eva_defconfig
arm                        mini2440_defconfig
m68k                            q40_defconfig
sh                           se7721_defconfig
arm                           tegra_defconfig
um                                  defconfig
powerpc                        cell_defconfig
sh                                  defconfig
powerpc                    klondike_defconfig
xtensa                  audio_kc705_defconfig
arm                           h3600_defconfig
parisc                generic-64bit_defconfig
sh                           se7619_defconfig
sh                          landisk_defconfig
nios2                            alldefconfig
sh                           se7343_defconfig
sh                            migor_defconfig
x86_64                           alldefconfig
powerpc                 canyonlands_defconfig
mips                         mpc30x_defconfig
powerpc                        warp_defconfig
powerpc                 mpc837x_mds_defconfig
arm                           viper_defconfig
m68k                       bvme6000_defconfig
m68k                        mvme147_defconfig
arm                             pxa_defconfig
arm                        keystone_defconfig
h8300                       h8s-sim_defconfig
openrisc                 simple_smp_defconfig
xtensa                generic_kc705_defconfig
powerpc                       holly_defconfig
powerpc                     rainier_defconfig
m68k                       m5208evb_defconfig
powerpc                      mgcoge_defconfig
mips                     loongson1b_defconfig
arc                         haps_hs_defconfig
sh                               allmodconfig
sh                   secureedge5410_defconfig
arm                        realview_defconfig
sh                   rts7751r2dplus_defconfig
sh                          urquell_defconfig
m68k                           sun3_defconfig
m68k                             allmodconfig
ia64                      gensparse_defconfig
arm                           sama5_defconfig
sh                 kfr2r09-romimage_defconfig
sh                           se7724_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
parisc64                            defconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220519
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                            mmp2_defconfig
arm                   milbeaut_m10v_defconfig
arm                       versatile_defconfig
mips                       lemote2f_defconfig
arm                        magician_defconfig
powerpc                   bluestone_defconfig
powerpc                        icon_defconfig
powerpc                      katmai_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc8272_ads_defconfig
mips                     loongson1c_defconfig
powerpc                     tqm8560_defconfig
arm                  colibri_pxa300_defconfig
arm                        mvebu_v5_defconfig
arm                              alldefconfig
powerpc                  mpc885_ads_defconfig
powerpc                    gamecube_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220519
hexagon              randconfig-r041-20220519
s390                 randconfig-r044-20220519
riscv                randconfig-r042-20220519
hexagon              randconfig-r045-20220521
hexagon              randconfig-r041-20220521
riscv                randconfig-r042-20220521

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

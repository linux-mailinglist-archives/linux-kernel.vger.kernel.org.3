Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB6F47EA77
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 03:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350929AbhLXCK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 21:10:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:63788 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230044AbhLXCK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 21:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640311828; x=1671847828;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UNn9TG7se6A4eKBO9iOuCu8tpu2grl/kvf8OPxQDpck=;
  b=iIkhb1t2SJ6516uWhwoBJZr34B4hQtJvhH3hXBhH1OLfMeBio5Hp0Cqm
   H2R62vWcshfqcuowAP4uk2QAxFON0p0wdSrvq2QiKWh+FnJxcsMsPtcBy
   nPA/Wmgsq04vzzyLKstQfgcypnnSVYEZmdNJFnyoLd6zDoeTTIDQozgVr
   cKXHkp9OnXlskT2+JXgLBu2vQXqHhImvva99ET61k8e09QNxyd85M4kiN
   9c5vQKUuHAoJUKiHW+BY9U2L4UvZyzYUnF3NHY9piZSagIxFSK+D4AoU1
   jc6G22xnxgR+gy+r5FFmW1zdkGqT1mJeCUWYBTTdI15f+Kkjc0rbYgeei
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="221587905"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="221587905"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 18:10:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="522278716"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Dec 2021 18:10:26 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n0a2M-0002VT-32; Fri, 24 Dec 2021 02:10:26 +0000
Date:   Fri, 24 Dec 2021 10:10:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 5fe392ff9d1f7254a1fbb3f72d9893088e4d23eb
Message-ID: <61c52bff.p5TRZQaJd1ECoiHt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: 5fe392ff9d1f7254a1fbb3f72d9893088e4d23eb  x86/boot/compressed: Move CLANG_FLAGS to beginning of KBUILD_CFLAGS

elapsed time: 725m

configs tested: 143
configs skipped: 72

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211223
powerpc                     mpc5200_defconfig
arm                       imx_v6_v7_defconfig
sh                   rts7751r2dplus_defconfig
arm                            qcom_defconfig
arm                          iop32x_defconfig
arc                          axs103_defconfig
powerpc                      mgcoge_defconfig
powerpc                    mvme5100_defconfig
m68k                         amcore_defconfig
arm                   milbeaut_m10v_defconfig
alpha                            alldefconfig
sh                           se7343_defconfig
arm                       spear13xx_defconfig
arm                      integrator_defconfig
mips                        vocore2_defconfig
arm                          simpad_defconfig
powerpc                      ep88xc_defconfig
mips                     decstation_defconfig
arc                            hsdk_defconfig
powerpc                      pmac32_defconfig
arm                        oxnas_v6_defconfig
powerpc                     ppa8548_defconfig
mips                         tb0219_defconfig
powerpc                      pcm030_defconfig
powerpc                    amigaone_defconfig
powerpc                      arches_defconfig
sh                        apsh4ad0a_defconfig
arm                           sunxi_defconfig
m68k                          hp300_defconfig
openrisc                         alldefconfig
mips                      bmips_stb_defconfig
um                                  defconfig
arm                           corgi_defconfig
powerpc                     redwood_defconfig
arm                         lubbock_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                 linkstation_defconfig
arm                           u8500_defconfig
arm                            xcep_defconfig
um                               alldefconfig
mips                 decstation_r4k_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                        edosk7760_defconfig
mips                     cu1000-neo_defconfig
arm                           stm32_defconfig
powerpc                       ppc64_defconfig
sh                           se7724_defconfig
mips                     loongson1b_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                           se7721_defconfig
arm                     eseries_pxa_defconfig
powerpc64                           defconfig
arm                        neponset_defconfig
um                             i386_defconfig
arm                         lpc18xx_defconfig
sh                ecovec24-romimage_defconfig
m68k                            mac_defconfig
arm                          exynos_defconfig
sh                          lboxre2_defconfig
arm                  randconfig-c002-20211223
arm                  randconfig-c002-20211224
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
x86_64               randconfig-a013-20211223
x86_64               randconfig-a015-20211223
x86_64               randconfig-a014-20211223
x86_64               randconfig-a011-20211223
x86_64               randconfig-a012-20211223
x86_64               randconfig-a016-20211223
i386                 randconfig-a012-20211223
i386                 randconfig-a011-20211223
i386                 randconfig-a014-20211223
i386                 randconfig-a016-20211223
i386                 randconfig-a015-20211223
i386                 randconfig-a013-20211223
arc                  randconfig-r043-20211223
riscv                randconfig-r042-20211223
s390                 randconfig-r044-20211223
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20211223
x86_64               randconfig-a003-20211223
x86_64               randconfig-a005-20211223
x86_64               randconfig-a006-20211223
x86_64               randconfig-a004-20211223
x86_64               randconfig-a002-20211223
i386                 randconfig-a006-20211223
i386                 randconfig-a004-20211223
i386                 randconfig-a002-20211223
i386                 randconfig-a003-20211223
i386                 randconfig-a005-20211223
i386                 randconfig-a001-20211223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

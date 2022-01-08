Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55CF4881AD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 06:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiAHFfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 00:35:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:14674 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbiAHFfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 00:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641620140; x=1673156140;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=y6xc8/q3f4Z3JLLx707h+TnoCh2Mj7Nxsd1tJbfbjKo=;
  b=h8f2smqk3lQxXcgc7SMQgl2IUVWAJcQ0mps4OELUEzE957PD8b5izsPr
   RNNy85F0r5gTlFyH+dtrl/9ijxQ5nWJPIl3z/xZdBpfeH9zdz4uBh75Ul
   Wjal0c8EUmyuGZH81J4TpFtwyfcOD8d5A1RRv6HwkJc4PM+g+R/OT+34D
   +Nd4OgTUgErx00HVDMiYdNBEf3RXQNS8GH+AdP/Tvco/6gKmO7Oz2E8Nj
   a19aqJpNX+AiUiZpkAgf9/RP2Igjg90lXmbR1qGOtbW0RsEyJwcYTRFhv
   8mTBJBykYJgE7w5qGNmbtHw4sMVro8zFvSFzZj4CAlLZ8MxAmCIePbYzf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="267296497"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="267296497"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 21:35:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="514056551"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 07 Jan 2022 21:35:38 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n64OA-0000IH-2A; Sat, 08 Jan 2022 05:35:38 +0000
Date:   Sat, 08 Jan 2022 13:35:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 2056e2989bf47ad7274ecc5e9dda2add53c112f9
Message-ID: <61d9228c.smEaj263WqrcCvRD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: 2056e2989bf47ad7274ecc5e9dda2add53c112f9  x86/sgx: Fix NULL pointer dereference on non-SGX systems

elapsed time: 728m

configs tested: 140
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220107
m68k                            q40_defconfig
powerpc                        warp_defconfig
arm                       multi_v4t_defconfig
sh                           se7619_defconfig
arm                         cm_x300_defconfig
arm                         lpc18xx_defconfig
sh                          landisk_defconfig
sparc                               defconfig
sh                            shmin_defconfig
powerpc                    sam440ep_defconfig
powerpc                      ppc6xx_defconfig
sh                            hp6xx_defconfig
m68k                       m5475evb_defconfig
powerpc                 linkstation_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                         assabet_defconfig
sparc                            allyesconfig
h8300                            alldefconfig
arm                          simpad_defconfig
um                           x86_64_defconfig
sh                        sh7785lcr_defconfig
powerpc                  iss476-smp_defconfig
sh                           se7750_defconfig
arm                          iop32x_defconfig
powerpc                 canyonlands_defconfig
h8300                            allyesconfig
um                             i386_defconfig
riscv             nommu_k210_sdcard_defconfig
m68k                       m5208evb_defconfig
powerpc                      arches_defconfig
xtensa                              defconfig
sh                              ul2_defconfig
um                                  defconfig
nios2                            allyesconfig
powerpc                      cm5200_defconfig
microblaze                      mmu_defconfig
arm                  randconfig-c002-20220107
arm                  randconfig-c002-20220108
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a005-20220107
x86_64               randconfig-a001-20220107
x86_64               randconfig-a004-20220107
x86_64               randconfig-a006-20220107
x86_64               randconfig-a002-20220107
x86_64               randconfig-a003-20220107
i386                 randconfig-a003-20220107
i386                 randconfig-a005-20220107
i386                 randconfig-a004-20220107
i386                 randconfig-a006-20220107
i386                 randconfig-a002-20220107
i386                 randconfig-a001-20220107
x86_64               randconfig-a015-20220108
x86_64               randconfig-a012-20220108
x86_64               randconfig-a014-20220108
x86_64               randconfig-a013-20220108
x86_64               randconfig-a011-20220108
x86_64               randconfig-a016-20220108
s390                 randconfig-r044-20220108
arc                  randconfig-r043-20220108
riscv                randconfig-r042-20220108
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220108
mips                 randconfig-c004-20220108
i386                 randconfig-c001-20220108
riscv                randconfig-c006-20220108
s390                 randconfig-c005-20220108
powerpc              randconfig-c003-20220108
x86_64               randconfig-c007-20220108
mips                 randconfig-c004-20220107
arm                  randconfig-c002-20220107
i386                 randconfig-c001-20220107
riscv                randconfig-c006-20220107
powerpc              randconfig-c003-20220107
s390                 randconfig-c005-20220107
x86_64               randconfig-c007-20220107
mips                           ip28_defconfig
powerpc                      katmai_defconfig
arm                        mvebu_v5_defconfig
powerpc                     tqm8560_defconfig
powerpc                     skiroot_defconfig
x86_64               randconfig-a012-20220107
x86_64               randconfig-a015-20220107
x86_64               randconfig-a014-20220107
x86_64               randconfig-a013-20220107
x86_64               randconfig-a011-20220107
x86_64               randconfig-a016-20220107
i386                 randconfig-a012-20220107
i386                 randconfig-a016-20220107
i386                 randconfig-a014-20220107
i386                 randconfig-a015-20220107
i386                 randconfig-a011-20220107
i386                 randconfig-a013-20220107
s390                 randconfig-r044-20220107
hexagon              randconfig-r041-20220107
hexagon              randconfig-r045-20220107
riscv                randconfig-r042-20220107

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

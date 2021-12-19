Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818A9479FD6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 08:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhLSH4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 02:56:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:59297 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhLSH42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 02:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639900588; x=1671436588;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/bIwrXvQAWcLoQOCW2fz1kgjuUpCUac5yDV/xuXA11U=;
  b=F3+ZcBy/WgIjwhCNbDPJXOKL7vCcUe/oWGpTdp23h6JGRdSieSWha++v
   1z8QZfkjEEm/i3Cy8lLiuh96I76TJh1sNq6qBb2zWUIffHfG0YpSMe4XQ
   jVC+PSdMyTX1clPYHltw9QnN7EyTBGkdNK1aKBvTOHXwPX7Kc9mQGnbPJ
   wMOmMxAd1XqJgkQ2sE7LSfmZ8IPHoipKJmckPGBtOmgeNEoXVU+AQ3PA1
   jwy0CTzRthc+0abKFdtPy2tGFws2LJIPaYV3Qg+gWGyzxMnDotX/MkXz9
   kt6zCVKdi+ZTjwIffR5M5nmaz3FFCdwBDlVXl22+jftqNFcNYnNWeQoSi
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10202"; a="220669829"
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="220669829"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 23:56:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="467007258"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 Dec 2021 23:56:26 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myr3S-0006ni-78; Sun, 19 Dec 2021 07:56:26 +0000
Date:   Sun, 19 Dec 2021 15:56:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 0f0be91c3f9ea49da23d6c47e9f3634b05b8e77c
Message-ID: <61bee59e.pFsN1abBNMfooINm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 0f0be91c3f9ea49da23d6c47e9f3634b05b8e77c  Merge branch 'irq/msi'

elapsed time: 725m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
mips                        workpad_defconfig
arm                         at91_dt_defconfig
powerpc                   lite5200b_defconfig
arc                            hsdk_defconfig
arm                           u8500_defconfig
sh                     sh7710voipgw_defconfig
powerpc                    sam440ep_defconfig
nios2                            alldefconfig
powerpc                       ebony_defconfig
mips                      malta_kvm_defconfig
arm                           sama5_defconfig
riscv                          rv32_defconfig
powerpc                     powernv_defconfig
um                           x86_64_defconfig
mips                        jmr3927_defconfig
powerpc                     stx_gp3_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         shannon_defconfig
powerpc                    ge_imp3a_defconfig
mips                            ar7_defconfig
sh                        sh7785lcr_defconfig
arm                     davinci_all_defconfig
arm                         lubbock_defconfig
arm                       mainstone_defconfig
powerpc                 mpc834x_mds_defconfig
arm                  randconfig-c002-20211219
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                               defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a011-20211219
x86_64               randconfig-a013-20211219
x86_64               randconfig-a012-20211219
x86_64               randconfig-a014-20211219
x86_64               randconfig-a015-20211219
x86_64               randconfig-a016-20211219
i386                 randconfig-a013-20211219
i386                 randconfig-a011-20211219
i386                 randconfig-a016-20211219
i386                 randconfig-a015-20211219
i386                 randconfig-a014-20211219
i386                 randconfig-a012-20211219
arc                  randconfig-r043-20211219
riscv                randconfig-r042-20211219
s390                 randconfig-r044-20211219
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a001-20211219
x86_64               randconfig-a003-20211219
x86_64               randconfig-a002-20211219
x86_64               randconfig-a004-20211219
x86_64               randconfig-a006-20211219
x86_64               randconfig-a005-20211219
i386                 randconfig-a002-20211219
i386                 randconfig-a001-20211219
i386                 randconfig-a005-20211219
i386                 randconfig-a003-20211219
i386                 randconfig-a006-20211219
i386                 randconfig-a004-20211219
hexagon              randconfig-r045-20211219
hexagon              randconfig-r041-20211219

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B38D470E78
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhLJXVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:21:02 -0500
Received: from mga03.intel.com ([134.134.136.65]:2605 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231804AbhLJXU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639178243; x=1670714243;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XpGZGlWV24W2z4SzJ4ECJUZRQ9E8adK5g/oFEhLxqFc=;
  b=UsSUof5ICNOBGK7B7qp2bVdLnLJ9jPqgz1Oen0tVxdRlGqugFmFEnoAQ
   3pRB7Gv5oXtA9ucCHUOqoUR3wwJRt8rJVcvWTOlgJ6wmtflUHHKJ+Ez2L
   JcZRSJ0UbaoI6de+1vEheOWwvEFlaJEbUL81TZJOYKdfeUBh23NBOyFmI
   RM70gtm6y5/dH1jchIUze5nmcZ4lh+IX8v5HJW7cWsBWiwEZhHR0k5W6W
   em5b2FPJwsz4BhpidaTF5WblVGUsvWwzO4lmxxkA2PnzCmDAeNBB1xLiK
   mwnsdcVFMnwUfBIOd/3V7IgOzx0cghwRvuQUsJwVu4rgs3YaNU1FiWQxQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="238420316"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="238420316"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 15:17:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="463860073"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Dec 2021 15:17:21 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvp8i-0003mx-HT; Fri, 10 Dec 2021 23:17:20 +0000
Date:   Sat, 11 Dec 2021 07:16:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 e463a09af2f0677b9485a7e8e4e70b396b2ffb6f
Message-ID: <61b3dfc8.R7FaKC3ZEJBAZl3h%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: e463a09af2f0677b9485a7e8e4e70b396b2ffb6f  x86: Add straight-line-speculation mitigation

elapsed time: 722m

configs tested: 135
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211210
sh                          rsk7269_defconfig
m68k                             allmodconfig
arm                         lubbock_defconfig
powerpc                         wii_defconfig
mips                      loongson3_defconfig
sh                          lboxre2_defconfig
h8300                       h8s-sim_defconfig
i386                             alldefconfig
arc                    vdk_hs38_smp_defconfig
mips                    maltaup_xpa_defconfig
mips                         cobalt_defconfig
mips                        bcm63xx_defconfig
xtensa                generic_kc705_defconfig
m68k                            q40_defconfig
arc                           tb10x_defconfig
arc                     nsimosci_hs_defconfig
x86_64                           alldefconfig
powerpc                      ppc6xx_defconfig
xtensa                  audio_kc705_defconfig
ia64                         bigsur_defconfig
sh                             sh03_defconfig
ia64                                defconfig
arm64                            alldefconfig
arm                       imx_v4_v5_defconfig
powerpc                  mpc866_ads_defconfig
m68k                          amiga_defconfig
m68k                          sun3x_defconfig
arm                           h5000_defconfig
parisc                           allyesconfig
alpha                            alldefconfig
sparc                               defconfig
sh                               j2_defconfig
powerpc                 mpc8560_ads_defconfig
mips                  cavium_octeon_defconfig
powerpc                      chrp32_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                        m5407c3_defconfig
arc                            hsdk_defconfig
arm                     davinci_all_defconfig
mips                         db1xxx_defconfig
powerpc                     taishan_defconfig
mips                         mpc30x_defconfig
sh                             shx3_defconfig
powerpc                     tqm8541_defconfig
arm                          pxa3xx_defconfig
powerpc                    mvme5100_defconfig
riscv                            alldefconfig
m68k                       m5275evb_defconfig
xtensa                          iss_defconfig
arm                  randconfig-c002-20211210
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a006-20211210
x86_64               randconfig-a005-20211210
x86_64               randconfig-a001-20211210
x86_64               randconfig-a002-20211210
x86_64               randconfig-a003-20211210
x86_64               randconfig-a004-20211210
i386                 randconfig-a001-20211210
i386                 randconfig-a002-20211210
i386                 randconfig-a005-20211210
i386                 randconfig-a003-20211210
i386                 randconfig-a006-20211210
i386                 randconfig-a004-20211210
arc                  randconfig-r043-20211210
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
arm                  randconfig-c002-20211210
x86_64               randconfig-c007-20211210
riscv                randconfig-c006-20211210
mips                 randconfig-c004-20211210
i386                 randconfig-c001-20211210
s390                 randconfig-c005-20211210
powerpc              randconfig-c003-20211210
x86_64               randconfig-a011-20211210
x86_64               randconfig-a012-20211210
x86_64               randconfig-a014-20211210
x86_64               randconfig-a013-20211210
x86_64               randconfig-a016-20211210
x86_64               randconfig-a015-20211210
i386                 randconfig-a013-20211210
i386                 randconfig-a011-20211210
i386                 randconfig-a016-20211210
i386                 randconfig-a014-20211210
i386                 randconfig-a015-20211210
i386                 randconfig-a012-20211210
hexagon              randconfig-r045-20211210
riscv                randconfig-r042-20211210
s390                 randconfig-r044-20211210
hexagon              randconfig-r041-20211210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

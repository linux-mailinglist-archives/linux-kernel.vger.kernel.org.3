Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2151B4718EE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 07:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhLLGuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 01:50:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:1543 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhLLGuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 01:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639291802; x=1670827802;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UngDwz10eoJ8+ZwFjZLI6Ul1V3AWLBWADuHYUrN4hrM=;
  b=SNsdrqV5czGejn+U+BfnH+erJ2xttukpSRvUIEuCloLV6gZsMWRZiOOi
   sOHsYT6pyg7YYoSPDBUxR9IBDe5r4IGl7HADKHf2PtZr0DIzi3a6fTyGC
   jrISKjhFcYeX5R4UOdbv7KzA5A7xcmTHzB8c/GbYTXEUthgS0S/xwfUyx
   qCUUkX6XYfQtl8tJH9inlbV0LdwJsu9Y97+P4sPyMzBTbDOnmeiS9Eb92
   Yf5mqJROkCJxDjEfKY+2XJ/mDreWdhg7zSTUiEWj/Cs7PMGPP6PEY9zOl
   v5MQEr7nRo4hDnSrqVWPAdsxzGAgFojUNJkzJMXy4cAoyalNozLqnuzzB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="238804207"
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="238804207"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 22:50:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="681254070"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Dec 2021 22:50:00 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwIgK-0005U6-8f; Sun, 12 Dec 2021 06:50:00 +0000
Date:   Sun, 12 Dec 2021 14:49:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 8297efc79487755c90bcb74bae4dbf8a4e9f721b
Message-ID: <61b59b79.l94i24W9M7TP45X9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 8297efc79487755c90bcb74bae4dbf8a4e9f721b  Merge branch into tip/master: 'irq/urgent'

elapsed time: 725m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
m68k                        m5307c3_defconfig
arm                        spear6xx_defconfig
sh                             sh03_defconfig
riscv                            alldefconfig
mips                      bmips_stb_defconfig
powerpc                        cell_defconfig
mips                         tb0287_defconfig
arm                       aspeed_g4_defconfig
sh                            titan_defconfig
sh                   sh7770_generic_defconfig
mips                         cobalt_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     mpc512x_defconfig
arc                     nsimosci_hs_defconfig
powerpc                         ps3_defconfig
sparc64                          alldefconfig
arc                        vdk_hs38_defconfig
mips                     loongson1b_defconfig
sh                               j2_defconfig
arm                      integrator_defconfig
arm                  randconfig-c002-20211212
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a001-20211212
x86_64               randconfig-a002-20211212
x86_64               randconfig-a003-20211212
x86_64               randconfig-a004-20211212
x86_64               randconfig-a006-20211212
x86_64               randconfig-a005-20211212
i386                 randconfig-a001-20211212
i386                 randconfig-a002-20211212
i386                 randconfig-a005-20211212
i386                 randconfig-a003-20211212
i386                 randconfig-a006-20211212
i386                 randconfig-a004-20211212
arc                  randconfig-r043-20211212
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a011-20211212
x86_64               randconfig-a012-20211212
x86_64               randconfig-a013-20211212
x86_64               randconfig-a015-20211212
x86_64               randconfig-a014-20211212
x86_64               randconfig-a016-20211212
i386                 randconfig-a013-20211210
i386                 randconfig-a011-20211210
i386                 randconfig-a016-20211210
i386                 randconfig-a014-20211210
i386                 randconfig-a015-20211210
i386                 randconfig-a012-20211210
s390                 randconfig-r044-20211212
hexagon              randconfig-r041-20211212
hexagon              randconfig-r045-20211212
riscv                randconfig-r042-20211212

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

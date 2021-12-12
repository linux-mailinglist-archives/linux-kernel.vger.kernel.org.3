Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F4A4719A2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 11:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhLLKjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 05:39:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:30410 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229724AbhLLKjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 05:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639305546; x=1670841546;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XMVhzZiTwstaNWpaRYUoepnrT4xCDkqdTRvDuIZSxi0=;
  b=lviTU9rkkzO5zpf65R3t2zBE7pOuUOTBAbN71yFqx+v1xKXTHJIs8up2
   vDB0XznXMPl8MyGSOIqj/DwxtvyrKQYHQC9BhMBDWG04J62XAVfJxnETp
   Zvv3ccFo4X//L+IM8HwMoyl3L9Hw/t7mdyn2ooHA0WM9Wav1SKtiWcLv9
   K4wpHucqBKDROQzIV0K1z8DNTt6fdBg84LFUdTrcftGbvwiUhrPp+SmeM
   BT6J/o7CqsIA2Ci6IyKyA4nQ17FEDKP/3NEC+pyIdRMnILE8McEIe64N5
   ebwCE5sPMzW08/DrHs6QryHTyv7TC/2o1+Me9/1lv6tLT3zwaMgd/hbJA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="262711925"
X-IronPort-AV: E=Sophos;i="5.88,200,1635231600"; 
   d="scan'208";a="262711925"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 02:39:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,200,1635231600"; 
   d="scan'208";a="582531337"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2021 02:39:04 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwMG0-0005aB-AU; Sun, 12 Dec 2021 10:39:04 +0000
Date:   Sun, 12 Dec 2021 18:38:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 0f09c274698590d508c43f924d9dffc7130b782d
Message-ID: <61b5d126.Hh93LWLC8St+A+yQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 0f09c274698590d508c43f924d9dffc7130b782d  futex: Fix additional regressions

elapsed time: 720m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc836x_rdk_defconfig
ia64                             allyesconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     mpc512x_defconfig
arc                     nsimosci_hs_defconfig
powerpc                         ps3_defconfig
sparc64                          alldefconfig
powerpc                    sam440ep_defconfig
powerpc                     tqm8541_defconfig
mips                           ip27_defconfig
arm                      tct_hammer_defconfig
sh                           se7712_defconfig
mips                     loongson1b_defconfig
mips                      malta_kvm_defconfig
mips                     cu1000-neo_defconfig
arm                        realview_defconfig
sh                           se7206_defconfig
arm                  randconfig-c002-20211212
ia64                                defconfig
ia64                             allmodconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nds32                               defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
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
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a001-20211212
i386                 randconfig-a002-20211212
i386                 randconfig-a005-20211212
i386                 randconfig-a003-20211212
i386                 randconfig-a006-20211212
i386                 randconfig-a004-20211212
x86_64               randconfig-a001-20211212
x86_64               randconfig-a002-20211212
x86_64               randconfig-a003-20211212
x86_64               randconfig-a004-20211212
x86_64               randconfig-a006-20211212
x86_64               randconfig-a005-20211212
arc                  randconfig-r043-20211212
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211212
arm                  randconfig-c002-20211212
riscv                randconfig-c006-20211212
mips                 randconfig-c004-20211212
i386                 randconfig-c001-20211212
s390                 randconfig-c005-20211212
powerpc              randconfig-c003-20211212
x86_64               randconfig-a011-20211212
x86_64               randconfig-a012-20211212
x86_64               randconfig-a014-20211212
x86_64               randconfig-a013-20211212
x86_64               randconfig-a016-20211212
x86_64               randconfig-a015-20211212
i386                 randconfig-a013-20211212
i386                 randconfig-a011-20211212
i386                 randconfig-a016-20211212
i386                 randconfig-a014-20211212
i386                 randconfig-a015-20211212
i386                 randconfig-a012-20211212
hexagon              randconfig-r045-20211212
s390                 randconfig-r044-20211212
hexagon              randconfig-r041-20211212
riscv                randconfig-r042-20211212

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

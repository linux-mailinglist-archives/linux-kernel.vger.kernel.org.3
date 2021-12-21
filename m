Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6F347C8D0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbhLUVbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:31:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:25967 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236944AbhLUVbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640122284; x=1671658284;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dhM0n7DG5w61MtipLRwn2rzXYvDshX9u90IZfSWI7Yc=;
  b=WZctKQCNJHRQ4/R8PTUkVHAUP+BO05se6jNzntg1HOZ+ipMFShMRNnna
   tdn38AkWq1BpATspWgmCxCyqVcL4oMIQasDOrPiel85BwGRVwY8n+bG9J
   4HNzBfAYbG0tqwVuelthFcS2nAGtS4VtulTbclQsdjjTU+lKAj6QO13YM
   tSr33ZE86np4dCkUSUApzGlY2z4Dalb20DpSZ7hlHK7sKPZIjoqlE2Qg1
   OXhxPfHfsFFZrIHkaHZpesRFhwYSWSnpDeSVExG4/dgi9mn1/xtBGwT/x
   Gwb+RBACIWxGZifeaenzQyFCQUU+C24FxKT+khwjRfLlfJO3HgWszev2x
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240720790"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="240720790"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 13:31:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="616911736"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 Dec 2021 13:31:18 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzmj7-0009ZN-Qz; Tue, 21 Dec 2021 21:31:17 +0000
Date:   Wed, 22 Dec 2021 05:30:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 ab57c081e4ce39845d70ea9c8432d3f12d71d7c5
Message-ID: <61c24776.Qye93OoeHgzkBZsX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: ab57c081e4ce39845d70ea9c8432d3f12d71d7c5  Merge branch into tip/master: 'core/entry'

elapsed time: 729m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
mips                     loongson1c_defconfig
arm                        realview_defconfig
powerpc                  storcenter_defconfig
sh                        edosk7705_defconfig
sh                             espt_defconfig
m68k                       m5275evb_defconfig
arm                              alldefconfig
arm                         cm_x300_defconfig
mips                malta_qemu_32r6_defconfig
sh                           se7712_defconfig
powerpc                 mpc832x_mds_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                 canyonlands_defconfig
powerpc                      ppc44x_defconfig
arm                     eseries_pxa_defconfig
xtensa                          iss_defconfig
mips                       capcella_defconfig
sh                        dreamcast_defconfig
mips                           ci20_defconfig
sh                           se7206_defconfig
mips                        jmr3927_defconfig
m68k                            q40_defconfig
arm                          pcm027_defconfig
powerpc                      katmai_defconfig
arm                         assabet_defconfig
sh                            shmin_defconfig
powerpc                   lite5200b_defconfig
arm                  randconfig-c002-20211220
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a001-20211220
x86_64               randconfig-a003-20211220
x86_64               randconfig-a004-20211220
x86_64               randconfig-a002-20211220
x86_64               randconfig-a006-20211220
x86_64               randconfig-a005-20211220
i386                 randconfig-a002-20211220
i386                 randconfig-a003-20211220
i386                 randconfig-a001-20211220
i386                 randconfig-a006-20211220
i386                 randconfig-a004-20211220
i386                 randconfig-a005-20211220
arc                  randconfig-r043-20211221
riscv                randconfig-r042-20211221
s390                 randconfig-r044-20211221
arc                  randconfig-r043-20211220
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a013-20211220
x86_64               randconfig-a015-20211220
x86_64               randconfig-a014-20211220
x86_64               randconfig-a012-20211220
x86_64               randconfig-a011-20211220
x86_64               randconfig-a016-20211220
hexagon              randconfig-r041-20211221
hexagon              randconfig-r045-20211221
hexagon              randconfig-r041-20211220
hexagon              randconfig-r045-20211220
riscv                randconfig-r042-20211220
s390                 randconfig-r044-20211220

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

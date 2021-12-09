Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDFA46E729
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbhLILCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:02:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:54909 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236327AbhLILB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639047505; x=1670583505;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JAzr9XraNt+l3oHCHUr8SoljnHzcf0h+32SXJEBbMTU=;
  b=M0wn5Fmo/3Ci1tJxy6kBXNFDOOEY0TvvuG0+Vo/8lY66SN3/SijnPHNv
   5b/FgbyhdrbnFRhpPFkJ+WsbAXLtKvvRXj39biY/1pAynoRh1Xyn5IzHO
   fU9Rkfi639NZ8GFAt9/tRYYYdCJY7jBmsPFrxVROOryDtTbNh+Mp4Wuie
   dL0LLXGcT8hPqDZExyEv+OThsbChp7GSf30yDge8PWgVGMsm9gNSR9+bO
   4OklC4TEpBLBunW5Fpc/93N3IChKm/klSMXrDw7XbS8cx6W1C95cr4Y9V
   kQOSRm0VpT2mOd24NZ98d2hWf4xf/fLnEW3fPO7PWnkIqtc7QdxFj3M7m
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="301458712"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="301458712"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 02:58:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="543558771"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Dec 2021 02:58:23 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvH82-0001oa-IL; Thu, 09 Dec 2021 10:58:22 +0000
Date:   Thu, 09 Dec 2021 18:57:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 f16786c556896bb8e500d2868dbb1101ac2a0cd3
Message-ID: <61b1e11c.p64lpvNgL///sm+0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: f16786c556896bb8e500d2868dbb1101ac2a0cd3  Merge locking/core into tip/master

elapsed time: 2366m

configs tested: 164
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211207
sh                        edosk7760_defconfig
riscv                            alldefconfig
arm                            xcep_defconfig
powerpc                   bluestone_defconfig
powerpc                      cm5200_defconfig
arm                        spear3xx_defconfig
h8300                     edosk2674_defconfig
mips                      maltasmvp_defconfig
mips                           rs90_defconfig
h8300                            allyesconfig
sh                        sh7763rdp_defconfig
csky                             alldefconfig
arc                        nsim_700_defconfig
sparc                       sparc64_defconfig
arm                         axm55xx_defconfig
sh                                  defconfig
nios2                         3c120_defconfig
powerpc                      walnut_defconfig
sh                            hp6xx_defconfig
arm                           sunxi_defconfig
powerpc                    socrates_defconfig
arm                          iop32x_defconfig
arm                       versatile_defconfig
arc                     haps_hs_smp_defconfig
m68k                            q40_defconfig
arc                 nsimosci_hs_smp_defconfig
arm64                            alldefconfig
powerpc                       ppc64_defconfig
arc                        nsimosci_defconfig
sh                          rsk7203_defconfig
sh                ecovec24-romimage_defconfig
arm                          ep93xx_defconfig
ia64                             allyesconfig
arm                         shannon_defconfig
sh                           se7722_defconfig
arm                         lpc32xx_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                           se7619_defconfig
powerpc                     stx_gp3_defconfig
arc                      axs103_smp_defconfig
mips                     cu1000-neo_defconfig
arm                        cerfcube_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     ppa8548_defconfig
powerpc                     powernv_defconfig
arm                         hackkit_defconfig
powerpc                      acadia_defconfig
arm                          badge4_defconfig
powerpc                  iss476-smp_defconfig
alpha                               defconfig
xtensa                          iss_defconfig
arm                         nhk8815_defconfig
arm                  randconfig-c002-20211207
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
x86_64               randconfig-a006-20211207
x86_64               randconfig-a005-20211207
x86_64               randconfig-a001-20211207
x86_64               randconfig-a002-20211207
x86_64               randconfig-a004-20211207
x86_64               randconfig-a003-20211207
i386                 randconfig-a001-20211207
i386                 randconfig-a005-20211207
i386                 randconfig-a002-20211207
i386                 randconfig-a003-20211207
i386                 randconfig-a006-20211207
i386                 randconfig-a004-20211207
x86_64               randconfig-a016-20211208
x86_64               randconfig-a011-20211208
x86_64               randconfig-a013-20211208
x86_64               randconfig-a012-20211208
x86_64               randconfig-a015-20211208
x86_64               randconfig-a014-20211208
x86_64               randconfig-a006-20211209
x86_64               randconfig-a005-20211209
x86_64               randconfig-a001-20211209
x86_64               randconfig-a002-20211209
x86_64               randconfig-a004-20211209
x86_64               randconfig-a003-20211209
arc                  randconfig-r043-20211207
arc                  randconfig-r043-20211209
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
arm                  randconfig-c002-20211209
x86_64               randconfig-c007-20211209
riscv                randconfig-c006-20211209
i386                 randconfig-c001-20211209
mips                 randconfig-c004-20211209
powerpc              randconfig-c003-20211209
s390                 randconfig-c005-20211209
i386                 randconfig-a001-20211208
i386                 randconfig-a003-20211208
i386                 randconfig-a002-20211208
i386                 randconfig-a005-20211208
i386                 randconfig-a004-20211208
i386                 randconfig-a006-20211208
x86_64               randconfig-a016-20211209
x86_64               randconfig-a011-20211209
x86_64               randconfig-a013-20211209
x86_64               randconfig-a015-20211209
x86_64               randconfig-a012-20211209
x86_64               randconfig-a014-20211209
i386                 randconfig-a016-20211207
i386                 randconfig-a013-20211207
i386                 randconfig-a011-20211207
i386                 randconfig-a014-20211207
i386                 randconfig-a012-20211207
i386                 randconfig-a015-20211207
s390                 randconfig-r044-20211207
hexagon              randconfig-r041-20211207
hexagon              randconfig-r045-20211207
riscv                randconfig-r042-20211207
s390                 randconfig-r044-20211209
hexagon              randconfig-r041-20211209
riscv                randconfig-r042-20211209
hexagon              randconfig-r045-20211209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

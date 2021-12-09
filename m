Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D4D46F6B5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhLIWYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:24:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:4085 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232317AbhLIWYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639088442; x=1670624442;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kmZUlSxY9+fNYgxgYgneXb5H8nisX/u+yk0IcU0/X9U=;
  b=QZ8rF72fxE8L1hzCa+aId1rRXdhg/4tpSdnTVys52h/PUmJSG3MYgcPN
   VRGkKb3DTqC10aai8UikA16sUg2Cjo+WeoFiWvQ+hiHCrgMH4TbtGmlKT
   TkoIUf0hTOcv0DKQ1hPhUg+8KukLSwMkoPFndG4YTHRkj/Jh5t2dnJ18I
   08SBj1IKdtDmUQy0yY0Iy4m2nyZuUp9CIX3GqaMoF+vJG3Yfmij4d3lAz
   r2wYSML/IpkElzUOHjoqXsFXx9qOBBptqhbr9KQoZgHCyGn1Siv4wQ390
   qkXkiHJaV/Rm3mGfZU5VNDJjb5lRoTI1Np+29OKrd4LDEaoFGn9b0f02C
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="262325271"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="262325271"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 14:20:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="680508247"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Dec 2021 14:20:41 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvRmK-0002R7-C4; Thu, 09 Dec 2021 22:20:40 +0000
Date:   Fri, 10 Dec 2021 06:20:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 20f07a044a76aebaaa0603038857229b5c460d69
Message-ID: <61b28116.+kvNAOGj9jXWStMK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/sev
branch HEAD: 20f07a044a76aebaaa0603038857229b5c460d69  x86/sev: Move common memory encryption code to mem_encrypt.c

elapsed time: 1761m

configs tested: 170
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211207
sh                        edosk7760_defconfig
riscv                            alldefconfig
arm                            xcep_defconfig
powerpc                    socrates_defconfig
sh                          r7780mp_defconfig
m68k                       m5208evb_defconfig
sh                          sdk7780_defconfig
mips                        qi_lb60_defconfig
sh                        sh7763rdp_defconfig
csky                             alldefconfig
arc                        nsim_700_defconfig
arm                    vt8500_v6_v7_defconfig
riscv                          rv32_defconfig
sh                          polaris_defconfig
nios2                         10m50_defconfig
powerpc                     asp8347_defconfig
powerpc                    sam440ep_defconfig
powerpc                      tqm8xx_defconfig
m68k                        m5307c3_defconfig
arm                             mxs_defconfig
sh                        apsh4ad0a_defconfig
arm                          iop32x_defconfig
arm                       versatile_defconfig
arm                        spear3xx_defconfig
arc                     haps_hs_smp_defconfig
m68k                            q40_defconfig
arc                 nsimosci_hs_smp_defconfig
arm64                            alldefconfig
powerpc                       ppc64_defconfig
arc                        nsimosci_defconfig
powerpc                          g5_defconfig
mips                        bcm63xx_defconfig
arm                         nhk8815_defconfig
arm                         shannon_defconfig
sh                           se7722_defconfig
arm                         lpc32xx_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                           se7619_defconfig
powerpc                     stx_gp3_defconfig
m68k                             alldefconfig
arm                           sama5_defconfig
powerpc                     sequoia_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                   currituck_defconfig
arm                           tegra_defconfig
powerpc                     mpc512x_defconfig
powerpc                      pasemi_defconfig
sh                            titan_defconfig
m68k                       m5275evb_defconfig
sh                        edosk7705_defconfig
arm                  randconfig-c002-20211207
arm                  randconfig-c002-20211209
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
sparc                            allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211209
x86_64               randconfig-a005-20211209
x86_64               randconfig-a001-20211209
x86_64               randconfig-a002-20211209
x86_64               randconfig-a004-20211209
x86_64               randconfig-a003-20211209
x86_64               randconfig-a001-20211207
x86_64               randconfig-a002-20211207
x86_64               randconfig-a003-20211207
x86_64               randconfig-a005-20211207
x86_64               randconfig-a004-20211207
x86_64               randconfig-a006-20211207
i386                 randconfig-a001-20211207
i386                 randconfig-a005-20211207
i386                 randconfig-a002-20211207
i386                 randconfig-a003-20211207
i386                 randconfig-a006-20211207
i386                 randconfig-a004-20211207
i386                 randconfig-a001-20211209
i386                 randconfig-a005-20211209
i386                 randconfig-a003-20211209
i386                 randconfig-a002-20211209
i386                 randconfig-a006-20211209
i386                 randconfig-a004-20211209
x86_64               randconfig-a016-20211208
x86_64               randconfig-a011-20211208
x86_64               randconfig-a013-20211208
x86_64               randconfig-a012-20211208
x86_64               randconfig-a015-20211208
x86_64               randconfig-a014-20211208
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-a016-20211209
x86_64               randconfig-a011-20211209
x86_64               randconfig-a013-20211209
x86_64               randconfig-a015-20211209
x86_64               randconfig-a012-20211209
x86_64               randconfig-a014-20211209
i386                 randconfig-a013-20211209
i386                 randconfig-a016-20211209
i386                 randconfig-a011-20211209
i386                 randconfig-a014-20211209
i386                 randconfig-a012-20211209
i386                 randconfig-a015-20211209
i386                 randconfig-a016-20211207
i386                 randconfig-a013-20211207
i386                 randconfig-a011-20211207
i386                 randconfig-a014-20211207
i386                 randconfig-a012-20211207
i386                 randconfig-a015-20211207
hexagon              randconfig-r045-20211209
s390                 randconfig-r044-20211209
hexagon              randconfig-r041-20211209
riscv                randconfig-r042-20211209
hexagon              randconfig-r045-20211207
s390                 randconfig-r044-20211207
riscv                randconfig-r042-20211207
hexagon              randconfig-r041-20211207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

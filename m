Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B438147114E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 04:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244649AbhLKDqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 22:46:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:7132 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237709AbhLKDqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 22:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639194149; x=1670730149;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Gw8Un5buuLc2nGIlo6e0wCCcMH/7tJ51T5hvY1l8Dno=;
  b=AKBqdD+vj3E2ZiN2gB+en4nGiJQ3xP3JM7cgyXSfZQRkpz1yDakz4jpb
   euDS4pZk48OFLIsVqLMyMrYoH33Kwhj+mWXWNjGatAd+GLQx8dtIzIXTn
   2RtQOHnGg9TMSe0jrT1T0kOLYAhAs/qillLdIFFJ9AJvNVuW62eQ5sRkH
   RfIt+muAk7MbhON6EkI27NwfAwsOEtuKox6w7eBgtJoQl9McrtPZ0pKkV
   fRralihYZyqCCO3b5eXR4ekm9k3OmNUAfSWwmI/+j14gpHCDcAa5SUdAV
   FHoyJs5W4jemuB60qDI27G/gPKy0Sh0HZyCuSykUy0vqUf6Z15EqpzvGO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="236018430"
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="236018430"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 19:42:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="463931548"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Dec 2021 19:42:28 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvtHH-00044I-FF; Sat, 11 Dec 2021 03:42:27 +0000
Date:   Sat, 11 Dec 2021 11:41:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 ab0ae3d5a15f609f013d59c20b2436da5190f84b
Message-ID: <61b41dfa.xNnS/1TwKtPN7B0y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: ab0ae3d5a15f609f013d59c20b2436da5190f84b  rcu: Add mutex for rcu boost kthread spawning and affinity setting

elapsed time: 765m

configs tested: 154
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
sh                          r7780mp_defconfig
powerpc                          g5_defconfig
arm                  colibri_pxa270_defconfig
m68k                                defconfig
openrisc                         alldefconfig
powerpc                       ebony_defconfig
arm                           h5000_defconfig
sh                      rts7751r2d1_defconfig
arm                       aspeed_g5_defconfig
sparc64                             defconfig
arm                          ixp4xx_defconfig
sh                           se7780_defconfig
mips                     cu1830-neo_defconfig
powerpc                 xes_mpc85xx_defconfig
ia64                        generic_defconfig
arm                           sama7_defconfig
powerpc                       holly_defconfig
powerpc                   motionpro_defconfig
powerpc                    mvme5100_defconfig
sh                   sh7770_generic_defconfig
powerpc                        icon_defconfig
h8300                       h8s-sim_defconfig
i386                             alldefconfig
arc                    vdk_hs38_smp_defconfig
mips                    maltaup_xpa_defconfig
mips                         cobalt_defconfig
mips                        bcm63xx_defconfig
m68k                            q40_defconfig
arc                           tb10x_defconfig
arc                     nsimosci_hs_defconfig
xtensa                generic_kc705_defconfig
nios2                         3c120_defconfig
arm                       multi_v4t_defconfig
sh                           se7619_defconfig
arm                      integrator_defconfig
mips                     loongson2k_defconfig
um                             i386_defconfig
powerpc                     sequoia_defconfig
arm                         lpc32xx_defconfig
microblaze                      mmu_defconfig
sh                        edosk7705_defconfig
sh                             sh03_defconfig
ia64                                defconfig
arm64                            alldefconfig
sh                          rsk7203_defconfig
sh                          polaris_defconfig
arm                             mxs_defconfig
arm                            hisi_defconfig
arm                       imx_v4_v5_defconfig
powerpc                  mpc866_ads_defconfig
m68k                          amiga_defconfig
m68k                          sun3x_defconfig
parisc                           allyesconfig
powerpc                 mpc8540_ads_defconfig
m68k                       bvme6000_defconfig
powerpc                      ppc40x_defconfig
mips                  cavium_octeon_defconfig
powerpc                      chrp32_defconfig
m68k                        m5407c3_defconfig
arc                            hsdk_defconfig
openrisc                  or1klitex_defconfig
powerpc                     pq2fads_defconfig
alpha                            alldefconfig
arm                       netwinder_defconfig
x86_64                              defconfig
powerpc                     tqm8541_defconfig
arm                          pxa3xx_defconfig
riscv                            alldefconfig
m68k                       m5275evb_defconfig
xtensa                          iss_defconfig
arm                  randconfig-c002-20211210
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
x86_64               randconfig-a012-20211210
x86_64               randconfig-a014-20211210
x86_64               randconfig-a013-20211210
x86_64               randconfig-a016-20211210
x86_64               randconfig-a015-20211210
x86_64               randconfig-a011-20211210
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

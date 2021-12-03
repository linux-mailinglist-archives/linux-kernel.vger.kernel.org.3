Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34B2467296
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378880AbhLCHa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:30:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:41461 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343808AbhLCHa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:30:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="223802979"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="223802979"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 23:27:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="678003130"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2021 23:27:00 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mt2yB-000HDz-PJ; Fri, 03 Dec 2021 07:26:59 +0000
Date:   Fri, 03 Dec 2021 15:25:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 9a951429b2e1670a76b68c90880b01430fe509e4
Message-ID: <61a9c685.oLMwVvxQ1VHgrfIY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 9a951429b2e1670a76b68c90880b01430fe509e4  x86/mm: Fix PAGE_KERNEL_IO removal breakage

elapsed time: 729m

configs tested: 173
configs skipped: 74

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211202
i386                 randconfig-c001-20211203
powerpc                    sam440ep_defconfig
nds32                            alldefconfig
powerpc                     asp8347_defconfig
arm                             rpc_defconfig
powerpc                      ppc44x_defconfig
arm                        shmobile_defconfig
arm                       imx_v6_v7_defconfig
um                             i386_defconfig
powerpc                     sequoia_defconfig
arm                          ep93xx_defconfig
arm                     davinci_all_defconfig
h8300                     edosk2674_defconfig
sh                           se7724_defconfig
powerpc                      cm5200_defconfig
powerpc                     ppa8548_defconfig
powerpc                      chrp32_defconfig
powerpc                     powernv_defconfig
sh                          r7785rp_defconfig
arc                        nsim_700_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     tqm8541_defconfig
arm                        mini2440_defconfig
sh                        apsh4ad0a_defconfig
sh                         ap325rxa_defconfig
arm                         socfpga_defconfig
arm                        spear6xx_defconfig
sh                   sh7770_generic_defconfig
arm                            hisi_defconfig
sh                          landisk_defconfig
arm                           u8500_defconfig
powerpc                     taishan_defconfig
arm                  colibri_pxa300_defconfig
sh                             sh03_defconfig
sh                          sdk7780_defconfig
xtensa                  audio_kc705_defconfig
arm                            qcom_defconfig
arm                     eseries_pxa_defconfig
ia64                          tiger_defconfig
sh                               j2_defconfig
powerpc                          allmodconfig
microblaze                          defconfig
arm                       omap2plus_defconfig
arm                          iop32x_defconfig
arm                         vf610m4_defconfig
sh                           se7619_defconfig
arc                          axs103_defconfig
m68k                       m5208evb_defconfig
powerpc                    mvme5100_defconfig
powerpc                     mpc83xx_defconfig
xtensa                       common_defconfig
arm                        multi_v7_defconfig
arc                              allyesconfig
um                           x86_64_defconfig
sparc                               defconfig
powerpc                    gamecube_defconfig
sh                            shmin_defconfig
sh                          sdk7786_defconfig
arm                           h5000_defconfig
m68k                             allmodconfig
m68k                                defconfig
arm                  randconfig-c002-20211203
arm                  randconfig-c002-20211202
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
nios2                               defconfig
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
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211203
x86_64               randconfig-a005-20211203
x86_64               randconfig-a001-20211203
x86_64               randconfig-a002-20211203
x86_64               randconfig-a004-20211203
x86_64               randconfig-a003-20211203
i386                 randconfig-a001-20211203
i386                 randconfig-a005-20211203
i386                 randconfig-a002-20211203
i386                 randconfig-a003-20211203
i386                 randconfig-a006-20211203
i386                 randconfig-a004-20211203
x86_64               randconfig-a016-20211202
x86_64               randconfig-a011-20211202
x86_64               randconfig-a013-20211202
x86_64               randconfig-a014-20211202
x86_64               randconfig-a012-20211202
x86_64               randconfig-a015-20211202
i386                 randconfig-a016-20211202
i386                 randconfig-a013-20211202
i386                 randconfig-a011-20211202
i386                 randconfig-a014-20211202
i386                 randconfig-a012-20211202
i386                 randconfig-a015-20211202
arc                  randconfig-r043-20211202
s390                 randconfig-r044-20211202
riscv                randconfig-r042-20211202
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
arm                  randconfig-c002-20211202
x86_64               randconfig-c007-20211202
riscv                randconfig-c006-20211202
i386                 randconfig-c001-20211202
powerpc              randconfig-c003-20211202
s390                 randconfig-c005-20211202
arm                  randconfig-c002-20211203
x86_64               randconfig-c007-20211203
riscv                randconfig-c006-20211203
mips                 randconfig-c004-20211203
i386                 randconfig-c001-20211203
powerpc              randconfig-c003-20211203
s390                 randconfig-c005-20211203
x86_64               randconfig-a006-20211202
x86_64               randconfig-a005-20211202
x86_64               randconfig-a001-20211202
x86_64               randconfig-a002-20211202
x86_64               randconfig-a004-20211202
x86_64               randconfig-a003-20211202
i386                 randconfig-a001-20211202
i386                 randconfig-a005-20211202
i386                 randconfig-a002-20211202
i386                 randconfig-a003-20211202
i386                 randconfig-a006-20211202
i386                 randconfig-a004-20211202
x86_64               randconfig-a016-20211203
x86_64               randconfig-a011-20211203
x86_64               randconfig-a013-20211203
x86_64               randconfig-a014-20211203
x86_64               randconfig-a015-20211203
x86_64               randconfig-a012-20211203
i386                 randconfig-a016-20211203
i386                 randconfig-a013-20211203
i386                 randconfig-a011-20211203
i386                 randconfig-a014-20211203
i386                 randconfig-a012-20211203
i386                 randconfig-a015-20211203
hexagon              randconfig-r045-20211203
s390                 randconfig-r044-20211203
hexagon              randconfig-r041-20211203
riscv                randconfig-r042-20211203

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD75476A12
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhLPF7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 00:59:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:39981 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231468AbhLPF7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 00:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639634382; x=1671170382;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ccssznjGs/rg8GgfK3KuhTo2j9qFQEYFQksqf9RAL0w=;
  b=SqJvofLz819+3L6YgsHg42KnEDMsyxemLi+0FCPFN6d7ISYrPEYwSr81
   22DlTjvKlT1UvH72/NIM4LNrE8JmHxXSXM8mybTUNEgPJBfTwhDelvKST
   BJ5cWIzPXr10O2KSaH0ZBqUIM2HuQDp0S5GmGX0BgdMAsAXwcJJVHYO9u
   1KLZ791VW0sEJenEneb/CIM6YbZk4q9+c5ISTO2CRnOK6hJ2c2wc7aAft
   OCuULmRkgvz2SEEsLZ30yAw7dPyEvBsEyz0p/lFbfSthj9kaznfzfEtc1
   qd0U8hoeZnR8UnlgECPwc2iC9sOf+LCdjuFxYLi8iC8W7nYWJFh/Aqd5z
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="220092273"
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="220092273"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 21:59:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="662334733"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Dec 2021 21:59:40 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxjnn-0002oU-Hg; Thu, 16 Dec 2021 05:59:39 +0000
Date:   Thu, 16 Dec 2021 13:59:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/msi] BUILD SUCCESS
 91f7d2dbf952f54442fa81bb62f78ee023179bf9
Message-ID: <61bad5c1.VgM3riPO/pHsQNwc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi
branch HEAD: 91f7d2dbf952f54442fa81bb62f78ee023179bf9  x86/xen: Use correct #ifdef guard for xen_initdom_restore_msi()

elapsed time: 728m

configs tested: 158
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm                              allyesconfig
mips                 randconfig-c004-20211214
i386                 randconfig-c001-20211214
m68k                          hp300_defconfig
arm                        clps711x_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     tqm8540_defconfig
sh                          rsk7203_defconfig
arm                          moxart_defconfig
arm                      footbridge_defconfig
mips                            gpr_defconfig
sh                     magicpanelr2_defconfig
arm                         s3c6400_defconfig
arm                           stm32_defconfig
powerpc                       ppc64_defconfig
powerpc                 mpc837x_mds_defconfig
arm                          lpd270_defconfig
m68k                        mvme16x_defconfig
arm                            hisi_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                          axs103_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                   sh7770_generic_defconfig
arm                         palmz72_defconfig
mips                          rb532_defconfig
arm                          exynos_defconfig
sh                         apsh4a3a_defconfig
arm                        mvebu_v5_defconfig
um                                  defconfig
sh                                  defconfig
sh                        edosk7760_defconfig
mips                          ath79_defconfig
arc                        vdk_hs38_defconfig
powerpc                      pcm030_defconfig
sh                             espt_defconfig
mips                 decstation_r4k_defconfig
sparc                               defconfig
powerpc                      katmai_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                           ci20_defconfig
arm                              alldefconfig
powerpc                      tqm8xx_defconfig
arm                          gemini_defconfig
mips                         tb0226_defconfig
sh                              ul2_defconfig
arm                            zeus_defconfig
nios2                         10m50_defconfig
powerpc                      arches_defconfig
xtensa                              defconfig
m68k                        stmark2_defconfig
powerpc                 mpc836x_rdk_defconfig
m68k                        m5407c3_defconfig
powerpc                          g5_defconfig
mips                     loongson1c_defconfig
sh                   rts7751r2dplus_defconfig
h8300                       h8s-sim_defconfig
arm                           h3600_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                               j2_defconfig
arm                        keystone_defconfig
sh                        edosk7705_defconfig
mips                         tb0287_defconfig
powerpc                     powernv_defconfig
arc                      axs103_smp_defconfig
arm                         orion5x_defconfig
sh                          lboxre2_defconfig
arm                  randconfig-c002-20211214
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
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211214
x86_64               randconfig-a005-20211214
x86_64               randconfig-a001-20211214
x86_64               randconfig-a002-20211214
x86_64               randconfig-a003-20211214
x86_64               randconfig-a004-20211214
i386                 randconfig-a001-20211214
i386                 randconfig-a002-20211214
i386                 randconfig-a005-20211214
i386                 randconfig-a003-20211214
i386                 randconfig-a006-20211214
i386                 randconfig-a004-20211214
x86_64               randconfig-a006-20211216
x86_64               randconfig-a005-20211216
x86_64               randconfig-a001-20211216
x86_64               randconfig-a002-20211216
x86_64               randconfig-a003-20211216
x86_64               randconfig-a004-20211216
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
arm                  randconfig-c002-20211215
x86_64               randconfig-c007-20211215
riscv                randconfig-c006-20211215
mips                 randconfig-c004-20211215
i386                 randconfig-c001-20211215
s390                 randconfig-c005-20211215
powerpc              randconfig-c003-20211215
x86_64               randconfig-a011-20211214
x86_64               randconfig-a014-20211214
x86_64               randconfig-a012-20211214
x86_64               randconfig-a013-20211214
x86_64               randconfig-a016-20211214
x86_64               randconfig-a015-20211214
hexagon              randconfig-r045-20211214
s390                 randconfig-r044-20211214
riscv                randconfig-r042-20211214
hexagon              randconfig-r041-20211214
hexagon              randconfig-r045-20211216
s390                 randconfig-r044-20211216
riscv                randconfig-r042-20211216
hexagon              randconfig-r041-20211216

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

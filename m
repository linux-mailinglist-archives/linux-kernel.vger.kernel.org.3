Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2163146E6F9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhLIKuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:50:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:48962 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232702AbhLIKuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639046791; x=1670582791;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TaHltV4gXbhnaMP8aXblz8KcC+ovhTZ3rpeAYDViLTU=;
  b=HgfbQngi0qLY2zAuJqgzIKuoOENep692Sm5Q8uIK99RzrhVjml8YDbM+
   L5hdXsoYzDmsluNWZ5al2iYw8nOZMsAi20r/t0+DVq4SJAKZ5znt+odmA
   IiFSeGAI9eblwVuFhQUX0bNkULVeHzBqkNNqwq2mbbuLbnyq/lRH/nedU
   qBPU71oMqf8pBI3mQBBKFeGtqX5R4chpNPTZXrsjrNWUsQcIvC0igc/5W
   SrFrDxEjKM4EOUXev960947/6WPReOqlip2Sq83NRk2BcnuBpWXJR9Lh8
   H2fM0Wq0a+nBcJ01c8ZqRb8gaoWLW/ADgmLbmsemJgM8brsV2KX9pRfkv
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="238014195"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="238014195"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 02:45:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="612458292"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 09 Dec 2021 02:45:19 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvGvO-0001n6-Ia; Thu, 09 Dec 2021 10:45:18 +0000
Date:   Thu, 09 Dec 2021 18:44:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 ef8df9798d469b7c45c66664550e93469749f1e8
Message-ID: <61b1de08.mCibImPJaCxBZBSS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: ef8df9798d469b7c45c66664550e93469749f1e8  sched/fair: Cleanup task_util and capacity type

elapsed time: 732m

configs tested: 209
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211207
i386                 randconfig-c001-20211209
powerpc                      mgcoge_defconfig
arm                        mvebu_v7_defconfig
m68k                        stmark2_defconfig
arm                          imote2_defconfig
sh                        edosk7760_defconfig
riscv                            alldefconfig
arm                            xcep_defconfig
sh                        sh7763rdp_defconfig
csky                             alldefconfig
arc                        nsim_700_defconfig
sh                           se7206_defconfig
arc                      axs103_smp_defconfig
mips                           mtx1_defconfig
m68k                       m5249evb_defconfig
arm                           spitz_defconfig
powerpc64                        alldefconfig
sh                            titan_defconfig
powerpc                  storcenter_defconfig
arm                          lpd270_defconfig
parisc                           alldefconfig
arm                        spear6xx_defconfig
arm                           h5000_defconfig
arm                         orion5x_defconfig
powerpc                      chrp32_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                      pcm030_defconfig
powerpc                     sequoia_defconfig
arm                         mv78xx0_defconfig
um                           x86_64_defconfig
arm                         palmz72_defconfig
arm                       versatile_defconfig
powerpc                 canyonlands_defconfig
sh                           se7750_defconfig
arm                         lpc18xx_defconfig
arm                            hisi_defconfig
powerpc                        icon_defconfig
powerpc                       ebony_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc6xx_defconfig
mips                         tb0287_defconfig
sh                          landisk_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                      pxa255-idp_defconfig
mips                       lemote2f_defconfig
arm                        clps711x_defconfig
sh                     sh7710voipgw_defconfig
arm                      integrator_defconfig
powerpc                      makalu_defconfig
m68k                             alldefconfig
arm                           sama5_defconfig
powerpc                          g5_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                            zeus_defconfig
powerpc                      cm5200_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         hackkit_defconfig
arm                          badge4_defconfig
powerpc                  iss476-smp_defconfig
powerpc                      acadia_defconfig
h8300                       h8s-sim_defconfig
sh                   sh7724_generic_defconfig
powerpc               mpc834x_itxgp_defconfig
um                                  defconfig
arc                     nsimosci_hs_defconfig
sh                          lboxre2_defconfig
xtensa                generic_kc705_defconfig
powerpc                        warp_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                     magicpanelr2_defconfig
powerpc                 mpc834x_itx_defconfig
i386                                defconfig
sh                           se7343_defconfig
sh                            migor_defconfig
arm                       aspeed_g4_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                 mpc8540_ads_defconfig
sparc                       sparc64_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
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
x86_64               randconfig-a006-20211209
x86_64               randconfig-a005-20211209
x86_64               randconfig-a001-20211209
x86_64               randconfig-a002-20211209
x86_64               randconfig-a004-20211209
x86_64               randconfig-a003-20211209
i386                 randconfig-a001-20211209
i386                 randconfig-a005-20211209
i386                 randconfig-a003-20211209
i386                 randconfig-a002-20211209
i386                 randconfig-a006-20211209
i386                 randconfig-a004-20211209
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
i386                 randconfig-a013-20211208
i386                 randconfig-a016-20211208
i386                 randconfig-a011-20211208
i386                 randconfig-a014-20211208
i386                 randconfig-a012-20211208
i386                 randconfig-a015-20211208
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211207
arm                  randconfig-c002-20211207
riscv                randconfig-c006-20211207
i386                 randconfig-c001-20211207
powerpc              randconfig-c003-20211207
s390                 randconfig-c005-20211207
arm                  randconfig-c002-20211209
x86_64               randconfig-c007-20211209
riscv                randconfig-c006-20211209
i386                 randconfig-c001-20211209
mips                 randconfig-c004-20211209
powerpc              randconfig-c003-20211209
s390                 randconfig-c005-20211209
x86_64               randconfig-a016-20211207
x86_64               randconfig-a011-20211207
x86_64               randconfig-a013-20211207
x86_64               randconfig-a014-20211207
x86_64               randconfig-a015-20211207
x86_64               randconfig-a012-20211207
i386                 randconfig-a016-20211207
i386                 randconfig-a013-20211207
i386                 randconfig-a011-20211207
i386                 randconfig-a014-20211207
i386                 randconfig-a012-20211207
i386                 randconfig-a015-20211207
i386                 randconfig-a013-20211209
i386                 randconfig-a016-20211209
i386                 randconfig-a011-20211209
i386                 randconfig-a014-20211209
i386                 randconfig-a012-20211209
i386                 randconfig-a015-20211209
hexagon              randconfig-r045-20211208
hexagon              randconfig-r041-20211208
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

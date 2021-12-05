Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474F3468C7C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbhLER7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:59:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:21037 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232874AbhLER7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:59:04 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="261228166"
X-IronPort-AV: E=Sophos;i="5.87,289,1631602800"; 
   d="scan'208";a="261228166"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 09:55:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,289,1631602800"; 
   d="scan'208";a="461565197"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Dec 2021 09:55:35 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtvja-000KNL-Pe; Sun, 05 Dec 2021 17:55:34 +0000
Date:   Mon, 06 Dec 2021 01:54:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 cd21e779ff218178e90dac267940863be5f60cb3
Message-ID: <61acfcea.53QI0rjubqRyCsAM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: cd21e779ff218178e90dac267940863be5f60cb3  kcsan: Turn barrier instrumentation into macros

elapsed time: 721m

configs tested: 147
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       aspeed_g4_defconfig
arm                         axm55xx_defconfig
arm                          moxart_defconfig
powerpc                 mpc8272_ads_defconfig
arm                         lubbock_defconfig
sh                               allmodconfig
riscv                    nommu_k210_defconfig
openrisc                         alldefconfig
sh                        sh7785lcr_defconfig
sparc                            allyesconfig
powerpc                    klondike_defconfig
arm                             rpc_defconfig
powerpc                    amigaone_defconfig
arm                           h3600_defconfig
arm                   milbeaut_m10v_defconfig
arm                        mvebu_v7_defconfig
ia64                            zx1_defconfig
powerpc                     tqm8541_defconfig
arm                          ep93xx_defconfig
m68k                            mac_defconfig
arm                          badge4_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      tqm8xx_defconfig
m68k                         amcore_defconfig
arm                        cerfcube_defconfig
xtensa                          iss_defconfig
powerpc                     kilauea_defconfig
arm                     eseries_pxa_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                       m5208evb_defconfig
powerpc                     pseries_defconfig
powerpc                      ppc64e_defconfig
powerpc                     sequoia_defconfig
powerpc                    socrates_defconfig
sh                           se7712_defconfig
arm                           stm32_defconfig
arm                      integrator_defconfig
sh                           se7780_defconfig
sh                   sh7724_generic_defconfig
powerpc                    ge_imp3a_defconfig
m68k                         apollo_defconfig
sh                          r7780mp_defconfig
csky                                defconfig
arm                           tegra_defconfig
h8300                            alldefconfig
powerpc                      cm5200_defconfig
s390                       zfcpdump_defconfig
um                           x86_64_defconfig
sh                        sh7757lcr_defconfig
sh                           se7721_defconfig
arm                         cm_x300_defconfig
powerpc                     mpc83xx_defconfig
m68k                           sun3_defconfig
sh                              ul2_defconfig
sh                         apsh4a3a_defconfig
m68k                          atari_defconfig
powerpc                          g5_defconfig
sh                            migor_defconfig
arm                           sama5_defconfig
arm                          pxa910_defconfig
arm                          gemini_defconfig
powerpc                 mpc8313_rdb_defconfig
riscv                          rv32_defconfig
arm                  randconfig-c002-20211205
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
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211205
x86_64               randconfig-a005-20211205
x86_64               randconfig-a001-20211205
x86_64               randconfig-a002-20211205
x86_64               randconfig-a004-20211205
x86_64               randconfig-a003-20211205
i386                 randconfig-a001-20211205
i386                 randconfig-a005-20211205
i386                 randconfig-a003-20211205
i386                 randconfig-a002-20211205
i386                 randconfig-a006-20211205
i386                 randconfig-a004-20211205
arc                  randconfig-r043-20211205
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211205
arm                  randconfig-c002-20211205
riscv                randconfig-c006-20211205
mips                 randconfig-c004-20211205
i386                 randconfig-c001-20211205
powerpc              randconfig-c003-20211205
s390                 randconfig-c005-20211205
x86_64               randconfig-a011-20211205
x86_64               randconfig-a013-20211205
x86_64               randconfig-a015-20211205
x86_64               randconfig-a012-20211205
x86_64               randconfig-a014-20211205
x86_64               randconfig-a016-20211205
i386                 randconfig-a013-20211205
i386                 randconfig-a011-20211205
i386                 randconfig-a014-20211205
i386                 randconfig-a012-20211205
i386                 randconfig-a015-20211205
i386                 randconfig-a016-20211205
hexagon              randconfig-r045-20211205
s390                 randconfig-r044-20211205
riscv                randconfig-r042-20211205
hexagon              randconfig-r041-20211205

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

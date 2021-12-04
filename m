Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37C1468833
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhLDXRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 18:17:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:28343 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbhLDXRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:17:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="217174596"
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="217174596"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 15:14:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="501638827"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2021 15:14:05 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mteEG-000JY1-Ka; Sat, 04 Dec 2021 23:14:04 +0000
Date:   Sun, 05 Dec 2021 07:14:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 315c4f884800c45cb6bd8c90422fad554a8b9588
Message-ID: <61abf638.jpE/YhzUH+W/NZTg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent
branch HEAD: 315c4f884800c45cb6bd8c90422fad554a8b9588  sched/uclamp: Fix rq->uclamp_max not set on first enqueue

possible Warning in current branch (please contact us if interested):

kernel/sched/rt.c:257:6: warning: no previous prototype for 'unregister_rt_sched_group' [-Wmissing-prototypes]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-defconfig
|   `-- kernel-sched-rt.c:warning:no-previous-prototype-for-unregister_rt_sched_group
|-- csky-defconfig
|   `-- kernel-sched-rt.c:warning:no-previous-prototype-for-unregister_rt_sched_group
|-- m68k-defconfig
|   `-- kernel-sched-rt.c:warning:no-previous-prototype-for-unregister_rt_sched_group
|-- mips-randconfig-r021-20211203
|   `-- kernel-sched-rt.c:warning:no-previous-prototype-for-unregister_rt_sched_group
|-- nds32-allnoconfig
|   `-- kernel-sched-rt.c:warning:no-previous-prototype-for-unregister_rt_sched_group
|-- nds32-defconfig
|   `-- kernel-sched-rt.c:warning:no-previous-prototype-for-unregister_rt_sched_group
|-- nios2-defconfig
|   `-- kernel-sched-rt.c:warning:no-previous-prototype-for-unregister_rt_sched_group
|-- openrisc-randconfig-r026-20211203
|   `-- kernel-sched-rt.c:warning:no-previous-prototype-for-unregister_rt_sched_group
|-- powerpc-allnoconfig
|   `-- kernel-sched-rt.c:warning:no-previous-prototype-for-unregister_rt_sched_group
|-- riscv-allnoconfig
|   `-- kernel-sched-rt.c:warning:no-previous-prototype-for-unregister_rt_sched_group
|-- riscv-nommu_k210_defconfig
|   `-- kernel-sched-rt.c:warning:no-previous-prototype-for-unregister_rt_sched_group
|-- riscv-nommu_virt_defconfig
|   `-- kernel-sched-rt.c:warning:no-previous-prototype-for-unregister_rt_sched_group
`-- sparc-defconfig
    `-- kernel-sched-rt.c:warning:no-previous-prototype-for-unregister_rt_sched_group

elapsed time: 727m

configs tested: 209
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
mips                 randconfig-c004-20211203
i386                 randconfig-c001-20211203
arm                        clps711x_defconfig
alpha                            alldefconfig
ia64                         bigsur_defconfig
sh                             shx3_defconfig
arc                        vdk_hs38_defconfig
sh                          landisk_defconfig
arm                       imx_v6_v7_defconfig
arm                           tegra_defconfig
powerpc                     mpc5200_defconfig
sh                      rts7751r2d1_defconfig
s390                                defconfig
arm                         shannon_defconfig
powerpc                 mpc8540_ads_defconfig
sh                        edosk7760_defconfig
powerpc                     tqm8555_defconfig
openrisc                    or1ksim_defconfig
arc                              allyesconfig
sh                            hp6xx_defconfig
nios2                               defconfig
powerpc                  mpc866_ads_defconfig
sh                          kfr2r09_defconfig
arm                             rpc_defconfig
mips                          ath79_defconfig
powerpc                    klondike_defconfig
sparc                            allyesconfig
arm                         axm55xx_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                          atari_defconfig
powerpc                     tqm8560_defconfig
sh                     sh7710voipgw_defconfig
arm                       aspeed_g5_defconfig
powerpc                      cm5200_defconfig
powerpc                     skiroot_defconfig
arm                           sunxi_defconfig
powerpc                     tqm8541_defconfig
mips                      pic32mzda_defconfig
arm                          ep93xx_defconfig
m68k                            mac_defconfig
arm                          badge4_defconfig
arc                     nsimosci_hs_defconfig
powerpc                 linkstation_defconfig
powerpc                     asp8347_defconfig
mips                    maltaup_xpa_defconfig
powerpc                    gamecube_defconfig
mips                            e55_defconfig
arc                         haps_hs_defconfig
sh                           se7712_defconfig
arm                         assabet_defconfig
powerpc                       eiger_defconfig
powerpc                          g5_defconfig
powerpc                      katmai_defconfig
arm                        neponset_defconfig
arm                      integrator_defconfig
powerpc                     kilauea_defconfig
arm                         lubbock_defconfig
mips                         mpc30x_defconfig
h8300                       h8s-sim_defconfig
openrisc                  or1klitex_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                       m5249evb_defconfig
m68k                       m5275evb_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                            qcom_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        mvebu_v5_defconfig
sh                        sh7785lcr_defconfig
arm                            mps2_defconfig
mips                         bigsur_defconfig
m68k                       bvme6000_defconfig
riscv                          rv32_defconfig
arm                         cm_x300_defconfig
powerpc                    amigaone_defconfig
powerpc                     mpc83xx_defconfig
m68k                           sun3_defconfig
sh                              ul2_defconfig
arm                    vt8500_v6_v7_defconfig
i386                             allyesconfig
arc                     haps_hs_smp_defconfig
m68k                        m5307c3_defconfig
sh                         apsh4a3a_defconfig
sh                            migor_defconfig
arm                  randconfig-c002-20211203
arm                  randconfig-c002-20211205
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
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
i386                 randconfig-a001-20211205
i386                 randconfig-a005-20211205
i386                 randconfig-a003-20211205
i386                 randconfig-a002-20211205
i386                 randconfig-a006-20211205
i386                 randconfig-a004-20211205
x86_64               randconfig-a006-20211205
x86_64               randconfig-a005-20211205
x86_64               randconfig-a001-20211205
x86_64               randconfig-a002-20211205
x86_64               randconfig-a004-20211205
x86_64               randconfig-a003-20211205
arc                  randconfig-r043-20211203
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
x86_64               randconfig-c007-20211205
arm                  randconfig-c002-20211205
riscv                randconfig-c006-20211205
mips                 randconfig-c004-20211205
i386                 randconfig-c001-20211205
powerpc              randconfig-c003-20211205
s390                 randconfig-c005-20211205
x86_64               randconfig-a006-20211204
x86_64               randconfig-a005-20211204
x86_64               randconfig-a001-20211204
x86_64               randconfig-a002-20211204
x86_64               randconfig-a004-20211204
x86_64               randconfig-a003-20211204
i386                 randconfig-a001-20211204
i386                 randconfig-a005-20211204
i386                 randconfig-a003-20211204
i386                 randconfig-a002-20211204
i386                 randconfig-a006-20211204
i386                 randconfig-a004-20211204
x86_64               randconfig-a016-20211205
x86_64               randconfig-a011-20211205
x86_64               randconfig-a013-20211205
x86_64               randconfig-a015-20211205
x86_64               randconfig-a012-20211205
x86_64               randconfig-a014-20211205
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
i386                 randconfig-a013-20211205
i386                 randconfig-a016-20211205
i386                 randconfig-a011-20211205
i386                 randconfig-a014-20211205
i386                 randconfig-a012-20211205
i386                 randconfig-a015-20211205
hexagon              randconfig-r045-20211204
hexagon              randconfig-r041-20211204
hexagon              randconfig-r045-20211205
s390                 randconfig-r044-20211205
riscv                randconfig-r042-20211205
hexagon              randconfig-r041-20211205
hexagon              randconfig-r045-20211203
s390                 randconfig-r044-20211203
hexagon              randconfig-r041-20211203
riscv                randconfig-r042-20211203

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

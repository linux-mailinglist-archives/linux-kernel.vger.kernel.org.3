Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336E94670AC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244433AbhLCDYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:24:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:58822 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245593AbhLCDYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:24:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="260904573"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="260904573"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 19:20:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="460724828"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 02 Dec 2021 19:20:53 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msz80-000H29-AU; Fri, 03 Dec 2021 03:20:52 +0000
Date:   Fri, 03 Dec 2021 11:20:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 e7f2be115f0746b969c0df14c0d182f65f005ca5
Message-ID: <61a98d0e.d7Txej/YXUyUDgpw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: e7f2be115f0746b969c0df14c0d182f65f005ca5  sched/cputime: Fix getrusage(RUSAGE_THREAD) with nohz_full

possible Warning in current branch (please contact us if interested):

kernel/sched/rt.c:257:6: warning: no previous prototype for 'unregister_rt_sched_group' [-Wmissing-prototypes]
kernel/sched/rt.c:257:6: warning: no previous prototype for function 'unregister_rt_sched_group' [-Wmissing-prototypes]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- openrisc-randconfig-r012-20211202
|   `-- kernel-sched-rt.c:warning:no-previous-prototype-for-unregister_rt_sched_group
`-- parisc-randconfig-r013-20211202
    `-- kernel-sched-rt.c:warning:no-previous-prototype-for-unregister_rt_sched_group

clang_recent_errors
`-- arm-randconfig-r014-20211202
    `-- kernel-sched-rt.c:warning:no-previous-prototype-for-function-unregister_rt_sched_group

elapsed time: 731m

configs tested: 161
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211202
arm                         lubbock_defconfig
xtensa                       common_defconfig
sh                            migor_defconfig
microblaze                          defconfig
arm                  colibri_pxa300_defconfig
arm                         hackkit_defconfig
powerpc                     asp8347_defconfig
m68k                         amcore_defconfig
h8300                               defconfig
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
sh                             sh03_defconfig
sh                          sdk7780_defconfig
xtensa                  audio_kc705_defconfig
ia64                                defconfig
x86_64                           alldefconfig
arm                      footbridge_defconfig
sh                   rts7751r2dplus_defconfig
s390                       zfcpdump_defconfig
riscv                    nommu_k210_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                        stmark2_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                           omap1_defconfig
arm                     am200epdkit_defconfig
arm                        vexpress_defconfig
powerpc                     skiroot_defconfig
arm                       imx_v6_v7_defconfig
sh                               j2_defconfig
powerpc                          allmodconfig
sh                         apsh4a3a_defconfig
arm                            pleb_defconfig
h8300                            alldefconfig
arm                      tct_hammer_defconfig
arc                              alldefconfig
m68k                           sun3_defconfig
arm                       mainstone_defconfig
sh                          r7780mp_defconfig
sh                ecovec24-romimage_defconfig
powerpc                      ppc44x_defconfig
s390                          debug_defconfig
m68k                          amiga_defconfig
xtensa                          iss_defconfig
arm                        spear3xx_defconfig
sh                          sdk7786_defconfig
powerpc                    gamecube_defconfig
arm                           h5000_defconfig
m68k                             allmodconfig
m68k                                defconfig
arm                  randconfig-c002-20211202
arm                  randconfig-c002-20211203
ia64                             allmodconfig
ia64                             allyesconfig
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
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
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
arm                  randconfig-c002-20211202
x86_64               randconfig-c007-20211202
riscv                randconfig-c006-20211202
i386                 randconfig-c001-20211202
powerpc              randconfig-c003-20211202
s390                 randconfig-c005-20211202
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
i386                 randconfig-a016-20211203
i386                 randconfig-a013-20211203
i386                 randconfig-a011-20211203
i386                 randconfig-a014-20211203
i386                 randconfig-a012-20211203
hexagon              randconfig-r045-20211202
hexagon              randconfig-r041-20211202

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

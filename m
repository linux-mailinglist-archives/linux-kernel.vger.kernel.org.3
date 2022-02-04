Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E201F4A9A69
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353461AbiBDNz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:55:29 -0500
Received: from mga07.intel.com ([134.134.136.100]:28697 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233073AbiBDNz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643982928; x=1675518928;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HvZB57k6fTmUJuZ2cLYcd3W3I6NOwegvW/l5f4MolQs=;
  b=XsjNUEzBrX5V/mF5Z6aumUOoV7GompJYEUUILOvvAjmrX3uLKDCWVMu7
   3y8i7tGMwz8MKa/rUknJZdPWNJP6VRq7p3qPClrnX39DEzrXkTWgM1Dj6
   4LZhZvQvHFmPnvvXIOPfPz5zOnlXEAx4Nt12sK9rd0f9Z2yWRx42BpNmY
   AW25+8UVTwmGTS0abXx/vHAPT5WQ+TsOC8vDZbGwm2UE0nvxR8l28ctVS
   3oqSO6JXoosNkeJek1+C6+vFcKrZ4/tf2zZXloxdcWgYo8dPSMj/A6Oq9
   r7VvXxboovLk67lvPYSkJMFSYg9+u8/3U7ucs1vK51F9a4yj07t1/tXoE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="311671119"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="311671119"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 05:55:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="677104552"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 04 Feb 2022 05:55:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFz3e-000Xgb-17; Fri, 04 Feb 2022 13:55:26 +0000
Date:   Fri, 04 Feb 2022 21:54:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.02.02a] BUILD SUCCESS
 50d89f397e66a1de85f8ae9955e6cce7e3fdde57
Message-ID: <61fd3033.bCEcQXD7W23VaJBV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.02.02a
branch HEAD: 50d89f397e66a1de85f8ae9955e6cce7e3fdde57  rcu-tasks: Set ->percpu_enqueue_shift to zero upon contention

elapsed time: 2132m

configs tested: 207
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220131
powerpc              randconfig-c003-20220131
i386                          randconfig-c001
m68k                          hp300_defconfig
sh                   sh7724_generic_defconfig
arc                    vdk_hs38_smp_defconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
arc                         haps_hs_defconfig
sh                           sh2007_defconfig
powerpc                     stx_gp3_defconfig
mips                           gcw0_defconfig
arm                           sunxi_defconfig
openrisc                    or1ksim_defconfig
arm                         assabet_defconfig
mips                 decstation_r4k_defconfig
m68k                          multi_defconfig
powerpc                       maple_defconfig
m68k                        stmark2_defconfig
arc                        nsimosci_defconfig
m68k                        m5307c3_defconfig
sh                        apsh4ad0a_defconfig
sparc                       sparc32_defconfig
microblaze                      mmu_defconfig
powerpc                   motionpro_defconfig
powerpc                       eiger_defconfig
sh                   secureedge5410_defconfig
arc                        nsim_700_defconfig
mips                           ci20_defconfig
sh                           se7750_defconfig
sh                         microdev_defconfig
arc                            hsdk_defconfig
arm                         vf610m4_defconfig
parisc                           allyesconfig
arc                          axs101_defconfig
ia64                             allmodconfig
powerpc                      ep88xc_defconfig
mips                          rb532_defconfig
arm                            mps2_defconfig
s390                       zfcpdump_defconfig
h8300                       h8s-sim_defconfig
powerpc                      pcm030_defconfig
parisc                generic-64bit_defconfig
sh                           se7721_defconfig
sparc                            allyesconfig
powerpc                     mpc83xx_defconfig
mips                         bigsur_defconfig
powerpc                   currituck_defconfig
powerpc                     tqm8548_defconfig
powerpc                 canyonlands_defconfig
s390                          debug_defconfig
nds32                             allnoconfig
microblaze                          defconfig
sh                           se7206_defconfig
nds32                               defconfig
arm                            qcom_defconfig
powerpc                     pq2fads_defconfig
m68k                            q40_defconfig
sh                              ul2_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                ecovec24-romimage_defconfig
m68k                       m5249evb_defconfig
arm                             rpc_defconfig
arm                             pxa_defconfig
sh                             espt_defconfig
mips                           ip32_defconfig
powerpc                       holly_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                        sh7785lcr_defconfig
sh                     magicpanelr2_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     taishan_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     rainier_defconfig
mips                    maltaup_xpa_defconfig
openrisc                 simple_smp_defconfig
sh                          rsk7203_defconfig
sh                         ecovec24_defconfig
ia64                         bigsur_defconfig
um                                  defconfig
arm                         nhk8815_defconfig
arm                  randconfig-c002-20220202
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
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
riscv                randconfig-c006-20220201
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220201
mips                 randconfig-c004-20220201
i386                          randconfig-c001
arm                  randconfig-c002-20220201
riscv                randconfig-c006-20220130
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
arm                       imx_v4_v5_defconfig
powerpc                     ppa8548_defconfig
arm                        mvebu_v5_defconfig
riscv                    nommu_virt_defconfig
arm                         lpc32xx_defconfig
hexagon                             defconfig
arm                         socfpga_defconfig
x86_64                           allyesconfig
arm                         shannon_defconfig
powerpc                     tqm5200_defconfig
arm                           sama7_defconfig
arm                       spear13xx_defconfig
arm                         hackkit_defconfig
arm                           spitz_defconfig
mips                          ath79_defconfig
mips                  cavium_octeon_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                          imote2_defconfig
powerpc                      katmai_defconfig
powerpc                     kilauea_defconfig
arm                              alldefconfig
powerpc                      obs600_defconfig
powerpc                 mpc832x_mds_defconfig
arm                          pcm027_defconfig
powerpc                       ebony_defconfig
mips                malta_qemu_32r6_defconfig
mips                      bmips_stb_defconfig
arm                          pxa168_defconfig
mips                        workpad_defconfig
powerpc                        icon_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
i386                 randconfig-a011-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0A149B056
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574279AbiAYJc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:32:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:32553 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1573833AbiAYJ10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:27:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643102846; x=1674638846;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BslUopwdkn6hqPPPjIlnIuLGFxUBwc2V6iMFkRY3pak=;
  b=a4u60lE0S3M0cbKlwePYhNia+g6HE/XwfAVdmh9BAMNS0D+bzcEFEUVo
   icggdexsLQ1vYjtY9D1MW1pLjiGJWiBt0DTYGeDSmjVkmgbNMSWp3nSx5
   C5e2Mzf5U6CEQOdqt7/stBlHxFLIPl0T8K9Fu8QtM7ElCIHQeQZFA2sJ6
   O6IP4T0KzH0IxJexw0S+yLcToiOUvRU3nlczw6938rzH2F/DHEhf+By4w
   aXmYxAqvKaW1SpTZUkwZcTkADxfJcM8i3lLba4bzPpL+bi2ELGnHPzpAQ
   lxubJmr9btBrM5YyEmTlKFr1wS2z7XPQ8iz8K5GjwVvTTYsLuyqOXuffa
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="243860549"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="243860549"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 01:16:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="673931295"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2022 01:16:33 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCHwH-000JdQ-9t; Tue, 25 Jan 2022 09:16:33 +0000
Date:   Tue, 25 Jan 2022 17:15:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 ab2a290a7391fdf42c3d3cf3b278143b84856ee1
Message-ID: <61efbfcf.LMZi+O1sdP6v9nPU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: ab2a290a7391fdf42c3d3cf3b278143b84856ee1  rcu: Replace cpumask_weight with cpumask_empty where appropriate

elapsed time: 1822m

configs tested: 211
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
arc                 nsimosci_hs_smp_defconfig
arm                       imx_v6_v7_defconfig
i386                                defconfig
xtensa                       common_defconfig
m68k                          multi_defconfig
sh                 kfr2r09-romimage_defconfig
mips                         bigsur_defconfig
powerpc                     rainier_defconfig
mips                      maltasmvp_defconfig
m68k                          hp300_defconfig
m68k                        mvme16x_defconfig
sh                   sh7770_generic_defconfig
arc                           tb10x_defconfig
sh                           se7722_defconfig
mips                     decstation_defconfig
sparc                       sparc64_defconfig
powerpc                      ppc6xx_defconfig
mips                            gpr_defconfig
arc                          axs101_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     asp8347_defconfig
sh                           se7751_defconfig
sh                         microdev_defconfig
powerpc                     stx_gp3_defconfig
sh                          polaris_defconfig
um                                  defconfig
m68k                             allyesconfig
powerpc                           allnoconfig
arm                         cm_x300_defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc837x_mds_defconfig
sh                           sh2007_defconfig
sh                          kfr2r09_defconfig
nios2                         10m50_defconfig
powerpc                     sequoia_defconfig
arm                           h5000_defconfig
sh                          rsk7269_defconfig
arm                         vf610m4_defconfig
sh                            shmin_defconfig
riscv                    nommu_k210_defconfig
m68k                          atari_defconfig
openrisc                            defconfig
csky                                defconfig
sh                           se7206_defconfig
ia64                          tiger_defconfig
arc                            hsdk_defconfig
arm                       multi_v4t_defconfig
arm                        trizeps4_defconfig
sparc                       sparc32_defconfig
arm                        mvebu_v7_defconfig
arm                           viper_defconfig
sh                   sh7724_generic_defconfig
ia64                        generic_defconfig
arm                          simpad_defconfig
h8300                       h8s-sim_defconfig
alpha                               defconfig
ia64                            zx1_defconfig
xtensa                              defconfig
xtensa                generic_kc705_defconfig
openrisc                         alldefconfig
i386                             alldefconfig
arc                        vdk_hs38_defconfig
sh                           se7780_defconfig
mips                         cobalt_defconfig
arm                           sunxi_defconfig
sh                         ap325rxa_defconfig
arc                         haps_hs_defconfig
powerpc                     mpc83xx_defconfig
h8300                            alldefconfig
sh                          r7780mp_defconfig
mips                  maltasmvp_eva_defconfig
sh                             shx3_defconfig
parisc                generic-32bit_defconfig
riscv                            allmodconfig
powerpc                     tqm8541_defconfig
sh                          sdk7780_defconfig
microblaze                      mmu_defconfig
arc                     haps_hs_smp_defconfig
sh                          r7785rp_defconfig
powerpc                      cm5200_defconfig
arm                           u8500_defconfig
openrisc                 simple_smp_defconfig
powerpc                    amigaone_defconfig
arm                            lart_defconfig
mips                        bcm47xx_defconfig
xtensa                          iss_defconfig
mips                            ar7_defconfig
arm                       aspeed_g5_defconfig
arm                  randconfig-c002-20220123
arm                  randconfig-c002-20220124
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a001-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
i386                 randconfig-a002-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a006-20220124
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220124
riscv                randconfig-c006-20220124
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220124
x86_64               randconfig-c007-20220124
powerpc                       ebony_defconfig
mips                       rbtx49xx_defconfig
arm                        spear3xx_defconfig
arm                                 defconfig
arm                     am200epdkit_defconfig
mips                          ath79_defconfig
mips                        workpad_defconfig
mips                     loongson2k_defconfig
arm                             mxs_defconfig
mips                        bcm63xx_defconfig
mips                     cu1000-neo_defconfig
mips                  cavium_octeon_defconfig
mips                        omega2p_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                   milbeaut_m10v_defconfig
arm                           sama7_defconfig
powerpc                     kmeter1_defconfig
powerpc                     mpc512x_defconfig
mips                           ip22_defconfig
mips                   sb1250_swarm_defconfig
mips                         tb0287_defconfig
arm                        vexpress_defconfig
mips                            e55_defconfig
powerpc                          g5_defconfig
arm                          imote2_defconfig
mips                           mtx1_defconfig
powerpc                   lite5200b_defconfig
powerpc                     tqm5200_defconfig
mips                       lemote2f_defconfig
powerpc                        icon_defconfig
powerpc                     mpc5200_defconfig
powerpc                     tqm8560_defconfig
mips                      maltaaprp_defconfig
mips                     cu1830-neo_defconfig
arm                        neponset_defconfig
arm                     davinci_all_defconfig
powerpc                      ppc44x_defconfig
arm                              alldefconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
riscv                randconfig-r042-20220124
hexagon              randconfig-r045-20220123
hexagon              randconfig-r045-20220124
hexagon              randconfig-r041-20220124
hexagon              randconfig-r041-20220123

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

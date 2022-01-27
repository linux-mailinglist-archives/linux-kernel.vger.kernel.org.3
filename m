Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6887249DFDC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbiA0Ku6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:50:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:55176 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233448AbiA0Kuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643280655; x=1674816655;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IIcFQcNnmoFXfCZm+wl/TFNBrrqeXuU1a6Y00BepP1Y=;
  b=h2Faja2l0+tERTt2e+R79qJ4tAzcfj0kAEelsc5k2ZZcu88xWh3z6vjK
   a7G/TB+YiyuR7/ExCLoA5qwNMyNkhplFYmiJHcAW5H3ckQwxrgu/JDLeR
   krFcq8RHOT9cHSjbfGEnDYuo7RvsOrJHz76c7J1MBTLMHxA+az98gmle3
   ohKnmunFGFr/cNh5XQ9EvjbHHWeNu/+XzN1531VE8GGfWaHSemZQsk8yx
   iYTgRJaaUIa6wK6ZwusbSFoIU0Tc9QVaEpYC70cAB4rHz5I1q8rRrIOSY
   t4H9y8FY4tp4bzgv12ZoL3QXmS5cU855amLOLg7PF6n0ReoVoeAOr5GLE
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="244416705"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="244416705"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 02:50:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="581430621"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jan 2022 02:50:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nD2Mf-000MVF-1y; Thu, 27 Jan 2022 10:50:53 +0000
Date:   Thu, 27 Jan 2022 18:49:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.01.25a] BUILD SUCCESS
 fa92d727f94486195e12dc782fec17d103072101
Message-ID: <61f278d1.gPHEq2M+kJEHn5xp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.01.25a
branch HEAD: fa92d727f94486195e12dc782fec17d103072101  srcutree: Use export for srcu_struct defined by DEFINE_STATIC_SRCU()

elapsed time: 836m

configs tested: 169
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
m68k                         apollo_defconfig
arc                    vdk_hs38_smp_defconfig
mips                  decstation_64_defconfig
sh                         ecovec24_defconfig
sparc64                          alldefconfig
h8300                    h8300h-sim_defconfig
arm                         nhk8815_defconfig
mips                         rt305x_defconfig
arm                            zeus_defconfig
nios2                         10m50_defconfig
xtensa                              defconfig
arc                        vdk_hs38_defconfig
sh                          rsk7269_defconfig
ia64                        generic_defconfig
sh                           sh2007_defconfig
um                                  defconfig
xtensa                  audio_kc705_defconfig
mips                         cobalt_defconfig
powerpc                      makalu_defconfig
arm                         lubbock_defconfig
sh                           se7722_defconfig
m68k                          amiga_defconfig
powerpc                      ppc6xx_defconfig
arm                             ezx_defconfig
arm                          pxa3xx_defconfig
powerpc                      pasemi_defconfig
m68k                       m5208evb_defconfig
arm                        oxnas_v6_defconfig
sh                   sh7724_generic_defconfig
sparc                            allyesconfig
arc                            hsdk_defconfig
arm                            hisi_defconfig
i386                             alldefconfig
sh                             espt_defconfig
m68k                         amcore_defconfig
mips                 decstation_r4k_defconfig
sh                            migor_defconfig
openrisc                 simple_smp_defconfig
powerpc                      tqm8xx_defconfig
m68k                       m5249evb_defconfig
h8300                            alldefconfig
arm                           corgi_defconfig
arm                          pxa910_defconfig
powerpc                  iss476-smp_defconfig
arm                  randconfig-c002-20220127
arm                  randconfig-c002-20220124
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
sh                               allmodconfig
arc                                 defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220125
arc                  randconfig-r043-20220125
arc                  randconfig-r043-20220124
s390                 randconfig-r044-20220125
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
arm                  colibri_pxa300_defconfig
arm                          imote2_defconfig
powerpc                      obs600_defconfig
arm                            mmp2_defconfig
mips                   sb1250_swarm_defconfig
powerpc                    socrates_defconfig
arm                              alldefconfig
arm                      pxa255-idp_defconfig
hexagon                             defconfig
mips                     loongson2k_defconfig
arm                        neponset_defconfig
powerpc                     kmeter1_defconfig
arm                           omap1_defconfig
powerpc                     skiroot_defconfig
i386                             allyesconfig
powerpc                      walnut_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                        fsp2_defconfig
powerpc                      katmai_defconfig
riscv                          rv32_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
riscv                randconfig-r042-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r041-20220124
s390                 randconfig-r044-20220124
riscv                randconfig-r042-20220126
hexagon              randconfig-r045-20220126
hexagon              randconfig-r041-20220126

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

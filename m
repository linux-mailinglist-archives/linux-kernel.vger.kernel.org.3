Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5860E4C426F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239563AbiBYKio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiBYKig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:38:36 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73513CF3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645785484; x=1677321484;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+9HfgleLO5mmjMRlqezvKr2Ck1pBw1IsGGw6GT9YZ80=;
  b=D6uXXQ1rHALBLBubdaBPjHkV/ENy4eB+lW2+Y58zr0Jd+gZifIyK+LWf
   SEGHIldsJQFoVXr+yBOBlnTIt7vRoI15QQo4fNSjMEKi7wH0SBtvefGdZ
   CrLjyWsCN67Zz537DwN/fJI4RpUi6+qZDonM1TOGOkKJ20DM0JHuIonuR
   YuCpbTXymKI6L2kz+T8IGp8ICv5hLyOi/dRP1RAQr1bCxah9/K93B4bDo
   1xoXKza2m8EJvynkMLo42lD+fssQMtpUViIL73nHkc56gJ4MRDEa/35lK
   g1JNZL2bW+/Ehtmt98Z3AiyRA2Il4gxtKbQdKCWYx9L6kqEchogTPOALB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252667577"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="252667577"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 02:38:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="707820158"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Feb 2022 02:38:00 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNXz5-0004C5-N7; Fri, 25 Feb 2022 10:37:59 +0000
Date:   Fri, 25 Feb 2022 18:37:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 9f0daba62e958c31326c7a9eae33651e3a3cc6b4
Message-ID: <6218b16e.8GOE1TON+M0qj7GJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 9f0daba62e958c31326c7a9eae33651e3a3cc6b4  torture: Make thread detection more robust by using lspcu

elapsed time: 796m

configs tested: 135
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220225
mips                 randconfig-c004-20220225
arm                        spear6xx_defconfig
powerpc                     sequoia_defconfig
microblaze                      mmu_defconfig
powerpc                  iss476-smp_defconfig
h8300                     edosk2674_defconfig
sh                           se7751_defconfig
arm                         s3c6400_defconfig
arm                         assabet_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                         wii_defconfig
powerpc64                        alldefconfig
mips                         rt305x_defconfig
arm                           sama5_defconfig
arm64                            alldefconfig
sh                            shmin_defconfig
x86_64                              defconfig
powerpc                     mpc83xx_defconfig
mips                         db1xxx_defconfig
powerpc                      bamboo_defconfig
m68k                         amcore_defconfig
arm                        keystone_defconfig
openrisc                         alldefconfig
powerpc                     redwood_defconfig
powerpc                        warp_defconfig
xtensa                    xip_kc705_defconfig
arc                    vdk_hs38_smp_defconfig
h8300                               defconfig
sh                           se7780_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          lboxre2_defconfig
arm                            zeus_defconfig
arc                            hsdk_defconfig
powerpc                     tqm8555_defconfig
arc                          axs103_defconfig
arm                  randconfig-c002-20220223
arm                  randconfig-c002-20220224
arm                  randconfig-c002-20220225
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220223
arc                  randconfig-r043-20220224
riscv                randconfig-r042-20220224
s390                 randconfig-r044-20220224
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
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20220225
x86_64                        randconfig-c007
arm                  randconfig-c002-20220225
mips                 randconfig-c004-20220225
i386                          randconfig-c001
riscv                randconfig-c006-20220225
i386                             allyesconfig
arm                         orion5x_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220223
hexagon              randconfig-r041-20220223
riscv                randconfig-r042-20220223
hexagon              randconfig-r041-20220224
hexagon              randconfig-r045-20220224
s390                 randconfig-r044-20220223
hexagon              randconfig-r045-20220225
hexagon              randconfig-r041-20220225
riscv                randconfig-r042-20220225

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

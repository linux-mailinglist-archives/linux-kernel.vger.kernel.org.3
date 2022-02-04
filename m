Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703AA4A9B94
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359508AbiBDPDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:03:49 -0500
Received: from mga12.intel.com ([192.55.52.136]:56366 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353524AbiBDPDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643987027; x=1675523027;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eN25JFn1Lr4vWxdrtdGhIpVzCDCbrGcrzyv9SoyZpe8=;
  b=QuZ1wstSO7Re0EZCR2SHks8MmrF8J4Itl5LqfOEOFej6y4szzth7aQTZ
   PAd/1TRnJWQqSfSRb4+SydPyc0iusICBXeAGcCFEzarqQW5GYWbb7FBbN
   Z8vbCVN+DFugGHjm2n/ocRcdtIx1KPBSzbSy4MwLU1MkXidCtPt16UtZ9
   QZ0viUiaL5D8cPvhMIt3y6+c01x03b0+k37epSzdxxP/8FvKGeKORc7CM
   EoiIwSieTWmCc1QWy44gdJ2qOEWaCsRNtZUUL2ThvzGiDbpKiUtLdbQV9
   x4RIcoNzaR5sj5LYIA7eaxHUUtTWKzaYqTlVrjG+OWn1GBBjP4bI2D6Vq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="228352105"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="228352105"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 07:03:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="631726347"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Feb 2022 07:03:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nG07U-000Xl9-KY; Fri, 04 Feb 2022 15:03:28 +0000
Date:   Fri, 04 Feb 2022 23:02:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 d51c69ea4ca3075d24dac8f20c1023cc9627ff28
Message-ID: <61fd4018.oaKncrZekS8TdV+j%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: d51c69ea4ca3075d24dac8f20c1023cc9627ff28  rcu-tasks: Set ->percpu_enqueue_shift to zero upon contention

elapsed time: 794m

configs tested: 147
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
m68k                        stmark2_defconfig
arc                        nsimosci_defconfig
powerpc                       maple_defconfig
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
arm                           sunxi_defconfig
powerpc                     mpc83xx_defconfig
powerpc                     stx_gp3_defconfig
mips                         bigsur_defconfig
powerpc                   currituck_defconfig
powerpc                     tqm8548_defconfig
powerpc                 canyonlands_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                ecovec24-romimage_defconfig
m68k                       m5249evb_defconfig
arm                             rpc_defconfig
arm                             pxa_defconfig
sh                             espt_defconfig
mips                           ip32_defconfig
microblaze                      mmu_defconfig
xtensa                           allyesconfig
powerpc                     pq2fads_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                     magicpanelr2_defconfig
powerpc                     rainier_defconfig
mips                    maltaup_xpa_defconfig
openrisc                 simple_smp_defconfig
nios2                         10m50_defconfig
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
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
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
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
mips                          malta_defconfig
x86_64                           allyesconfig
mips                          ath79_defconfig
powerpc                     ppa8548_defconfig
powerpc                      obs600_defconfig
arm                         socfpga_defconfig
powerpc                 mpc832x_mds_defconfig
arm                          pcm027_defconfig
arm                           spitz_defconfig
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
hexagon              randconfig-r045-20220203
hexagon              randconfig-r041-20220203
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

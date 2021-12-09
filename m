Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5067C46E837
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbhLIMUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:20:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:60294 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231759AbhLIMUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639052187; x=1670588187;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gbBIKAHopvCeruDlTLwpSaVOKDPmuaUDOGbLXejgYtk=;
  b=QKUVubwrPujvAvQJqb22/4Hln2/2Tsig5Cn1O5V9cRwpA2qt1BjdTG1n
   /qIRAc4cvAng24/Tol4wgVQsynqHGLeHRsgqqVZ6z6JK8NwOGJiRebT7I
   0YQ7Yi86JUVytEjqf9C/mXWAwXLKVfrtM6EtfYG5RiE4E654oWTBI6iWc
   4b3FibSmXw6o+SPUKqrxJgXAN+YnchgfRc02zjS9lPE1plSo9+yqRzsoa
   OU4rKtXVHlXaUBVX4r5vta2XAqU0doMRWVqJ09FV5RmXYj5qvY1B5jcoJ
   55guicENO2FJNH/t4pWSz5luC9uKzA1rOHE70/jbN1lV9IK9I8WJG4uDr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="301468948"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="301468948"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 04:16:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="503468790"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 09 Dec 2021 04:16:25 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvILY-0001sw-AV; Thu, 09 Dec 2021 12:16:24 +0000
Date:   Thu, 09 Dec 2021 20:15:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 07f892dade6a3b08fb833e2e9cf5074afc0d937f
Message-ID: <61b1f35a.W8TXaYmVjUlnR/n4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 07f892dade6a3b08fb833e2e9cf5074afc0d937f  EXP workqueue: Fix unbind_workers() VS wq_worker_sleeping() race

elapsed time: 1842m

configs tested: 105
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211207
m68k                             alldefconfig
arc                           tb10x_defconfig
arm                           tegra_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                        workpad_defconfig
sh                             espt_defconfig
arm                      footbridge_defconfig
powerpc                      acadia_defconfig
sh                     sh7710voipgw_defconfig
sh                           se7721_defconfig
arm                        mvebu_v7_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                         ecovec24_defconfig
arm                         orion5x_defconfig
sh                           se7780_defconfig
i386                             allyesconfig
mips                         db1xxx_defconfig
sh                          sdk7786_defconfig
arc                            hsdk_defconfig
powerpc                      katmai_defconfig
s390                                defconfig
arm                  randconfig-c002-20211207
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
sparc                               defconfig
i386                   debian-10.3-kselftests
sparc                            allyesconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211207
x86_64               randconfig-a005-20211207
x86_64               randconfig-a001-20211207
x86_64               randconfig-a002-20211207
x86_64               randconfig-a004-20211207
x86_64               randconfig-a003-20211207
i386                 randconfig-a001-20211207
i386                 randconfig-a005-20211207
i386                 randconfig-a002-20211207
i386                 randconfig-a003-20211207
i386                 randconfig-a006-20211207
i386                 randconfig-a004-20211207
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
x86_64               randconfig-c007-20211207
arm                  randconfig-c002-20211207
riscv                randconfig-c006-20211207
mips                 randconfig-c004-20211207
powerpc              randconfig-c003-20211207
s390                 randconfig-c005-20211207
x86_64               randconfig-a016-20211207
x86_64               randconfig-a013-20211207
x86_64               randconfig-a014-20211207
x86_64               randconfig-a012-20211207
i386                 randconfig-a016-20211207
i386                 randconfig-a013-20211207
i386                 randconfig-a011-20211207
i386                 randconfig-a014-20211207
i386                 randconfig-a012-20211207
i386                 randconfig-a015-20211207
hexagon              randconfig-r045-20211207
s390                 randconfig-r044-20211207
hexagon              randconfig-r041-20211207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E08054C012
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346025AbiFODTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346000AbiFODTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:19:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210533DA4D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 20:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655263141; x=1686799141;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=X8E3v3moZ8QmOiY0XivvT6KVBdGsG5L4nxv5/ODdYlc=;
  b=lu5adHSXAXC7uxAvC6yrFHlqlsGiR93nSNokDQd4dO89nQZGQbYg3eJ3
   lqhRsKi2yMQ+8/GTn/Q3D+6AQFLpZz8K57v0+D8cKZz4xPszDEvSK+/68
   L8BJl00eYDp8uHEuSWlyE1kwqWbbOEnds3EDylf4e5/DBTSiBV5tiV7qH
   pcyXgTgYySjWXHbIWpPKSrGA/fRbH/JGmugz2l3wEW+JCJjxd2iQIAjs+
   K+LFKnpAhej4khiCKqSagtuDuyTefZy9gcAiSXL4WPBZhRuXo7vxlAz55
   vP+17VZAA0JJtYcU8i7AK2xAhytRe1XPHfh09uzF5hEfsFqtQKeA35x83
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="304242344"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="304242344"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 20:19:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="588849860"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2022 20:18:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1JYZ-000MXD-1i;
        Wed, 15 Jun 2022 03:18:59 +0000
Date:   Wed, 15 Jun 2022 11:18:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.06.12a] BUILD SUCCESS
 cd8d01a998897d27ca429b3b8f2df55aa11c8fea
Message-ID: <62a94f7f.zDFyLWoyaAqd0WRj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.06.12a
branch HEAD: cd8d01a998897d27ca429b3b8f2df55aa11c8fea  squash! rcu-tasks: Track blocked RCU Tasks Trace readers

elapsed time: 1766m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
i386                 randconfig-c001-20220613
m68k                       m5249evb_defconfig
mips                         bigsur_defconfig
m68k                       m5275evb_defconfig
xtensa                         virt_defconfig
arm                        mini2440_defconfig
powerpc                     pq2fads_defconfig
powerpc                   motionpro_defconfig
csky                             alldefconfig
arm                         axm55xx_defconfig
sh                         microdev_defconfig
arm                      jornada720_defconfig
arm                           u8500_defconfig
microblaze                          defconfig
arc                      axs103_smp_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
x86_64               randconfig-k001-20220613
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                          randconfig-a003
i386                          randconfig-a005
x86_64               randconfig-a012-20220613
x86_64               randconfig-a011-20220613
x86_64               randconfig-a015-20220613
x86_64               randconfig-a013-20220613
x86_64               randconfig-a014-20220613
x86_64               randconfig-a016-20220613
i386                 randconfig-a012-20220613
i386                 randconfig-a011-20220613
i386                 randconfig-a013-20220613
i386                 randconfig-a014-20220613
i386                 randconfig-a016-20220613
i386                 randconfig-a015-20220613
riscv                randconfig-r042-20220613
arc                  randconfig-r043-20220613
s390                 randconfig-r044-20220613
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                      malta_kvm_defconfig
arm                          collie_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      katmai_defconfig
powerpc                    ge_imp3a_defconfig
x86_64               randconfig-a003-20220613
x86_64               randconfig-a006-20220613
x86_64               randconfig-a001-20220613
x86_64               randconfig-a005-20220613
x86_64               randconfig-a002-20220613
x86_64               randconfig-a004-20220613
i386                 randconfig-a002-20220613
i386                 randconfig-a003-20220613
i386                 randconfig-a001-20220613
i386                 randconfig-a004-20220613
i386                 randconfig-a005-20220613
i386                 randconfig-a006-20220613
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20220613
hexagon              randconfig-r045-20220613

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

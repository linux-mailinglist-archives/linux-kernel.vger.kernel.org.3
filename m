Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A6C53C4BF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbiFCGP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiFCGP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:15:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D01037032
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 23:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654236957; x=1685772957;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+sDRByMFRZJJMwRhwUrah7z2Y6BvlxkzIQaSm57NLA8=;
  b=gwRL/wCbg0AFE6RkP+XtS5zjd/uAqqSrcw32hZa60FxZ9/rmTmYql1fr
   CSui7W2F6NJ8/0dmCVh7iamU//ErfKUEI5pHhZUnoJrpPam4heHvx30jt
   bm6aMLl2qcSsNeI2lwWLF+Dj7Rn9jaK+iJkHsyFkgmMEfOxyfUcY6ngDX
   oSyKoIxT/wLVRL+bbtQimTdFvFxNnwplS8rYRZLfZ+gZv6u+PTT6rTV2j
   uXDqCGPJsRaAfG/ZioSFfgNbTAn1J3wuiUY6luihLCh1KU7EyV15xlhN8
   Rw25TDsaxi80V/xUMawu/CyqbwoV/Y8alCtcwGlLycC91c9avvrtsF2FJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="256042020"
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="256042020"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 23:15:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="905333895"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jun 2022 23:15:55 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nx0bC-0006Ym-UQ;
        Fri, 03 Jun 2022 06:15:54 +0000
Date:   Fri, 03 Jun 2022 14:14:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.06.02a] BUILD SUCCESS
 e68e882faf09f482da33ff7603759d130cc9ddb7
Message-ID: <6299a6df.dqR6TsSP+pB6Uywa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.06.02a
branch HEAD: e68e882faf09f482da33ff7603759d130cc9ddb7  fixup! rcu-tasks: Scan running tasks for RCU Tasks Trace readers

elapsed time: 727m

configs tested: 87
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm64                               defconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
parisc64                            defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220602
s390                 randconfig-r044-20220602
riscv                randconfig-r042-20220602
arc                  randconfig-r043-20220531
riscv                randconfig-r042-20220531
s390                 randconfig-r044-20220531
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220602
hexagon              randconfig-r041-20220602
hexagon              randconfig-r041-20220531
hexagon              randconfig-r045-20220531

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

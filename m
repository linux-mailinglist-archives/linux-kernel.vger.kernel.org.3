Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF46A550B0D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 15:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiFSN5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 09:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiFSN5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 09:57:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1868B6598
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 06:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655647022; x=1687183022;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hcpX/N8rWmN0t5L/Inrrc3NLfJZ4xbyd37d9JP5xD8s=;
  b=OSOoAfOamTijUEX59jK6cgs1xPwXQHbmpH2UhYD1SueL0Aolp8ZF+zap
   zZvpFFMZv9sfPv1Pw9LIU2KGHq4jOZSwAhMue4LUy3dIFpxpeWMiJcS7R
   ABksBWJhNPU2Yz/jFJgxAAqBzJ8lzxF/OdNFMU8jmdyxP/tK0nysOY6Oj
   dEAdLDc5Orj5e3EBJC9S7QLDeoHvmf54062pfyIf+aL5Bp3H3xxUVOwSr
   2EPO2J5JXbLxMG0ZiFyxYq1SK4nBMFE3MHT/WsaI/OUtspK9OjVui68w/
   viNcxopVtZ2DJc6LpZgIyVvX/Hxp3jQImBdNFFSqVvZUe47CROLk2ugbU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="260162255"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="260162255"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 06:57:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="619808640"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 19 Jun 2022 06:57:00 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2vQB-000RGd-AR;
        Sun, 19 Jun 2022 13:56:59 +0000
Date:   Sun, 19 Jun 2022 21:56:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:ctxt-test.2022.06.16a] BUILD SUCCESS
 f1be8e1f579dde73fd90b5488f5c19745902f1d0
Message-ID: <62af2b16.xG//QCY/5ULl38fP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git ctxt-test.2022.06.16a
branch HEAD: f1be8e1f579dde73fd90b5488f5c19745902f1d0  context_tracking: Interrupts always disabled for ct_idle_exit()

elapsed time: 731m

configs tested: 98
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
openrisc                  or1klitex_defconfig
arm                         axm55xx_defconfig
mips                           xway_defconfig
powerpc                  storcenter_defconfig
m68k                          hp300_defconfig
mips                     loongson1b_defconfig
powerpc                       eiger_defconfig
arm                            pleb_defconfig
m68k                             alldefconfig
m68k                       m5249evb_defconfig
ia64                            zx1_defconfig
sh                        sh7763rdp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
alpha                               defconfig
csky                                defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                              debian-10.3
i386                             allyesconfig
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a005
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a015
x86_64                        randconfig-a011
x86_64                        randconfig-a013
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20220619
riscv                randconfig-r042-20220619
s390                 randconfig-r044-20220619
riscv                             allnoconfig
riscv                            allmodconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
arm                          pcm027_defconfig
powerpc                    gamecube_defconfig
riscv                             allnoconfig
powerpc                     kmeter1_defconfig
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a002
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220619
hexagon              randconfig-r041-20220619

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

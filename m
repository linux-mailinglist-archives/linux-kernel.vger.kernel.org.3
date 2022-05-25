Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA059533603
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 06:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243788AbiEYEWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 00:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiEYEWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 00:22:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44B35E17A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 21:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653452562; x=1684988562;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=n7fbpGUk48N80qzDAxiCEtIpi4wLi4sLS95Hcf4r+5w=;
  b=Jc4G7c5ufjEEDP/MkHG0bmsawIXlJ3dxcwp9rJt/fEYTBHsO4nv9k2QM
   G3oqOKSMoioYiqNt1CmmT9Z+lMFo2hIuUAmADLeaH4/OLXKA7qTPqjfXE
   UgJd8ry9eDWAZGVz9gZ7KeYbhsEm5bOzd9sZziqgLa91rjtjiDEWWxPMp
   CCrFw2wEuGRxzDy9uJk+4Bi5ctb45Td5EtkEFA7/lp21d6YB8Pf61j/ML
   9kvdSLRTx8USfTnduUs7G9W6Zs+YUUbu6hQX8LqZtrf4Q6nEMZrMaSgjb
   t/zJKcqAlYEQ1u4vB9OZouWSHQaEy8ZnbpzfPMxqyYBgXnWTdqpsZe1Va
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273823744"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273823744"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 21:22:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="664248552"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 May 2022 21:22:41 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntiXg-0002ij-IW;
        Wed, 25 May 2022 04:22:40 +0000
Date:   Wed, 25 May 2022 12:22:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.05.18a] BUILD SUCCESS
 9735325cf6f7eb6cdcf1ad875b49faa72f288f79
Message-ID: <628daef3.rSmQa/YrjedRRrS9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.05.18a
branch HEAD: 9735325cf6f7eb6cdcf1ad875b49faa72f288f79  fixup! rcu-tasks: Scan running tasks for RCU Tasks Trace readers

Unverified Warning (likely false positive, please contact us if interested):

kernel/rcu/tasks.h:1514 rcu_tasks_trace_pregp_step() error: uninitialized symbol 'rtpcp'.

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-m021
    `-- kernel-rcu-tasks.h-rcu_tasks_trace_pregp_step()-error:uninitialized-symbol-rtpcp-.

elapsed time: 1725m

configs tested: 130
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                              ul2_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                            mac_defconfig
m68k                          sun3x_defconfig
arm                      integrator_defconfig
m68k                          hp300_defconfig
arm                        cerfcube_defconfig
arc                     nsimosci_hs_defconfig
m68k                         amcore_defconfig
arm                           imxrt_defconfig
arm                        realview_defconfig
sparc64                          alldefconfig
arm                             ezx_defconfig
sh                     sh7710voipgw_defconfig
powerpc                        warp_defconfig
sh                           se7206_defconfig
m68k                             alldefconfig
arm                       multi_v4t_defconfig
xtensa                          iss_defconfig
mips                     loongson1b_defconfig
um                                  defconfig
powerpc                         wii_defconfig
sh                          r7780mp_defconfig
nios2                         3c120_defconfig
ia64                                defconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a002-20220523
x86_64               randconfig-a001-20220523
x86_64               randconfig-a003-20220523
x86_64               randconfig-a006-20220523
x86_64               randconfig-a004-20220523
i386                 randconfig-a004-20220523
i386                 randconfig-a001-20220523
i386                 randconfig-a003-20220523
i386                 randconfig-a002-20220523
i386                 randconfig-a006-20220523
i386                 randconfig-a005-20220523
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220524
s390                 randconfig-r044-20220524
riscv                randconfig-r042-20220524
arc                  randconfig-r043-20220523
s390                 randconfig-r044-20220522
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                        mvebu_v5_defconfig
mips                       rbtx49xx_defconfig
riscv                          rv32_defconfig
arm                          moxart_defconfig
mips                        maltaup_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     akebono_defconfig
powerpc                      walnut_defconfig
arm                          pcm027_defconfig
powerpc                          g5_defconfig
powerpc                      katmai_defconfig
mips                            e55_defconfig
powerpc                      obs600_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220523
hexagon              randconfig-r045-20220524
hexagon              randconfig-r041-20220524

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

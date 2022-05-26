Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C0E534A55
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 08:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346095AbiEZGQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 02:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiEZGQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 02:16:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4E29D4E2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 23:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653545814; x=1685081814;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8b3MKEI8vXPH1LL13iR0lae7JJm0E7F/0Dvp3zoVoSU=;
  b=PnqqhAQssGFbHF1zeYPTTPqLIF+JHu0HW1Ku1aDIzNcwDU65j7VEU7cQ
   kiPHuTQwRQOTrgIenY/2dAOcPtiwlKDHAIuEgZ5h6g8S/WhfLGuGLvbT9
   NlibDN7KArRcJWrrc0fhXigp+AZZj6KF4pgU5lQqg1eMxHQemmQEw52MX
   MmpaejgXTvZyhXRJ6hHCmCQc4gdQUp1rfmsF0h92NZe0kxqhlgbB6eE4t
   2xpYg3unHDCmYcmsK3isNEDWCg8AW9pl6oMQUAVbNfirhyAgRHA0D458U
   3y9P4XdpW54PaR+N3EnlF57X/VtrQmz4Gr/pPXewDsH1ACXtSK+PQSlNe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="254547671"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="254547671"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 23:16:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="746150968"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 May 2022 23:16:52 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nu6nk-0003ei-0v;
        Thu, 26 May 2022 06:16:52 +0000
Date:   Thu, 26 May 2022 14:16:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:for-peterz.2022.05.25a] BUILD REGRESSION
 4b2a6af8fe31e85fb2754b8da5072041a4dea471
Message-ID: <628f1b33.NaW86V0CuzXTR2D5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-peterz.2022.05.25a
branch HEAD: 4b2a6af8fe31e85fb2754b8da5072041a4dea471  rcu-tasks: Add detailed debugging facility to RCU Tasks Trace CPU stall warning

Error/Warning reports:

https://lore.kernel.org/lkml/202205260344.sqrr1y1S-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "rcu_trc_cmpxchg_need_qs" [kernel/rcu/rcuscale.ko] undefined!
ERROR: modpost: "rcu_trc_cmpxchg_need_qs" [kernel/torture.ko] undefined!
kernel/rcu/tasks.h:1233:27: warning: variable 'trs_new' set but not used [-Wunused-but-set-variable]
kernel/rcu/tasks.h:1236:27: warning: variable 'trs_new' set but not used [-Wunused-but-set-variable]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- alpha-buildonly-randconfig-r006-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- alpha-randconfig-r026-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- alpha-randconfig-r036-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- arc-allyesconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- arc-randconfig-r004-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- arc-randconfig-r011-20220524
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- arc-randconfig-r012-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- arc-randconfig-r022-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- arc-randconfig-r034-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- arc-randconfig-r035-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- arc-randconfig-r043-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- arc-randconfig-r043-20220526
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- arm-allmodconfig
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- arm-allyesconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- arm64-allyesconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- arm64-defconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- h8300-allyesconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- h8300-randconfig-r006-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- h8300-randconfig-r012-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- h8300-randconfig-r015-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- h8300-randconfig-r031-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- h8300-randconfig-r032-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- i386-allyesconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- i386-debian-10.3
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- i386-debian-10.3-kselftests
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- i386-randconfig-a003
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- i386-randconfig-a005
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- i386-randconfig-a012
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- i386-randconfig-a014
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- i386-randconfig-a016
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- i386-randconfig-m021
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- ia64-allmodconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- ia64-allyesconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- ia64-randconfig-r021-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- ia64-randconfig-r023-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- ia64-randconfig-r024-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- m68k-allmodconfig
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- m68k-allyesconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- m68k-defconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- m68k-randconfig-r003-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- m68k-randconfig-r033-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- m68k-randconfig-r034-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- m68k-randconfig-r036-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- microblaze-randconfig-m031-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- microblaze-randconfig-r005-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- microblaze-randconfig-r022-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- microblaze-randconfig-r033-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- mips-allmodconfig
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- mips-allyesconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- mips-randconfig-r002-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- nios2-allyesconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- nios2-buildonly-randconfig-r002-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- nios2-randconfig-r016-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- nios2-randconfig-r032-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- openrisc-randconfig-r025-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- parisc-allyesconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- parisc-buildonly-randconfig-r005-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- parisc-randconfig-r013-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- powerpc-allmodconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- powerpc-allyesconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- riscv-allmodconfig
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- riscv-allyesconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- riscv-defconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- riscv-randconfig-r015-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- riscv-randconfig-r016-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- riscv-randconfig-r024-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- riscv-rv32_defconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- s390-allmodconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- s390-allyesconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- s390-defconfig
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- s390-randconfig-r014-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- s390-randconfig-r044-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- sh-allmodconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- sparc-allyesconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- sparc-randconfig-r002-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- sparc-randconfig-r021-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- sparc-randconfig-s031-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- sparc64-randconfig-r005-20220524
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- x86_64-allyesconfig
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- x86_64-kexec
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- x86_64-randconfig-a004
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- x86_64-randconfig-a006
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- x86_64-randconfig-a011
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- x86_64-randconfig-a013
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- x86_64-randconfig-a015
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- x86_64-rhel-8.3
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- x86_64-rhel-8.3-func
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- x86_64-rhel-8.3-kselftests
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- x86_64-rhel-8.3-kunit
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
|-- x86_64-rhel-8.3-syz
|   `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used
`-- xtensa-allyesconfig
    `-- kernel-rcu-tasks.h:warning:variable-trs_new-set-but-not-used

elapsed time: 726m

configs tested: 99
configs skipped: 3

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
sh                         apsh4a3a_defconfig
nios2                               defconfig
powerpc                     rainier_defconfig
sh                         ecovec24_defconfig
sh                           se7712_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     redwood_defconfig
parisc                              defconfig
mips                    maltaup_xpa_defconfig
xtensa                          iss_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
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
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220524
s390                 randconfig-r044-20220524
riscv                randconfig-r042-20220524
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                  randconfig-c002-20220524
x86_64                        randconfig-c007
s390                 randconfig-c005-20220524
i386                          randconfig-c001
powerpc              randconfig-c003-20220524
riscv                randconfig-c006-20220524
mips                 randconfig-c004-20220524
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220526
hexagon              randconfig-r041-20220526

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

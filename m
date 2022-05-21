Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE23B52FC45
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 14:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiEUMDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 08:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiEUMDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 08:03:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B3139164
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 05:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653134620; x=1684670620;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BkEq0WMHuivqcmeBAQbzeoV4slsy1jifff58ar4CHKY=;
  b=ltEWYgM7jSKD2WAZ0w3c+egT2zR89BNjx7XmPcoR/fc/rFANh4+keQV1
   0qeOh4JhYMrziAWmt2pSgNQXngMBCFTUpY7TUE/FVbudybIMuvKGgXu4Q
   HLZYU6BVULQMNKuO5cFfwRN5l7VIygRVrIOBoc9GBnwxa974Q5RTLbZBJ
   VtQFm+Iks4ONXeXcz1A9doMOIyqhdmp6iEK/BSmio4Qr7FKqHdq8b2lRe
   9pTi4VQFTngfcURantB32vGH30/tLSp/7v4Lgjid9tiaSghrgSjBKM4Yr
   oEcHRycjgqQNL+dbX3qlsLycQHjmnMY2DZ3JcTA4HrgoKVCwjwREwFFF4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="298158860"
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="298158860"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 05:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="525070179"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 May 2022 05:03:38 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsNpa-0006Gk-6c;
        Sat, 21 May 2022 12:03:38 +0000
Date:   Sat, 21 May 2022 20:03:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.05.17a] BUILD REGRESSION
 9a9671fb7a3966dfc7dc67f6aa80acdfe185d72d
Message-ID: <6288d508.2BUectugl0ScEvvp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.05.17a
branch HEAD: 9a9671fb7a3966dfc7dc67f6aa80acdfe185d72d  rcu: Apply noinstr to rcu_idle_enter() and rcu_idle_exit()

Error/Warning reports:

https://lore.kernel.org/lkml/202205181919.oILbHBZa-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "rcu_tasks_trace_qs_blkd" [kernel/rcu/rcuscale.ko] undefined!
ERROR: modpost: "rcu_tasks_trace_qs_blkd" [kernel/torture.ko] undefined!

Unverified Error/Warning (likely false positive, please contact us if interested):

cat: 'smatch_trinity_*': No such file or directory
grep: smatch_trinity_*: No such file or directory

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- i386-randconfig-a003
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- i386-randconfig-a005
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- i386-randconfig-a012
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- i386-randconfig-a014
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- i386-randconfig-a016
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- i386-randconfig-c021
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- i386-randconfig-m021
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|   |-- cat:smatch_trinity_:No-such-file-or-directory
|   `-- grep:smatch_trinity_:No-such-file-or-directory
|-- ia64-randconfig-r033-20220519
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|-- m68k-allmodconfig
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- microblaze-randconfig-r014-20220519
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|-- parisc-randconfig-r036-20220519
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|-- powerpc-allmodconfig
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- riscv-allmodconfig
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- riscv-randconfig-r004-20220519
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- s390-defconfig
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- s390-randconfig-r044-20220518
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- x86_64-randconfig-a004
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- x86_64-randconfig-a006
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- x86_64-randconfig-a011
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- x86_64-randconfig-a013
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- x86_64-randconfig-a015
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- x86_64-randconfig-c022
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- x86_64-randconfig-s022
|   |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
|-- x86_64-rhel-8.3-func
|   `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined
`-- xtensa-buildonly-randconfig-r002-20220519
    |-- ERROR:rcu_tasks_trace_qs_blkd-kernel-rcu-rcuscale.ko-undefined
    `-- ERROR:rcu_tasks_trace_qs_blkd-kernel-torture.ko-undefined

elapsed time: 4736m

configs tested: 152
configs skipped: 5

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
parisc                           alldefconfig
powerpc                 mpc834x_mds_defconfig
mips                            gpr_defconfig
sh                               j2_defconfig
s390                       zfcpdump_defconfig
arm                         axm55xx_defconfig
ia64                      gensparse_defconfig
mips                           ci20_defconfig
xtensa                          iss_defconfig
h8300                    h8300h-sim_defconfig
sh                   sh7770_generic_defconfig
powerpc                      pcm030_defconfig
arm                        mini2440_defconfig
xtensa                           allyesconfig
m68k                            q40_defconfig
sh                           se7721_defconfig
arm                           tegra_defconfig
arm                        cerfcube_defconfig
arm                           corgi_defconfig
um                                  defconfig
powerpc                        cell_defconfig
sh                                  defconfig
powerpc64                           defconfig
powerpc                        warp_defconfig
mips                       capcella_defconfig
powerpc                 linkstation_defconfig
alpha                               defconfig
arm                           h5000_defconfig
arm                        multi_v7_defconfig
ia64                         bigsur_defconfig
sh                          landisk_defconfig
h8300                       h8s-sim_defconfig
powerpc                     mpc83xx_defconfig
powerpc                      ep88xc_defconfig
arm                      footbridge_defconfig
sh                          sdk7786_defconfig
mips                 decstation_r4k_defconfig
um                             i386_defconfig
m68k                          hp300_defconfig
mips                         mpc30x_defconfig
m68k                             allyesconfig
arm                           imxrt_defconfig
powerpc                      ppc6xx_defconfig
sh                   secureedge5410_defconfig
arm                        realview_defconfig
sh                   rts7751r2dplus_defconfig
sh                          urquell_defconfig
sh                           se7724_defconfig
sh                 kfr2r09-romimage_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
h8300                            allyesconfig
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
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220518
riscv                randconfig-r042-20220518
s390                 randconfig-r044-20220518
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
s390                 randconfig-c005-20220518
powerpc              randconfig-c003-20220518
x86_64                        randconfig-c007
riscv                randconfig-c006-20220518
mips                 randconfig-c004-20220518
i386                          randconfig-c001
arm                  randconfig-c002-20220518
powerpc                   microwatt_defconfig
powerpc                      acadia_defconfig
arm                          pxa168_defconfig
mips                      bmips_stb_defconfig
powerpc                    socrates_defconfig
mips                     cu1000-neo_defconfig
arm                         palmz72_defconfig
mips                            e55_defconfig
arm                        mvebu_v5_defconfig
arm                              alldefconfig
powerpc                  mpc885_ads_defconfig
powerpc                    gamecube_defconfig
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
hexagon              randconfig-r045-20220519
hexagon              randconfig-r041-20220519
s390                 randconfig-r044-20220519
riscv                randconfig-r042-20220519
hexagon              randconfig-r045-20220518
hexagon              randconfig-r041-20220518

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

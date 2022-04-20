Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1EA5086A0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377939AbiDTLKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377910AbiDTLKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:10:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDB02FFD0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650452842; x=1681988842;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=b5LaYQB0C8DdZpq+qMT5IZYjRzmWsg5sTt2s9ZNyBEc=;
  b=jnFfV6+s1u9YzfblqD319QHGC9HLERRWPrQmkAsfAZTz8eAAqXuakwbN
   1qur9yY0et/zjWmGAoImITGaahIfHzXDCXJs7Ri/oNSD5VL+Uow4gARJS
   MMGP3hX5U3yuNXU3Ey7xxGLD1rLIx5I3d+3CJjIFNLTgbOXMwH1Eoyys2
   mjcXs2v0hLFJfzG2bSZ4d/rs2hUt67a+YUI82zD4/VBafXsbOi2A0x09Z
   3fuqawqSItz/cFoLXqBCYuUzf+hdgQbfmyAKRQtTb4AgbXqykrprF7qTh
   e4VPpYP2z93zkCqMK9KNvFdMJ/CjlpOaKfoEQnOospC3tTx8hc+TM6SbX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="251307689"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="251307689"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 04:07:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="555150432"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 20 Apr 2022 04:07:21 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nh8B6-0006vD-I6;
        Wed, 20 Apr 2022 11:07:20 +0000
Date:   Wed, 20 Apr 2022 19:06:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 cec83620bfa1e09a5af60b439ddcedae5af1544a
Message-ID: <625fe92e.Ps3q22sRHfEojmVV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: cec83620bfa1e09a5af60b439ddcedae5af1544a  rcu/torture: Change order of warning and trace dump

elapsed time: 1858m

configs tested: 155
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220420
sh                              ul2_defconfig
arm                       aspeed_g5_defconfig
nios2                               defconfig
powerpc64                           defconfig
arm                       imx_v6_v7_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                       eiger_defconfig
nios2                         10m50_defconfig
arm                          pxa910_defconfig
arm                        cerfcube_defconfig
arm                         at91_dt_defconfig
sh                          sdk7786_defconfig
xtensa                    xip_kc705_defconfig
h8300                       h8s-sim_defconfig
powerpc                   motionpro_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                       common_defconfig
arc                      axs103_smp_defconfig
ia64                         bigsur_defconfig
arm                        keystone_defconfig
powerpc                     redwood_defconfig
mips                     loongson1b_defconfig
m68k                         amcore_defconfig
s390                                defconfig
powerpc                      makalu_defconfig
ia64                        generic_defconfig
mips                            ar7_defconfig
um                           x86_64_defconfig
mips                    maltaup_xpa_defconfig
arm                          lpd270_defconfig
powerpc                       ppc64_defconfig
sh                          rsk7201_defconfig
riscv                            allyesconfig
sparc                               defconfig
powerpc                  iss476-smp_defconfig
ia64                                defconfig
openrisc                            defconfig
sh                           se7721_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                        mvme16x_defconfig
arc                            hsdk_defconfig
mips                       bmips_be_defconfig
mips                      loongson3_defconfig
arc                        nsimosci_defconfig
sh                            hp6xx_defconfig
arc                           tb10x_defconfig
arm                          iop32x_defconfig
sh                        dreamcast_defconfig
m68k                        mvme147_defconfig
ia64                             alldefconfig
sh                   rts7751r2dplus_defconfig
mips                         cobalt_defconfig
arc                     nsimosci_hs_defconfig
arm                           u8500_defconfig
sh                           sh2007_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220420
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
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
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220419
arc                  randconfig-r043-20220419
s390                 randconfig-r044-20220419
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
riscv                randconfig-c006-20220420
mips                 randconfig-c004-20220420
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220420
powerpc              randconfig-c003-20220420
s390                 randconfig-c005-20220420
mips                        qi_lb60_defconfig
arm                         s3c2410_defconfig
arm                       netwinder_defconfig
arm                     davinci_all_defconfig
mips                           ip28_defconfig
mips                       rbtx49xx_defconfig
powerpc                      obs600_defconfig
mips                          ath25_defconfig
powerpc                  mpc885_ads_defconfig
arm                         mv78xx0_defconfig
powerpc                    mvme5100_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220420
riscv                randconfig-r042-20220420
hexagon              randconfig-r045-20220420
hexagon              randconfig-r045-20220419
hexagon              randconfig-r041-20220419

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

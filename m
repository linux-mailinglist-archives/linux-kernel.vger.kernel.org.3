Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BB04AEE26
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiBIJjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:39:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbiBIJhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:37:24 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8653CE01645B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644399442; x=1675935442;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/6uiJQFfqhv44fXSuW+FhKqitrm0zUSNGD6jShAAAto=;
  b=CHVqRHQCSJNpnXwQ1eISCK012gkZtoQDUqCp5p2p11qfj9qEapFGUYWx
   x6w06zrhKNJ3kVu4a1hCRzBwtBbkWD3OfVdGUCf8fj6UEafT+4WoRysAr
   mM3Bmlv6FknyJl6zqckMZLOr9o8QfVVRI3VxfQHao2wYMw2Xl/orlRMn0
   MS5lJG6KEq1piw7j1XHkC1/iyUeNEoIb9in0DnJHWMauokMB9klvmHDjT
   QGos/6Mpp0s5XK+rlJnl2xuPYAdlc5ej6xOHbGs2pUBmIAAarIxODHdnj
   S3gT8DbUIrcMqLrNp7O/JcUue550FfGvQlYpnDBzSYX5jXWWnBlP0UeZo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="236568952"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="236568952"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 01:14:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="525918355"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Feb 2022 01:14:36 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHj3b-0001Xs-Pp; Wed, 09 Feb 2022 09:14:35 +0000
Date:   Wed, 09 Feb 2022 17:13:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.02.03a] BUILD SUCCESS
 bb642455a39a2f9a89b921e7782937023bb92fcd
Message-ID: <620385d7.E1jVPSh0kkKj4xaa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.02.03a
branch HEAD: bb642455a39a2f9a89b921e7782937023bb92fcd  squash! mm: Check for SLAB_TYPESAFE_BY_RCU and __GFP_ZERO slab creation

elapsed time: 1492m

configs tested: 170
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
powerpc                   motionpro_defconfig
sh                   sh7724_generic_defconfig
sh                               alldefconfig
arc                          axs103_defconfig
sh                          rsk7264_defconfig
mips                  decstation_64_defconfig
arm                        cerfcube_defconfig
sh                        dreamcast_defconfig
sh                           se7750_defconfig
openrisc                         alldefconfig
sparc                       sparc64_defconfig
m68k                        m5272c3_defconfig
powerpc                        warp_defconfig
alpha                               defconfig
mips                         cobalt_defconfig
sh                          urquell_defconfig
mips                     decstation_defconfig
sh                         microdev_defconfig
xtensa                  nommu_kc705_defconfig
arm                         cm_x300_defconfig
sh                             espt_defconfig
powerpc                       ppc64_defconfig
h8300                     edosk2674_defconfig
nds32                               defconfig
m68k                       m5475evb_defconfig
powerpc                      mgcoge_defconfig
powerpc                 canyonlands_defconfig
powerpc                     stx_gp3_defconfig
sparc64                             defconfig
powerpc                     taishan_defconfig
mips                       bmips_be_defconfig
mips                           jazz_defconfig
powerpc                     sequoia_defconfig
mips                         rt305x_defconfig
arc                          axs101_defconfig
ia64                      gensparse_defconfig
powerpc                 mpc834x_itx_defconfig
sh                   rts7751r2dplus_defconfig
arm                        multi_v7_defconfig
sh                          sdk7780_defconfig
mips                         db1xxx_defconfig
sh                             sh03_defconfig
openrisc                            defconfig
sh                        sh7763rdp_defconfig
arm                        mvebu_v7_defconfig
mips                            gpr_defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
sh                           se7724_defconfig
sh                                  defconfig
mips                     loongson1b_defconfig
sh                   sh7770_generic_defconfig
csky                             alldefconfig
arc                           tb10x_defconfig
microblaze                      mmu_defconfig
powerpc                      tqm8xx_defconfig
sh                          polaris_defconfig
arm                         axm55xx_defconfig
powerpc                  storcenter_defconfig
arm                         assabet_defconfig
sh                           se7343_defconfig
mips                 decstation_r4k_defconfig
powerpc                      arches_defconfig
powerpc                  iss476-smp_defconfig
powerpc                       maple_defconfig
riscv                    nommu_k210_defconfig
parisc                           alldefconfig
sh                           se7619_defconfig
arm                  randconfig-c002-20220209
arm                  randconfig-c002-20220208
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
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
x86_64                        randconfig-a006
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a004
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220208
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220209
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220209
i386                          randconfig-c001
mips                 randconfig-c004-20220209
arm                  randconfig-c002-20220209
mips                        qi_lb60_defconfig
arm                          ixp4xx_defconfig
mips                        bcm63xx_defconfig
mips                           ip27_defconfig
arm                  colibri_pxa270_defconfig
mips                        workpad_defconfig
arm                         s3c2410_defconfig
hexagon                             defconfig
powerpc                        icon_defconfig
powerpc                     tqm8540_defconfig
mips                  cavium_octeon_defconfig
powerpc                     kmeter1_defconfig
arm                         orion5x_defconfig
arm                         hackkit_defconfig
powerpc                     mpc512x_defconfig
mips                         tb0287_defconfig
arm                       mainstone_defconfig
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a004
i386                          randconfig-a002
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015
hexagon              randconfig-r045-20220208
hexagon              randconfig-r041-20220208
riscv                randconfig-r042-20220208
s390                 randconfig-r044-20220208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

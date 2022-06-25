Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CEF55A847
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiFYI6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 04:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiFYI6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 04:58:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E55C13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656147481; x=1687683481;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=t49LYzrVRmoiyMb/Pkr3GaafBpydKRfVVaIEHGrUvfU=;
  b=hZSbIbBs36yqpt6Lr2rw5COr6Y79YhM7COUV7vf2+F8SUAezF7EsYPIq
   twsYpos5JyFxxdC5iWA1tWzBlMpt3/gGwd/gvwOtUPn4vQuKTVZNA9iwh
   Ekklan1r1dbDfqzYEfSCbgeXJPDVu2GgO42rwDVDVbr6bfevXydxLjLEM
   u/gvoNIFu76y+fwSMHrEzZJ2+sGgJmkln3Rpg7m32g3QOqoLe7AnFRbfi
   rFVI4bTJwc6jRMq9TSFMSMwLnTNzG3V4+FAobPcI2eOUNHePNNc/q98Di
   d6vHt/ATQUM4DGtJKrzOy0uSOZREDlp1sOKSD68F7yriWRUEeAvZsQjZ0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="261585815"
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; 
   d="scan'208";a="261585815"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 01:58:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; 
   d="scan'208";a="835457584"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jun 2022 01:58:00 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o51c7-0005ZR-DV;
        Sat, 25 Jun 2022 08:57:59 +0000
Date:   Sat, 25 Jun 2022 16:57:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 29dc4a37468641e2a9fca7f8c41c4d30f3c659a9
Message-ID: <62b6cdff.qSPHru6GM4II1cDp%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 29dc4a37468641e2a9fca7f8c41c4d30f3c659a9  rcu: Back off upon fill_page_cache_func() allocation failure

elapsed time: 1719m

configs tested: 95
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                      arches_defconfig
m68k                          multi_defconfig
powerpc                     mpc83xx_defconfig
sh                 kfr2r09-romimage_defconfig
um                           x86_64_defconfig
sh                                  defconfig
openrisc                  or1klitex_defconfig
arm                           imxrt_defconfig
sparc                       sparc64_defconfig
sh                   rts7751r2dplus_defconfig
arm                        realview_defconfig
arm                        keystone_defconfig
microblaze                          defconfig
arm                          iop32x_defconfig
powerpc                      ppc40x_defconfig
sh                           se7206_defconfig
powerpc                         ps3_defconfig
arm64                            alldefconfig
sh                     sh7710voipgw_defconfig
m68k                            q40_defconfig
powerpc                      chrp32_defconfig
alpha                               defconfig
sh                         ecovec24_defconfig
arm                           viper_defconfig
arm                       aspeed_g5_defconfig
parisc64                            defconfig
powerpc                 mpc834x_mds_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
s390                             allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-c001
arm                  randconfig-c002-20220624
ia64                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
sh                               allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220624
x86_64                        randconfig-a004
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                     kmeter1_defconfig
powerpc                     kilauea_defconfig
x86_64                           allyesconfig
powerpc                 mpc8315_rdb_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r045-20220624
hexagon              randconfig-r041-20220624
s390                 randconfig-r044-20220624
riscv                randconfig-r042-20220624
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

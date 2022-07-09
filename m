Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3370156C9CF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiGIOGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGIOGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:06:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D04B0E7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657375606; x=1688911606;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HcxuvaH1AVup5N6xLIBQPzP0infzrk2fOewwcGQB17s=;
  b=XeD0bE9Jcuu2lRXd9LQlH2qGXCIQcJ9ulxj0kBNzQmiDI7MjUXYOVPMe
   yn1AyZRLgEnznDwWPsm3JXImFsRE5jsbcvXRXxhoKMCpqNyj0yO3ApX+1
   Ie3tkE8lLVip1g5Vcfwi7LBHWSB4VjySQ2V96MTTJJTkMf/oSs1xNXl1M
   CURzLYa+j53e5A7u8u4D5zA/y18jJ/k5hNVD9mjRx+Anq+AqMllYoaPQn
   RnC1RaoA8IeYG+wZKbtAc8PCCD6vYefzBXldh8Z4kDoTd2j9Gyjx/53K1
   vEI0uAZ+p3f0YbHUPa5elUcsAdKltt+NrCMQ48IxJZYXMP2KM6JM44h+D
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="283191049"
X-IronPort-AV: E=Sophos;i="5.92,258,1650956400"; 
   d="scan'208";a="283191049"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 07:06:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,258,1650956400"; 
   d="scan'208";a="721157427"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Jul 2022 07:06:44 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAB6Z-000On7-Pn;
        Sat, 09 Jul 2022 14:06:43 +0000
Date:   Sat, 09 Jul 2022 22:05:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 88cea4e18ed430aa1187063450236fc00408eaac
Message-ID: <62c98b3a.dpCGYScSU208X/8h%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 88cea4e18ed430aa1187063450236fc00408eaac  rcu: Make tiny RCU support leak callbacks for debug-object errors

elapsed time: 874m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                         apollo_defconfig
arm                      footbridge_defconfig
microblaze                      mmu_defconfig
sh                          rsk7264_defconfig
arc                 nsimosci_hs_smp_defconfig
ia64                          tiger_defconfig
sh                        edosk7705_defconfig
arm                           corgi_defconfig
sh                           se7721_defconfig
sh                           se7750_defconfig
mips                         rt305x_defconfig
alpha                            alldefconfig
xtensa                         virt_defconfig
m68k                         amcore_defconfig
arm                      integrator_defconfig
arm                            lart_defconfig
mips                       bmips_be_defconfig
arm                        clps711x_defconfig
arm                        oxnas_v6_defconfig
sparc                               defconfig
powerpc                      mgcoge_defconfig
mips                             allyesconfig
powerpc                     mpc83xx_defconfig
sh                            migor_defconfig
arm                            hisi_defconfig
parisc64                            defconfig
nios2                            alldefconfig
mips                      maltasmvp_defconfig
csky                                defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220707
arc                  randconfig-r043-20220707
s390                 randconfig-r044-20220707
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
hexagon                          alldefconfig
arm                   milbeaut_m10v_defconfig
powerpc                      walnut_defconfig
powerpc                          g5_defconfig
mips                       rbtx49xx_defconfig
arm                         palmz72_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r045-20220707
hexagon              randconfig-r041-20220707

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

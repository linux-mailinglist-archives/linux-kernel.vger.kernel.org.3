Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDAF55A63C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 04:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiFYCmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 22:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiFYCmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 22:42:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC3362729
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 19:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656124965; x=1687660965;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0uujsD3SOiGH5sgBu2coFyi75Wh1BWtOMUkp2RHVrrE=;
  b=h+PAWGOPXK7+dVwI6hJY8ddcB7b2Sa/mJSguwZFfi58lHRT3BT4FUSqu
   UqP+fJ7jR79hrLLMc0SusJbEd+c576NfpJTCU4F8nNMkwOyu/n8HYVXfW
   DgnC0ZcMGWA/ce/GqWzG1ZFMeqs/p+KyLEwoCGF8Q0AXqJlPQhcGyk8Cp
   C0JK905ibCtrO+09i1sP6rLQqVBqWhVi1F8mSFB7FUZSzabyiMXf5XmTK
   7oxbMiykVZyBnmbZuYs7f6iBqqoXXKfPMLFPSJFj37rl3BFHcevrGRpkc
   9sH2XRjft4QZFitjvwvRQAY4kbl8rvs2ToBAleMbYx217F63spmq2Vx+N
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="367454808"
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; 
   d="scan'208";a="367454808"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 19:42:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; 
   d="scan'208";a="678786631"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jun 2022 19:42:44 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4vky-0005Bj-1C;
        Sat, 25 Jun 2022 02:42:44 +0000
Date:   Sat, 25 Jun 2022 10:41:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/for-next-fam0-uapi] BUILD SUCCESS
 c5e8d1aae52a6de9c87cd3d6fc6d113f5d3a9207
Message-ID: <62b675ec.wKX6AOZ6cbE71vtF%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/for-next-fam0-uapi
branch HEAD: c5e8d1aae52a6de9c87cd3d6fc6d113f5d3a9207  treewide: uapi: Replace zero-length arrays with flexible-array members

elapsed time: 720m

configs tested: 90
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                           se7206_defconfig
arm                            lart_defconfig
arc                              alldefconfig
arm                             pxa_defconfig
m68k                         amcore_defconfig
arm                        realview_defconfig
um                           x86_64_defconfig
xtensa                           alldefconfig
mips                  decstation_64_defconfig
sh                   sh7770_generic_defconfig
sh                             sh03_defconfig
s390                                defconfig
sh                          sdk7786_defconfig
sh                             shx3_defconfig
arm                           h3600_defconfig
i386                             alldefconfig
powerpc                      ppc6xx_defconfig
mips                            ar7_defconfig
mips                           xway_defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
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
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20220624
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
arm                   milbeaut_m10v_defconfig
mips                     cu1000-neo_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                      ppc64e_defconfig
powerpc                    gamecube_defconfig
powerpc                  mpc866_ads_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220624
hexagon              randconfig-r045-20220624
s390                 randconfig-r044-20220624
riscv                randconfig-r042-20220624

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

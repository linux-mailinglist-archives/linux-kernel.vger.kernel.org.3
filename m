Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A27558916
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiFWTgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiFWTf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:35:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F03960E19
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656012095; x=1687548095;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HAj7OHxWdJ9BVmnhFCmUWDcduKmpkjD0Dm8uamBQr+w=;
  b=KMCi9shvImScjEMq0lB3Z/O9qH0USqPlQUib6Tc0+05nh2TZlICOtUKA
   b3lzSrV//meE6cHQhB1QbqzlNxb6GlKrEYiVsmLLhmvWqKD2bGEN/MhzD
   GSekCeyooZyR/XFoH0MhtSEfv5V0LLOH6JCd6dVxDC/5o4S5gM04tMv8O
   SyAKoYOGYPGsCvDNmaQRR1sT/UGzt2CKOIZN7H21D8YHiuaQak/a9tsGj
   9xpX4E6QbUt+nRvxbDAI+AVhRrtk3jOeMeAv3oOigIENXbpc9L+/BnkY6
   /A18W2t71MxDhR8bUdjfYm3vb+FcIANsmn4t5gswWU4oOGg/0a53go0kQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="280861503"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="280861503"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 12:21:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="592849911"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jun 2022 12:21:34 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4SOT-0002wj-Fh;
        Thu, 23 Jun 2022 19:21:33 +0000
Date:   Fri, 24 Jun 2022 03:21:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 aa87c769aa1ab26de12cca849e7913b908a52707
Message-ID: <62b4bd28.iHEICXcZrLyiLF6e%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: aa87c769aa1ab26de12cca849e7913b908a52707  Merge branch into tip/master: 'x86/vmware'

elapsed time: 720m

configs tested: 84
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                          atari_defconfig
sh                             espt_defconfig
arc                    vdk_hs38_smp_defconfig
mips                  decstation_64_defconfig
arm                          gemini_defconfig
m68k                        stmark2_defconfig
arm                      jornada720_defconfig
sparc                               defconfig
sh                         microdev_defconfig
powerpc                      pasemi_defconfig
sh                             sh03_defconfig
openrisc                         alldefconfig
ia64                             allmodconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220622
arc                  randconfig-r043-20220623
riscv                randconfig-r042-20220623
s390                 randconfig-r044-20220623
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                 mpc8315_rdb_defconfig
arm                          ixp4xx_defconfig
riscv                             allnoconfig
powerpc                 mpc8560_ads_defconfig
arm                           omap1_defconfig
powerpc                     mpc5200_defconfig
arm                         s5pv210_defconfig
i386                             allyesconfig
mips                        qi_lb60_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220622
hexagon              randconfig-r041-20220623
s390                 randconfig-r044-20220622
hexagon              randconfig-r045-20220622
hexagon              randconfig-r045-20220623
riscv                randconfig-r042-20220622

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

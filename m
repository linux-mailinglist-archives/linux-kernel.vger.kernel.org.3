Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E50E4FDDBD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiDLLdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352789AbiDLLb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:31:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F356870F49
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649758256; x=1681294256;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5884kivJHQifT79otR8QDeDfSo9JqnHQwJVBugIosm0=;
  b=PTLBcECerO6AD9DuK05k1X5M8jAOBoPkoaPykxx76fsuuG15izyKKEi2
   ZOD1ZiHzLk1YCEzbAzTeMECT195FmM/uKrMkEvsJoKfg6TrwhOB/O/Yo1
   dAs42crRDEQ5MTHKrD1hWZFLpk/ZQApdax4IBdQQ7c9lbj3cAQQYFpX1J
   wMVEAJ32WR891yyO+u2AVBPNtx+YzxK/DJ0+G5Y4fJgx3OM5zmy1bjEjs
   IjoFPPZPL+CJ5w4vuFH0blIrgnk2+tTNHsFriNUbr/KJVQdxJNpmf+7sI
   4W5BKurj4cI00/Nz924LUq5b0MAufDvsNSpAl2egZawh2COwdzPRKaCup
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242924524"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="242924524"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 03:10:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="559269917"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 12 Apr 2022 03:10:55 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neDU7-0002jq-0X;
        Tue, 12 Apr 2022 10:10:55 +0000
Date:   Tue, 12 Apr 2022 18:10:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 c7bda0dca98cca351a9bc852b3df8b9b99ffd400
Message-ID: <62555011.cAgNlbiQ86vTNQrF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: c7bda0dca98cca351a9bc852b3df8b9b99ffd400  x86: Remove a.out support

elapsed time: 736m

configs tested: 121
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220411
arm                     eseries_pxa_defconfig
powerpc                      mgcoge_defconfig
mips                  decstation_64_defconfig
arm                       imx_v6_v7_defconfig
arm                          pxa3xx_defconfig
m68k                       m5475evb_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                          iss_defconfig
powerpc                     ep8248e_defconfig
arm                        realview_defconfig
sh                          sdk7780_defconfig
parisc64                         alldefconfig
powerpc                      ppc40x_defconfig
powerpc                      bamboo_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     mpc83xx_defconfig
ia64                      gensparse_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                               j2_defconfig
m68k                       m5249evb_defconfig
riscv                               defconfig
openrisc                         alldefconfig
arm                      jornada720_defconfig
arm                  randconfig-c002-20220411
x86_64               randconfig-c001-20220411
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
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
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
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
x86_64               randconfig-a016-20220411
x86_64               randconfig-a012-20220411
x86_64               randconfig-a013-20220411
x86_64               randconfig-a014-20220411
x86_64               randconfig-a015-20220411
x86_64               randconfig-a011-20220411
i386                 randconfig-a015-20220411
i386                 randconfig-a011-20220411
i386                 randconfig-a016-20220411
i386                 randconfig-a012-20220411
i386                 randconfig-a013-20220411
i386                 randconfig-a014-20220411
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220411
riscv                randconfig-r042-20220411
s390                 randconfig-r044-20220411
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                              defconfig

clang tested configs:
powerpc              randconfig-c003-20220411
arm                  randconfig-c002-20220411
riscv                randconfig-c006-20220411
x86_64               randconfig-c007-20220411
mips                 randconfig-c004-20220411
i386                 randconfig-c001-20220411
arm                        multi_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     mpc512x_defconfig
powerpc                     ppa8548_defconfig
x86_64                           allyesconfig
powerpc                 mpc837x_rdb_defconfig
arm                           sama7_defconfig
arm                          pxa168_defconfig
x86_64               randconfig-a003-20220411
x86_64               randconfig-a004-20220411
x86_64               randconfig-a006-20220411
x86_64               randconfig-a001-20220411
x86_64               randconfig-a002-20220411
x86_64               randconfig-a005-20220411
i386                 randconfig-a003-20220411
i386                 randconfig-a001-20220411
i386                 randconfig-a002-20220411
i386                 randconfig-a005-20220411
i386                 randconfig-a006-20220411
i386                 randconfig-a004-20220411
hexagon              randconfig-r041-20220411
hexagon              randconfig-r045-20220411

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

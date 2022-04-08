Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E1A4F8E69
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbiDHEy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 00:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiDHEyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:54:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5188A1440
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 21:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649393541; x=1680929541;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5m3SpVD8hWMEBJLOv0kkgBBD5h60I5V5qY4bFvYlwOk=;
  b=jngE1BH9PipK/uWkpOCIRFPJb2LrxeQ1HoQ0GrhEib4PqlLk5b8xTjNz
   xh2YqYgAi+2LJI/7zQD7eWPHS4T/2OhUiRzcttSMuWvXAYLfgX358IfpE
   678AKWizt+36LxG1IiyR3XaHP2Jr+QCB3SSBR5s8ss3aZeZ/NCtmlspZ2
   G20h6lcguSheusZ5NL1mtpH4AfoaORJRVBlaS8agmqfJFMBaOXrh2vXPp
   t33MhUaFWqoNraKcLUZb0xDsTCBsOklutRSX5VPy00+o6WOnO4XNjnBbm
   4Ib8IjG2PB007L82+bZpvVCQ3HeiHbdbZEYIQ2rn3udwl+HVUxpinjv8X
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260343966"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="260343966"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 21:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="642760005"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Apr 2022 21:52:20 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncgbb-00062b-I3;
        Fri, 08 Apr 2022 04:52:19 +0000
Date:   Fri, 08 Apr 2022 12:51:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 9b2687f29bc1a050ffd63b425129aa9db987e4f3
Message-ID: <624fbf56.riTJGBVlUPkgUGrJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: 9b2687f29bc1a050ffd63b425129aa9db987e4f3  x86/build: Don't build CONFIG_X86_32 as -ffreestanding

elapsed time: 720m

configs tested: 161
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                            mps2_defconfig
powerpc                      pasemi_defconfig
xtensa                           alldefconfig
xtensa                  nommu_kc705_defconfig
powerpc                 linkstation_defconfig
powerpc                     mpc83xx_defconfig
riscv                    nommu_k210_defconfig
arm                      footbridge_defconfig
powerpc                         wii_defconfig
arm                      integrator_defconfig
powerpc                     taishan_defconfig
sh                          polaris_defconfig
powerpc                      bamboo_defconfig
sh                           se7722_defconfig
arm                          iop32x_defconfig
arc                            hsdk_defconfig
powerpc                      ppc6xx_defconfig
sparc64                          alldefconfig
sh                           se7780_defconfig
powerpc                      ep88xc_defconfig
mips                     decstation_defconfig
arm                            hisi_defconfig
arm                           h5000_defconfig
arm                         lubbock_defconfig
sh                              ul2_defconfig
arm                        cerfcube_defconfig
ia64                      gensparse_defconfig
ia64                            zx1_defconfig
arm                        clps711x_defconfig
sh                   sh7770_generic_defconfig
powerpc                      mgcoge_defconfig
powerpc                      tqm8xx_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          lpd270_defconfig
sh                   rts7751r2dplus_defconfig
sh                   secureedge5410_defconfig
arm                             pxa_defconfig
sparc                               defconfig
powerpc                      pcm030_defconfig
sh                         ecovec24_defconfig
m68k                        mvme147_defconfig
powerpc                       eiger_defconfig
xtensa                    xip_kc705_defconfig
powerpc64                           defconfig
powerpc                       ppc64_defconfig
ia64                        generic_defconfig
arm                       multi_v4t_defconfig
i386                             alldefconfig
mips                        vocore2_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220406
arm                  randconfig-c002-20220407
arm                  randconfig-c002-20220408
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a005
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220406
arc                  randconfig-r043-20220406
arc                  randconfig-r043-20220407
s390                 randconfig-r044-20220406
riscv                randconfig-r042-20220408
s390                 randconfig-r044-20220408
arc                  randconfig-r043-20220408
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220408
riscv                randconfig-c006-20220408
mips                 randconfig-c004-20220408
arm                  randconfig-c002-20220408
arm                          imote2_defconfig
powerpc                     tqm5200_defconfig
powerpc                      pasemi_defconfig
arm                            mps2_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                              alldefconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     pseries_defconfig
arm                        magician_defconfig
powerpc                       ebony_defconfig
arm                       spear13xx_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                          pcm027_defconfig
riscv                             allnoconfig
arm                          collie_defconfig
arm                       mainstone_defconfig
riscv                            alldefconfig
arm                         s3c2410_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a006
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220406
riscv                randconfig-r042-20220407
hexagon              randconfig-r045-20220406
hexagon              randconfig-r041-20220407
hexagon              randconfig-r045-20220407
s390                 randconfig-r044-20220407
hexagon              randconfig-r045-20220408
hexagon              randconfig-r041-20220408

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

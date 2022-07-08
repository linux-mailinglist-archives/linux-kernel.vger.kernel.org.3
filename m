Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69BB56B241
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiGHFdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 01:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiGHFd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 01:33:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1521110D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 22:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657258407; x=1688794407;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=44U0VgQobVzDIiDlaXsE4/GM3PYjNOBqcsehHMWYdz0=;
  b=DJhHR1gLT1wBDzxHhJb6XyT7BTESx/75hNwdb1bZkkRAR2ZMFbBiAxnd
   Hcv0xExe0uHe/Tmif+7Bf6bYYAaOYQ18iD2Mt2lvuW0DTnDx8UXXsX0a8
   RPViTHI8W6ckwGFQrp80/6XEFL1VZ+ROHXJfj3zu5sm0jAYjeH/p5xo86
   e0wHCGJx0E2QbzPI+HiJFu4xip7G1UsJDzudOk4vx98uBqqAU3cVhprj5
   yDUTpW6cqbrc7EXTHdGPbeC16vVgiX6td88zw4vhATbe9XMTtaFUg8COn
   8laGMFf3sg3uXVdr4XryVsMOoqLIyFpBkBi7NcaC35G2crha94I3CyltQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="348179136"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="348179136"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 22:33:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="568813130"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Jul 2022 22:33:26 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9gcH-000Mxq-Dl;
        Fri, 08 Jul 2022 05:33:25 +0000
Date:   Fri, 08 Jul 2022 13:32:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 9de76f41ea2188f2784f48352f9278819d249afc
Message-ID: <62c7c188.W7Ybxga0Li0fRwZX%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 9de76f41ea2188f2784f48352f9278819d249afc  x86/mm: Refer to the intended config STRICT_DEVMEM in a comment

elapsed time: 720m

configs tested: 78
configs skipped: 72

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                 mpc8540_ads_defconfig
nios2                            allyesconfig
sh                           se7705_defconfig
powerpc                     tqm8548_defconfig
riscv                               defconfig
sh                           se7722_defconfig
xtensa                              defconfig
powerpc                     tqm8555_defconfig
m68k                            q40_defconfig
powerpc                      ppc6xx_defconfig
arm                      jornada720_defconfig
powerpc                     ep8248e_defconfig
m68k                           sun3_defconfig
sh                          r7780mp_defconfig
x86_64                           alldefconfig
xtensa                generic_kc705_defconfig
arc                      axs103_smp_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
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
riscv                randconfig-r042-20220707
arc                  randconfig-r043-20220707
s390                 randconfig-r044-20220707
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                  mpc885_ads_defconfig
powerpc                    mvme5100_defconfig
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
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220707
hexagon              randconfig-r041-20220707

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

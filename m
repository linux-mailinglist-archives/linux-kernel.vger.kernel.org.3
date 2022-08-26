Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9D45A1EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244781AbiHZCZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiHZCZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:25:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A981CC3F78
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 19:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661480746; x=1693016746;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fvCb7PvtYSSZYcUziXmyfxEeKXkqyaESbgiDBr55I0M=;
  b=LQECxCDDooyCsNdYsND+/aGiZ8kn5ZVD324/kyFX7mmvf9zqOY4PsVX7
   gxNdSJqR3TFoZKDfHQOFb224mtpeNPovnNrPCco2Tdopfimkjsl9Al95g
   N1kAbC0bfv+LU5SL8G6ZbLmjMtJ9RxuAEtNriz2vB9lgT/0Ejg35UwVQr
   H3ypuHBOh7gKip7QWjeyFp9OpSBGNE+wvFS9VwTPcwHHguZ0qPO4WDZr3
   1sZ1MTjRlhLxXpf4/oLpY06K0d9JXAorruFOK3wNRepxmmydrd85Mlpu1
   E0EQD8mPyXzDiynLEryjm5Hv8LW4a1tz0ILyD3aK+KJc7sPhZe1lK/Ori
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="356122012"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="356122012"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 19:25:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="639869819"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2022 19:25:45 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRP2W-0003Fy-1X;
        Fri, 26 Aug 2022 02:25:44 +0000
Date:   Fri, 26 Aug 2022 10:24:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 9203577122076d0d92df25b3787949f540567c26
Message-ID: <63082ef4.RYrnGc+afRCvKMI5%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 9203577122076d0d92df25b3787949f540567c26  Merge x86/urgent into tip/master

elapsed time: 724m

configs tested: 95
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
loongarch                         allnoconfig
um                             i386_defconfig
loongarch                           defconfig
um                           x86_64_defconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
arc                                 defconfig
i386                                defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                              allyesconfig
x86_64                        randconfig-a006
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
x86_64                              defconfig
i386                             allyesconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                        randconfig-a013
arm                                 defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arm                              allyesconfig
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
i386                          randconfig-a012
x86_64                           rhel-8.3-syz
i386                          randconfig-a016
i386                          randconfig-a014
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
riscv                randconfig-r042-20220824
s390                 randconfig-r044-20220824
arc                  randconfig-r043-20220824
arc                  randconfig-r043-20220825
arc                  randconfig-r043-20220823
ia64                             allmodconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
m68k                        m5407c3_defconfig
arm                        mvebu_v7_defconfig
powerpc                     mpc83xx_defconfig
alpha                            alldefconfig
arm                          pxa910_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r045-20220825
hexagon              randconfig-r045-20220823
riscv                randconfig-r042-20220823
riscv                randconfig-r042-20220825
hexagon              randconfig-r041-20220823
hexagon              randconfig-r041-20220825
s390                 randconfig-r044-20220825
s390                 randconfig-r044-20220823
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

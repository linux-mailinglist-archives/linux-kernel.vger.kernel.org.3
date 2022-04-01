Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444824EE7ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 07:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245217AbiDAFxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 01:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245205AbiDAFxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 01:53:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BD45748C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 22:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648792283; x=1680328283;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LUsDrFG9Q2jR0CDaosZ9jtW3pqzl1RrqwD0iH4NmVd8=;
  b=cfcWb8Bppbf2WVi07QcIrVBWRqVmcn9KhsZ+pVfYbZzUNC7Fx+cbOp/8
   eGIwdBwWnH9/WsJAnaGMSwgATtcDNjL/9Rz/hpXhZNoiNfOkiLN25bWkE
   +oY5Lg46wrcvr1JQ4kaksLaYqnvXBwndTsmBw0X7R40WvkjI3AAhD8ykn
   Xrt53qMOJ1Sfc2i8NIz0ExCpd/N3JQ0GMAz3z54DTapJmrSyrXTC88hLD
   Xqo57+kK+/zj6A0/4FBOS4n9+KgxgsoXIBat6zL1+yD0as8HQGIKvhe2X
   XMSV+W5VExqqI658M0+0EwEwmHLwRsH1UoC7EGgbkVaks6f/Lvndkfcj1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="247555560"
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="247555560"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 22:51:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="655426752"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2022 22:51:21 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naABs-0000zW-Uv;
        Fri, 01 Apr 2022 05:51:20 +0000
Date:   Fri, 01 Apr 2022 13:50:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/urgent] BUILD SUCCESS
 7dd5ad2d3e82fb55229e3fe18e09160878e77e20
Message-ID: <624692c2.5vOTXb1kGbSIggw1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/urgent
branch HEAD: 7dd5ad2d3e82fb55229e3fe18e09160878e77e20  Revert "signal, x86: Delay calling signals in atomic on RT enabled kernels"

elapsed time: 1029m

configs tested: 88
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                                 defconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
sh                            titan_defconfig
sparc                       sparc64_defconfig
m68k                       m5275evb_defconfig
arm                            zeus_defconfig
x86_64                        randconfig-c001
i386                          randconfig-c001
arm                  randconfig-c002-20220331
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
alpha                               defconfig
alpha                            allyesconfig
csky                                defconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
nios2                               defconfig
arc                              allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                               defconfig
sparc                            allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220331
hexagon              randconfig-r041-20220331
riscv                randconfig-r042-20220331

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

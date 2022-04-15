Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F676502DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 18:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355855AbiDOQhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 12:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239143AbiDOQhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:37:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C3B4160A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650040487; x=1681576487;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ac21St1oPxMtwuoNWfuYK5P7xLN+aSJg+1pI74ooCqI=;
  b=eh1V80WdfbUUEtBhakCs7cElVz89YpFTX8kft+Ogj4262+9N3AvWgoPV
   aASn8ygc9DQ0qUxZuloT2/YL4cyk+UustGyhtDjpmCZ5pWz+ef44Ly7gn
   f3kD67GLufxZTHXKKOdQ5QnWBC+MCsA9xwGU3JYj8xzetTATTyCwuRTxF
   gqzqMoHqE59bI7fHJuu8dTr0SGuwuUbeToKFFkCKbnbIFeewkprZm/MSe
   aJwnjsXmLTSqfpgJImJznkYHytnyN1PMVHd5E9cIo48clA5Ka+4V2n+sj
   hzZdTpEt1RbSm0CGdJkY2JgdW0Xy4tZU3b/pkthN8b/pRsBmO3Icyu0Od
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="323626033"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="323626033"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 09:34:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="701104911"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 15 Apr 2022 09:34:21 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfOtp-00029g-3F;
        Fri, 15 Apr 2022 16:34:21 +0000
Date:   Sat, 16 Apr 2022 00:33:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 6a01118827476d242c55886e0f4809b99d821762
Message-ID: <62599e76.Bqr9Rmq1FR3cOrsf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git master
branch HEAD: 6a01118827476d242c55886e0f4809b99d821762  Merge branch into tip/master: 'x86/platform'

elapsed time: 1741m

configs tested: 125
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                        stmark2_defconfig
arc                     haps_hs_smp_defconfig
arc                          axs103_defconfig
sh                   secureedge5410_defconfig
powerpc                   motionpro_defconfig
arm                       aspeed_g5_defconfig
sh                           se7705_defconfig
arm                           stm32_defconfig
arm                          pxa910_defconfig
microblaze                          defconfig
mips                     loongson1b_defconfig
powerpc                      bamboo_defconfig
powerpc64                           defconfig
powerpc                         wii_defconfig
arc                        vdk_hs38_defconfig
mips                           jazz_defconfig
sh                           se7724_defconfig
arm                           imxrt_defconfig
arm                            mps2_defconfig
sh                           se7343_defconfig
sh                          rsk7269_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220414
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
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                  randconfig-r043-20220414
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220414
arm                  randconfig-c002-20220414
i386                          randconfig-c001
powerpc                          allyesconfig
arm                         lpc32xx_defconfig
x86_64                           allyesconfig
mips                           ip28_defconfig
riscv                             allnoconfig
powerpc                     kmeter1_defconfig
powerpc                      acadia_defconfig
arm                       mainstone_defconfig
mips                       rbtx49xx_defconfig
arm                      tct_hammer_defconfig
powerpc                     tqm5200_defconfig
arm                        multi_v5_defconfig
mips                           mtx1_defconfig
arm                        spear3xx_defconfig
arm                        vexpress_defconfig
arm                          collie_defconfig
mips                          rm200_defconfig
mips                     loongson2k_defconfig
powerpc                          g5_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20220414
hexagon              randconfig-r045-20220414
riscv                randconfig-r042-20220414
s390                 randconfig-r044-20220414

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

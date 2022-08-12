Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E24F591731
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbiHLWPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiHLWPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:15:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F28B56D2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 15:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660342500; x=1691878500;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lrur/oeSbsziFfhl/Azs7jLuzFoEl0QHcQ43sDsdO1w=;
  b=S1xxk5/I5TfeH1fjMDzH/5TMLaqTeBtoTJB08/BkEwvCOHWl9NLi5EKD
   waVNELYSmvI6Q6a8wnIxdYvcsFko7GxRKKvXFKlBzQ7q/I2tA2kWsZy0h
   5Orsuj34VWLWR9EmnqIoDXAPudmGqaj9NeYdRz/U0Hgvtcr1T7W9o/yFP
   PAgYcPtlXJwyAb6BcboPLY0rbZW3PTd/XeLcurgGnC+W/zzVjQVvIu/Ax
   LAhJvbxzosW6Z/YSmZ60jGmfS5D5UGtcmKAsghRmNcqgcQPOr3ipRveSR
   akYVdQ6b7ZMd4KueOBl23pclqF0sjTyGqiHa2Mn0V3OwedOWHiXN6KJxc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292494249"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="292494249"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 15:14:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="665993174"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Aug 2022 15:14:58 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMcvh-00010B-2k;
        Fri, 12 Aug 2022 22:14:57 +0000
Date:   Sat, 13 Aug 2022 06:14:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 cf020a9648c5c18be3a38d4576d7a8fe8a1cb5c6
Message-ID: <62f6d0c2.OK+tfcY3QH4NPucs%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: cf020a9648c5c18be3a38d4576d7a8fe8a1cb5c6  Merge branch into tip/master: 'x86/platform'

elapsed time: 719m

configs tested: 80
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
x86_64                           allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
um                             i386_defconfig
um                           x86_64_defconfig
i386                          randconfig-a012
x86_64                        randconfig-a015
i386                          randconfig-a016
arc                  randconfig-r043-20220812
powerpc                           allnoconfig
s390                 randconfig-r044-20220812
powerpc                          allmodconfig
i386                          randconfig-a001
sh                               allmodconfig
riscv                randconfig-r042-20220812
i386                          randconfig-a003
i386                          randconfig-a005
mips                             allyesconfig
arm                                 defconfig
ia64                             allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
m68k                             allmodconfig
alpha                            allyesconfig
arm                              allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
arm64                            allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                        clps711x_defconfig
m68k                        m5407c3_defconfig
powerpc                       eiger_defconfig
sh                     magicpanelr2_defconfig
powerpc                   currituck_defconfig
arc                         haps_hs_defconfig
m68k                            q40_defconfig
m68k                        m5272c3_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
arc                           tb10x_defconfig
sh                          sdk7780_defconfig
xtensa                          iss_defconfig
m68k                          atari_defconfig
sh                           se7780_defconfig
openrisc                       virt_defconfig
m68k                           virt_defconfig
mips                  maltasmvp_eva_defconfig
sparc                       sparc32_defconfig
xtensa                  cadence_csp_defconfig
sh                        edosk7705_defconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a015
hexagon              randconfig-r045-20220812
hexagon              randconfig-r041-20220812
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
powerpc                      ppc44x_defconfig
arm                         s3c2410_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

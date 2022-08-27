Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A3C5A3781
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 13:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiH0Ltk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 07:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiH0Lst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 07:48:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F486580B
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 04:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661600928; x=1693136928;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=EvkrzLLpK87ZvgDK7H66AG8iAN1MeP4gE4ySPsk3FAY=;
  b=QKY+BYLvEWkUfhuaMclzBMseujYMYuSXwq2Dr05WAVLT4rDkyP+b/FxY
   UTeeS3aHXDkK9b3Z7mnvisVBjl9cKahRJGrhRLHdNrrlfQVJoD0UiuqTz
   lmz437d+yETGHSp4vHNn9RN9Wv1Jc7XGPOBPMNY8gVOVG9uoQOx+Trg8y
   3SmfDOfonnal+e8+GxlgeufnUMUWkkrbLfDpoBd0WPqii2sGrp1rfc1Hf
   7atedkxM5eKO1E1BBPn2N6dHnuWQRre2bJorZlgPPCFgCexjKfb3eydSS
   TJbK/bzeN7kbNpel5AM9rOF/78KFD7ufMDdQ6wQges5LYFWNvbnMZv5Y4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="295927818"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="295927818"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 04:48:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="939041671"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Aug 2022 04:48:46 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRuIv-00008h-2z;
        Sat, 27 Aug 2022 11:48:45 +0000
Date:   Sat, 27 Aug 2022 19:48:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 3051ee34ccb5a821bc46ef06639ff275e9c810b7
Message-ID: <630a0481.Yt/9ryxGIfcsAp2N%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
branch HEAD: 3051ee34ccb5a821bc46ef06639ff275e9c810b7  perf: Add PERF_BR_NEW_ARCH_[N] map for BRBE on arm64 platform

elapsed time: 803m

configs tested: 83
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
loongarch                         allnoconfig
arc                                 defconfig
s390                             allmodconfig
loongarch                           defconfig
alpha                               defconfig
s390                                defconfig
arc                              allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20220827
x86_64                        randconfig-a002
s390                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a006
m68k                             allyesconfig
mips                             allyesconfig
m68k                             allmodconfig
powerpc                          allmodconfig
x86_64                              defconfig
i386                          randconfig-a012
i386                                defconfig
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                               rhel-8.3
parisc                              defconfig
x86_64                           allyesconfig
nios2                               defconfig
i386                          randconfig-a001
x86_64                           rhel-8.3-syz
parisc64                            defconfig
i386                          randconfig-a003
nios2                            allyesconfig
arm                                 defconfig
x86_64                          rhel-8.3-func
i386                          randconfig-a005
parisc                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
arc                  randconfig-r043-20220823
arc                  randconfig-r043-20220825
arm                              allyesconfig
arm64                            allyesconfig
riscv                            allmodconfig
powerpc                          allyesconfig
riscv                            allyesconfig
ia64                             allmodconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          debian-10.3-kvm

clang tested configs:
hexagon              randconfig-r041-20220827
hexagon              randconfig-r045-20220827
x86_64                        randconfig-a001
x86_64                        randconfig-a003
riscv                randconfig-r042-20220827
s390                 randconfig-r044-20220827
x86_64                        randconfig-a005
i386                          randconfig-a015
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20220825
hexagon              randconfig-r041-20220823
hexagon              randconfig-r045-20220825
s390                 randconfig-r044-20220823
riscv                randconfig-r042-20220825
s390                 randconfig-r044-20220825
riscv                randconfig-r042-20220823
hexagon              randconfig-r045-20220823

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

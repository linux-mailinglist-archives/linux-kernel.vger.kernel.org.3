Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA84B58BE11
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 00:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbiHGWnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 18:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbiHGWm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 18:42:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87631150
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 15:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659912058; x=1691448058;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yIJWjqpQC2u3xCkCJHtdqFgJMqnShtDrw8ImGeZFfF0=;
  b=DhngCNiN2zTuPaznfg06ZY4OyD11b51cJcWvxHRJCGu+dEOVZTtG/LtH
   7ftBP/AsiAz0ee53VS0ctJ+MKkvMkhLNtNpvJIBl77xNr8C94YInOCtNw
   94ZVgqfFAiH2pQ1tqboBpwbNZ41XmcW9dcK2IEQbwEBgqfz/QNwB4koYv
   62+eVIVxyaEv3n8BS4z9D3X+WXYQ6hUK4nT9gSlwscyVv6Pi9ZQvAWJcp
   noeEIibFK+f1mInmjOuqLj5G4d3H0YEKjKqmmlIVUl8jjSqOgbDT55kLU
   RDdajyv0TOEeTX6+vNiAYHI8d0H/tDcVnwaEHqzJC9HyCjql4v/bwr5IZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="354467628"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="354467628"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 15:40:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="580114296"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Aug 2022 15:40:57 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKox6-000LjI-2T;
        Sun, 07 Aug 2022 22:40:56 +0000
Date:   Mon, 08 Aug 2022 06:40:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 a20dc5e7b11c5345bc5552c80085184c4459f6a5
Message-ID: <62f03f65.cwnLgvxIrWJLwDTc%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: a20dc5e7b11c5345bc5552c80085184c4459f6a5  Merge branch into tip/master: 'x86/platform'

elapsed time: 716m

configs tested: 76
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
powerpc                           allnoconfig
i386                          randconfig-a001
um                           x86_64_defconfig
i386                          randconfig-a003
arc                  randconfig-r043-20220807
i386                                defconfig
s390                 randconfig-r044-20220807
x86_64                              defconfig
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a013
i386                          randconfig-a014
x86_64                          rhel-8.3-func
x86_64                        randconfig-a011
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
x86_64                           rhel-8.3-kvm
riscv                randconfig-r042-20220807
x86_64                           rhel-8.3-syz
csky                              allnoconfig
x86_64                               rhel-8.3
i386                          randconfig-a012
x86_64                        randconfig-a004
i386                          randconfig-a016
arc                               allnoconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a002
alpha                             allnoconfig
sh                               allmodconfig
riscv                             allnoconfig
x86_64                           allyesconfig
alpha                            alldefconfig
arm                                 defconfig
m68k                             allyesconfig
m68k                        m5407c3_defconfig
x86_64                        randconfig-a006
alpha                            allyesconfig
m68k                             allmodconfig
powerpc                     stx_gp3_defconfig
mips                             allyesconfig
arc                              allyesconfig
powerpc                          allmodconfig
sh                          rsk7264_defconfig
sparc64                          alldefconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
arm                        mini2440_defconfig
sparc                            alldefconfig
mips                         cobalt_defconfig
loongarch                 loongson3_defconfig
arm                            xcep_defconfig
arm                           stm32_defconfig
mips                      maltasmvp_defconfig
powerpc                      chrp32_defconfig

clang tested configs:
i386                          randconfig-a002
hexagon              randconfig-r041-20220807
i386                          randconfig-a004
i386                          randconfig-a013
hexagon              randconfig-r045-20220807
i386                          randconfig-a006
i386                          randconfig-a011
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a015
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                        randconfig-a001
arm                     am200epdkit_defconfig
x86_64                        randconfig-a003
arm                        mvebu_v5_defconfig
arm                       spear13xx_defconfig
arm                         mv78xx0_defconfig
arm                          ep93xx_defconfig
arm                              alldefconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

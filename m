Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024FB58B860
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 23:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiHFVGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 17:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiHFVGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 17:06:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AF912D08
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659819970; x=1691355970;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fDNpRk/0cZ06Wzhp+L+xgu8a/KnLjTQuWvHPvOgh03I=;
  b=T0DdsAwAnseVA3cNa2Xtq5UJQRuO+q59YIZ9vavmV4jbTOgPUUKdsqaO
   2KSCMR4TGZtsVJo11bGtfm5igfxGjHFfnUCqQ/QckTkfq22X6BB/rRy+s
   B2F37o6JvvXUmk/nFDVr6lVZMMIK4KWIpprRxfFhYUz9a2HZ8pBUqaBw+
   zAfEUuooeXVm83LfYja6YXtySg0HGWn9XQ/3Ew4p0n5mwXZahlqWFWeW0
   fw9l6Boc6qRIQad3obHM8NyJkFQWejo4MIKYCAjw3sqivoqvjNqIvh2Ie
   3/VXbMeas+CsqdMxK0ovxC0BDSgB5mwK2SH4aIDULV3rohxVeSMMEC7uw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="316291666"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="316291666"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 14:06:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="632402667"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Aug 2022 14:06:08 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKQzn-000Kft-2P;
        Sat, 06 Aug 2022 21:06:07 +0000
Date:   Sun, 07 Aug 2022 05:05:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 221f9d9cdf429df8c3843b4291f4f412fde11543
Message-ID: <62eed790.gK8pES+kKLDHuWHr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: 221f9d9cdf429df8c3843b4291f4f412fde11543  posix-timers: Make do_clock_gettime() static

elapsed time: 717m

configs tested: 78
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                        randconfig-a004
x86_64                        randconfig-a002
um                             i386_defconfig
um                           x86_64_defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a011
riscv                randconfig-r042-20220805
i386                          randconfig-a005
s390                 randconfig-r044-20220805
arc                  randconfig-r043-20220805
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                              defconfig
i386                             allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a014
x86_64                           allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
m68k                             allmodconfig
arc                              allyesconfig
arm                                 defconfig
x86_64                           rhel-8.3-kvm
alpha                            allyesconfig
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
mips                             allyesconfig
x86_64                         rhel-8.3-kunit
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm                          pxa3xx_defconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                      footbridge_defconfig
ia64                             allmodconfig
arm                        realview_defconfig
arc                               allnoconfig
powerpc                   currituck_defconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
m68k                        mvme16x_defconfig
powerpc                    klondike_defconfig
powerpc                        cell_defconfig
s390                          debug_defconfig
arm                        clps711x_defconfig
sh                          landisk_defconfig
mips                      maltasmvp_defconfig
arm                             ezx_defconfig
powerpc                         ps3_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
x86_64                        randconfig-a005
x86_64                        randconfig-a012
hexagon              randconfig-r045-20220805
hexagon              randconfig-r041-20220805
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
powerpc                 xes_mpc85xx_defconfig
mips                      maltaaprp_defconfig
mips                          ath25_defconfig
arm                         bcm2835_defconfig
powerpc                   lite5200b_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                  mpc885_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

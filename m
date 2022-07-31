Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A571E585CFB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 05:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiGaDEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 23:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiGaDEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 23:04:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D84313CE1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 20:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659236647; x=1690772647;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7+1RD1Re9px7Auqkvldv6Epw4/8UOchTahNURBN9OkU=;
  b=INQKjYZlFdMU+znR+bhrdUFcmCYxVloI5Zvqh6Ag0k524dFSv5kFW/3V
   sm63JLuFLvGy2hZjjpr8d2wBqxIxFGkQzrnFbNwXgX1OovG3nkhS2OU4k
   zfEsAumtyxl64ufQihZmpiNFpQrJrXTI2maa1JPx8SMAcSb3dKBFLDjD8
   RSSx/Ad//Ugkl6If2VtmIsKLoSZZ2wJCwDJYQJyMwBCNjA9YA0PdAaieS
   T6qKj9j+UeHgXCTDh/BqXmq7tGpluN2v+TXOxeCcwY7e0aXXlVSItNkwD
   zSROL2OE15iNxlKr0WilF4EkjOtgpS6eJNuJRg73DjDoB0WmFpkmQceOt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="288976700"
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="288976700"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 20:04:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="577385581"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 Jul 2022 20:04:04 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHzFM-000DbD-0u;
        Sun, 31 Jul 2022 03:04:04 +0000
Date:   Sun, 31 Jul 2022 11:03:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 58b0b6adb85450f988ca1d9ed05f1c82701ed64e
Message-ID: <62e5f0f8.pnKQcPozz6Jml0Q+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 58b0b6adb85450f988ca1d9ed05f1c82701ed64e  Merge branch into tip/master: 'sched/core'

elapsed time: 717m

configs tested: 93
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arm                                 defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                                defconfig
x86_64                              defconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a002
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
arm64                            allyesconfig
i386                             allyesconfig
i386                          randconfig-a001
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
arc                              allyesconfig
x86_64                        randconfig-a006
i386                          randconfig-a003
x86_64                          rhel-8.3-func
i386                          randconfig-a014
powerpc                           allnoconfig
alpha                            allyesconfig
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
arm                              allyesconfig
x86_64                        randconfig-a004
mips                             allyesconfig
arc                  randconfig-r043-20220730
m68k                             allyesconfig
m68k                             allmodconfig
i386                          randconfig-a005
x86_64                           allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
sh                               allmodconfig
arc                  randconfig-r043-20220729
ia64                             allmodconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
arm                        clps711x_defconfig
powerpc                  iss476-smp_defconfig
nios2                         3c120_defconfig
ia64                             alldefconfig
sh                          kfr2r09_defconfig
xtensa                  audio_kc705_defconfig
sh                        dreamcast_defconfig
sh                           se7722_defconfig
arm                           sama5_defconfig
xtensa                generic_kc705_defconfig
arm                        trizeps4_defconfig
sparc                       sparc32_defconfig
powerpc                       eiger_defconfig
openrisc                         alldefconfig
powerpc                   currituck_defconfig
parisc                generic-64bit_defconfig
arm                       imx_v6_v7_defconfig
powerpc                      pcm030_defconfig
sh                          rsk7264_defconfig
sh                         microdev_defconfig
sh                          urquell_defconfig
sh                            shmin_defconfig
powerpc                     rainier_defconfig
arm64                            alldefconfig
arc                     haps_hs_smp_defconfig
ia64                                defconfig
openrisc                    or1ksim_defconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220730
x86_64                        randconfig-a005
i386                          randconfig-a013
x86_64                        randconfig-a001
hexagon              randconfig-r041-20220729
x86_64                        randconfig-a003
riscv                randconfig-r042-20220730
riscv                randconfig-r042-20220729
s390                 randconfig-r044-20220730
hexagon              randconfig-r045-20220729
i386                          randconfig-a002
i386                          randconfig-a011
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a015
hexagon              randconfig-r041-20220730
s390                 randconfig-r044-20220729
arm                          ep93xx_defconfig
riscv                          rv32_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                   microwatt_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

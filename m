Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369FD57C80D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiGUJtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiGUJts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:49:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F65A814B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658396988; x=1689932988;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cZIk67FVaNbtZuvKdX2cpRHJBrAqOXcyqpFPn3oWtgQ=;
  b=dcrGTkN1sA6vpVUnFberQEaPPkOZ9WI8rcPsp58u5oelYv43+5kBALTR
   fOSzJJx1KbtsguhZ9jn600y54V713atdOuVAt0O0gOm+8EDuTWC/VLD7A
   Ilbm5y174q5bOpFTZ1Tl7nH5wT3G2+Ulbc9/UDw+iIoQcAJhfSbDXKYK2
   l/aw7Y11RUbiNoT0x/sRnfp5nuMJww0FH4jh3RNBAsFa/UAdxBRKUVxA/
   g98WuRC5wR6aWShmf8AVduGx0lPpEBRvcuN6RP10xh8gGfpwTRRMLE4ML
   WONs7nmNA7mDIF3LZqLmoR1QZFd6KDxVPZGygp6hpBSuQ7vbbV6jZ9xki
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="287011413"
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="287011413"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 02:49:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="740617886"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2022 02:49:47 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oESoU-0001gr-An;
        Thu, 21 Jul 2022 09:49:46 +0000
Date:   Thu, 21 Jul 2022 17:49:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/for-next-fam1] BUILD SUCCESS
 6000a0296e3d32c25e0e618f96a79ca511b4e5de
Message-ID: <62d92132.Yu0VXroVO93sdXQ1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/for-next-fam1
branch HEAD: 6000a0296e3d32c25e0e618f96a79ca511b4e5de  ksmbd: Replace multiple one-element arrays with flexible-array members

elapsed time: 730m

configs tested: 116
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                      integrator_defconfig
arm                        keystone_defconfig
arc                          axs101_defconfig
xtensa                  audio_kc705_defconfig
powerpc                    adder875_defconfig
mips                         bigsur_defconfig
csky                              allnoconfig
um                             i386_defconfig
mips                           ci20_defconfig
arm                          lpd270_defconfig
arm                        mvebu_v7_defconfig
m68k                           virt_defconfig
sh                           se7206_defconfig
sh                             shx3_defconfig
sh                                  defconfig
powerpc                     rainier_defconfig
powerpc                        cell_defconfig
nios2                               defconfig
openrisc                 simple_smp_defconfig
xtensa                    smp_lx200_defconfig
sh                         microdev_defconfig
mips                          rb532_defconfig
parisc                           allyesconfig
arm                            hisi_defconfig
sh                           se7724_defconfig
arm                       aspeed_g5_defconfig
arm                            zeus_defconfig
powerpc                     tqm8548_defconfig
sparc                             allnoconfig
arm                        mini2440_defconfig
arc                        nsimosci_defconfig
mips                  maltasmvp_eva_defconfig
sh                   secureedge5410_defconfig
m68k                        mvme147_defconfig
nios2                         10m50_defconfig
xtensa                              defconfig
m68k                            mac_defconfig
arm                           viper_defconfig
powerpc                      ep88xc_defconfig
powerpc                      pcm030_defconfig
ia64                         bigsur_defconfig
arm                          exynos_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
nios2                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
loongarch                           defconfig
loongarch                         allnoconfig
arm                  randconfig-c002-20220718
i386                 randconfig-c001-20220718
x86_64               randconfig-c001-20220718
alpha                             allnoconfig
arc                               allnoconfig
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
x86_64               randconfig-a012-20220718
x86_64               randconfig-a011-20220718
x86_64               randconfig-a014-20220718
x86_64               randconfig-a016-20220718
x86_64               randconfig-a013-20220718
x86_64               randconfig-a015-20220718
i386                 randconfig-a015-20220718
i386                 randconfig-a011-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a014-20220718
i386                 randconfig-a016-20220718
i386                 randconfig-a013-20220718
i386                          randconfig-a012
i386                          randconfig-a016
s390                 randconfig-r044-20220718
riscv                randconfig-r042-20220718
arc                  randconfig-r043-20220718
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                      tct_hammer_defconfig
mips                           ip28_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                 mpc832x_mds_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a004
i386                 randconfig-a001-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a002-20220718
i386                 randconfig-a004-20220718
i386                 randconfig-a005-20220718
i386                 randconfig-a003-20220718
x86_64               randconfig-a005-20220718
x86_64               randconfig-a003-20220718
x86_64               randconfig-a006-20220718
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

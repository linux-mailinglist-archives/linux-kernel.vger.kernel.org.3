Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054B55A5545
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiH2UD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiH2UDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:03:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18F197D5C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661803425; x=1693339425;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XOGyC0FCcQ0lkLzShiWWDDDVAMZkETxULm71xSAJCQQ=;
  b=UvCp6XUfd+aDBeVwM7jeL83M0h59u/i1uR2vFWs2oiNIeZgrJTspW863
   IjUk56VoV3t39xJpIBcvBtxH30uwNZBYnHTLTnCweIbn3ZEbb9dPq+8Ky
   ujcJu1BJ3rhVucll58PgMygXbHz2+QQjDVJ5avkXGfoOX6nsEnPHd1hOP
   +EpFrAM9Ky9rkYyL+CRBGocGoNwj55gfsRXoP8AQIcjosQspPkrKmkPTV
   vdf8pjf/M8F8B6HPo7J0pnEBNieNdrK3CX8lEnTpNE2GR//0+Nj3FaFCW
   kCqeMy30LqP9W/7Wydup0jmYHqXQ2BAtbEhcfovNINKGG2WWU8SN0LCfM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="292566253"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="292566253"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 13:03:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="939714490"
Received: from lkp-server02.sh.intel.com (HELO e45bc14ccf4d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2022 13:03:44 -0700
Received: from kbuild by e45bc14ccf4d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSkz1-0000CM-2a;
        Mon, 29 Aug 2022 20:03:43 +0000
Date:   Tue, 30 Aug 2022 04:03:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 9a5ff834d93ca2d7ebdc9a14365cb456546a072f
Message-ID: <630d1b9d.7lS7XIzioMgVXt4i%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 9a5ff834d93ca2d7ebdc9a14365cb456546a072f  Merge branch into tip/master: 'x86/timers'

elapsed time: 720m

configs tested: 108
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
csky                                defconfig
sparc                               defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          debian-10.3-kvm
i386                 randconfig-a001-20220829
i386                 randconfig-a003-20220829
powerpc                           allnoconfig
x86_64               randconfig-a003-20220829
i386                 randconfig-a002-20220829
x86_64               randconfig-a002-20220829
x86_64               randconfig-a001-20220829
i386                 randconfig-a005-20220829
i386                 randconfig-a006-20220829
i386                 randconfig-a004-20220829
x86_64               randconfig-a004-20220829
x86_64               randconfig-a005-20220829
xtensa                           allyesconfig
x86_64               randconfig-a006-20220829
arc                                 defconfig
x86_64                              defconfig
alpha                               defconfig
loongarch                         allnoconfig
loongarch                           defconfig
nios2                               defconfig
nios2                            allyesconfig
parisc                              defconfig
parisc                           allyesconfig
parisc64                            defconfig
x86_64                               rhel-8.3
sh                               allmodconfig
mips                             allyesconfig
arc                  randconfig-r043-20220829
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
m68k                             allyesconfig
i386                             allyesconfig
arm                                 defconfig
ia64                             allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64                           allyesconfig
microblaze                      mmu_defconfig
arm                         lpc18xx_defconfig
powerpc                  storcenter_defconfig
powerpc                          allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
riscv                               defconfig
powerpc                       eiger_defconfig
arc                 nsimosci_hs_smp_defconfig
ia64                                defconfig
i386                 randconfig-c001-20220829
sh                           se7722_defconfig
xtensa                  nommu_kc705_defconfig
arm                             ezx_defconfig
arm                            mps2_defconfig
xtensa                           alldefconfig
sh                            migor_defconfig
sh                      rts7751r2d1_defconfig
m68k                        m5407c3_defconfig
sh                          r7780mp_defconfig
m68k                          multi_defconfig
sh                                  defconfig
sh                          r7785rp_defconfig
sh                             shx3_defconfig
mips                       bmips_be_defconfig
arm                           h5000_defconfig
arm                        keystone_defconfig
arm64                            alldefconfig
arc                          axs103_defconfig
sh                          lboxre2_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
hexagon              randconfig-r041-20220829
hexagon              randconfig-r045-20220829
riscv                randconfig-r042-20220829
s390                 randconfig-r044-20220829
x86_64               randconfig-a011-20220829
x86_64               randconfig-a014-20220829
x86_64               randconfig-a012-20220829
x86_64               randconfig-a013-20220829
x86_64               randconfig-a016-20220829
x86_64               randconfig-a015-20220829
i386                 randconfig-a011-20220829
i386                 randconfig-a014-20220829
i386                 randconfig-a013-20220829
arm                        mvebu_v5_defconfig
i386                 randconfig-a012-20220829
i386                 randconfig-a015-20220829
i386                 randconfig-a016-20220829
x86_64               randconfig-k001-20220829

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

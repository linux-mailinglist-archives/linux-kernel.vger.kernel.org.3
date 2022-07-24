Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE06257F3B2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 09:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbiGXH1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 03:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236243AbiGXH1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:27:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84EE19013
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 00:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658647668; x=1690183668;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tpDrCUkMna01zR8lMcYZO/9eRHspoDq4q2XUzc/RAiM=;
  b=dbmKILbVBfX1nlmQ9cYfKDFs6wNdIWIDc2YmXteQeCbu4OvjnynkK7UC
   T8ROhTlVOl7HB/yUtoHEG9FIWOa40Zau0EKUKSutB76CfOCqx+YuRG94k
   IEJEmObn23pXIKbt7qmZzCxFsYdmpAfvlqBAT4W6f/87XaKEymHo+SO67
   gc0cRAKLIE/jY/3LS4SUAeRWMiiWIlA6tE+r6dnQUGKOnXmK6PEc8xZBK
   C6vnVYUsTojmcuOpfr/Bb/rRJ5GSdFlQYiGBE/mrjg00Uurqz75u/Z6Q7
   070MIIgnArgMhdOpQwVN382TrV+Fn025ELuiUUTMd1q8kXWm+DacOxuQ2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="285071013"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="285071013"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 00:27:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="926518909"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2022 00:27:47 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFW1i-0003gB-1t;
        Sun, 24 Jul 2022 07:27:46 +0000
Date:   Sun, 24 Jul 2022 15:27:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 b648ab487f31bc4c38941bc770ea97fe394304bb
Message-ID: <62dcf444.S7xUTw52rReKb5JQ%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: b648ab487f31bc4c38941bc770ea97fe394304bb  x86/speculation: Make all RETbleed mitigations 64-bit only

elapsed time: 721m

configs tested: 90
configs skipped: 67

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
um                                  defconfig
arm                           h5000_defconfig
mips                  decstation_64_defconfig
mips                         mpc30x_defconfig
powerpc                     pq2fads_defconfig
mips                       bmips_be_defconfig
sh                          r7785rp_defconfig
parisc                           alldefconfig
m68k                          amiga_defconfig
mips                 decstation_r4k_defconfig
arm                           stm32_defconfig
arm                           tegra_defconfig
sh                                  defconfig
parisc                generic-64bit_defconfig
mips                           jazz_defconfig
xtensa                           allyesconfig
m68k                          sun3x_defconfig
xtensa                    smp_lx200_defconfig
arm                         nhk8815_defconfig
m68k                       m5208evb_defconfig
sh                            titan_defconfig
ia64                         bigsur_defconfig
loongarch                           defconfig
parisc64                         alldefconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-c001
arm                  randconfig-c002-20220724
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                                defconfig
i386                             allyesconfig
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
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                          malta_defconfig
powerpc                 mpc832x_mds_defconfig
arm                       mainstone_defconfig
mips                        qi_lb60_defconfig
mips                        bcm63xx_defconfig
riscv                    nommu_virt_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     ppa8548_defconfig
mips                      malta_kvm_defconfig
mips                           rs90_defconfig
powerpc                   microwatt_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        spear3xx_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

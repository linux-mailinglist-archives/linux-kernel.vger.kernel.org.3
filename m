Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003F35685E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiGFKm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiGFKmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:42:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332DF275D7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657104140; x=1688640140;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jjd+XK8+tenxLqO77FT7FThH/zjpZXXJ3/hRjuv8RQ4=;
  b=CAccGdQsPOVENWrFHneAUzz1MRtac0PIbia80FUj9lrqTQ732KYoU2hW
   RX9/WF2oABYZMukxLBTFwnlfu51GjhYSnX0pJvRr1wv9NrqiQUAozQzfd
   MpII6yYvMAJ3LpOskPK/sEWtDkZ3El/59sDYUvAtJuNXlr1ACHUXtgceW
   ZrnBnwoOOGe4CenwJhgvRsK+o6NfzmaVHZcDJmKYKd27M+1NgKbR7ViPk
   hsxsgaJoSq9s2S9O71hA4C/qe6kDvhC5pVAQ8aBW566pb61Lle1DodcRA
   S6dxBf0GoJrDkB/HToIQ/QB/P+gR+SpJc1S0119iJR45J63ZJ1Twltu6h
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="263495819"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="263495819"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 03:41:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="660920600"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2022 03:41:57 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o92Tk-000KSP-J7;
        Wed, 06 Jul 2022 10:41:56 +0000
Date:   Wed, 06 Jul 2022 18:41:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 2b4ad13e89bc96d2325c128ffd4a437ff12d3c67
Message-ID: <62c566e3.BIfmNVL9/i5mS7Ka%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 2b4ad13e89bc96d2325c128ffd4a437ff12d3c67  doc: Emphasize the need for explicit RCU read-side markers

elapsed time: 795m

configs tested: 101
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
xtensa                  audio_kc705_defconfig
sh                            shmin_defconfig
sh                            migor_defconfig
arc                         haps_hs_defconfig
powerpc                        warp_defconfig
sh                               j2_defconfig
arm                         lubbock_defconfig
m68k                          multi_defconfig
arc                     haps_hs_smp_defconfig
mips                         bigsur_defconfig
sh                            titan_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     pq2fads_defconfig
sh                         ecovec24_defconfig
sh                           se7206_defconfig
x86_64                           alldefconfig
openrisc                            defconfig
sh                        sh7785lcr_defconfig
m68k                        m5407c3_defconfig
sparc                       sparc64_defconfig
m68k                        mvme147_defconfig
sh                          polaris_defconfig
arm                         assabet_defconfig
arm                       multi_v4t_defconfig
arm                           sunxi_defconfig
parisc                              defconfig
m68k                        mvme16x_defconfig
xtensa                    xip_kc705_defconfig
xtensa                         virt_defconfig
sh                              ul2_defconfig
sh                          r7785rp_defconfig
m68k                       m5475evb_defconfig
m68k                          amiga_defconfig
sh                        sh7757lcr_defconfig
mips                        bcm47xx_defconfig
arc                 nsimosci_hs_smp_defconfig
i386                                defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
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
riscv                randconfig-r042-20220703
s390                 randconfig-r044-20220703
arc                  randconfig-r043-20220703
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                          ath79_defconfig
powerpc                     ksi8560_defconfig
powerpc                     kilauea_defconfig
arm                           sama7_defconfig
arm                         orion5x_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220703
hexagon              randconfig-r041-20220703

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

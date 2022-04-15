Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563F5502002
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 03:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345589AbiDOBOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 21:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiDOBOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:14:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B942360A90
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 18:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649985107; x=1681521107;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=C2mIQ72UPAr8Sb4G9EkFvFHUqFVYOorjTHs5Rfr0HAE=;
  b=T0IJuVGRVAIohphvz8g1yg9J47LE87YL6WkcdCbNl4mDMBqOu+xmdDV1
   9NLhzZ5L3MCm7KMOk1p/2pktSAciajYevtERZkBR4BRozBoR6t4RPlmdG
   vKnHZ68uJvOoksuNJQFo5WrvfTqZ2AcFjwu1yU8n7tAbwd1bddEzihcH9
   eoL13eHX/aqHjJNfmby7A/75zrwxIIv+5+XdxOVLp0ZiPy65dWO67GvK0
   Oxb9OZUWPjgCkCZ8QI0Wd/YpcBie1V4wf99LxEMys/FLeyIXMMfj5RjTS
   x61Y3yOnRhlZKMtTZyYFoCloSeKNOopahRUr/s74a08dVUBNVyDuEGxA3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="323512491"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="323512491"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 18:11:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="527623018"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Apr 2022 18:11:46 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfAUz-0001Mv-FI;
        Fri, 15 Apr 2022 01:11:45 +0000
Date:   Fri, 15 Apr 2022 09:10:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.04.12a] BUILD SUCCESS
 846285fc50b26e9bbf9cb6608907172cb2af4ec0
Message-ID: <6258c61c.agCBcohJhZwBkQRW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.04.12a
branch HEAD: 846285fc50b26e9bbf9cb6608907172cb2af4ec0  rcu: Make normal polling GP be more precise about sequence numbers

elapsed time: 2839m

configs tested: 112
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
mips                           ci20_defconfig
arm                        cerfcube_defconfig
sh                   sh7770_generic_defconfig
powerpc                       maple_defconfig
xtensa                         virt_defconfig
m68k                       m5475evb_defconfig
arm                        shmobile_defconfig
arm                        oxnas_v6_defconfig
sh                           se7721_defconfig
arc                            hsdk_defconfig
riscv                            allmodconfig
arc                     nsimosci_hs_defconfig
powerpc                   motionpro_defconfig
arc                     haps_hs_smp_defconfig
parisc                           alldefconfig
arm                            zeus_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220414
arm                  randconfig-c002-20220413
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
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a001
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220413
arc                  randconfig-r043-20220413
s390                 randconfig-r044-20220413
arc                  randconfig-r043-20220414
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
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
powerpc                        icon_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      obs600_defconfig
arm                      tct_hammer_defconfig
powerpc                     tqm5200_defconfig
arm                        multi_v5_defconfig
mips                           mtx1_defconfig
arm                        spear3xx_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
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

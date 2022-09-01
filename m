Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1F35A8B03
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiIABq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiIABqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:46:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D93F915EB
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661996783; x=1693532783;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nEnqZOLNMxV4VhWt6dGK2kIybG1Ju24/QgWYZinT50Y=;
  b=b6McElgvpJDebBB97X4UNJBBk4h59Vx/KRELxgQqw0/AFJ7Gcg2JC6qh
   89jV229jQHcuxl6VlSmqkKVpIQ07XW6f6FYaETWZj6zUoAPR9A15xb+o1
   9gKTuitsjEPd/b9bRj33H4DZD7koog3wnmffGH1dZBvJHdwvEXbDT3Url
   qAoIOR9+8URabv0BBw6zrJkPo15rJxIMmpo35JGcorq1DF8JbxHbHTk7R
   idX7kD/u9BDfZ2qh4ova/x6iOD8qz8ICo845WUo5iU3MreCOGt79z2fPG
   A95REm2uyA5aj3j/9SCxtGYfIuUkfXwSSGRUVfzIVAbLKiGmK17VyXrYP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="275993674"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="275993674"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 18:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="940653232"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 31 Aug 2022 18:46:22 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTZHh-0000xF-1Z;
        Thu, 01 Sep 2022 01:46:21 +0000
Date:   Thu, 01 Sep 2022 09:45:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.08.29a] BUILD SUCCESS
 ff670fc591f8d0ef00f3862ddbfaedbb7b154335
Message-ID: <63100ece.zgc/Tl1hVwYWhLNP%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.08.29a
branch HEAD: ff670fc591f8d0ef00f3862ddbfaedbb7b154335  rcutorture: Avoid torture.sh compressing identical files

elapsed time: 873m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220830
powerpc                           allnoconfig
x86_64                              defconfig
m68k                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm                                 defconfig
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a013
i386                          randconfig-a001
x86_64                        randconfig-a011
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
arc                  randconfig-r043-20220831
s390                 randconfig-r044-20220831
riscv                randconfig-r042-20220831
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
sh                   sh7724_generic_defconfig
sparc                       sparc32_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                          rsk7203_defconfig
sh                               alldefconfig
arm                           imxrt_defconfig
nios2                         10m50_defconfig
arm                        spear6xx_defconfig
parisc                              defconfig
mips                    maltaup_xpa_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
mips                      loongson3_defconfig
sh                          r7780mp_defconfig
parisc64                            defconfig
sh                           se7705_defconfig
sh                          lboxre2_defconfig

clang tested configs:
hexagon              randconfig-r045-20220830
hexagon              randconfig-r041-20220830
riscv                randconfig-r042-20220830
s390                 randconfig-r044-20220830
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
x86_64                        randconfig-a012
i386                          randconfig-a004
hexagon              randconfig-r041-20220831
i386                          randconfig-a006
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220831
x86_64                        randconfig-a014
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

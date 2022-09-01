Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28955A8B08
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiIABqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiIABqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:46:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981B595AE5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661996784; x=1693532784;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=EtLlr9uQLdAAJ1CGO7bZKV+kms/6yIw0mQBR1SQ1PLo=;
  b=PMs2NxoeNJRcSrsIzOQzFIvO9/mqFS/hpC+GNDiaCzI0XbBXUxkXXCoQ
   AvoUCYRwcvOz7R7PHVFImmGTovf4n2GbtZkVLdHyh5/bl5iemWu+wU7Tw
   TdQgMbt3Iz/zz1PBXumQ1ja/HGctAps6yjQq+GWZhg31JLre3jIkPmQ74
   y0bViA0SLXJAIacD0LqETzJCYXjY7jvB5OkhOcd6vBBKCyjj+sPJ4lnZq
   7P+Jzyp+GWlILwOv4D+V8YvWg6rqEkKtM1pON733dMfq9Ni7zgomFtWmK
   pVHSrmI6n/c4/+IOMBqoWeSqXgujBuOJzeK41I6X2gv3FFzbUlhHZhb/H
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="275993675"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="275993675"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 18:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="642115888"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 31 Aug 2022 18:46:22 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTZHh-0000xC-1K;
        Thu, 01 Sep 2022 01:46:21 +0000
Date:   Thu, 01 Sep 2022 09:45:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.08.31a] BUILD SUCCESS
 09a840306da247329e005129aa64f5ecc0c2ded9
Message-ID: <63100ec8.l1MMgIYJAn6B/db8%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.08.31a
branch HEAD: 09a840306da247329e005129aa64f5ecc0c2ded9  rcutorture: Avoid torture.sh compressing identical files

elapsed time: 721m

configs tested: 78
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                  randconfig-r043-20220830
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
sh                               allmodconfig
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
m68k                             allmodconfig
x86_64                               rhel-8.3
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           allyesconfig
arm                                 defconfig
m68k                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                             allyesconfig
arm64                            allyesconfig
arc                  randconfig-r043-20220831
i386                          randconfig-a014
arm                              allyesconfig
riscv                randconfig-r042-20220831
s390                 randconfig-r044-20220831
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a015
i386                          randconfig-a005
ia64                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
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
i386                          randconfig-c001
mips                      loongson3_defconfig
sh                          r7780mp_defconfig
parisc64                            defconfig
sh                           se7705_defconfig
sh                          lboxre2_defconfig

clang tested configs:
hexagon              randconfig-r045-20220830
hexagon              randconfig-r041-20220830
s390                 randconfig-r044-20220830
riscv                randconfig-r042-20220830
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
x86_64                        randconfig-a005
i386                          randconfig-a015
hexagon              randconfig-r041-20220831
hexagon              randconfig-r045-20220831
i386                          randconfig-a011
x86_64                        randconfig-a014
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a016
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

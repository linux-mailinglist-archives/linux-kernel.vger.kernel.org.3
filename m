Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECC1550A8F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbiFSMRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiFSMRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:17:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC82EBC2C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655641019; x=1687177019;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Rjn/1n5/MBaAomFIIxJ19SYA5IJ1xGBXn3QnIaoIWtI=;
  b=QLNqnGyarer9dve+kuK1yHHAOcpi70ncNTs8TR8Wc5z8N2gqNqYjtVpL
   a+MpHqs5fT7las3C6Pk/WqTKIK+caAy2J3jBtHlwscvC8B8TvlgjFhFd9
   c9yG1LK5DkLT2rqa3IpYWfF3fYFJGRB89sR1EPYxFA/Ff6Oi+jE0dwtqu
   /r7dmZGJ8BGwFL77WRhDZPQf2fPISXQkd6t7BVoPdmoCKrltco9oF5uE0
   k1h3FGVqU87wdr6RUXbJHBLK1LsdV0iAMIDFGLxCFCSRewLfhEuVTtRTs
   w+oNCbPMj+lKr3kZqsE9UI/snbfGu+ScX4sCX8SkLkP8ZevWYbMAo9REQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278498411"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278498411"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 05:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="590781027"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2022 05:16:58 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2trN-000RE3-Vp;
        Sun, 19 Jun 2022 12:16:57 +0000
Date:   Sun, 19 Jun 2022 20:16:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:poll-test.2022.06.16a] BUILD SUCCESS
 3c94474d4e33e5031523e68f73b044201ef225b5
Message-ID: <62af1386.RO/LU0Zs5PJ0HMb/%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git poll-test.2022.06.16a
branch HEAD: 3c94474d4e33e5031523e68f73b044201ef225b5  rcu: Add irqs-disabled indicator to expedited RCU CPU stall warnings

elapsed time: 2354m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm64                               defconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220619
sh                             espt_defconfig
powerpc                     pq2fads_defconfig
m68k                            mac_defconfig
xtensa                         virt_defconfig
arm                            zeus_defconfig
powerpc                       holly_defconfig
xtensa                  audio_kc705_defconfig
sparc64                          alldefconfig
arm                            lart_defconfig
sh                        edosk7760_defconfig
m68k                             alldefconfig
m68k                       m5249evb_defconfig
ia64                            zx1_defconfig
sh                        sh7763rdp_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
parisc64                            defconfig
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
i386                             allyesconfig
sparc                               defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-a012
arc                  randconfig-r043-20220617
s390                 randconfig-r044-20220617
riscv                randconfig-r042-20220617
riscv                            allmodconfig
riscv                             allnoconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                              defconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
mips                       rbtx49xx_defconfig
powerpc                     tqm8560_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                   lite5200b_defconfig
powerpc                 mpc8313_rdb_defconfig
riscv                            alldefconfig
powerpc                     tqm8540_defconfig
mips                        omega2p_defconfig
powerpc                       ebony_defconfig
powerpc                          allmodconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220617
hexagon              randconfig-r045-20220617

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

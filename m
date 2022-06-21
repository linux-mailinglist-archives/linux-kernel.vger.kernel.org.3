Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EA8553BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354263AbiFUUfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiFUUfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:35:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF502EA03
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655843715; x=1687379715;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2o9RodzJ20o5wCuYZ6M8mj94HVI9sW4ePWCpYGaOpag=;
  b=aWfCyvyowuWut4/tfr9wqN/capTh7HrpZawg4WhlZreyt1CJRnYpzbD7
   aUMCQOTctp/hjxaaruf4W/HCfz0ON3CB/5qwKJ2b8pSUp7ocr8FO8IdkV
   FsSG4cdoFcZFNg+ThN2xcju1Ajngb2jMecg9HiD7RDxBN1T90oPQu9Iu7
   I3/9Og1KKB1uyx/f78XvyEa8YuI6zoT8CvRMOpiUGHn/A6TqQ7aoa9LlN
   4zw/YiSba5pWrbr+yTAuK7KN7+qIGMQIPGyWFmEJG1cQSD5T3rWlq/Jtd
   W5FYV6rXpa7TUf1mbICyZbqUfjjyBoyumlCHTpg2gMIoVbnju1CsC6PX9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="341914748"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="341914748"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 13:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="538185607"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Jun 2022 13:35:13 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3kaf-0000Oz-Aa;
        Tue, 21 Jun 2022 20:35:13 +0000
Date:   Wed, 22 Jun 2022 04:34:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:ctxt.2022.06.20a] BUILD SUCCESS
 2ab5ecfa6d411119b6fc6d7ec316d60349a384a5
Message-ID: <62b22b5d.d9r3UqcWLjit+5Na%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git ctxt.2022.06.20a
branch HEAD: 2ab5ecfa6d411119b6fc6d7ec316d60349a384a5  context_tracking: Interrupts always disabled for ct_idle_exit()

elapsed time: 950m

configs tested: 84
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
parisc64                            defconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                               defconfig
sparc                            allyesconfig
powerpc                          allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                 randconfig-a003-20220620
i386                 randconfig-a001-20220620
i386                 randconfig-a002-20220620
i386                 randconfig-a004-20220620
i386                 randconfig-a005-20220620
i386                 randconfig-a006-20220620
arc                  randconfig-r043-20220619
riscv                randconfig-r042-20220619
arc                  randconfig-r043-20220620
s390                 randconfig-r044-20220619
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64               randconfig-a013-20220620
x86_64               randconfig-a012-20220620
x86_64               randconfig-a011-20220620
x86_64               randconfig-a014-20220620
x86_64               randconfig-a015-20220620
x86_64               randconfig-a016-20220620
i386                 randconfig-a012-20220620
i386                 randconfig-a011-20220620
i386                 randconfig-a013-20220620
i386                 randconfig-a016-20220620
i386                 randconfig-a014-20220620
i386                 randconfig-a015-20220620
hexagon              randconfig-r045-20220619
hexagon              randconfig-r045-20220620
riscv                randconfig-r042-20220620
hexagon              randconfig-r041-20220619
hexagon              randconfig-r041-20220620
s390                 randconfig-r044-20220620

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

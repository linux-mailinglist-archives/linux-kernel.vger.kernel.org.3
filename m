Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDD35769C0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 00:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbiGOWPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 18:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiGOWPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 18:15:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE088FD6C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657923168; x=1689459168;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mFX8Tq4zQFBWK4EPQZCIzTDcZ5Mo77njE5GD1C9WHPM=;
  b=QUBfGh7dpSebpLr+m6MPM/n2XW7e6MJ8wOMo57I2B1wON4fAq7ruG+GC
   LoEtT+iG2W9JvLGJu11haOtH4XQ2k8ZsPBZt9kMs0NXxLa+uXe6NtQsT2
   JF8Nk1rD86N20BvapF9UUe9foHDdWiIMVO9Zj4XqXsuu+M/NjPck9JafA
   cHFWZwuVJEONpnVV28bkgKN+3tWzNzEh5tfxW0IV9RrDDv1/GsVPrOyS3
   ZDvJoTiecakOG2O6eUiduK7aXLp2G8jOI/0qxCMvV/XRjD+uUG3OCvsUl
   Cp5nuXcAGbE784XylHyKdHHKZsyp6BM5XMWaVqmTPEY3fU27FR248sqN7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="347597627"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="347597627"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 15:12:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="546815602"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Jul 2022 15:12:46 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCTYD-0000nY-Sk;
        Fri, 15 Jul 2022 22:12:45 +0000
Date:   Sat, 16 Jul 2022 06:12:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:joel.2022.07.14a] BUILD REGRESSION
 37d0460c40e7e364151894260d483ade68b1de34
Message-ID: <62d1e638.vu5Pg3TX+uGBl7As%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git joel.2022.07.14a
branch HEAD: 37d0460c40e7e364151894260d483ade68b1de34  rcutorture: Add test code for call_rcu_lazy()

Error/Warning reports:

https://lore.kernel.org/lkml/202207150959.APaZTo2Q-lkp@intel.com
https://lore.kernel.org/llvm/202207150859.kU3p78eN-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

kernel/rcu/rcuscale.c:819:14: error: call to undeclared function 'rcu_lazy_get_jiffies_till_flush'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
kernel/rcu/rcuscale.c:819:28: error: implicit declaration of function 'rcu_lazy_get_jiffies_till_flush' [-Werror=implicit-function-declaration]
kernel/rcu/rcuscale.c:822:17: error: implicit declaration of function 'rcu_lazy_set_jiffies_till_flush' [-Werror=implicit-function-declaration]
kernel/rcu/rcuscale.c:822:3: error: call to undeclared function 'rcu_lazy_set_jiffies_till_flush'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- x86_64-randconfig-a002
|   |-- kernel-rcu-rcuscale.c:error:implicit-declaration-of-function-rcu_lazy_get_jiffies_till_flush
|   `-- kernel-rcu-rcuscale.c:error:implicit-declaration-of-function-rcu_lazy_set_jiffies_till_flush
`-- x86_64-randconfig-a013
    |-- kernel-rcu-rcuscale.c:error:implicit-declaration-of-function-rcu_lazy_get_jiffies_till_flush
    `-- kernel-rcu-rcuscale.c:error:implicit-declaration-of-function-rcu_lazy_set_jiffies_till_flush
clang_recent_errors
|-- arm-randconfig-r015-20220714
|   |-- kernel-rcu-rcuscale.c:error:call-to-undeclared-function-rcu_lazy_get_jiffies_till_flush-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-rcuscale.c:error:call-to-undeclared-function-rcu_lazy_set_jiffies_till_flush-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- hexagon-randconfig-r041-20220714
|   |-- kernel-rcu-rcuscale.c:error:call-to-undeclared-function-rcu_lazy_get_jiffies_till_flush-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-rcuscale.c:error:call-to-undeclared-function-rcu_lazy_set_jiffies_till_flush-ISO-C99-and-later-do-not-support-implicit-function-declarations
`-- x86_64-randconfig-a012
    |-- kernel-rcu-rcuscale.c:error:call-to-undeclared-function-rcu_lazy_get_jiffies_till_flush-ISO-C99-and-later-do-not-support-implicit-function-declarations
    `-- kernel-rcu-rcuscale.c:error:call-to-undeclared-function-rcu_lazy_set_jiffies_till_flush-ISO-C99-and-later-do-not-support-implicit-function-declarations

elapsed time: 1417m

configs tested: 33
configs skipped: 2

gcc tested configs:
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a016
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                              defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015
hexagon              randconfig-r045-20220714
hexagon              randconfig-r041-20220714

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

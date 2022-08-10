Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A9C58E757
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 08:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiHJGdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 02:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiHJGdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:33:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7D26E2DF
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660113194; x=1691649194;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PGR8oSk4ngEBEGDpyq9h6FThvhV42UZ8jkU3Q9MaFhM=;
  b=Io3DLD/Ylc9cUn5VzY54YV8dXbNXx/v/lxcNfo9zNY88GeDOQX4ud/TO
   nWjej8Xhfo2NrK4vcRtzpD4BnoLp8om3BPxMcPNJgZqkeYodjRKsxUoNr
   Yr/pGVMxT2pPBz7w8B1qFQX8mZmv9IhmDfnzPQ+lGXi7XMO2cfgPJW5h4
   SYQ2Fg5UhbXD3Bzw6/vlyXdiixmRLhX6Y8ux7GRSyTIovKGHyiAYryLih
   2moNqYxoBbr3+Fft/nn2V1RqHeQjDXipb+dcWKC6YeOGwrJ+lVPvsCFjW
   MDgLgxpsXPG1JYetse0rDqzcoh+e5/Z0tNF5E4q0g8O6dZi8yOVDYrsAR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="277949320"
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="277949320"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 23:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="633645557"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Aug 2022 23:33:12 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLfHE-000NbZ-0T;
        Wed, 10 Aug 2022 06:33:12 +0000
Date:   Wed, 10 Aug 2022 14:32:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 e362359ace6f87c201531872486ff295df306d13
Message-ID: <62f350f4.wDdKmKrx39xGDAdm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: e362359ace6f87c201531872486ff295df306d13  posix-cpu-timers: Cleanup CPU timers before freeing them during exec

elapsed time: 715m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a015
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a006
arm                                 defconfig
x86_64                               rhel-8.3
i386                             allyesconfig
riscv                randconfig-r042-20220810
i386                          randconfig-a014
arc                  randconfig-r043-20220810
x86_64                           allyesconfig
arm64                            allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
arm                              allyesconfig
s390                 randconfig-r044-20220810
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a014
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220810
i386                          randconfig-a011
hexagon              randconfig-r045-20220810
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

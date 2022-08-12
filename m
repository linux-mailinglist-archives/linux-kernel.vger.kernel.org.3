Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29624591727
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbiHLWID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiHLWIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:08:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BE0B5166
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 15:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660342080; x=1691878080;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Q+zlsWM7gPlxze9cIPzq6DDYiwlhtMS1KPKP6mqV/tA=;
  b=T9jhbVdWzXn5CSc6GENaDH2xYh4tRsNtQAOOmXWD4V7ac6jygw9a+cls
   auT6rUEZohf0Cnyt4u/yDOa5rANwbfi+NP1gbMTy3XzlVjQT0LtK8NMWD
   BTTw4u9edJ85vl6inOlRP2WotUlRSc7GjyeRzqsVmN6muQbbGAnvKAC/Y
   NHdjZLJnO/axYwiAs3YwM6trXiGOF5SGSXXyokp+6qVxRjkQFgFMlbLYa
   c+XXctBSp7LjkniZKRgNBQhOiuvLXz8nAc4pEv9GXvBgEMxAYLTb8b8oO
   Bqf9WlQImp9Ml8gIC4cjAPtKk8O7bRGH/DoN8C1OXvzy4Bs1c2wbSIox4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="355703338"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="355703338"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 15:07:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="933874119"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Aug 2022 15:07:58 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMcov-0000zz-2N;
        Fri, 12 Aug 2022 22:07:57 +0000
Date:   Sat, 13 Aug 2022 06:07:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 09348d75a6ce60eec85c86dd0ab7babc4db3caf6
Message-ID: <62f6cf3a.I3J5R2Hi4LAMHECf%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 09348d75a6ce60eec85c86dd0ab7babc4db3caf6  sched/all: Change all BUG_ON() instances in the scheduler to WARN_ON_ONCE()

elapsed time: 718m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                          randconfig-a001
i386                          randconfig-a003
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a005
m68k                             allyesconfig
m68k                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
riscv                randconfig-r042-20220812
arc                  randconfig-r043-20220812
i386                                defconfig
x86_64                        randconfig-a013
s390                 randconfig-r044-20220812
x86_64                        randconfig-a011
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                             allyesconfig
x86_64                        randconfig-a015
arm                                 defconfig
i386                          randconfig-a014
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a006
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
powerpc                          allmodconfig
arm                              allyesconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
arm64                            allyesconfig
ia64                             allmodconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r045-20220812
hexagon              randconfig-r041-20220812
x86_64                        randconfig-a012
i386                          randconfig-a013
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
i386                          randconfig-a011
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

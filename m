Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC945888A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbiHCISG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiHCISA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:18:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60736162
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 01:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659514678; x=1691050678;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3K3b321UPGFc06pTNH6+VZ1/KdoV4hSzLaFNFRLMr/k=;
  b=QsNMl73oFeVeOd7tjE+XCdUDEJMgUeDIJifOiOze6/fHeX03TrWqDEiH
   QeeOnS1/fmdRQDHI/23WghVBC0O5EXs8cJHYH/j6MQANl/NJU7T3hQ3ot
   gbtXf9w24CrMF3PFMsZyRBCSAJI/racHaSF+hpnaPHnFCo0SEhNqUdcM3
   lftvchv+HVhRc6CrA7ec37ov6U6Ck8Y8mfT0a752MC3UCm+kgvr4aolh8
   K08KQuUYo3sls5ystntJrmSEqnK/t/v7ROgTWCZe50AgyJ8u7wOuwZ+cN
   IEGFZ2YZStSWcszwOnW4+dhBPTCDV1rBCwO9Vi1cTgPBn46v2jw3QHrLp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="351329811"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="351329811"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 01:17:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="578555713"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Aug 2022 01:17:57 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ9Zk-000H2R-1m;
        Wed, 03 Aug 2022 08:17:56 +0000
Date:   Wed, 03 Aug 2022 16:17:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 0f03d6805bfc454279169a1460abb3f6b3db317f
Message-ID: <62ea2f03.JhD03AzH4xs9MeCP%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 0f03d6805bfc454279169a1460abb3f6b3db317f  sched/debug: Print each field value left-aligned in sched_show_task()

elapsed time: 721m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
i386                                defconfig
x86_64                           allyesconfig
powerpc                           allnoconfig
i386                             allyesconfig
x86_64               randconfig-a014-20220801
powerpc                          allmodconfig
m68k                             allmodconfig
x86_64               randconfig-a011-20220801
arc                              allyesconfig
x86_64               randconfig-a012-20220801
alpha                            allyesconfig
m68k                             allyesconfig
i386                 randconfig-a012-20220801
mips                             allyesconfig
i386                 randconfig-a013-20220801
x86_64               randconfig-a013-20220801
arm                                 defconfig
x86_64               randconfig-a016-20220801
x86_64               randconfig-a015-20220801
i386                 randconfig-a011-20220801
arc                  randconfig-r043-20220801
i386                 randconfig-a016-20220801
i386                 randconfig-a015-20220801
i386                 randconfig-a014-20220801
sh                               allmodconfig
ia64                             allmodconfig
s390                 randconfig-r044-20220801
riscv                randconfig-r042-20220801
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
arm                              allyesconfig
x86_64                           rhel-8.3-syz
arm64                            allyesconfig

clang tested configs:
x86_64               randconfig-a002-20220801
x86_64               randconfig-a001-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a004-20220801
x86_64               randconfig-a005-20220801
x86_64               randconfig-a006-20220801
i386                 randconfig-a001-20220801
i386                 randconfig-a002-20220801
i386                 randconfig-a003-20220801
i386                 randconfig-a005-20220801
i386                 randconfig-a004-20220801
hexagon              randconfig-r045-20220801
hexagon              randconfig-r041-20220801
i386                 randconfig-a006-20220801

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

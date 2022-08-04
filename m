Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A644589BDC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239756AbiHDMn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239732AbiHDMnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:43:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0B62BB01
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 05:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659617000; x=1691153000;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=boeQQhfSs+1eNQufXVd3SPhe8Leg/Z7JKh4sSYUz+1w=;
  b=dV+DCmnjmw9/bDyjNkSV4sLZtKEtEoNbf7Z/rTjvJE24lhllVwDf+72v
   Y2O4HdCf6gQ6u4EDrVMmwlrGfrcgV2RNtvdZjDdoxevHCdueIKIcBFeKJ
   4b0GtH6efmKPAl+kgroERN5rAgkyqNxhXECjn40sJ+/g1t0qJR6u65Q1m
   k/tLbffcH/A/NVKqZ2un29iX0G5hiXKffFsAf4YC+CqaQ3vlimZVvcn/5
   +vHELc/z+Z+sX4DC15r6FJ2vv5og6v9loQoF6wsGBx9CpTIepO07AhKOE
   Ex+ZYP9sIDOUffQ7X2QtvhPPzLH2SCcj9GZ4g21oVxfS+1YyrKmG0/JzK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="353920228"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="353920228"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 05:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="579060418"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Aug 2022 05:43:19 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJaC6-000IR5-1x;
        Thu, 04 Aug 2022 12:43:18 +0000
Date:   Thu, 04 Aug 2022 20:42:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.08.03a] BUILD SUCCESS
 b07e8e7bbf95f4777f1ee4d35deafee8baa83bcb
Message-ID: <62ebbec9.p2FujINbjfxSawvq%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.08.03a
branch HEAD: b07e8e7bbf95f4777f1ee4d35deafee8baa83bcb  rcu: Add full-sized polling for start_poll_expedited()

elapsed time: 733m

configs tested: 86
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                                defconfig
i386                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                           allyesconfig
xtensa                         virt_defconfig
arm                        multi_v7_defconfig
sh                          rsk7264_defconfig
loongarch                         allnoconfig
arm                            qcom_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arc                  randconfig-r043-20220804
um                                  defconfig
sh                          r7785rp_defconfig
sh                                  defconfig
mips                 decstation_r4k_defconfig
sh                        sh7757lcr_defconfig
m68k                             allyesconfig
loongarch                           defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-c001
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arc                           tb10x_defconfig
arc                     haps_hs_smp_defconfig
powerpc                 mpc8540_ads_defconfig
sh                        sh7785lcr_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-c001
arm                  randconfig-c002-20220804
nios2                         3c120_defconfig
sh                        apsh4ad0a_defconfig
parisc64                            defconfig
arm                           viper_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
mips                           rs90_defconfig
powerpc                      obs600_defconfig
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
mips                          malta_defconfig
arm                       cns3420vb_defconfig
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

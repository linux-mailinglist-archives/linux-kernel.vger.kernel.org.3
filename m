Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5785AC370
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 10:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiIDI1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 04:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiIDI1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 04:27:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D58A419A8
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 01:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662280025; x=1693816025;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JQeFaJ4f95e8WYDw78FGLeuc+EIjHNI0iN4qkwgBqg0=;
  b=RP5+FZDCcPSF4B2vUBJj+Qg6qKuwRrGicPm3krJY9L5FFT2KC4bZO9Wt
   Atg5eRE1hzd1l1GOWXsbJ3qqScgDyMg8mlYisgOernOBpWkAJJuNOHsn1
   8Nm0uuCCc4bUqLtBu/GFMWt7qjB3A25g5RxNJd608WqbdLu8xvRqJvRZW
   yL3adQ8BQBrTFB2TBRigjZ+O7XHb6udz3v0RJZFsgaVDd4db9Bv3qlnsU
   3yqC/1p8F3BVry1UuzbOCEcWK5G85U3vzHnxsOcDtmQAYhIH5ZypAeAI7
   o7QS4EFcXr9VDIZo02qzTkUhtDMp5+gmBxpJN7UaQbOef0H6K8LXX6j5J
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="296226830"
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="296226830"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 01:26:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="616113245"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 04 Sep 2022 01:26:40 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUkxj-0002or-28;
        Sun, 04 Sep 2022 08:26:39 +0000
Date:   Sun, 04 Sep 2022 16:26:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:lazy.2022.09.03a] BUILD SUCCESS
 e0c7d40eb8b115b099f2a5a01bf1d6719c0aa228
Message-ID: <6314613d.Sr3zYvr16cna560u%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lazy.2022.09.03a
branch HEAD: e0c7d40eb8b115b099f2a5a01bf1d6719c0aa228  squash! rcu: Fix late wakeup when flush of bypass cblist happens

elapsed time: 725m

configs tested: 78
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                        randconfig-a004
arm                                 defconfig
x86_64                        randconfig-a002
x86_64                               rhel-8.3
i386                                defconfig
x86_64                        randconfig-a006
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20220904
x86_64                           allyesconfig
alpha                            allyesconfig
x86_64                          rhel-8.3-func
powerpc                           allnoconfig
arc                              allyesconfig
x86_64                        randconfig-a013
riscv                randconfig-r042-20220904
powerpc                          allmodconfig
x86_64                         rhel-8.3-kunit
s390                 randconfig-r044-20220904
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
mips                             allyesconfig
arm                              allyesconfig
m68k                             allmodconfig
arm64                            allyesconfig
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a011
i386                          randconfig-a001
i386                          randconfig-a003
ia64                             allmodconfig
csky                              allnoconfig
x86_64                        randconfig-a015
i386                          randconfig-a005
arc                               allnoconfig
i386                          randconfig-a014
alpha                             allnoconfig
riscv                             allnoconfig
i386                          randconfig-a012
arm                           u8500_defconfig
m68k                       m5475evb_defconfig
sh                           se7722_defconfig
sh                          sdk7780_defconfig
sparc64                          alldefconfig
i386                          randconfig-a016
m68k                             alldefconfig
i386                             allyesconfig
mips                      fuloong2e_defconfig
m68k                           sun3_defconfig
arc                            hsdk_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         assabet_defconfig
m68k                          atari_defconfig
mips                         bigsur_defconfig
arm                           tegra_defconfig
mips                  decstation_64_defconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220904

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220904
x86_64                        randconfig-a003
hexagon              randconfig-r041-20220904
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a002
x86_64                        randconfig-a014
i386                          randconfig-a004
arm                   milbeaut_m10v_defconfig
arm                         orion5x_defconfig
arm                           sama7_defconfig
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
powerpc                 xes_mpc85xx_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

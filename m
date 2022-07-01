Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1AD56306E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbiGAJkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbiGAJkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:40:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8843830F67
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656668438; x=1688204438;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zQhcKvnOaWShwVOqfYD8BoIkwEetrx5DFKsYvofAuvo=;
  b=DEqtMGwn/NaLl0zsJi/4pE2itHSzn+X/r3mK5Een539+PtEtrtmfABW7
   4regzUcLKXjCf5JiXNjeNZngcJy5PgTCuNdAgCTpAE9PYDYIS5NK3Yj+3
   J10w8RokycGIuKPsibZdRTh8a3UE6CbCYMuWDdaP9tYWkt9MJI/alHmHU
   PdBq5Of3lrUCzHcBUWwL12UkOg4O6f6eZPMenqSrCK1VsYrXbjLGejkM7
   Z5zDKZ9p4I78gSbH85LDCIcliKJPVfLkOwXD9sTa4efwUzyAMxImAHD+D
   36r8/o1Np3jK1weWDMkSb4F08hBZM9vpJ0q4/wNTZmhHGAzpmVgcf1Ay3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="263011409"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="263011409"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 02:40:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="618352963"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Jul 2022 02:40:36 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7D8e-000Dne-7j;
        Fri, 01 Jul 2022 09:40:36 +0000
Date:   Fri, 01 Jul 2022 17:39:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.06.30a] BUILD SUCCESS
 6147dce9b7277fa1f21cd2b5bd97e2f0a8fb343c
Message-ID: <62bec0e4.JV5kjSzzJFJFo8Rg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.06.30a
branch HEAD: 6147dce9b7277fa1f21cd2b5bd97e2f0a8fb343c  rcu: Update rcu_preempt_deferred_qs() comments for !PREEMPT kernels

elapsed time: 941m

configs tested: 64
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                         db1xxx_defconfig
sh                         microdev_defconfig
arm                            zeus_defconfig
arm                             ezx_defconfig
riscv                    nommu_k210_defconfig
powerpc                     tqm8541_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                  decstation_64_defconfig
arc                     haps_hs_smp_defconfig
arm                        shmobile_defconfig
ia64                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220629
s390                 randconfig-r044-20220629
riscv                randconfig-r042-20220629
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-k001
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r045-20220629
hexagon              randconfig-r041-20220629

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

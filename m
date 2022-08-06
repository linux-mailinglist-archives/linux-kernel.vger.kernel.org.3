Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2583758B532
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 13:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiHFLT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 07:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiHFLT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 07:19:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7D512623
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 04:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659784795; x=1691320795;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=05yVS5aKWmPuPZJRrtiBsBjGElWdMRNBxOirLVcn0LI=;
  b=gZNaxxeRcNRwHBxt/e9KGkoqWts699J8WgP+Ozu3BOaOPQ+aOZ2J7wqo
   9Ah1IwDZ8kvY99W700DAGDycDVb4ifXcklyNCoGnXZ4GpqPGZ37DHti06
   laR6FN9cDNzbnc4SjW800Dd42j4f4Hvr3PKciPh61bXun1S2BPovZNNF5
   GzGpqOY/s0E5ms0IeqL6BjlTZaLtJ5ScvDSuuY21pry3z7ap9Pxy65QTD
   O3q+jbSDKiJ07+ZNiY4EyrDddn96RZbtHxLxuCGq5su7LDOUps4OyvDbB
   rEpmYg7weBdl1/fUGMu7r0tpXvM3Zp1DPTZD/vU+aP7XWKxUs9KvlYvDH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="289118339"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="289118339"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 04:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="554397391"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Aug 2022 04:19:54 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKHqT-000KIx-1t;
        Sat, 06 Aug 2022 11:19:53 +0000
Date:   Sat, 06 Aug 2022 19:19:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.08.03b] BUILD SUCCESS
 ce1b7858edab35808512996e67c82cac4273381c
Message-ID: <62ee4e37.ZcifBy+SCm8l3xzR%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.08.03b
branch HEAD: ce1b7858edab35808512996e67c82cac4273381c  fixup! rcu: Make synchronize_rcu_expedited() fast path update .expedited_sequence

elapsed time: 1014m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
i386                                defconfig
um                           x86_64_defconfig
i386                             allyesconfig
arm                                 defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
arm                              allyesconfig
arm64                            allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                 randconfig-r044-20220805
arc                  randconfig-r043-20220805
riscv                randconfig-r042-20220805
sh                          landisk_defconfig
sh                 kfr2r09-romimage_defconfig
arc                         haps_hs_defconfig
powerpc                      ppc6xx_defconfig
xtensa                    smp_lx200_defconfig
powerpc                     tqm8548_defconfig
openrisc                         alldefconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
um                               alldefconfig
loongarch                 loongson3_defconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
arm                     eseries_pxa_defconfig
csky                                defconfig
powerpc                 mpc8540_ads_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
um                                  defconfig
m68k                          amiga_defconfig
arc                            hsdk_defconfig
arm                      integrator_defconfig
powerpc                      chrp32_defconfig
nios2                         10m50_defconfig
arm                            zeus_defconfig
sh                        edosk7705_defconfig
i386                          randconfig-c001
sh                           se7619_defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a011
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-c001
arm                  randconfig-c002-20220805
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
ia64                             allmodconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
powerpc                 mpc832x_mds_defconfig
mips                      maltaaprp_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20220805
hexagon              randconfig-r045-20220805
x86_64                        randconfig-k001
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B983B589BBF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbiHDMhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239405AbiHDMhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:37:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956692AC5E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 05:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659616640; x=1691152640;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HjyNx2iFLJHd9I7XmwV5ysYZ7bKkb7I9DrQp3lYM3B4=;
  b=XJd1TBrnkyxRIGLqet5rdPmkzMqKW410i2V0Tq7ySRKxJUDSX54A8hTi
   EFSgcKnDGQx25YUpOquduHr+1596zsxszT5ejo4XAy2yOeNHb3RteijTT
   61LmgOcV3E0UFuRv6FO97lHswJ/2wQ5Hj43HIm+ISotaE4SI113liP9pd
   TCtlnS3SbkaBjhrr77X5Btj3F+ql4xq6o4gBYsCE+Ln1CaW1MVqqDbBQQ
   mKqWNCUKG556puhApB4rsK2xGRTYr+WkjyxQ93oXGUuSHT8yMfOG89/1K
   2sBDtP0c3VNSgX5QLgSYU00+7Q2/9m/Tu+z4gVSWcsH55q1AwBbakQxZ7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="376220525"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="376220525"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 05:37:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="553705940"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Aug 2022 05:37:18 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJa6I-000IQF-0c;
        Thu, 04 Aug 2022 12:37:18 +0000
Date:   Thu, 04 Aug 2022 20:36:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.08.01a] BUILD SUCCESS
 5d874ee87c28e860e6fd72cea7428509a923d87b
Message-ID: <62ebbd4d.+sfHGPNXzkmca0UL%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.08.01a
branch HEAD: 5d874ee87c28e860e6fd72cea7428509a923d87b  rcu: Add full-sized polling for start_poll_expedited()

elapsed time: 931m

configs tested: 84
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
i386                                defconfig
arc                              allyesconfig
x86_64                        randconfig-a006
alpha                            allyesconfig
x86_64                               rhel-8.3
m68k                             allmodconfig
m68k                             allyesconfig
x86_64                           allyesconfig
i386                             allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
xtensa                         virt_defconfig
arm                        multi_v7_defconfig
sh                          rsk7264_defconfig
loongarch                         allnoconfig
arm                            qcom_defconfig
um                                  defconfig
sh                          r7785rp_defconfig
sh                                  defconfig
mips                 decstation_r4k_defconfig
sh                        sh7757lcr_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arc                  randconfig-r043-20220804
loongarch                           defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
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
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
mips                           rs90_defconfig
powerpc                      obs600_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
mips                          malta_defconfig
arm                       cns3420vb_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

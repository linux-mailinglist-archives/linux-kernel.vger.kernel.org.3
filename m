Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7F9589927
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiHDIQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239453AbiHDIQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:16:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799C165812
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659601005; x=1691137005;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jGckr1w3kvfLQM3Vz1vsva5+NTL4JHMNpNhm/eQ3EAk=;
  b=oCZuK10tg9PqAb6E9XDoU84RfgeJiP+HNtrPfMqtyGXj2vPvk3pJgOaR
   dCZQvk3WQ/ohE/4xGMV3MO86dxZMyiygtsTIoUJKn3JL7a/U3WpNDbfKP
   +vT0i7jUiVkEqkfT3mGlip51JF4zWJ7PJdX47RsqRUmfcfLg2Pvae7CEe
   ywDcw5UERS0Rm/vfQuLCMulxdjDpQQN9m9okdsClnpHu37tpfqvmDDaSB
   IpwyOWPw9ZkV0xrOLzTW3lIzSZLtJuSKISv5RTBVRjwLSdOHPm+nphxsQ
   M5HzHsfJgdCAMduK/tgY26jbgw7iZR8XlgHbxPUJPmy6M6MY5feE5T7eR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="351585237"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="351585237"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 01:16:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="636006452"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Aug 2022 01:16:43 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJW27-000I99-0X;
        Thu, 04 Aug 2022 08:16:43 +0000
Date:   Thu, 04 Aug 2022 16:16:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 625395c4a0f4775e0fe00f616888d2e6c1ba49db
Message-ID: <62eb8054.KTKwx9L7ZAfKTwam%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 625395c4a0f4775e0fe00f616888d2e6c1ba49db  x86/numa: Use cpumask_available instead of hardcoded NULL check

elapsed time: 973m

configs tested: 97
configs skipped: 66

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                                defconfig
x86_64                           rhel-8.3-syz
i386                             allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
csky                              allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
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
loongarch                           defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arc                           tb10x_defconfig
arc                     haps_hs_smp_defconfig
powerpc                 mpc8540_ads_defconfig
sh                        sh7785lcr_defconfig
alpha                             allnoconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220804
arm                        mini2440_defconfig
powerpc                 mpc837x_rdb_defconfig
m68k                       bvme6000_defconfig
arm                        cerfcube_defconfig
sh                           sh2007_defconfig
powerpc                     mpc83xx_defconfig
arc                         haps_hs_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
s390                             allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
i386                          randconfig-a013
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
mips                           rs90_defconfig
powerpc                      obs600_defconfig
x86_64                        randconfig-k001
mips                          malta_defconfig
arm                       cns3420vb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

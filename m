Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA78589422
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 23:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbiHCVsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 17:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiHCVsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:48:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF8A19008
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 14:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659563311; x=1691099311;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=r8fp3HpRpjrHVQPC0418ZRVChCErssWUoIAowUgyBdM=;
  b=Ar5nLVUOY0g5FMT+0M5SllOFWo7WW770IqB0EL/5lrgoB7om/5kjxnNR
   LFTIA+8R/F6zDZDyQvkFEFlTn6KK58RNDFKynp003a6YRP3/3jPczzTpK
   16aN5ldq8P/TisEhE45lUnHRXSI7uzmwL2mtQjkXXs7mu1AgeD0yEx1ce
   kc4SaJGVki35Von6Td2z+0bDX3KSix4jZAmM+pkPkILmHdy1/JH1jfkyx
   xhP8Dy8gd+g0efAMOgzvpiJpT7TKK3bxKZg5n3m2lElvzVhAGiOu/F6xE
   03GEUO30k0aPV+iXKSpmJaKFwTtrns3jx8t5WA47INq7kPz3XwF0orOLn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="351497907"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="351497907"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 14:48:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="578819551"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Aug 2022 14:48:24 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJME4-000Hgp-0H;
        Wed, 03 Aug 2022 21:48:24 +0000
Date:   Thu, 04 Aug 2022 05:47:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 87514b2c24f294c32e9e743b095541dcf43928f7
Message-ID: <62eaecfa.HmC6HgSby0na+npT%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 87514b2c24f294c32e9e743b095541dcf43928f7  sched/rt: Fix Sparse warnings due to undefined rt.c declarations

elapsed time: 718m

configs tested: 84
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220803
riscv                randconfig-r042-20220803
s390                 randconfig-r044-20220803
i386                                defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
i386                             allyesconfig
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
arm                                 defconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
m68k                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a015
m68k                             allmodconfig
x86_64                           allyesconfig
arc                              allyesconfig
i386                          randconfig-a014
x86_64                        randconfig-a013
i386                          randconfig-a012
x86_64                        randconfig-a011
arm                              allyesconfig
i386                          randconfig-a016
arm64                            allyesconfig
alpha                            allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
powerpc                   motionpro_defconfig
arm                         at91_dt_defconfig
ia64                             allmodconfig
sh                           se7343_defconfig
x86_64                           alldefconfig
sh                     sh7710voipgw_defconfig
m68k                       bvme6000_defconfig
arm                           h5000_defconfig
m68k                           sun3_defconfig
sh                             shx3_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                          randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
hexagon              randconfig-r045-20220803
hexagon              randconfig-r041-20220803
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a014
i386                          randconfig-a011
x86_64                        randconfig-a016
x86_64                        randconfig-a012
arm                         s5pv210_defconfig
arm                         lpc32xx_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

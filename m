Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D32589789
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbiHDFur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238870AbiHDFun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:50:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4371606B3
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 22:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659592241; x=1691128241;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MSgDUBJCyCfmrsSuMQCndywN6lvwJs941h14fgWBi2k=;
  b=jPSPhuIPl+9NWD4J5rhoMdxSVi3BIqMEcIPpZgBn6MgL8xlCiqsP0iGd
   3OP6+lWpkVszsPgsK/ETRvW0bYN5p/fTlymw6BfHSBPa9kE/+l/7m2Iu6
   fJyPi9kgygy5AzwzFtD5kjV2SR9p7/sWvtpbPfeYaUlB74gXtB03gqcYn
   aRLpv7x9KvGI3WQYnD5HMpJC29J7Br3uvj6mhY516qU0tc5MWAh6gbUY8
   pwiwKctpsGufmqoT7b918j7yxv9caoVNxRxZ2zTNsBVgHX8qrHSBZXn27
   sGV+SODjHsJRYFBa0M1gN3Xq2ac7RirwF7vR/b7DAKETs8woB2qXw3sil
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="272891062"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="272891062"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 22:50:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="553592120"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 Aug 2022 22:50:40 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJTkl-000I49-2D;
        Thu, 04 Aug 2022 05:50:39 +0000
Date:   Thu, 04 Aug 2022 13:50:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 18c31c9711a90b48a77b78afb65012d9feec444c
Message-ID: <62eb5e15.facRBn7sd527UZh5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 18c31c9711a90b48a77b78afb65012d9feec444c  sched/fair: Make per-cpu cpumasks static

elapsed time: 718m

configs tested: 80
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                                defconfig
m68k                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                           allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a015
i386                          randconfig-a014
x86_64                        randconfig-a006
i386                          randconfig-a012
i386                          randconfig-a016
arm                                 defconfig
i386                          randconfig-a001
powerpc                           allnoconfig
i386                          randconfig-a003
mips                             allyesconfig
powerpc                          allmodconfig
i386                          randconfig-a005
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
sh                               allmodconfig
arc                  randconfig-r043-20220803
riscv                randconfig-r042-20220803
s390                 randconfig-r044-20220803
ia64                             allmodconfig
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
arc                  randconfig-r043-20220804
loongarch                           defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          randconfig-c001

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
x86_64                        randconfig-a005
x86_64                        randconfig-a014
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20220803
hexagon              randconfig-r045-20220803
mips                           rs90_defconfig
powerpc                      obs600_defconfig
x86_64                        randconfig-k001
mips                          malta_defconfig
arm                       cns3420vb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

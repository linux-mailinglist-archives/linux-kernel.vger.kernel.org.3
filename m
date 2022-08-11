Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBFF590665
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 20:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiHKSlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiHKSlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:41:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649367AC31
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660243290; x=1691779290;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=X6sZSNUzLXhRh57Cnx/Z0lXWANXXB4fzoKtBRTg8hB0=;
  b=HWMgOLSwIK5vhMVbhgzaDtakACODVCeoFo2Ie0kOrWc4ZTSXqRkPTKgl
   cmlUWuytK5xFjL18tFM1SGfqfrZueap/F0Hdq8Yct+l9QdTGZKvjyseCE
   7vUvENgLRr823PYS3tXLbNQTFobIFKrgyD97EK9wVz0TRmFWHvJKx8znZ
   zBU6Uff5Lj5AvpE7YNjzEhFJbyhPMYEYFKMHtYAdjAgCtT3MGRIX+Iubi
   /UW9Sf0basQGLOdUxSkUN8PWX8PDJiIf+7DHTBPLy42onMS5PNIrLopzJ
   2mmAZnvksuEB1S3I8GKRp/8e2UlU8A8HfyDQiIZfnwF2pnv3hRmDIiJSO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="278381507"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="278381507"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 11:41:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="581783025"
Received: from lkp-server02.sh.intel.com (HELO cfab306db114) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Aug 2022 11:41:01 -0700
Received: from kbuild by cfab306db114 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMD76-0000WR-2C;
        Thu, 11 Aug 2022 18:41:00 +0000
Date:   Fri, 12 Aug 2022 02:40:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 4166496e1b5ade307cc0dfbadb4e6a56e80c852f
Message-ID: <62f54d00.peXmIGLNhYofbTca%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 4166496e1b5ade307cc0dfbadb4e6a56e80c852f  Merge branch into tip/master: 'WIP/fixes'

elapsed time: 719m

configs tested: 92
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arm                                 defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arc                  randconfig-r043-20220810
m68k                             allmodconfig
arc                              allyesconfig
x86_64                        randconfig-a015
alpha                            allyesconfig
s390                 randconfig-r044-20220810
i386                                defconfig
m68k                             allyesconfig
riscv                randconfig-r042-20220810
x86_64                              defconfig
i386                          randconfig-a014
arm                              allyesconfig
arm64                            allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a004
i386                          randconfig-a001
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                           allyesconfig
ia64                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
powerpc                           allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                       m5475evb_defconfig
xtensa                    smp_lx200_defconfig
nios2                               defconfig
powerpc                        warp_defconfig
um                                  defconfig
sh                               j2_defconfig
powerpc                     mpc83xx_defconfig
powerpc                      tqm8xx_defconfig
m68k                            q40_defconfig
powerpc                      makalu_defconfig
powerpc                  iss476-smp_defconfig
powerpc                 mpc834x_mds_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                          randconfig-c001
mips                           ci20_defconfig
loongarch                        alldefconfig
xtensa                  cadence_csp_defconfig
m68k                             alldefconfig
sh                             espt_defconfig
xtensa                              defconfig
sh                     magicpanelr2_defconfig
arm                            lart_defconfig
arm                         lubbock_defconfig
sh                        dreamcast_defconfig
riscv                    nommu_k210_defconfig
sh                        sh7757lcr_defconfig
arm64                            alldefconfig
ia64                            zx1_defconfig

clang tested configs:
hexagon              randconfig-r041-20220810
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
hexagon              randconfig-r045-20220810
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a005
i386                          randconfig-a002
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a004
i386                          randconfig-a006
riscv                randconfig-r042-20220811
s390                 randconfig-r044-20220811
hexagon              randconfig-r045-20220811
hexagon              randconfig-r041-20220811
x86_64                        randconfig-k001
powerpc                       ebony_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

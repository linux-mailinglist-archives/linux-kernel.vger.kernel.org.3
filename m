Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44D858BA25
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 10:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbiHGIBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 04:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiHGIB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 04:01:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51287675
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 01:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659859287; x=1691395287;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=b7xHvxaitYuSv1rLqi8dZ9A5eMxVNiB4vL3lO5eQq00=;
  b=dF4FrZZkFo7djTOEwnu1d7Efs6TTvmvRhRntW/Vcqt11qQwZn0Caaddq
   MuRWc2cKPvvAnloc1mA6KjzRYFdKf9Uet6cKz+w2Rg6aZ7w87yECvMqYK
   VH25Hd4M7veyHYrk6r+V30WlXDtk1jE+n1jlbnag20TKzF0LmeIlOi/t8
   TF/aQ9vEhVnRkPgoMYrq7bPCwoM8gHybqxT/C4ZoMpiiL0RuiQVQX1TzQ
   T+4k0XgAcj0q842Y6O95yaLkU6a2KjdyaxalH7ITD8HmZWfGL6kUvFyxe
   h3feU9SYNVZ4HhdmvCz1fHZQpC57/sz7Y1RMHm8Rseoku8glfKiywjXcJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="352144879"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="352144879"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 01:01:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="931687194"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2022 01:01:25 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKbDx-000L81-18;
        Sun, 07 Aug 2022 08:01:25 +0000
Date:   Sun, 07 Aug 2022 16:00:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f6f499f09cc094d56f1af5e69ea480f27c02f150
Message-ID: <62ef7136.HDrlTINftlEpEchX%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f6f499f09cc094d56f1af5e69ea480f27c02f150  Merge branch into tip/master: 'x86/mm'

elapsed time: 770m

configs tested: 78
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
i386                          randconfig-a001
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                             allyesconfig
i386                          randconfig-a003
x86_64                              defconfig
x86_64                        randconfig-a015
i386                          randconfig-a005
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
mips                             allyesconfig
x86_64                        randconfig-a002
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           allyesconfig
m68k                             allyesconfig
sh                               allmodconfig
arc                               allnoconfig
x86_64                        randconfig-a004
alpha                             allnoconfig
m68k                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a006
arm                                 defconfig
x86_64                           rhel-8.3-kvm
riscv                             allnoconfig
arm                              allyesconfig
i386                          randconfig-a014
arc                  randconfig-r043-20220807
csky                              allnoconfig
i386                          randconfig-a012
arm64                            allyesconfig
i386                          randconfig-a016
s390                 randconfig-r044-20220807
ia64                             allmodconfig
riscv                randconfig-r042-20220807
arm                         lubbock_defconfig
m68k                          sun3x_defconfig
arm                           sama5_defconfig
xtensa                          iss_defconfig
arm                           h3600_defconfig
arm                         at91_dt_defconfig
m68k                                defconfig
sh                         microdev_defconfig
mips                  decstation_64_defconfig
arm                          lpd270_defconfig
openrisc                         alldefconfig
arm                        keystone_defconfig
arm                         lpc18xx_defconfig
ia64                          tiger_defconfig
powerpc                 mpc85xx_cds_defconfig
m68k                       m5275evb_defconfig
sh                             shx3_defconfig
i386                          randconfig-c001
powerpc                          allmodconfig

clang tested configs:
i386                          randconfig-a002
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a016
i386                          randconfig-a013
x86_64                        randconfig-a005
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220807
hexagon              randconfig-r045-20220807
powerpc                 mpc8272_ads_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                    socrates_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

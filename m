Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF7858B9F9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 09:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiHGHH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 03:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiHGHH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 03:07:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E77D13D
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 00:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659856045; x=1691392045;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=20BuPddcZaRU+Vz6633dj6LdEb8lGh5RLzoEFJIlRoM=;
  b=N7LNUp6XgTaBLhp0QIw8rr06+M2gkYI0uWYacK8x73pDJVneJuw8Oh7Q
   AM2FwewNb3TAGKmhZKxca4cdBfSCff4V8qHBhOetjdEnBHmGprvKFjtBY
   Hb7lHAl1fKp/7xGzCLwirfAnwBv5YuPN0kw8GNg9UnZsxp3we7cGVuYhV
   N96nbqzqfKpux8KNguwGd3a7K4Lg5Xcg9FRyefJpPHJ1kAV4OHWr1MUkC
   +Gyy6jB4GENtMrUCHG7Sl3fXD2v5+ONb3Gw4QzxXWVypDoa6+uRNwgQwn
   Cl4vA10du8H7l7aBPVh0crYhEUV6lo3IkRp8jR8frXA/ZOmlOqfkiFcW1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="270191754"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="270191754"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 00:07:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="693419765"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Aug 2022 00:07:24 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKaNf-000L51-2T;
        Sun, 07 Aug 2022 07:07:23 +0000
Date:   Sun, 07 Aug 2022 15:06:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 86af8230ce138e0423f43f6b104f3fa050aced6d
Message-ID: <62ef6482.zCWXFc/rEOHN6m2w%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 86af8230ce138e0423f43f6b104f3fa050aced6d  x86/mm: Rename set_memory_present() to set_memory_p()

elapsed time: 716m

configs tested: 68
configs skipped: 73

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                               rhel-8.3
x86_64                        randconfig-a004
x86_64                           allyesconfig
x86_64                        randconfig-a002
i386                          randconfig-a014
x86_64                        randconfig-a006
i386                          randconfig-a012
i386                          randconfig-a016
mips                     decstation_defconfig
ia64                      gensparse_defconfig
sh                         microdev_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                          randconfig-a001
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                          randconfig-a003
powerpc                       ppc64_defconfig
sh                          sdk7780_defconfig
arm                          pxa910_defconfig
i386                          randconfig-a005
i386                          randconfig-c001
arm                         lpc18xx_defconfig
m68k                       m5275evb_defconfig
sh                             shx3_defconfig
powerpc                 mpc85xx_cds_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-c001
arm                  randconfig-c002-20220807
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a011
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
arm                       imx_v4_v5_defconfig
i386                          randconfig-a006
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

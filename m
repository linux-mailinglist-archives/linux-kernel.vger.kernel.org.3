Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E470E50F17F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343524AbiDZGvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242936AbiDZGu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:50:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E936627171
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650955671; x=1682491671;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vZKprBkj/vC5IYENQi9CmGVZ3nkyIgQl414kNXEGvsw=;
  b=fF2Ch0mjs6O0MQvbbmb99PMXxX0UmG/v5lyn6dAjL2PT4EgX31C6Z5UX
   o8dje6AZX/kboXVao4xv5riDI51uENiW4ux7Y4AaWbSmMcgq9104IhzrD
   jQufdYHt+Lh06CbRFGwx9qZ1URLUT+fzbIUzDT2xiKnDRQvre8XbTMHvN
   sO31/eRNdopO4dwPclAWJyfJeIORaekcTR3Q9H5/DXkZm3ePw3Ma4OA8I
   ovzDH9lbfiGwzOShVCJqxK/kb5UqTNdKtZs6IGgIlxnghoW07RS5kcwdv
   F/JWuub3CTinYpyYZvB5Kr3Sb1nPwS1VpJnEZ/4G72Xd9Cn2ek+w6AaZd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="328416131"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="328416131"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 23:47:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="595614745"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Apr 2022 23:47:50 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njEzD-0003IZ-FW;
        Tue, 26 Apr 2022 06:47:47 +0000
Date:   Tue, 26 Apr 2022 14:47:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 8da18e1d2df3cc2b503bb75733f41eca040c4381
Message-ID: <62679581.Jv/72GnRcfwBx1uT%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 8da18e1d2df3cc2b503bb75733f41eca040c4381  Merge ras/core into tip/master

elapsed time: 880m

configs tested: 69
configs skipped: 92

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                 randconfig-c001-20220425
arm                         lubbock_defconfig
arc                     haps_hs_smp_defconfig
arm                           h3600_defconfig
xtensa                  nommu_kc705_defconfig
x86_64               randconfig-c001-20220425
arm                  randconfig-c002-20220425
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
i386                   debian-10.3-kselftests
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20220425
x86_64               randconfig-a014-20220425
x86_64               randconfig-a011-20220425
x86_64               randconfig-a013-20220425
x86_64               randconfig-a012-20220425
x86_64               randconfig-a016-20220425
i386                 randconfig-a012-20220425
i386                 randconfig-a011-20220425
i386                 randconfig-a015-20220425
i386                 randconfig-a013-20220425
i386                 randconfig-a016-20220425
arc                  randconfig-r043-20220425
s390                 randconfig-r044-20220425
riscv                randconfig-r042-20220425
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                        magician_defconfig
powerpc                       ebony_defconfig
i386                 randconfig-a006-20220425
i386                 randconfig-a002-20220425
i386                 randconfig-a005-20220425
i386                 randconfig-a003-20220425
i386                 randconfig-a001-20220425
i386                 randconfig-a004-20220425
x86_64               randconfig-a002-20220425
x86_64               randconfig-a004-20220425
x86_64               randconfig-a003-20220425
x86_64               randconfig-a001-20220425
x86_64               randconfig-a005-20220425
x86_64               randconfig-a006-20220425

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

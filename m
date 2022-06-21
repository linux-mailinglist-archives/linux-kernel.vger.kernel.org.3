Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC80553843
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352331AbiFUQ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiFUQ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:56:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7981221E27
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655830568; x=1687366568;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IqVaXVAhUiszl3qJo7uuOGds65md3km2SF/RMtbFfKc=;
  b=KC5EEF1CiM0wzHYHaUcbUjjMFLUIeHAFSDTYIHoOAZ8lTllsD8SH0yv/
   uoc9Br2yQG2j2VdHL0V8Hw9h3+H2MJevQMDqm1oAuoMaaMT5BpFGIGVGD
   de5UyHi1GQLZE6jvzkTnTqg9ykLN6jdsQmEpSVYHYaCyjoDNxyqjNoVoU
   GXFLVmMfBFvZaoS8PQOrZUlUqhDL/2SrOXe2V7EJiVu+sHLELowhgZ0al
   +WLzrr0HvJw5UIRTnMh2CA4QidAuuA/uvdOdHFHHgPDvbGnfFcbeKdn0a
   vCc/KHfbD4sDu5GuyAj9n0LZGW9yd/u1ZRkcBjctyHR6LyHkA2fmRKq0+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="344162385"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="344162385"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 09:56:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="643717673"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2022 09:56:06 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3hAb-0000C7-Lu;
        Tue, 21 Jun 2022 16:56:05 +0000
Date:   Wed, 22 Jun 2022 00:56:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 229e73d46994f15314f58b2d39bf952111d89193
Message-ID: <62b1f820.EM3mLkwqdZQ+tQj0%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: 229e73d46994f15314f58b2d39bf952111d89193  x86/pmem: Fix platform-device leak in error path

elapsed time: 733m

configs tested: 49
configs skipped: 81

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
m68k                          hp300_defconfig
arc                        vdk_hs38_defconfig
sh                          landisk_defconfig
m68k                          sun3x_defconfig
m68k                          multi_defconfig
xtensa                       common_defconfig
m68k                       m5249evb_defconfig
arm64                            alldefconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allmodconfig
i386                 randconfig-a005-20220620
i386                 randconfig-a001-20220620
i386                 randconfig-a006-20220620
i386                 randconfig-a004-20220620
i386                 randconfig-a003-20220620
i386                 randconfig-a002-20220620
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
x86_64                        randconfig-k001
hexagon              randconfig-r041-20220621
hexagon              randconfig-r045-20220621

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

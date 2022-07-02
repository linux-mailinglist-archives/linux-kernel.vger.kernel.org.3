Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880FC564300
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 00:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiGBWBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 18:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGBWBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 18:01:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083B1BC98
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 15:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656799274; x=1688335274;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mXD4/q9xtgcdXA1JTMqCjAMPxUV06PmyLgL6nbTXblI=;
  b=OcB6X4lYbs42CMn5Od1AX3sy7JYpCJ+hgvSWftzlXZR5ltXFpjGEZ9NU
   nHjJqMQBf+NOpEIgcyVz0t6+E2lmSoRQIh4kODtkPxjcokXfpRSZrkfn8
   JFDn+qgqji/Opg2IqkefkHZaqmfa9p2bzA90jrmpFYhOI6NRKTL1QbndQ
   ccDlz9QVUci0nUB8yrmoblA7HDyo1+y5Orv9yO+Q7fP8zglkzT/sZs9ls
   txPItwUQP3uL4W6eGk0ArhMno8tX+1poKTqA9+gte/zcyR6VEE345NT1u
   4vd8Nh/o7pvJPUhPvbsI+ATCUmp2LzT+WuNt6wgCCU12e0/tYmlbuA1sn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="346856890"
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="346856890"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 15:01:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="659784434"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jul 2022 15:01:12 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7lAt-000Ffn-NG;
        Sat, 02 Jul 2022 22:01:11 +0000
Date:   Sun, 03 Jul 2022 06:00:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 7e09ac27f43b382f5fe9bb7c7f4c465ece1f8a23
Message-ID: <62c0c006.p0A6gL1ancVUYyBy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 7e09ac27f43b382f5fe9bb7c7f4c465ece1f8a23  x86: Fix .brk attribute in linker script

elapsed time: 723m

configs tested: 47
configs skipped: 78

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                   secureedge5410_defconfig
sh                   sh7724_generic_defconfig
m68k                       m5475evb_defconfig
nios2                         10m50_defconfig
m68k                                defconfig
x86_64                           alldefconfig
alpha                               defconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
powerpc                        fsp2_defconfig
arm                     davinci_all_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

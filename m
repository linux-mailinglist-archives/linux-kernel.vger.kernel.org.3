Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E036C58A930
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 12:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbiHEKFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 06:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiHEKFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 06:05:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66977267D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 03:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659693917; x=1691229917;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=x4z2n+0ul8epVGqGJkMwZlvquRalUboGw6+5B8SZyGI=;
  b=KlUMBbR87W30Zroh/1ILjv2t2UuYw+kqIfMX1aJdBNEaliR+4SzO/yH+
   nL1DqX8uUaoaOKJo+PCa4xDHA9Bmv5l/8OpkwE5Na/JKh952sjmdw93ab
   0T6h259WsiLJMTXYEyBPhAQ3Yq77LZq0Rfz9SaCt1bWDqFQCT3zaYQClS
   LRCKP6tJWf24A2RRuI2jnnpUaZ69YWUujmmj/P6iBF+ltjKaovqwZ6WZF
   qjkF9QS7iJoTi9UtEm9NmJsbKDvCnHwyRMQILYFi3n5cswfaKUJvzkeS0
   lkSVjx1Tz7/ygL6MnNfG3Kf2Sy/AA8ocUZxPX7JDSQMMjFQjp3Z2/4h2W
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="273214648"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="273214648"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 03:05:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="579449750"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Aug 2022 03:05:14 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJuCg-000JH5-14;
        Fri, 05 Aug 2022 10:05:14 +0000
Date:   Fri, 05 Aug 2022 18:04:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 de979c83574abf6e78f3fa65b716515c91b2613d
Message-ID: <62eceb47.wSjrCVaH28afjjh0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: de979c83574abf6e78f3fa65b716515c91b2613d  x86/entry: Build thunk_$(BITS) only if CONFIG_PREEMPTION=y

elapsed time: 813m

configs tested: 41
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                         amcore_defconfig
sh                             shx3_defconfig
parisc                generic-64bit_defconfig
i386                          randconfig-c001
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
loongarch                           defconfig
loongarch                         allnoconfig
powerpc                    amigaone_defconfig
arc                        nsim_700_defconfig
sh                          landisk_defconfig
mips                            ar7_defconfig
openrisc                 simple_smp_defconfig

clang tested configs:
x86_64                        randconfig-k001
arm                        mvebu_v5_defconfig
mips                        bcm63xx_defconfig
arm                              alldefconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

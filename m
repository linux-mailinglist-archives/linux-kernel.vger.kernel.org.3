Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761EE58A2EC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbiHDVxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiHDVxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:53:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A18B7D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 14:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659650019; x=1691186019;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OHCsl+XUzQO7RT4641GA7PUmBwvdkIz4kTfdE4EpX5E=;
  b=EJyaBDjd9OeY24PKTzTBwfP8Xi2AEqIe6nAKgSm65zTGyBsLrj6zxyIU
   wLJ/VU2lYP3/Pwy9vyH/2ibxrsiXMKHCXuR+dzvCrQmXRzbcxbM3MAm5T
   uhZoEbQtKTNAPH4XWZci0utCZhDT+O5CPmeL79hyRqvM5a1XrTRx4Vc8c
   jxW9AY01cJhiRVRo26iEClJJGbCtIzt3HE8EzsiHWkfQj0uUFz984117B
   cVc/R2zwUxmyjSrJItHpyVrXmDuPIcxbPjZcOO8JKuNgetbOAU4el2KOO
   wk1BHDY75l1KfGmnHEFf9UhlpEHW7yMK8lUjqR6ejzbwpc2HdapdSjS+b
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="354051606"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="354051606"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 14:53:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="671428782"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2022 14:53:36 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJime-000Isz-0H;
        Thu, 04 Aug 2022 21:53:36 +0000
Date:   Fri, 05 Aug 2022 05:52:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 9aeaf5bc4e30ec968ae660b865ed491a28daf500
Message-ID: <62ec3fa4.IzBQy9swDRQCCzlS%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 9aeaf5bc4e30ec968ae660b865ed491a28daf500  locking/spinlocks: Mark spinlocks noinline when inline spinlocks are disabled

elapsed time: 697m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
i386                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arc                  randconfig-r043-20220804
x86_64                               rhel-8.3
x86_64                        randconfig-a015
x86_64                           allyesconfig
i386                          randconfig-a014
i386                             allyesconfig
arm                                 defconfig
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a006
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
arm                              allyesconfig
powerpc                           allnoconfig
i386                          randconfig-a001
arm64                            allyesconfig
alpha                            allyesconfig
i386                          randconfig-a003
arc                              allyesconfig
i386                          randconfig-a005
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220804
hexagon              randconfig-r041-20220804
x86_64                        randconfig-a012
i386                          randconfig-a013
riscv                randconfig-r042-20220804
x86_64                        randconfig-a016
s390                 randconfig-r044-20220804
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

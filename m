Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD26588891
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiHCIQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiHCIP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:15:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6AB60E2
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 01:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659514558; x=1691050558;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FXwmgyslZZE5b28VYrKrk9yKDHO6M7WRyutjjaxjhcA=;
  b=kVza93VKGnQJLxo/wJU8iK0cGSfQnGIJP8+nG2zI+SZUoPGIl99EanIA
   4SJPKm4valSjbxNGIc6O91D3UMRnAgl2ROkjYIrT6R3jKzKRMCA8WLoV5
   KTze/mJKfBreVn+HiXksByHpxDUcpyvKQqulE9QQAlJTOvgwBJ9gF8xn9
   /cZjtSLVAdpW9XfzMBTVFRUBgLnl0cL9AOQrhKikulXcWCiL5pxxZbjcq
   q2sHy4ZkqJqOx5DIh91mBCMGlFydzZ6gyB/5u8oXPukO2fYvOEvnub1I5
   LrErMNbxWqGnIAF2Y3HhOJcQuiuo9tmfp9iEQJZcBMr+PCNv1UX++ADly
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="353619615"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="353619615"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 01:15:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="848500924"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2022 01:15:57 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ9Xo-000H2F-1Y;
        Wed, 03 Aug 2022 08:15:56 +0000
Date:   Wed, 03 Aug 2022 16:15:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 d171011e6adad135eaced630dce26cac9a174037
Message-ID: <62ea2eaa.l7o3D6IbdFLnGN3r%lkp@intel.com>
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
branch HEAD: d171011e6adad135eaced630dce26cac9a174037  selftests: futex: Fix 'the the' typo in comment

elapsed time: 717m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
i386                                defconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20220801
i386                             allyesconfig
powerpc                           allnoconfig
s390                 randconfig-r044-20220801
riscv                randconfig-r042-20220801
powerpc                          allmodconfig
x86_64               randconfig-a014-20220801
arm                                 defconfig
x86_64               randconfig-a015-20220801
sh                               allmodconfig
x86_64               randconfig-a011-20220801
mips                             allyesconfig
x86_64               randconfig-a012-20220801
arm64                            allyesconfig
arm                              allyesconfig
x86_64               randconfig-a013-20220801
x86_64               randconfig-a016-20220801
m68k                             allmodconfig
arc                              allyesconfig
i386                 randconfig-a012-20220801
alpha                            allyesconfig
i386                 randconfig-a013-20220801
i386                 randconfig-a014-20220801
i386                 randconfig-a011-20220801
i386                 randconfig-a016-20220801
i386                 randconfig-a015-20220801
m68k                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz

clang tested configs:
hexagon              randconfig-r045-20220801
hexagon              randconfig-r041-20220801
i386                 randconfig-a004-20220801
i386                 randconfig-a006-20220801
i386                 randconfig-a001-20220801
i386                 randconfig-a002-20220801
i386                 randconfig-a003-20220801
i386                 randconfig-a005-20220801
x86_64               randconfig-a002-20220801
x86_64               randconfig-a001-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a004-20220801
x86_64               randconfig-a005-20220801
x86_64               randconfig-a006-20220801

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

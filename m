Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B6158892C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbiHCJQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbiHCJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:16:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112A720BE3
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659518160; x=1691054160;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=NdhuWMrftmLjr1Wdf/OUysQBe2UuRWAvLpA11ln3+20=;
  b=A9tpaUBH+XZy2MpRodrUrJ7asHVFdLKL/DinwPOfHAd0pPZ0akSGK5g7
   wqU+2krO1RG4O3Fd6cfpUp/vU3K+QG4d6JFazi3t/p6sa75DSkW9u0viU
   Zp5Pw8GBRKraRKz9FaLDVTowIZblRRS7Yn0n071MWAaSbjsfrOvuPBtvq
   83IE1GoB/opmdmntzd0stsT9R6sFkCgyiYqxoqkA0DcU2f495XrbEFgcm
   xqw8HOPiE5rgkNND/RWe2hh+UENzUkP6xt72F41SX5YQudkcsW3FRenQb
   MkTNk0h+ld5PfatYa6DfitojrSBAWx2X3srB2Nk+w/Ja81u7BSxfGjlO7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="353629822"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="353629822"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 02:15:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="930319022"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2022 02:15:58 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJATt-000H51-3D;
        Wed, 03 Aug 2022 09:15:57 +0000
Date:   Wed, 03 Aug 2022 17:15:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 ffa6482e461ff550325356ae705b79e256702ea9
Message-ID: <62ea3cc4.hNJwYzuCIFtkrnli%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: ffa6482e461ff550325356ae705b79e256702ea9  x86/bus_lock: Don't assume the init value of DEBUGCTLMSR.BUS_LOCK_DETECT to be zero

elapsed time: 1261m

configs tested: 45
configs skipped: 69

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64               randconfig-a014-20220801
x86_64               randconfig-a011-20220801
x86_64               randconfig-a012-20220801
x86_64               randconfig-a013-20220801
i386                             allyesconfig
x86_64               randconfig-a015-20220801
x86_64               randconfig-a016-20220801
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
i386                 randconfig-a012-20220801
i386                 randconfig-a013-20220801
i386                 randconfig-a011-20220801
i386                 randconfig-a015-20220801
i386                 randconfig-a016-20220801
i386                 randconfig-a014-20220801
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig

clang tested configs:
x86_64               randconfig-a002-20220801
x86_64               randconfig-a001-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a006-20220801
x86_64               randconfig-a005-20220801
x86_64               randconfig-a004-20220801
i386                 randconfig-a001-20220801
i386                 randconfig-a002-20220801
i386                 randconfig-a003-20220801
i386                 randconfig-a005-20220801
i386                 randconfig-a004-20220801
i386                 randconfig-a006-20220801
hexagon              randconfig-r045-20220803
hexagon              randconfig-r041-20220803
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

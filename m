Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54551570D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiGKWQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiGKWQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:16:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FE128724
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657577806; x=1689113806;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0R+juBQCFBsStqkkAeUVW1maHMT0CMoj+nxv2u/r/h0=;
  b=VSnjE/fy0CW8iYtzHNTktLSLnu74OG/6UMpgq70JfPpTRIvn9kUsGUT8
   FIr0vqzeggqf2UT80XV3R/rsIjJu05hVs34ZqCf2jGTO/4ExVPdshxsl6
   0kBuVPU0TnYI4+NuL7gr9Db3M9+laHIgf9M81U1awZCUE/sQyji0ouwa5
   2izahpdo7I397m1XVkBuoNnpuLhdJeqYe4rTVfONjea3eEOAJ9NHOYNks
   i5XwgjEPPcfhMXXtEazx1iX3kCDDip5jQiThH5oJSE+o68NzxXk92qjck
   Ctc2gxR7I/i2YRjIyqiPQQ9a+pu8C7nMAyfpD/ozpGHN4Q/Za5cVReRWB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="371089236"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="371089236"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 15:16:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="545183466"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Jul 2022 15:16:45 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB1hs-0001Jd-AG;
        Mon, 11 Jul 2022 22:16:44 +0000
Date:   Tue, 12 Jul 2022 06:16:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 da4600c76da7d787db04ce059b1f176da8a8d375
Message-ID: <62cca120.9SsyKHZ0KhoD7FB8%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: da4600c76da7d787db04ce059b1f176da8a8d375  x86/pat: Fix x86_has_pat_wp()

elapsed time: 727m

configs tested: 43
configs skipped: 81

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
s390                       zfcpdump_defconfig
sh                   sh7724_generic_defconfig
arm                        mvebu_v7_defconfig
sh                          polaris_defconfig
xtensa                generic_kc705_defconfig
powerpc                 linkstation_defconfig
sh                          rsk7201_defconfig
arc                           tb10x_defconfig
parisc                generic-32bit_defconfig
mips                        vocore2_defconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

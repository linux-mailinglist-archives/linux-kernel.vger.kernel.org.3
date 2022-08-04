Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E9358A2BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbiHDVWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbiHDVWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:22:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC859357C4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659648157; x=1691184157;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GEhFIuYgcMY2jA3WCMQ1TJKEhWe7evy0MUBxPtemUn4=;
  b=Uywi/PDemN1AbI9fHPrhQ2BaqS5hDjYPhaS9Pvct5lTDOUsvFL3pRBLF
   nQSxJ9ZXg1bYS5vky87S7pD+CejztMdvbATTEaIsI7vkCmN0NiuLsIs/U
   2MntHlYcCFNf01/TPxB3H/90EflQkTcmgzGt/6BmKZi1ibTQA5Qt54BNQ
   7VXuVnAeeNvjBx7QC2nXeLtT1q4VGRCh9uoyrPMoapDS5lROpMfDU3KKR
   0MEx7auZHUDGOnKkXeqdB/9ef1FV0UAA6pRZIS2bO2TQX4+31bROcNyLs
   FHs8zf0PrUDnXJmNXxlAPPZ8274UfRuXvsrrNyjhxdxSVYetgY+bsZwlf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="290824040"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="290824040"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 14:22:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="671420862"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2022 14:22:36 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJiId-000Irj-1J;
        Thu, 04 Aug 2022 21:22:35 +0000
Date:   Fri, 05 Aug 2022 05:21:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 99643bab36b642be10bf09cd3285c37c9e5b597f
Message-ID: <62ec386c.lknrdv5tfrA7wpMS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 99643bab36b642be10bf09cd3285c37c9e5b597f  perf/core: Fix ';;' typo

elapsed time: 713m

configs tested: 26
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
i386                             allyesconfig
x86_64                           allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a016
m68k                             allyesconfig
powerpc                           allnoconfig
m68k                             allmodconfig
ia64                             allmodconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20220804
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015

clang tested configs:
i386                          randconfig-a015
s390                 randconfig-r044-20220804
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

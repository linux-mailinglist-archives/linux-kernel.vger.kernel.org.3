Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD35858A58B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 07:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbiHEFAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 01:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiHEFAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 01:00:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42121C6A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 22:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659675612; x=1691211612;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pDWo0Ja2ARI5KLUZvjW5Kv2ujb1AhVYLfAJmHLtH9bw=;
  b=KIQts2GwwEnBlxNJ5jpg/gQ5Hjs40Bww8prKP7GNsE50VTu9Qs/yhaNd
   F/590M4KPrSmn7xRkA64SUCPhxmcAmGhtf9emZ561vzPz3jZWI1plTmME
   N1gfGOFRDkwTtej8YVNEEkwf4+aMNaHw6vihREFFYeixKsM1SQgVt3p/Y
   WXnIQ9tSqjrA4QrksVdEVdqCb+2175hXN6NQtG0VSh6bwr8ymELbT6tBV
   J6LcnRyMkuXEokCR0eJK2boj0Fopu8tJ8HWt1HRGHMDp38n0jmTLiw2mL
   UWNL2y41lOYN72BdMl+gyXG7QTVIwE0BbiphUq0LWVI1aVG5yZ5o1fRZO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="354121178"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="354121178"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 22:00:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="553988128"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Aug 2022 22:00:10 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJpRS-000J95-0B;
        Fri, 05 Aug 2022 05:00:10 +0000
Date:   Fri, 05 Aug 2022 12:59:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 edf13ecbc8d68cc7462df9cae1f4a137df3b827c
Message-ID: <62eca3bf.yqSUhbe46VlyZudl%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: edf13ecbc8d68cc7462df9cae1f4a137df3b827c  x86: Fix various duplicate-word comment typos

elapsed time: 1105m

configs tested: 42
configs skipped: 74

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
x86_64                        randconfig-a015
i386                          randconfig-a003
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20220804
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig

clang tested configs:
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a012
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

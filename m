Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FCE58A2BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiHDV2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiHDV2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:28:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C21E140DE
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 14:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659648517; x=1691184517;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=k6BAs8/YIc7B/rdxovTPCuQ9CWH+/TdXWj5UVJoM/oc=;
  b=LyMLU3SOZnqwJP7wNebbqDO0+KPdZa3MaqChbrfun8sOPeDI6HGFA2k9
   MWu5NbooFEmlt/co4UmJ7TnkmfT2YR0d11KwVlJNdQq0RpFxMUCKr8Cs0
   nLztSip9568jI872Jr/hXA/QBy73vmK6aopRrxzG2apoUlByR91bxg3Te
   B5V5DtfZY5uLYmgDXxAyLbObivdWi4JG8RtrR6tjaFKMvquX171Nzds05
   Y//dXDlpaYgha6uVWiGPhq7kM2PTNDGa0oa3hZ38kobqcBUhm76BRKj/g
   OQNOBrXh0hXP1t6+DMOTVqh0b4U3MSsaWz4owu35ZfnIe324+aMhwPiwe
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="287611863"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="287611863"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 14:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="553871647"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Aug 2022 14:28:36 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJiOR-000Is5-1v;
        Thu, 04 Aug 2022 21:28:35 +0000
Date:   Fri, 05 Aug 2022 05:28:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 8648f92a66a323ed01903d2cbb248cdbe2f312d9
Message-ID: <62ec39fc.BA83cEXIwybSBW1D%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 8648f92a66a323ed01903d2cbb248cdbe2f312d9  sched/core: Remove superfluous semicolon

elapsed time: 720m

configs tested: 31
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a014
arm                                 defconfig
x86_64                        randconfig-a002
m68k                             allyesconfig
x86_64                              defconfig
m68k                             allmodconfig
i386                             allyesconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                               rhel-8.3
sh                               allmodconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20220804
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a005
s390                 randconfig-r044-20220804
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

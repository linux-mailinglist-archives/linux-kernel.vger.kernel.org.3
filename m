Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296AE58A4C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 04:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbiHECeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 22:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiHECeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 22:34:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FECB6FA26
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 19:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659666849; x=1691202849;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lSzcseguImRnPZJT5m0YlPxXYETupsB73+jk/O7Rs5A=;
  b=MJyGQ1FclzhgcFrUM7+1LxJrlq2HTnkbB6doZxsMNoBTVY0dzxNpIKzx
   lM8vh3nByMqKdOAVMMaaeF86clRm7ofdKL2mLTwDxKJGys2BrGi3IDwvp
   A5PXptKKpUkxYoxPhj5eXRoD56e4QPmqYnbyRqNYW1MNWrlwVFzu3ftQA
   GNjnBk1+xAWmxGaBdZDgzXXz7/T4yKLuXwNH7n8EQeauwTpivJvhDicjy
   BXUlT2Kt4Z5aer1vK8HO2kbIWa8OzNEBN7kfFDHEkEhvWLWwgoOOL54Hy
   s0p+om/CZQqtxo+lLtLYiF9g6JoxwgyMttfoN4F34cw1LP0AJcBli8uU1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="354104105"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="354104105"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 19:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="553958242"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Aug 2022 19:34:07 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJnA7-000J4J-08;
        Fri, 05 Aug 2022 02:34:07 +0000
Date:   Fri, 05 Aug 2022 10:33:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 81a71f51b89e84f39df2a3b1daf4274ae6b7b194
Message-ID: <62ec8195.Skm5+kStH6qWkl9Q%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/platform
branch HEAD: 81a71f51b89e84f39df2a3b1daf4274ae6b7b194  x86/acrn: Set up timekeeping

elapsed time: 978m

configs tested: 34
configs skipped: 74

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
x86_64                              defconfig
i386                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a013
i386                          randconfig-a014
x86_64                        randconfig-a011
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
i386                          randconfig-a001
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a015
i386                          randconfig-a003
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a004
i386                          randconfig-a005
x86_64                        randconfig-a002
x86_64                        randconfig-a006

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a012
i386                          randconfig-a002
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

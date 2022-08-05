Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115E758A707
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiHEH3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiHEH3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:29:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E351B794
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 00:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659684554; x=1691220554;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rRjc95XG9gEDJcddxcK4WwU36mlJtD9dvEZpYzHHRCs=;
  b=a2oYEq1I1Cn9w8fpZkh9EvUSF8NqjdLFHet+S7aFo5eF7NQ7EAksNdJN
   DSHII8eiRzEaDtrJQZ9eVf7wmErb6MoKVYtl7s8l3cJpwcpcu0l36Ds2y
   V+mNyhvMqOolYSHSk7ibONp3KN6FwWEj0YDc/tEAhLFNaMjmA5WSw7hTr
   dd9vH5Jw0IqvbxD//+YZXOIJhrBgCoeVJFIY3UeNWmqem8dsIhnZ5C517
   btdcCIa7yowMkSC7UEu5zFW3YrUPzocjBThFgmTlRL2me30fHDVoxsPym
   oXn7167LdiYQkACAl2liv2wrl+XVzDb6o5u0+BuVKK3Du1BmfyhLM3Hyn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="354141351"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="354141351"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 00:29:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="692923683"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Aug 2022 00:29:12 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJrlg-000JCz-0n;
        Fri, 05 Aug 2022 07:29:12 +0000
Date:   Fri, 05 Aug 2022 15:28:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 6f458e6aa6da6a0116f2757770b6f1666021f7af
Message-ID: <62ecc6b2.W1UFw4+M8w8MLVB4%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 6f458e6aa6da6a0116f2757770b6f1666021f7af  Merge branch into tip/master: 'x86/urgent'

elapsed time: 722m

configs tested: 22
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                               rhel-8.3
mips                             allyesconfig
powerpc                           allnoconfig
m68k                             allyesconfig
powerpc                          allmodconfig
x86_64                           allyesconfig
sh                               allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

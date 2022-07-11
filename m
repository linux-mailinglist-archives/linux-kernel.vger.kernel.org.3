Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310E4570D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiGKWdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGKWds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:33:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB69018390
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657578827; x=1689114827;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=exH/qYsK7YSbUU9c5cTh+qseXLrMU7BADTGmJkP0TNY=;
  b=ScwpRoC8j3w1TE4t5Rd3GVISRUkseahsHgbGwj/Wlc2GyMy42iOZ7YIM
   IfogStfs30IqR+X8wlvPYc+hZ2AzFabqJmGLlzIEF970coK9RBRxeEDvI
   zQM9t8QNWXi2yi89hOHOnJBUPYOAV5YtOz0mkXRqbC6r4O/9c2hPPzfcN
   OkILPJ5xVANiD7cuzTaywGDVY7PVG7U45flc79RsZ5dCOxeJsjV6F4LbL
   LBEKK97d6qm9XBkgn2/1AF8v8AQfN35jfpZm+m/9tdmBZ8t+eGQgQU+6+
   R8NpqToct1pHh+DJ9+7Dr3INa0/9EVlYq5fQxzzrlQSDmOttyLv5jbPN4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="285526511"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="285526511"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 15:33:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="622259020"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 11 Jul 2022 15:33:45 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB1yK-0001Kp-Uu;
        Mon, 11 Jul 2022 22:33:44 +0000
Date:   Tue, 12 Jul 2022 06:33:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/kdump] BUILD SUCCESS
 68b8e9713c8ec90af93c16e1de51cca18cefdb56
Message-ID: <62cca545.Dpd7tjFQ/0g6naPp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/kdump
branch HEAD: 68b8e9713c8ec90af93c16e1de51cca18cefdb56  x86/setup: Use rng seeds from setup_data

elapsed time: 772m

configs tested: 23
configs skipped: 2

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
powerpc                           allnoconfig
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

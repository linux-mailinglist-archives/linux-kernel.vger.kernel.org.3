Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF35A54C671
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347033AbiFOKqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237029AbiFOKqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:46:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F1551585
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655289970; x=1686825970;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oQxuhjGD9lCIYMLV95OHuSL2ojSWpZXWYvCIMI/HCLg=;
  b=J+QvQ6UZoFGAxE4mI+dJfuBCMlut86WyB36v17PjA8mNhObsPBpvVY7W
   CttiDh3CAW4OS7Py3LLFqGV4Gguo+/dfyJPN5nrb25CPYIQ+tXNBn/wVQ
   GQdFcJ+tvNWM8XPJciRQ0SABdx/Ok7BIhguR2UXbrZ+gnHQmUZQdEfBzR
   qJOKcSAHNjs9WtuzARE4W4lv8bCpmVvNEK86vS2/wdqSXuaQFpEKYOnbe
   mLUCyQdhCt6VS3luo/sPNH/hc8BNfuyEuyMGUL3Kw1BtDJj1Ozrrfsyzh
   wq5PlqPVdpMNF2muM7/0GaXhAGfOhR6Hhip4k76XCnChDNSXb9zeZL2Ql
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="258768275"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="258768275"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 03:46:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="830973785"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2022 03:46:09 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1QXJ-000Mld-0u;
        Wed, 15 Jun 2022 10:46:09 +0000
Date:   Wed, 15 Jun 2022 18:45:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: xtensa-linux-ld: section .start VMA
 [00000000d1000000,00000000d1000007] overlaps section .image VMA
 [00000000d0003000,00000000d1535037]
Message-ID: <202206151848.twvxfjn7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   018ab4fabddd94f1c96f3b59e180691b9e88d5d8
commit: da0a4e5c8fbcce3d1afebf9f2a967083bb19634d xtensa: only build windowed register support code when needed
date:   8 months ago
config: xtensa-buildonly-randconfig-r001-20220615 (https://download.01.org/0day-ci/archive/20220615/202206151848.twvxfjn7-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=da0a4e5c8fbcce3d1afebf9f2a967083bb19634d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout da0a4e5c8fbcce3d1afebf9f2a967083bb19634d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> xtensa-linux-ld: section .start VMA [00000000d1000000,00000000d1000007] overlaps section .image VMA [00000000d0003000,00000000d1535037]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16E55A3D39
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 12:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiH1KvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 06:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiH1Ku4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 06:50:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDE318388
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 03:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661683854; x=1693219854;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uBnc/uUl4uYtFqyvUJIC8EP0Jc7OEbx0uhCCIwKRo20=;
  b=mHkg/y0Kzs+PLSd0VZOemuSRdx0QHbTk64DMUhjK1PQ6zUhw6XZvpDWp
   eUd1amidvEr50psJ578InQzGv9imbXnOAK0rNI99M5XpP4R4cSe/BQao+
   VDvSGAI2LIos8SP7KuFqAE4SbI7i4l1spxqrkdpCikZo2uRm/FS82zKfg
   TBd4gTNQgsxDW015KbRwHEh9tw8O5gMlW9fuozBbdJiNGlYD9m9SsdSvD
   cx/r6G/1za8G6tPUHlLo55nZn9BLlFWkfJO4aGooXI5zU9tEsTWG5t8Sd
   vm4frKeHThJ4afdU7Gw7XcPv/UQtS8Sh819tG5MZ1Hat8pcWQAWJXzikS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="296003346"
X-IronPort-AV: E=Sophos;i="5.93,270,1654585200"; 
   d="scan'208";a="296003346"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 03:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,270,1654585200"; 
   d="scan'208";a="561905548"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Aug 2022 03:50:52 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSFsS-00010t-0p;
        Sun, 28 Aug 2022 10:50:52 +0000
Date:   Sun, 28 Aug 2022 18:50:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c:1321:2-3: Unneeded
 semicolon
Message-ID: <202208281859.LUzCrKkS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   10d4879f9ef01cc6190fafe4257d06f375bab92c
commit: 25d7a5f5a6bb15a2dae0a3f39ea5dda215024726 ixgbe: stop resetting SYSTIME in ixgbe_ptp_start_cyclecounter
date:   4 days ago
config: alpha-randconfig-c033-20220828 (https://download.01.org/0day-ci/archive/20220828/202208281859.LUzCrKkS-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

cocci warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c:1321:2-3: Unneeded semicolon

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

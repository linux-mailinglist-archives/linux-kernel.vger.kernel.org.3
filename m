Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E13F4BDC21
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377180AbiBURYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:24:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356325AbiBURYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:24:00 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8044FAE69
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645464217; x=1677000217;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3l0vzYKfBNnbTycsWQ7CSo9hdXKMkG+TtZm7tloWDuM=;
  b=BA5Zvbt3t+oUJOiiinBwfU91B6EzY5B5sukLj4SEoxgTDdmnY03aNw9l
   AWJF3hrkW62gYkGFjeh1p0w+Ht0uxVSZu23MswDcUQqw/Z1tRQoO7nagP
   4cgoVMxT5FAv/+3Nv8gEU5WplUeFcB/uMJ9n9KlDf4L57vaITVPbYz97y
   zKFUQxJ3wZM73xF8GNXC86jtqRBhcS2nPCVt1jBAkIJSiiaugShO+wVSe
   GFuNpFkvSeFYQ5OVSeKJL63iAT5E9Zys5A+OyRl2etD6BdS+7PR31Wcaq
   pZUD1gdiBenp/utWYNAq1XUXQfs9HERol1dqFSMDsip76cWJFepMXS4cM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="276139480"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="276139480"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 09:23:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="507700031"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Feb 2022 09:23:35 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMCPP-0001p1-4q; Mon, 21 Feb 2022 17:23:35 +0000
Date:   Tue, 22 Feb 2022 01:23:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: ERROR: modpost: "iwl_mei_is_connected"
 [drivers/net/wireless/intel/iwlwifi/iwlwifi.ko] undefined!
Message-ID: <202202220159.LV6Fd9SI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cfb92440ee71adcc2105b0890bb01ac3cddb8507
commit: 977df8bd5844c9370c26a9477418165b870da27c iwlwifi: work around reverse dependency on MEI
date:   3 months ago
config: x86_64-randconfig-c002-20220221 (https://download.01.org/0day-ci/archive/20220222/202202220159.LV6Fd9SI-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=977df8bd5844c9370c26a9477418165b870da27c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 977df8bd5844c9370c26a9477418165b870da27c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "iwl_mei_is_connected" [drivers/net/wireless/intel/iwlwifi/iwlwifi.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

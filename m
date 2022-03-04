Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7254E4CCBF8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbiCDCsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbiCDCsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:48:37 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC55C1BE8D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 18:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646362069; x=1677898069;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g56pX/GSAWQSlgJNt88yTdMvqnz41826tIjouC0R+PE=;
  b=b2vmOrg+wS5G1HUUux0/LHX2NFSfg7xD7/CKx7i4HtCWaVvVFElKGMVw
   LUqakO4y9oeQ9oqpvl2hwy53VunomYxP7GQyImq5Wmk1csGv8OiRCQTJv
   B8NypuJyXjSJApDZcPjY7ZwjEgDCnD5wTMMziBNmjN5+XpWaoppZHi4JO
   8wWW+kXvi70S3PZan6ZdwVyl8espZRht+jgWPtNDCdj882L9ou2hPQXwL
   9Apl1dNTZr8iv+LAMfDFxzeR7SdUc4RUaRacKk+rCniqQyfbEFSvgHMZM
   M9pFqXYMxbrg6nlnLdBQUYkphxJiyyq8qSpg8s0s5Yyeqk3zaA5CveXxy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="233837695"
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="233837695"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 18:47:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="810158200"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Mar 2022 18:47:38 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPxyj-0001BB-O3; Fri, 04 Mar 2022 02:47:37 +0000
Date:   Fri, 4 Mar 2022 10:46:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.9-q-release
 7912/9999] include/linux/delayacct.h: linux/sched.h is included more than
 once.
Message-ID: <202203040338.WbHHoHF8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.9-q-release
head:   4be78b108a3a1d1ffbc2367c5a45855715451482
commit: 0f3e95cb46285a27db306d7a6e48fcf8a317b762 [7912/9999] UPSTREAM: sched/headers, delayacct: Move the 'struct task_delay_info' definition from <linux/sched.h> to <linux/delayacct.h>
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> include/linux/delayacct.h: linux/sched.h is included more than once.
>> /kbuild/src/consumer/include/linux/delayacct.h: linux/slab.h is included more than once.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

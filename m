Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145AB4CBB25
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiCCKVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiCCKVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:21:37 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693C8488AE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 02:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646302852; x=1677838852;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g56pX/GSAWQSlgJNt88yTdMvqnz41826tIjouC0R+PE=;
  b=ayFUGX6DEkoHnatl0XFulMiQKZb0K6vYOxjYbP87/fPJyp1bTzrixNLe
   huQWN692sHxxxSJGRa/JMTnqpxNsrhT5IoOrS4pOhBriDoinqCpveOdJV
   61A/cJmPiL/YnLYSum62EDmiw19UTz0jt2RqxYX6JDAHiS8kls+2/u6Fg
   7vXuFNt/aRYykQ3qbw6hI1dgqC13Y9NDumzjhmpgB9KQkbc/BtaSxXOlV
   LwGTmAyIFzsPIO2gCN1+j/K2AN6Xe7RuMQMFNWVHezjpE/YBA/DVKUG1s
   s/+uTQQpS4I1m5/FULFsdV+g4r6NW0zf/pbNA8yg0cbQiKN6XtwLjm0jp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="234250086"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="234250086"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 02:20:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="508539007"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 Mar 2022 02:20:50 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPiZl-0000Ny-Pr; Thu, 03 Mar 2022 10:20:49 +0000
Date:   Thu, 3 Mar 2022 18:20:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.9-q-release
 7912/9999] include/linux/delayacct.h: linux/sched.h is included more than
 once.
Message-ID: <202203031850.vSFz8tmp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

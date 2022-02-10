Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055F34B0505
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 06:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiBJF02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 00:26:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiBJF00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 00:26:26 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0AADB2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 21:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644470788; x=1676006788;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nYsayXmsrCG0aDf9fN2gKUNUi1WW6FFQ6yq/b5q1J20=;
  b=dkIkAwlVHNGnPg+51eSPre2bLW7lSGTVXCz/VqmZW9P/4+YIvo6AfP+6
   iBb5+5HbaN1Ncu1dMIZJwrKCEQbftBx2xB7VGjKXIkmQm0GrIz5gRMP6d
   N+BXfk8xzp+q068zldgD2F/zf8SHNb/T1VjqLxYD8zVVgMk4tX8cyBMtW
   GftIEmM969oWutXWbrgVdQB/IwBz8xQa0K8Hlz24WScHFwCo7ruEjKRsQ
   aXHXucR+hV3jZCLPWALjOIqchRvHzcI2ERnbton+AhEdG9WsCedqSDngl
   GeUgPcmxZI5m8O4kG16/X33b4rLD+RpEH9H5BUNCoHM9iBKAIA2m+WIA8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="230061880"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="230061880"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 21:26:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="633515701"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Feb 2022 21:26:27 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nI1yM-0002kU-3b; Thu, 10 Feb 2022 05:26:26 +0000
Date:   Thu, 10 Feb 2022 13:25:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhen Ni <nizhen@uniontech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:sched/core 29/30] kernel/sched/fair.c:230:2: error:
 implicit declaration of function 'sched_cfs_bandwidth_sysctl_init'
Message-ID: <202202101353.zojAXcpm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
head:   d95db7fbf521ca4274fd7b7bc4e7d8e2d78b35e6
commit: 17880af2ea65d254c1c225e6a25caa5352c3dbee [29/30] sched: Move cfs_bandwidth_slice sysctls to fair.c
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20220210/202202101353.zojAXcpm-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=17880af2ea65d254c1c225e6a25caa5352c3dbee
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/core
        git checkout 17880af2ea65d254c1c225e6a25caa5352c3dbee
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/sched/fair.c: In function 'sched_init_granularity':
>> kernel/sched/fair.c:230:2: error: implicit declaration of function 'sched_cfs_bandwidth_sysctl_init' [-Werror=implicit-function-declaration]
     230 |  sched_cfs_bandwidth_sysctl_init();
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/sched_cfs_bandwidth_sysctl_init +230 kernel/sched/fair.c

   226	
   227	void __init sched_init_granularity(void)
   228	{
   229		update_sysctl();
 > 230		sched_cfs_bandwidth_sysctl_init();
   231	}
   232	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

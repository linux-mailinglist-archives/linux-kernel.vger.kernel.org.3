Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7087850D549
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 23:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbiDXVjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 17:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbiDXVjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 17:39:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5A92AC61
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 14:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650836164; x=1682372164;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1GsevDkmtYy5fZQ588p/qpFrg3TuZ+86j19KyTEPcbA=;
  b=XnUEBSG9adL/VCslanR6O5s8fPtPHgZopge6cqng/PVENoYE7Z++CKX6
   iR31CggIp+re3HvCneweeqoyg8g8jWm6WMSSQKzJKvicwi8+ggJmCDIhh
   5YP3LO1GKNXg54xPUmzi/RU3JC2ttlfwYA60p6yoBBsNrTMrTpmk0ZLYN
   AwWaLOiXkAfdp2sJYP+98bRBY+HjbCUiVs7YBGE+qbQnEsd9j9QdrkR9y
   lIdX90tfKJBlwMfSYIKj2PNKgl3qPmJ2JWOLlWSDWOsglA6RLe999Q9UL
   dgQz5zrPkaNFkt4LRT7WEf0nxcmAIQAEUI5L6uYOsr4l97imN82fssuMI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="351537814"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="351537814"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 14:36:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="675780571"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Apr 2022 14:36:02 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nijth-0001o7-LE;
        Sun, 24 Apr 2022 21:36:01 +0000
Date:   Mon, 25 Apr 2022 05:35:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 127/2579] kernel/sched/fair.c:918:32:
 sparse: sparse: cast removes address space '__rcu' of expression
Message-ID: <202204250519.sArtxmdn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: c3b487719a9654b07ba650abe5bf9964e5474b69 [127/2579] headers/deps: Move task_struct::se to per_task()
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220425/202204250519.sArtxmdn-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=c3b487719a9654b07ba650abe5bf9964e5474b69
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout c3b487719a9654b07ba650abe5bf9964e5474b69
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash kernel/sched/ mm/ net/ipv4/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/sched/fair.c:918:32: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/sched/fair.c:5053:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:5053:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:5053:22: sparse:    struct task_struct *
   kernel/sched/fair.c:5579:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:5579:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:5579:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:7137:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7137:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7137:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:7435:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7435:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7435:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:4693:31: sparse: sparse: marked inline, but without a definition
   kernel/sched/fair.c: note: in included file:
   kernel/sched/sched.h:2022:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2022:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2022:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2180:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2180:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2180:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2022:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2022:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2022:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2022:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2022:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2022:25: sparse:    struct task_struct *

vim +/__rcu +918 kernel/sched/fair.c

   915	
   916	static void update_curr_fair(struct rq *rq)
   917	{
 > 918		update_curr(cfs_rq_of(&per_task(rq->curr, se)));
   919	}
   920	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1651955F284
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 02:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiF2Auq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 20:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiF2Auo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 20:50:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232A82F00C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 17:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656463844; x=1687999844;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SicGi26uebmdEwHWqDbzXdSIHfD6g+0F3qqCrKJiLnw=;
  b=jr24cq1+a6FFxpwrotQb7pWrLjUXyQKbyMbTwbWaCnFyQ1ocvypbUdIL
   jeox4nZOTmZMNs4KlaaJh20Jn5ICVwRSRd7a/FL9WbHGDfLoH6XHBHFTI
   XsB5qjM9gGmbja4/zkuqvXWfaDa7NZpXDrAYRWeqzEK3QHG77RrdcAYvS
   kg1FSF9WHZsd75o144D9Bby26TFxqJHfWTuXKyLUBupMFuZxiPAm8viiB
   Vl/S2HelIBHtmwzsZCDZnK5STtf6Y0AImyfTuoENda8bTJ65lsh8b1qA1
   TX0ev1ujOSt9aCT/nRBjIovXBRaMG7lm5Rs0Xkx3ozCdIEJqmIWZ7dLzR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="282620420"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="282620420"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 17:50:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="836903795"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jun 2022 17:50:41 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6Lui-000AmI-RD;
        Wed, 29 Jun 2022 00:50:40 +0000
Date:   Wed, 29 Jun 2022 08:50:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     kbuild-all@lists.01.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [gfs2:nopid 1/5] fs/gfs2/glock.c:2759:36: warning: initialization of
 'struct pid_namespace *' from 'int' makes pointer from integer without a
 cast
Message-ID: <202206290839.9woKp4xX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git nopid
head:   b1d0ed94e881ca5b5aee15e05f13db75445398f2
commit: 13ba8572506201aa85020970f776597fbcdcda56 [1/5] gfs2: Add glockfd debugfs file
config: csky-randconfig-r025-20220627 (https://download.01.org/0day-ci/archive/20220629/202206290839.9woKp4xX-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/?id=13ba8572506201aa85020970f776597fbcdcda56
        git remote add gfs2 https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
        git fetch --no-tags gfs2 nopid
        git checkout 13ba8572506201aa85020970f776597fbcdcda56
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash fs/gfs2/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/gfs2/glock.c: In function 'gfs2_glockfd_next_task':
   fs/gfs2/glock.c:2759:36: error: implicit declaration of function 'task_active_pid_ns' [-Werror=implicit-function-declaration]
    2759 |         struct pid_namespace *ns = task_active_pid_ns(current);
         |                                    ^~~~~~~~~~~~~~~~~~
>> fs/gfs2/glock.c:2759:36: warning: initialization of 'struct pid_namespace *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   fs/gfs2/glock.c: In function 'gfs2_glockfd_next_file':
   fs/gfs2/glock.c:2785:17: error: implicit declaration of function 'fput'; did you mean 'iput'? [-Werror=implicit-function-declaration]
    2785 |                 fput(i->file);
         |                 ^~~~
         |                 iput
   cc1: some warnings being treated as errors


vim +2759 fs/gfs2/glock.c

  2756	
  2757	static struct task_struct *gfs2_glockfd_next_task(struct gfs2_glockfd_iter *i)
  2758	{
> 2759		struct pid_namespace *ns = task_active_pid_ns(current);
  2760		struct pid *pid;
  2761	
  2762		if (i->task)
  2763			put_task_struct(i->task);
  2764	
  2765		rcu_read_lock();
  2766	retry:
  2767		i->task = NULL;
  2768		pid = find_ge_pid(i->tgid, ns);
  2769		if (pid) {
  2770			i->tgid = pid_nr_ns(pid, ns);
  2771			i->task = pid_task(pid, PIDTYPE_TGID);
  2772			if (!i->task) {
  2773				i->tgid++;
  2774				goto retry;
  2775			}
  2776			get_task_struct(i->task);
  2777		}
  2778		rcu_read_unlock();
  2779		return i->task;
  2780	}
  2781	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

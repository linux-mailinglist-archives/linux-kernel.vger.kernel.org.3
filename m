Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DBA4E8F33
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbiC1Hl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbiC1HlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:41:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0BE52E21
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 00:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648453182; x=1679989182;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NhGlVwa27JWWz3uynIhhlX3q60pFL3/x5Xqphkmvr4Q=;
  b=UCMl1TQ/2gWC+QJrEgYW555b/qurEfgdyFKOWycr/XpFCNvehX51nkly
   FGNPwsbLjXnMTYtNLr+ZMS1vog2TIaPGiyIArm+/pLkHkhOyMEYc84M5R
   96TukkF+ng/K8dIe09m2IGv36cgRmq8OK7r+VznWK8wZCq6un6ya2gO7Y
   e5hQefmPmtPqDzHZIQtdKExEN94KaVy6hhFxey4NoFEJ5PIFNkoQHwIE/
   rlm6pf35cJ3Luq1tkhRdUHOp+GaB1kk99NnCaH92BLe/WOXEehu9y9Bro
   8SGfSMGCQechPVg1heV7CvNShaMJVC03exDVIxG6bJL4YZ7YWXQ9HGW0Y
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="283822946"
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="283822946"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 00:39:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="651797048"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 28 Mar 2022 00:39:40 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYjyV-0001qa-Fo; Mon, 28 Mar 2022 07:39:39 +0000
Date:   Mon, 28 Mar 2022 15:39:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: kernel/trace/trace_events_user.c:747:16: sparse: sparse:
 incompatible types in comparison expression (different address spaces):
Message-ID: <202203281558.fjXyftuw-lkp@intel.com>
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
head:   ae085d7f9365de7da27ab5c0d16b12d51ea7fca9
commit: 7f5a08c79df35e68f1a43033450c5050f12bc155 user_events: Add minimal support for trace_event into ftrace
date:   6 weeks ago
config: i386-randconfig-s001-20220328 (https://download.01.org/0day-ci/archive/20220328/202203281558.fjXyftuw-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7f5a08c79df35e68f1a43033450c5050f12bc155
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7f5a08c79df35e68f1a43033450c5050f12bc155
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/acpi/apei/ drivers/gpu/drm/ kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/trace/trace_events_user.c:747:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> kernel/trace/trace_events_user.c:747:16: sparse:    void [noderef] __rcu *
>> kernel/trace/trace_events_user.c:747:16: sparse:    void *
>> kernel/trace/trace_events_user.c:811:13: sparse: sparse: cast removes address space '__user' of expression
>> kernel/trace/trace_events_user.c:811:13: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *buf @@     got char * @@
   kernel/trace/trace_events_user.c:811:13: sparse:     expected void [noderef] __user *buf
   kernel/trace/trace_events_user.c:811:13: sparse:     got char *
   kernel/trace/trace_events_user.c:827:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:827:16: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:827:16: sparse:    void *
   kernel/trace/trace_events_user.c:854:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:854:9: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:854:9: sparse:    void *

vim +747 kernel/trace/trace_events_user.c

   730	
   731	/*
   732	 * Validates the user payload and writes via iterator.
   733	 */
   734	static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
   735	{
   736		struct user_event_refs *refs;
   737		struct user_event *user = NULL;
   738		struct tracepoint *tp;
   739		ssize_t ret = i->count;
   740		int idx;
   741	
   742		if (unlikely(copy_from_iter(&idx, sizeof(idx), i) != sizeof(idx)))
   743			return -EFAULT;
   744	
   745		rcu_read_lock_sched();
   746	
 > 747		refs = rcu_dereference_sched(file->private_data);
   748	
   749		/*
   750		 * The refs->events array is protected by RCU, and new items may be
   751		 * added. But the user retrieved from indexing into the events array
   752		 * shall be immutable while the file is opened.
   753		 */
   754		if (likely(refs && idx < refs->count))
   755			user = refs->events[idx];
   756	
   757		rcu_read_unlock_sched();
   758	
   759		if (unlikely(user == NULL))
   760			return -ENOENT;
   761	
   762		tp = &user->tracepoint;
   763	
   764		/*
   765		 * It's possible key.enabled disables after this check, however
   766		 * we don't mind if a few events are included in this condition.
   767		 */
   768		if (likely(atomic_read(&tp->key.enabled) > 0)) {
   769			struct tracepoint_func *probe_func_ptr;
   770			user_event_func_t probe_func;
   771			void *tpdata;
   772			void *kdata;
   773			u32 datalen;
   774	
   775			kdata = kmalloc(i->count, GFP_KERNEL);
   776	
   777			if (unlikely(!kdata))
   778				return -ENOMEM;
   779	
   780			datalen = copy_from_iter(kdata, i->count, i);
   781	
   782			rcu_read_lock_sched();
   783	
   784			probe_func_ptr = rcu_dereference_sched(tp->funcs);
   785	
   786			if (probe_func_ptr) {
   787				do {
   788					probe_func = probe_func_ptr->func;
   789					tpdata = probe_func_ptr->data;
   790					probe_func(user, kdata, datalen, tpdata);
   791				} while ((++probe_func_ptr)->func);
   792			}
   793	
   794			rcu_read_unlock_sched();
   795	
   796			kfree(kdata);
   797		}
   798	
   799		return ret;
   800	}
   801	
   802	static ssize_t user_events_write(struct file *file, const char __user *ubuf,
   803					 size_t count, loff_t *ppos)
   804	{
   805		struct iovec iov;
   806		struct iov_iter i;
   807	
   808		if (unlikely(*ppos != 0))
   809			return -EFAULT;
   810	
 > 811		if (unlikely(import_single_range(READ, (char *)ubuf, count, &iov, &i)))
   812			return -EFAULT;
   813	
   814		return user_events_write_core(file, &i);
   815	}
   816	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

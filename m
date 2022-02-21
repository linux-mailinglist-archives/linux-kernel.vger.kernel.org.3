Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52B94BDB7F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355238AbiBUKvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:51:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355805AbiBUKvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:51:17 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5638357B31
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645438399; x=1676974399;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EhGh1hrXlmWRmd4DO0zw3q9pv+kq236zpC0vmb9HMWU=;
  b=L4zUaC6VrYmv6oq6GnOrGVx7L8riKPbiG//ANj4ke8wqn0aJ0fSRe5j2
   VE/6LIdIZ3fxXbbEbV4bX/tVbm2/QvBpP/HMz167LWA4Tjot+F1bman2K
   77f+Zl4JIQeXIglYvRM9JJkMIopHmo99zopu/ig6YFB6kIpAveZjkS3rT
   94wfPSLWwz36BB4fcSjWa8NzRoZ3ilVjXUX0vt2ZgZiaenrDB8Afsxg4M
   BJVbd8ElJsAD9ZDra2e0FDqQRRGblYUo6tP6hFnIQD4btigjG49cz47HO
   6n2T/fq+93SwoG/A/jriP7SF7FUIfuM/02IZryM/XxWkT94id6RvkDhqt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="276072160"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="276072160"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 02:13:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="490396275"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Feb 2022 02:13:12 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM5gt-0001Uy-FB; Mon, 21 Feb 2022 10:13:11 +0000
Date:   Mon, 21 Feb 2022 18:12:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [ammarfaizi2-block:rostedt/linux-trace/for-next 21/32]
 kernel/trace/trace_events_user.c:747:16: sparse: sparse: incompatible types
 in comparison expression (different address spaces):
Message-ID: <202202211836.MuxsYYnx-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block rostedt/linux-trace/for-next
head:   864ea0e10cc90416a01b46f0d47a6f26dc020820
commit: 7f5a08c79df35e68f1a43033450c5050f12bc155 [21/32] user_events: Add minimal support for trace_event into ftrace
config: x86_64-randconfig-s032-20220221 (https://download.01.org/0day-ci/archive/20220221/202202211836.MuxsYYnx-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/7f5a08c79df35e68f1a43033450c5050f12bc155
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block rostedt/linux-trace/for-next
        git checkout 7f5a08c79df35e68f1a43033450c5050f12bc155
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/trace/

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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

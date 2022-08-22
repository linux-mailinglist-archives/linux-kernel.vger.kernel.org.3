Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E5059C91D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbiHVTlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiHVTl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:41:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC31748CB3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661197286; x=1692733286;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ONoVEhGtoqXrJDMsWB6ACipS2h2oF8m5UdQT4iJsIZk=;
  b=nbeN/e0arlbjpIY2g/MVISoYTsCX3i4sPoXhgrE+WrABtviapqn0y591
   BSEEKEnhjZhK6roigIARGM9+WD22vhsS2wV3oARNtEwvmz8dMD7hxExiF
   50eMViSzoTnZUwj1cTIBrv5TWI2z6WFTL0Cpb0dWRX+btIJmbG5z5jNkd
   Ss8woXfEzghAULxmufw2AgsIsGdqE7Vq0xHxbBNrCPTaAgcAFCjQV3v85
   8WwNtqf6RCGP3+2v47LEmRtZrMpC2bRHCbfEEgIGMuhAWgneaUx1/FVnm
   Ws3MUnG1Gr+Yu3H3/PEp13CbUuqUdqIfWL2ICEbAG2UhXoqVDKBFO6hGB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="293502762"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="293502762"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 12:41:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="937166185"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Aug 2022 12:41:03 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQDIE-0000e7-2h;
        Mon, 22 Aug 2022 19:41:02 +0000
Date:   Tue, 23 Aug 2022 03:40:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/wip.rewrite 1/5] kernel/events/core.c:12047:9:
 error: implicit declaration of function 'mutex_lock_double'; did you mean
 'mutex_lock_killable'?
Message-ID: <202208230309.KzpqxoH0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.rewrite
head:   596b8cc92a97fa8defbff896dc9baedef441b983
commit: 6a606214738273b4c6bd00c500bab6cb53a5b9d7 [1/5] perf: Rewrite core context handling
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220823/202208230309.KzpqxoH0-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=6a606214738273b4c6bd00c500bab6cb53a5b9d7
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/wip.rewrite
        git checkout 6a606214738273b4c6bd00c500bab6cb53a5b9d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/events/core.c: In function 'perf_rotate_context':
   kernel/events/core.c:4236:36: warning: variable 'task_ctx' set but not used [-Wunused-but-set-variable]
    4236 |         struct perf_event_context *task_ctx = NULL;
         |                                    ^~~~~~~~
   kernel/events/core.c: At top level:
   kernel/events/core.c:4810:1: warning: no previous prototype for 'find_get_pmu_context' [-Wmissing-prototypes]
    4810 | find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
         | ^~~~~~~~~~~~~~~~~~~~
   kernel/events/core.c: In function 'perf_event_set_output':
>> kernel/events/core.c:12047:9: error: implicit declaration of function 'mutex_lock_double'; did you mean 'mutex_lock_killable'? [-Werror=implicit-function-declaration]
   12047 |         mutex_lock_double(&event->mmap_mutex, &output_event->mmap_mutex);
         |         ^~~~~~~~~~~~~~~~~
         |         mutex_lock_killable
   cc1: some warnings being treated as errors


vim +12047 kernel/events/core.c

974802eaa1afdc kernel/perf_counter.c Peter Zijlstra          2009-06-12  11992  
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra          2010-05-27  11993  static int
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra          2010-05-27  11994  perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
a4be7c2778d1fd kernel/perf_counter.c Peter Zijlstra          2009-08-19  11995  {
56de4e8f914668 kernel/events/core.c  Steven Rostedt (VMware  2019-12-13  11996) 	struct perf_buffer *rb = NULL;
a4be7c2778d1fd kernel/perf_counter.c Peter Zijlstra          2009-08-19  11997  	int ret = -EINVAL;
a4be7c2778d1fd kernel/perf_counter.c Peter Zijlstra          2009-08-19  11998  
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05  11999  	if (!output_event) {
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05  12000  		mutex_lock(&event->mmap_mutex);
a4be7c2778d1fd kernel/perf_counter.c Peter Zijlstra          2009-08-19  12001  		goto set;
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05  12002  	}
a4be7c2778d1fd kernel/perf_counter.c Peter Zijlstra          2009-08-19  12003  
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra          2010-05-27  12004  	/* don't allow circular references */
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra          2010-05-27  12005  	if (event == output_event)
a4be7c2778d1fd kernel/perf_counter.c Peter Zijlstra          2009-08-19  12006  		goto out;
a4be7c2778d1fd kernel/perf_counter.c Peter Zijlstra          2009-08-19  12007  
0f139300c9057c kernel/perf_event.c   Peter Zijlstra          2010-05-20  12008  	/*
0f139300c9057c kernel/perf_event.c   Peter Zijlstra          2010-05-20  12009  	 * Don't allow cross-cpu buffers
0f139300c9057c kernel/perf_event.c   Peter Zijlstra          2010-05-20  12010  	 */
0f139300c9057c kernel/perf_event.c   Peter Zijlstra          2010-05-20  12011  	if (output_event->cpu != event->cpu)
0f139300c9057c kernel/perf_event.c   Peter Zijlstra          2010-05-20  12012  		goto out;
0f139300c9057c kernel/perf_event.c   Peter Zijlstra          2010-05-20  12013  
0f139300c9057c kernel/perf_event.c   Peter Zijlstra          2010-05-20  12014  	/*
76369139ceb955 kernel/events/core.c  Frederic Weisbecker     2011-05-19  12015  	 * If its not a per-cpu rb, it must be the same task.
0f139300c9057c kernel/perf_event.c   Peter Zijlstra          2010-05-20  12016  	 */
0f139300c9057c kernel/perf_event.c   Peter Zijlstra          2010-05-20  12017  	if (output_event->cpu == -1 && output_event->ctx != event->ctx)
0f139300c9057c kernel/perf_event.c   Peter Zijlstra          2010-05-20  12018  		goto out;
0f139300c9057c kernel/perf_event.c   Peter Zijlstra          2010-05-20  12019  
34f439278cef7b kernel/events/core.c  Peter Zijlstra          2015-02-20  12020  	/*
34f439278cef7b kernel/events/core.c  Peter Zijlstra          2015-02-20  12021  	 * Mixing clocks in the same buffer is trouble you don't need.
34f439278cef7b kernel/events/core.c  Peter Zijlstra          2015-02-20  12022  	 */
34f439278cef7b kernel/events/core.c  Peter Zijlstra          2015-02-20  12023  	if (output_event->clock != event->clock)
34f439278cef7b kernel/events/core.c  Peter Zijlstra          2015-02-20  12024  		goto out;
34f439278cef7b kernel/events/core.c  Peter Zijlstra          2015-02-20  12025  
9ecda41acb971e kernel/events/core.c  Wang Nan                2016-04-05  12026  	/*
9ecda41acb971e kernel/events/core.c  Wang Nan                2016-04-05  12027  	 * Either writing ring buffer from beginning or from end.
9ecda41acb971e kernel/events/core.c  Wang Nan                2016-04-05  12028  	 * Mixing is not allowed.
9ecda41acb971e kernel/events/core.c  Wang Nan                2016-04-05  12029  	 */
9ecda41acb971e kernel/events/core.c  Wang Nan                2016-04-05  12030  	if (is_write_backward(output_event) != is_write_backward(event))
9ecda41acb971e kernel/events/core.c  Wang Nan                2016-04-05  12031  		goto out;
9ecda41acb971e kernel/events/core.c  Wang Nan                2016-04-05  12032  
45bfb2e50471ab kernel/events/core.c  Peter Zijlstra          2015-01-14  12033  	/*
45bfb2e50471ab kernel/events/core.c  Peter Zijlstra          2015-01-14  12034  	 * If both events generate aux data, they must be on the same PMU
45bfb2e50471ab kernel/events/core.c  Peter Zijlstra          2015-01-14  12035  	 */
45bfb2e50471ab kernel/events/core.c  Peter Zijlstra          2015-01-14  12036  	if (has_aux(event) && has_aux(output_event) &&
45bfb2e50471ab kernel/events/core.c  Peter Zijlstra          2015-01-14  12037  	    event->pmu != output_event->pmu)
45bfb2e50471ab kernel/events/core.c  Peter Zijlstra          2015-01-14  12038  		goto out;
45bfb2e50471ab kernel/events/core.c  Peter Zijlstra          2015-01-14  12039  
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05  12040  	/*
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05  12041  	 * Hold both mmap_mutex to serialize against perf_mmap_close().  Since
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05  12042  	 * output_event is already on rb->event_list, and the list iteration
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05  12043  	 * restarts after every removal, it is guaranteed this new event is
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05  12044  	 * observed *OR* if output_event is already removed, it's guaranteed we
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05  12045  	 * observe !rb->mmap_count.
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05  12046  	 */
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05 @12047  	mutex_lock_double(&event->mmap_mutex, &output_event->mmap_mutex);
a4be7c2778d1fd kernel/perf_counter.c Peter Zijlstra          2009-08-19  12048  set:
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra          2010-05-27  12049  	/* Can't redirect output if we've got an active mmap() */
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra          2010-05-27  12050  	if (atomic_read(&event->mmap_count))
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra          2010-05-27  12051  		goto unlock;
a4be7c2778d1fd kernel/perf_counter.c Peter Zijlstra          2009-08-19  12052  
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra          2010-05-27  12053  	if (output_event) {
76369139ceb955 kernel/events/core.c  Frederic Weisbecker     2011-05-19  12054  		/* get the rb we want to redirect to */
76369139ceb955 kernel/events/core.c  Frederic Weisbecker     2011-05-19  12055  		rb = ring_buffer_get(output_event);
76369139ceb955 kernel/events/core.c  Frederic Weisbecker     2011-05-19  12056  		if (!rb)
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra          2010-05-27  12057  			goto unlock;
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05  12058  
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05  12059  		/* did we race against perf_mmap_close() */
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05  12060  		if (!atomic_read(&rb->mmap_count)) {
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05  12061  			ring_buffer_put(rb);
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05  12062  			goto unlock;
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05  12063  		}
a4be7c2778d1fd kernel/perf_counter.c Peter Zijlstra          2009-08-19  12064  	}
a4be7c2778d1fd kernel/perf_counter.c Peter Zijlstra          2009-08-19  12065  
9bb5d40cd93c9d kernel/events/core.c  Peter Zijlstra          2013-06-04  12066  	ring_buffer_attach(event, rb);
9bb5d40cd93c9d kernel/events/core.c  Peter Zijlstra          2013-06-04  12067  
a4be7c2778d1fd kernel/perf_counter.c Peter Zijlstra          2009-08-19  12068  	ret = 0;
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra          2010-05-27  12069  unlock:
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra          2010-05-27  12070  	mutex_unlock(&event->mmap_mutex);
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05  12071  	if (output_event)
68e3c69803dada kernel/events/core.c  Peter Zijlstra          2022-07-05  12072  		mutex_unlock(&output_event->mmap_mutex);
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra          2010-05-27  12073  
a4be7c2778d1fd kernel/perf_counter.c Peter Zijlstra          2009-08-19  12074  out:
a4be7c2778d1fd kernel/perf_counter.c Peter Zijlstra          2009-08-19  12075  	return ret;
a4be7c2778d1fd kernel/perf_counter.c Peter Zijlstra          2009-08-19  12076  }
a4be7c2778d1fd kernel/perf_counter.c Peter Zijlstra          2009-08-19  12077  

:::::: The code at line 12047 was first introduced by commit
:::::: 68e3c69803dada336893640110cb87221bb01dcf perf/core: Fix data race between perf_event_set_output() and perf_mmap_close()

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

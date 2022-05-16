Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9BD527C13
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 04:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbiEPCjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 22:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbiEPCjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 22:39:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A490FD00
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 19:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652668778; x=1684204778;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rr5dtgu/wlB8YyV/1zjNYHWRK23YPLr8hnwK/EGLo24=;
  b=DbVSj37MpN69nUYoGwc2OQDqenjtw9Fc6wpyvxzKvvAnDtfVNj76RVVr
   uqC4Ke0/R5kr33i+YAY5SFECwl9E8y5BSmm4W6Pfn9tJPyUeQtfJe4oj9
   F2g7K4jx6Mz4WEbFRYoeGxiVFZQ0WfH73UvNr1p7eE+CI82PxhjvQ0+mD
   2KTzLCXV+eHAbsEN5z9VBVh8ll36eNu1JHVPZ9AyDJZf9MKuUWk6wPYxa
   1SbXn3LXcxpDjLjDrWeEjehSGM3KidqbwtpblcN+YywBKanEPNYp2C+CT
   m03Iql0s2SVwUWaRsQQ6As3cok1kgvUP4b9KprgzSc3PR6NEBe0K5B0QI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="269536696"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="269536696"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 19:39:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="713182353"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 15 May 2022 19:39:37 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqQe0-00026X-C5;
        Mon, 16 May 2022 02:39:36 +0000
Date:   Mon, 16 May 2022 10:39:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: kernel/workqueue.c:2798: warning: expecting prototype for
 flush_workqueue(). Prototype was for void() instead
Message-ID: <202205161030.Dv3ad4T3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220516-093322/Tetsuo-Handa/checkpatch-warn-about-flushing-system-wide-workqueues/20220425-073327
head:   cd007363b7985a824de0ec5e05f0cb0705e59c88
commit: cd007363b7985a824de0ec5e05f0cb0705e59c88 workqueue: Wrap flush_workqueue() using a macro
date:   63 minutes ago
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220516/202205161030.Dv3ad4T3-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/cd007363b7985a824de0ec5e05f0cb0705e59c88
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220516-093322/Tetsuo-Handa/checkpatch-warn-about-flushing-system-wide-workqueues/20220425-073327
        git checkout cd007363b7985a824de0ec5e05f0cb0705e59c88
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/workqueue.c:2798: warning: Function parameter or member 'flush_workqueue' not described in 'void'
>> kernel/workqueue.c:2798: warning: expecting prototype for flush_workqueue(). Prototype was for void() instead


vim +2798 kernel/workqueue.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  2789  
0fcb78c22f0634 Rolf Eike Beer 2006-07-30  2790  /**
^1da177e4c3f41 Linus Torvalds 2005-04-16  2791   * flush_workqueue - ensure that any scheduled work has run to completion.
0fcb78c22f0634 Rolf Eike Beer 2006-07-30  2792   * @wq: workqueue to flush
^1da177e4c3f41 Linus Torvalds 2005-04-16  2793   *
c5aa87bbf4b23f Tejun Heo      2013-03-13  2794   * This function sleeps until all work items which were queued on entry
c5aa87bbf4b23f Tejun Heo      2013-03-13  2795   * have finished execution, but it is not livelocked by new incoming ones.
^1da177e4c3f41 Linus Torvalds 2005-04-16  2796   */
cd007363b7985a Tetsuo Handa   2022-05-16  2797  void (flush_workqueue)(struct workqueue_struct *wq)
^1da177e4c3f41 Linus Torvalds 2005-04-16 @2798  {
73f53c4aa732ec Tejun Heo      2010-06-29  2799  	struct wq_flusher this_flusher = {
73f53c4aa732ec Tejun Heo      2010-06-29  2800  		.list = LIST_HEAD_INIT(this_flusher.list),
73f53c4aa732ec Tejun Heo      2010-06-29  2801  		.flush_color = -1,
fd1a5b04dfb899 Byungchul Park 2017-10-25  2802  		.done = COMPLETION_INITIALIZER_ONSTACK_MAP(this_flusher.done, wq->lockdep_map),
73f53c4aa732ec Tejun Heo      2010-06-29  2803  	};
73f53c4aa732ec Tejun Heo      2010-06-29  2804  	int next_color;
f293ea92007419 Oleg Nesterov  2007-05-09  2805  
3347fa0928210d Tejun Heo      2016-09-16  2806  	if (WARN_ON(!wq_online))
3347fa0928210d Tejun Heo      2016-09-16  2807  		return;
3347fa0928210d Tejun Heo      2016-09-16  2808  
87915adc3f0acd Johannes Berg  2018-08-22  2809  	lock_map_acquire(&wq->lockdep_map);
87915adc3f0acd Johannes Berg  2018-08-22  2810  	lock_map_release(&wq->lockdep_map);
87915adc3f0acd Johannes Berg  2018-08-22  2811  
3c25a55daadc7e Lai Jiangshan  2013-03-25  2812  	mutex_lock(&wq->mutex);
73f53c4aa732ec Tejun Heo      2010-06-29  2813  
73f53c4aa732ec Tejun Heo      2010-06-29  2814  	/*
73f53c4aa732ec Tejun Heo      2010-06-29  2815  	 * Start-to-wait phase
73f53c4aa732ec Tejun Heo      2010-06-29  2816  	 */
73f53c4aa732ec Tejun Heo      2010-06-29  2817  	next_color = work_next_color(wq->work_color);
73f53c4aa732ec Tejun Heo      2010-06-29  2818  
73f53c4aa732ec Tejun Heo      2010-06-29  2819  	if (next_color != wq->flush_color) {
73f53c4aa732ec Tejun Heo      2010-06-29  2820  		/*
73f53c4aa732ec Tejun Heo      2010-06-29  2821  		 * Color space is not full.  The current work_color
73f53c4aa732ec Tejun Heo      2010-06-29  2822  		 * becomes our flush_color and work_color is advanced
73f53c4aa732ec Tejun Heo      2010-06-29  2823  		 * by one.
73f53c4aa732ec Tejun Heo      2010-06-29  2824  		 */
6183c009f6cd94 Tejun Heo      2013-03-12  2825  		WARN_ON_ONCE(!list_empty(&wq->flusher_overflow));
73f53c4aa732ec Tejun Heo      2010-06-29  2826  		this_flusher.flush_color = wq->work_color;
73f53c4aa732ec Tejun Heo      2010-06-29  2827  		wq->work_color = next_color;
73f53c4aa732ec Tejun Heo      2010-06-29  2828  
73f53c4aa732ec Tejun Heo      2010-06-29  2829  		if (!wq->first_flusher) {
73f53c4aa732ec Tejun Heo      2010-06-29  2830  			/* no flush in progress, become the first flusher */
6183c009f6cd94 Tejun Heo      2013-03-12  2831  			WARN_ON_ONCE(wq->flush_color != this_flusher.flush_color);
73f53c4aa732ec Tejun Heo      2010-06-29  2832  
73f53c4aa732ec Tejun Heo      2010-06-29  2833  			wq->first_flusher = &this_flusher;
73f53c4aa732ec Tejun Heo      2010-06-29  2834  
112202d9098aae Tejun Heo      2013-02-13  2835  			if (!flush_workqueue_prep_pwqs(wq, wq->flush_color,
73f53c4aa732ec Tejun Heo      2010-06-29  2836  						       wq->work_color)) {
73f53c4aa732ec Tejun Heo      2010-06-29  2837  				/* nothing to flush, done */
73f53c4aa732ec Tejun Heo      2010-06-29  2838  				wq->flush_color = next_color;
73f53c4aa732ec Tejun Heo      2010-06-29  2839  				wq->first_flusher = NULL;
73f53c4aa732ec Tejun Heo      2010-06-29  2840  				goto out_unlock;
73f53c4aa732ec Tejun Heo      2010-06-29  2841  			}
73f53c4aa732ec Tejun Heo      2010-06-29  2842  		} else {
73f53c4aa732ec Tejun Heo      2010-06-29  2843  			/* wait in queue */
6183c009f6cd94 Tejun Heo      2013-03-12  2844  			WARN_ON_ONCE(wq->flush_color == this_flusher.flush_color);
73f53c4aa732ec Tejun Heo      2010-06-29  2845  			list_add_tail(&this_flusher.list, &wq->flusher_queue);
112202d9098aae Tejun Heo      2013-02-13  2846  			flush_workqueue_prep_pwqs(wq, -1, wq->work_color);
73f53c4aa732ec Tejun Heo      2010-06-29  2847  		}
73f53c4aa732ec Tejun Heo      2010-06-29  2848  	} else {
73f53c4aa732ec Tejun Heo      2010-06-29  2849  		/*
73f53c4aa732ec Tejun Heo      2010-06-29  2850  		 * Oops, color space is full, wait on overflow queue.
73f53c4aa732ec Tejun Heo      2010-06-29  2851  		 * The next flush completion will assign us
73f53c4aa732ec Tejun Heo      2010-06-29  2852  		 * flush_color and transfer to flusher_queue.
73f53c4aa732ec Tejun Heo      2010-06-29  2853  		 */
73f53c4aa732ec Tejun Heo      2010-06-29  2854  		list_add_tail(&this_flusher.list, &wq->flusher_overflow);
73f53c4aa732ec Tejun Heo      2010-06-29  2855  	}
73f53c4aa732ec Tejun Heo      2010-06-29  2856  
fca839c00a12d6 Tejun Heo      2015-12-07  2857  	check_flush_dependency(wq, NULL);
fca839c00a12d6 Tejun Heo      2015-12-07  2858  
3c25a55daadc7e Lai Jiangshan  2013-03-25  2859  	mutex_unlock(&wq->mutex);
73f53c4aa732ec Tejun Heo      2010-06-29  2860  
73f53c4aa732ec Tejun Heo      2010-06-29  2861  	wait_for_completion(&this_flusher.done);
73f53c4aa732ec Tejun Heo      2010-06-29  2862  
73f53c4aa732ec Tejun Heo      2010-06-29  2863  	/*
73f53c4aa732ec Tejun Heo      2010-06-29  2864  	 * Wake-up-and-cascade phase
73f53c4aa732ec Tejun Heo      2010-06-29  2865  	 *
73f53c4aa732ec Tejun Heo      2010-06-29  2866  	 * First flushers are responsible for cascading flushes and
73f53c4aa732ec Tejun Heo      2010-06-29  2867  	 * handling overflow.  Non-first flushers can simply return.
73f53c4aa732ec Tejun Heo      2010-06-29  2868  	 */
00d5d15b0641f4 Chris Wilson   2020-03-10  2869  	if (READ_ONCE(wq->first_flusher) != &this_flusher)
73f53c4aa732ec Tejun Heo      2010-06-29  2870  		return;
73f53c4aa732ec Tejun Heo      2010-06-29  2871  
3c25a55daadc7e Lai Jiangshan  2013-03-25  2872  	mutex_lock(&wq->mutex);
73f53c4aa732ec Tejun Heo      2010-06-29  2873  
4ce48b37bfedc2 Tejun Heo      2010-07-02  2874  	/* we might have raced, check again with mutex held */
4ce48b37bfedc2 Tejun Heo      2010-07-02  2875  	if (wq->first_flusher != &this_flusher)
4ce48b37bfedc2 Tejun Heo      2010-07-02  2876  		goto out_unlock;
4ce48b37bfedc2 Tejun Heo      2010-07-02  2877  
00d5d15b0641f4 Chris Wilson   2020-03-10  2878  	WRITE_ONCE(wq->first_flusher, NULL);
73f53c4aa732ec Tejun Heo      2010-06-29  2879  
6183c009f6cd94 Tejun Heo      2013-03-12  2880  	WARN_ON_ONCE(!list_empty(&this_flusher.list));
6183c009f6cd94 Tejun Heo      2013-03-12  2881  	WARN_ON_ONCE(wq->flush_color != this_flusher.flush_color);
73f53c4aa732ec Tejun Heo      2010-06-29  2882  
73f53c4aa732ec Tejun Heo      2010-06-29  2883  	while (true) {
73f53c4aa732ec Tejun Heo      2010-06-29  2884  		struct wq_flusher *next, *tmp;
73f53c4aa732ec Tejun Heo      2010-06-29  2885  
73f53c4aa732ec Tejun Heo      2010-06-29  2886  		/* complete all the flushers sharing the current flush color */
73f53c4aa732ec Tejun Heo      2010-06-29  2887  		list_for_each_entry_safe(next, tmp, &wq->flusher_queue, list) {
73f53c4aa732ec Tejun Heo      2010-06-29  2888  			if (next->flush_color != wq->flush_color)
73f53c4aa732ec Tejun Heo      2010-06-29  2889  				break;
73f53c4aa732ec Tejun Heo      2010-06-29  2890  			list_del_init(&next->list);
73f53c4aa732ec Tejun Heo      2010-06-29  2891  			complete(&next->done);
73f53c4aa732ec Tejun Heo      2010-06-29  2892  		}
73f53c4aa732ec Tejun Heo      2010-06-29  2893  
6183c009f6cd94 Tejun Heo      2013-03-12  2894  		WARN_ON_ONCE(!list_empty(&wq->flusher_overflow) &&
73f53c4aa732ec Tejun Heo      2010-06-29  2895  			     wq->flush_color != work_next_color(wq->work_color));
73f53c4aa732ec Tejun Heo      2010-06-29  2896  
73f53c4aa732ec Tejun Heo      2010-06-29  2897  		/* this flush_color is finished, advance by one */
73f53c4aa732ec Tejun Heo      2010-06-29  2898  		wq->flush_color = work_next_color(wq->flush_color);
73f53c4aa732ec Tejun Heo      2010-06-29  2899  
73f53c4aa732ec Tejun Heo      2010-06-29  2900  		/* one color has been freed, handle overflow queue */
73f53c4aa732ec Tejun Heo      2010-06-29  2901  		if (!list_empty(&wq->flusher_overflow)) {
73f53c4aa732ec Tejun Heo      2010-06-29  2902  			/*
73f53c4aa732ec Tejun Heo      2010-06-29  2903  			 * Assign the same color to all overflowed
73f53c4aa732ec Tejun Heo      2010-06-29  2904  			 * flushers, advance work_color and append to
73f53c4aa732ec Tejun Heo      2010-06-29  2905  			 * flusher_queue.  This is the start-to-wait
73f53c4aa732ec Tejun Heo      2010-06-29  2906  			 * phase for these overflowed flushers.
73f53c4aa732ec Tejun Heo      2010-06-29  2907  			 */
73f53c4aa732ec Tejun Heo      2010-06-29  2908  			list_for_each_entry(tmp, &wq->flusher_overflow, list)
73f53c4aa732ec Tejun Heo      2010-06-29  2909  				tmp->flush_color = wq->work_color;
73f53c4aa732ec Tejun Heo      2010-06-29  2910  
73f53c4aa732ec Tejun Heo      2010-06-29  2911  			wq->work_color = work_next_color(wq->work_color);
73f53c4aa732ec Tejun Heo      2010-06-29  2912  
73f53c4aa732ec Tejun Heo      2010-06-29  2913  			list_splice_tail_init(&wq->flusher_overflow,
73f53c4aa732ec Tejun Heo      2010-06-29  2914  					      &wq->flusher_queue);
112202d9098aae Tejun Heo      2013-02-13  2915  			flush_workqueue_prep_pwqs(wq, -1, wq->work_color);
73f53c4aa732ec Tejun Heo      2010-06-29  2916  		}
73f53c4aa732ec Tejun Heo      2010-06-29  2917  
73f53c4aa732ec Tejun Heo      2010-06-29  2918  		if (list_empty(&wq->flusher_queue)) {
6183c009f6cd94 Tejun Heo      2013-03-12  2919  			WARN_ON_ONCE(wq->flush_color != wq->work_color);
73f53c4aa732ec Tejun Heo      2010-06-29  2920  			break;
73f53c4aa732ec Tejun Heo      2010-06-29  2921  		}
73f53c4aa732ec Tejun Heo      2010-06-29  2922  
73f53c4aa732ec Tejun Heo      2010-06-29  2923  		/*
73f53c4aa732ec Tejun Heo      2010-06-29  2924  		 * Need to flush more colors.  Make the next flusher
112202d9098aae Tejun Heo      2013-02-13  2925  		 * the new first flusher and arm pwqs.
73f53c4aa732ec Tejun Heo      2010-06-29  2926  		 */
6183c009f6cd94 Tejun Heo      2013-03-12  2927  		WARN_ON_ONCE(wq->flush_color == wq->work_color);
6183c009f6cd94 Tejun Heo      2013-03-12  2928  		WARN_ON_ONCE(wq->flush_color != next->flush_color);
73f53c4aa732ec Tejun Heo      2010-06-29  2929  
73f53c4aa732ec Tejun Heo      2010-06-29  2930  		list_del_init(&next->list);
73f53c4aa732ec Tejun Heo      2010-06-29  2931  		wq->first_flusher = next;
73f53c4aa732ec Tejun Heo      2010-06-29  2932  
112202d9098aae Tejun Heo      2013-02-13  2933  		if (flush_workqueue_prep_pwqs(wq, wq->flush_color, -1))
73f53c4aa732ec Tejun Heo      2010-06-29  2934  			break;
73f53c4aa732ec Tejun Heo      2010-06-29  2935  
73f53c4aa732ec Tejun Heo      2010-06-29  2936  		/*
73f53c4aa732ec Tejun Heo      2010-06-29  2937  		 * Meh... this color is already done, clear first
73f53c4aa732ec Tejun Heo      2010-06-29  2938  		 * flusher and repeat cascading.
73f53c4aa732ec Tejun Heo      2010-06-29  2939  		 */
73f53c4aa732ec Tejun Heo      2010-06-29  2940  		wq->first_flusher = NULL;
73f53c4aa732ec Tejun Heo      2010-06-29  2941  	}
73f53c4aa732ec Tejun Heo      2010-06-29  2942  
73f53c4aa732ec Tejun Heo      2010-06-29  2943  out_unlock:
3c25a55daadc7e Lai Jiangshan  2013-03-25  2944  	mutex_unlock(&wq->mutex);
^1da177e4c3f41 Linus Torvalds 2005-04-16  2945  }
1dadafa86a7798 Tim Gardner    2015-08-04  2946  EXPORT_SYMBOL(flush_workqueue);
^1da177e4c3f41 Linus Torvalds 2005-04-16  2947  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

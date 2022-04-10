Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173D64FAB47
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 03:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbiDJBFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 21:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbiDJBFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 21:05:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D94583A7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 18:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649552610; x=1681088610;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dY0PSbvw7XbhKyFlcNW2O3T4MD20YfVrIuJtLDZfw1M=;
  b=ngBr5wekuv6fRW/b+AqrfgCW/jsArXDAriAtFkXfEGVvF3qXHococxCg
   I9XED+uQ7KpV8EQF8t3edwlIPsm4N4zgiWb5c98+jjqPiudfqHRUc5QPV
   tmiMNh9lM8TfA7U5mCnRocI7d7esmG2I4qN3wglQPxwynTS0QjmRGD19E
   rzGYoroqSdSZk4sTbzCcrhNsJ5VgIQ1/0fowNqdRzNuov7mCfrrzqMB+4
   FvzKB9T3LMHKf/6ieUZb2cBDGgU3k+N8sifion4vz2UEf22oXK9EQdfek
   2kMpHLhDdNAbrivsu3h/WSW+kgEDdHgr5CPkBFlvEo3185MkKPNic9hx6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="242517467"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="242517467"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 18:03:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="852829149"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 09 Apr 2022 18:03:28 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndLzD-0000Xr-V9;
        Sun, 10 Apr 2022 01:03:27 +0000
Date:   Sun, 10 Apr 2022 09:02:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [toke:xdp-queueing-04 3/12] kernel/bpf/pifomap.c:354:22: warning: no
 previous prototype for '__pifo_map_dequeue'
Message-ID: <202204100818.si982aTb-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-04
head:   d67202baf237752a91366c8ba9bd801942e5fdaf
commit: fe606924ca53da2ffef87d4234ef54a5f1b66fbb [3/12] bpf: Add a PIFO map type for queueing packets
config: nios2-randconfig-r011-20220410 (https://download.01.org/0day-ci/archive/20220410/202204100818.si982aTb-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=fe606924ca53da2ffef87d4234ef54a5f1b66fbb
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-04
        git checkout fe606924ca53da2ffef87d4234ef54a5f1b66fbb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:26,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from kernel/bpf/pifomap.c:5:
   kernel/bpf/pifomap.c: In function '__pifo_map_enqueue':
   kernel/bpf/pifomap.c:308:47: error: 'index' undeclared (first use in this function); did you mean 'q_index'?
     308 |         q_index = rank - min(queue->min_rank, index);
         |                                               ^~~~~
   include/linux/minmax.h:20:46: note: in definition of macro '__typecheck'
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                              ^
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   kernel/bpf/pifomap.c:308:26: note: in expansion of macro 'min'
     308 |         q_index = rank - min(queue->min_rank, index);
         |                          ^~~
   kernel/bpf/pifomap.c:308:47: note: each undeclared identifier is reported only once for each function it appears in
     308 |         q_index = rank - min(queue->min_rank, index);
         |                                               ^~~~~
   include/linux/minmax.h:20:46: note: in definition of macro '__typecheck'
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                              ^
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   kernel/bpf/pifomap.c:308:26: note: in expansion of macro 'min'
     308 |         q_index = rank - min(queue->min_rank, index);
         |                          ^~~
   include/linux/minmax.h:36:9: error: first argument to '__builtin_choose_expr' not a constant
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   kernel/bpf/pifomap.c:308:26: note: in expansion of macro 'min'
     308 |         q_index = rank - min(queue->min_rank, index);
         |                          ^~~
   kernel/bpf/pifomap.c: At top level:
>> kernel/bpf/pifomap.c:354:22: warning: no previous prototype for '__pifo_map_dequeue' [-Wmissing-prototypes]
     354 | union bpf_pifo_item *__pifo_map_dequeue(struct bpf_pifo_map *pifo, u64 flags, u64 *rank, bool xdp)
         |                      ^~~~~~~~~~~~~~~~~~


vim +/__pifo_map_dequeue +354 kernel/bpf/pifomap.c

   353	
 > 354	union bpf_pifo_item *__pifo_map_dequeue(struct bpf_pifo_map *pifo, u64 flags, u64 *rank, bool xdp)
   355	{
   356		struct bpf_pifo_queue *queue = pifo->queue;
   357		struct bpf_pifo_bucket *bucket;
   358		union bpf_pifo_item *item;
   359		unsigned long bucket_idx;
   360	
   361		lockdep_assert_held(&pifo->lock);
   362	
   363		if (flags) {
   364			*rank = -EINVAL;
   365			return NULL;
   366		}
   367	
   368		bucket_idx = pifo_find_first_bucket(queue);
   369		if (bucket_idx == -1) {
   370			*rank = -ENOENT;
   371			return NULL;
   372		}
   373		bucket = &queue->buckets[bucket_idx];
   374	
   375		if (WARN_ON_ONCE(!bucket->tail)) {
   376			*rank = -EFAULT;
   377			return NULL;
   378		}
   379	
   380		item = bucket->head;
   381		if (xdp)
   382			bucket->head = (union bpf_pifo_item *)item->frame.next;
   383		else
   384			bucket->head = (union bpf_pifo_item *)item->elem.next;
   385	
   386		if (!bucket->head) {
   387			bucket->tail = NULL;
   388			pifo_clear_bit(queue, bucket_idx);
   389		}
   390		pifo->num_queued--;
   391		bucket->elem_count--;
   392	
   393		*rank = bucket_idx + queue->min_rank;
   394		return item;
   395	}
   396	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

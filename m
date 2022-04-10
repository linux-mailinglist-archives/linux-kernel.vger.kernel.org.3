Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93174FAB3D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 02:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiDJAyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 20:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiDJAyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 20:54:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43BA12745
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 17:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649551949; x=1681087949;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fC8VFuebBAtAAGeP6vIEBrzqOf9KxWvYCJ5Q4/yMyyQ=;
  b=iBtQoSQtOhFd56hfp8qLsbkGItYPp7pF+Bhb4WXy4OkgiJww0d9koOAV
   x3sm+pF4qfgsRWN1Z/heLC9630l6T6v858C4RO4030RJlkB1peO5628EJ
   gOYMODDgQ6wzGTjNKGXiLTcjX3ETi5gYCbqARO4DrrF5ydeR1p1wmKkb5
   aZeb6xposw9/5j0wc37AaNCS0k4SHXxo2FPe+ZK7sYSB3H5TCTuiRcS9q
   m+wuCvSY6omQzzK3n0JS0sR5wgE0kBb98iy2x0d60zj3T2fRlDZKNWf6C
   PyAA4LnbC3cw1CQyHqIgvynu4+rs4abdq9xHcee7OWNU2MCRgUHok37bz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="286926068"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="286926068"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 17:52:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="558463988"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 09 Apr 2022 17:52:28 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndLoZ-0000XO-Pn;
        Sun, 10 Apr 2022 00:52:27 +0000
Date:   Sun, 10 Apr 2022 08:52:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [toke:xdp-queueing-04 3/12] kernel/bpf/pifomap.c:354:22: warning: no
 previous prototype for function '__pifo_map_dequeue'
Message-ID: <202204100802.zdu77Ho5-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-04
head:   d67202baf237752a91366c8ba9bd801942e5fdaf
commit: fe606924ca53da2ffef87d4234ef54a5f1b66fbb [3/12] bpf: Add a PIFO map type for queueing packets
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220410/202204100802.zdu77Ho5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 256c6b0ba14e8a7ab6373b61b7193ea8c0a3651c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=fe606924ca53da2ffef87d4234ef54a5f1b66fbb
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-04
        git checkout fe606924ca53da2ffef87d4234ef54a5f1b66fbb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/bpf/pifomap.c:308:40: error: implicitly declaring library function 'index' with type 'char *(const char *, int)' [-Werror,-Wimplicit-function-declaration]
           q_index = rank - min(queue->min_rank, index);
                                                 ^
   kernel/bpf/pifomap.c:308:40: note: include the header <strings.h> or explicitly provide a declaration for 'index'
   kernel/bpf/pifomap.c:308:19: warning: comparison of distinct pointer types ('typeof (queue->min_rank) *' (aka 'unsigned long long *') and 'typeof (index) *' (aka 'char *(*)(const char *, int)')) [-Wcompare-distinct-pointer-types]
           q_index = rank - min(queue->min_rank, index);
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   kernel/bpf/pifomap.c:308:19: warning: ordered comparison between pointer and integer ('u64' (aka 'unsigned long long') and 'char *(*)(const char *, int)')
           q_index = rank - min(queue->min_rank, index);
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:39: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ~~~~~~~~~~~~~~~~~~~~^~
   include/linux/minmax.h:37:15: note: expanded from macro '__careful_cmp'
                   __cmp(x, y, op), \
                   ~~~~~~~~~~~~^~~
   include/linux/minmax.h:28:30: note: expanded from macro '__cmp'
   #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
                            ~~~ ^  ~~~
   kernel/bpf/pifomap.c:308:19: warning: pointer/integer type mismatch in conditional expression ('u64' (aka 'unsigned long long') and 'char *(*)(const char *, int)') [-Wconditional-type-mismatch]
           q_index = rank - min(queue->min_rank, index);
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:37:3: note: expanded from macro '__careful_cmp'
                   __cmp(x, y, op), \
                   ^~~~~~~~~~~~~~~
   include/linux/minmax.h:28:37: note: expanded from macro '__cmp'
   #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
                                       ^ ~~~   ~~~
   kernel/bpf/pifomap.c:308:19: error: illegal initializer (only variables can be initialized)
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^
   include/linux/minmax.h:38:38: note: expanded from macro '__careful_cmp'
                   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
                                                      ^
   include/linux/compiler-clang.h:11:29: note: expanded from macro '__UNIQUE_ID'
   #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                               ^
   include/linux/compiler_types.h:68:22: note: expanded from macro '__PASTE'
   #define __PASTE(a,b) ___PASTE(a,b)
                        ^
   include/linux/compiler_types.h:67:23: note: expanded from macro '___PASTE'
   #define ___PASTE(a,b) a##b
                         ^
   <scratch space>:98:1: note: expanded from here
   __UNIQUE_ID___y828
   ^
>> kernel/bpf/pifomap.c:354:22: warning: no previous prototype for function '__pifo_map_dequeue' [-Wmissing-prototypes]
   union bpf_pifo_item *__pifo_map_dequeue(struct bpf_pifo_map *pifo, u64 flags, u64 *rank, bool xdp)
                        ^
   kernel/bpf/pifomap.c:354:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   union bpf_pifo_item *__pifo_map_dequeue(struct bpf_pifo_map *pifo, u64 flags, u64 *rank, bool xdp)
   ^
   static 
   4 warnings and 2 errors generated.


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

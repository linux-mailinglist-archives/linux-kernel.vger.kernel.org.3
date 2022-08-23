Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433ED59D26F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbiHWHl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241079AbiHWHlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:41:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2282491E9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661240482; x=1692776482;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eBUDp/rDp/TuKW82oc+oRAUoN3+jwli0qyESIDxf7Ps=;
  b=L0n9EmWFOIHItFAts2KpOu5VqPfnzvbh52wcovdMfbgzDyXGe+cVsFC2
   4Wz/XM6xbFEysNOzMrCUePrFqfUStG/KEX3NbmvoLT7DvBtEbwGJAa7rs
   3MXE0hnsh0y3LrLhJSJ33N+w4De9AdUCz9CUHz66a4ASZuXMj7ko1icCr
   Qyy1Nz4nvjPjYdIfHF2NryXJrGmkYqdxuxk1gMvnUbDUt1DcY3F15cmcY
   awaR/VgaYrlZJGlH6yykcN5Ef+Ihet0Vx51ULbVxST2gqI6pAcvp4SIlZ
   8ltO4uwIeY7n8josL/d92e7Z27fd/rjiwjrsivTDfUZLVMUNnBJrIX1eF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="294406947"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="294406947"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:41:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="669909829"
Received: from lkp-server01.sh.intel.com (HELO 5b31f6010e99) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 Aug 2022 00:41:19 -0700
Received: from kbuild by 5b31f6010e99 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQOXG-0000Bu-2m;
        Tue, 23 Aug 2022 07:41:18 +0000
Date:   Tue, 23 Aug 2022 15:41:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Chunming Zhou <david1.zhou@amd.com>,
        Guenter Roeck <groeck@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>
Subject: [jsarha:topic/chromeos-4.19-s0ix 7536/9999]
 drivers/gpu/drm/i915/i915_gem.c:3202:30: error: format specifies type 'int'
 but the argument has type 'u64' (aka 'unsigned long long')
Message-ID: <202208231552.C5IkgSE2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

FYI, the error/warning still remains.

tree:   https://github.com/jsarha/linux topic/chromeos-4.19-s0ix
head:   430bdaa0a8c38697780f45a148964d71951df11f
commit: 88445be194e93603d722c82108ed8c47c3f60e65 [7536/9999] UPSTREAM: dma-buf: make fence sequence numbers 64 bit v2
config: x86_64-randconfig-a005-20220822 (https://download.01.org/0day-ci/archive/20220823/202208231552.C5IkgSE2-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/88445be194e93603d722c82108ed8c47c3f60e65
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/chromeos-4.19-s0ix
        git checkout 88445be194e93603d722c82108ed8c47c3f60e65
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/mm/ drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/thread_info.h:38:
   arch/x86/include/asm/thread_info.h:229:13: error: calling '__builtin_frame_address' with a nonzero argument is unsafe [-Werror,-Wframe-address]
           oldframe = __builtin_frame_address(1);
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/thread_info.h:231:11: error: calling '__builtin_frame_address' with a nonzero argument is unsafe [-Werror,-Wframe-address]
                   frame = __builtin_frame_address(2);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/i915/i915_gem.c:31:
   In file included from drivers/gpu/drm/i915/i915_drv.h:44:
   In file included from include/linux/perf_event.h:48:
   include/linux/ftrace.h:706:9: error: calling '__builtin_return_address' with a nonzero argument is unsafe [-Werror,-Wframe-address]
           addr = CALLER_ADDR1;
                  ^~~~~~~~~~~~
   include/linux/ftrace.h:693:38: note: expanded from macro 'CALLER_ADDR1'
   #define CALLER_ADDR1 ((unsigned long)ftrace_return_address(1))
                                        ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ftrace.h:686:36: note: expanded from macro 'ftrace_return_address'
   #  define ftrace_return_address(n) __builtin_return_address(n)
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ftrace.h:709:9: error: calling '__builtin_return_address' with a nonzero argument is unsafe [-Werror,-Wframe-address]
           return CALLER_ADDR2;
                  ^~~~~~~~~~~~
   include/linux/ftrace.h:694:38: note: expanded from macro 'CALLER_ADDR2'
   #define CALLER_ADDR2 ((unsigned long)ftrace_return_address(2))
                                        ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ftrace.h:686:36: note: expanded from macro 'ftrace_return_address'
   #  define ftrace_return_address(n) __builtin_return_address(n)
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/i915/i915_gem.c:31:
   drivers/gpu/drm/i915/i915_drv.h:3199:9: error: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
           return i915_reset_backoff(error) | i915_terminally_wedged(error);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                            ||
   drivers/gpu/drm/i915/i915_drv.h:3199:9: note: cast one or both operands to int to silence this warning
   drivers/gpu/drm/i915/i915_gem.c:142:2: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
           GEM_TRACE("\n");
           ^~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.h:64:24: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                          ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:719:3: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:733:30: note: expanded from macro 'do_trace_printk'
                   __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
                                              ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.c:142:2: note: treat the string as an argument to avoid this
   drivers/gpu/drm/i915/i915_gem.h:64:24: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                          ^
   include/linux/kernel.h:719:3: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                   ^
   include/linux/kernel.h:733:30: note: expanded from macro 'do_trace_printk'
                   __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
                                              ^
   drivers/gpu/drm/i915/i915_gem.c:186:2: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
           GEM_TRACE("\n");
           ^~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.h:64:24: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                          ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:719:3: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:733:30: note: expanded from macro 'do_trace_printk'
                   __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
                                              ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.c:186:2: note: treat the string as an argument to avoid this
   drivers/gpu/drm/i915/i915_gem.h:64:24: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                          ^
   include/linux/kernel.h:719:3: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                   ^
   include/linux/kernel.h:733:30: note: expanded from macro 'do_trace_printk'
                   __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
                                              ^
   drivers/gpu/drm/i915/i915_gem.c:200:2: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
           GEM_TRACE("\n");
           ^~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.h:64:24: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                          ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:719:3: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:733:30: note: expanded from macro 'do_trace_printk'
                   __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
                                              ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.c:200:2: note: treat the string as an argument to avoid this
   drivers/gpu/drm/i915/i915_gem.h:64:24: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                          ^
   include/linux/kernel.h:719:3: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                   ^
   include/linux/kernel.h:733:30: note: expanded from macro 'do_trace_printk'
                   __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
                                              ^
>> drivers/gpu/drm/i915/i915_gem.c:3202:30: error: format specifies type 'int' but the argument has type 'u64' (aka 'unsigned long long') [-Werror,-Wformat]
                             request->fence.context, request->fence.seqno,
                                                     ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.h:64:37: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                                       ^~~~~~~~~~~
   include/linux/kernel.h:719:26: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                                   ~~~    ^~~~~~~~~~~
   include/linux/kernel.h:730:37: note: expanded from macro 'do_trace_printk'
           __trace_printk_check_format(fmt, ##args);                       \
                                       ~~~    ^~~~
   include/linux/kernel.h:682:40: note: expanded from macro '__trace_printk_check_format'
                   ____trace_printk_check_format(fmt, ##args);             \
                                                 ~~~    ^~~~
>> drivers/gpu/drm/i915/i915_gem.c:3202:30: error: format specifies type 'int' but the argument has type 'u64' (aka 'unsigned long long') [-Werror,-Wformat]
                             request->fence.context, request->fence.seqno,
                                                     ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.h:64:37: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                                       ^~~~~~~~~~~
   include/linux/kernel.h:719:26: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                                   ~~~    ^~~~~~~~~~~
   include/linux/kernel.h:735:36: note: expanded from macro 'do_trace_printk'
                   __trace_printk(_THIS_IP_, fmt, ##args);                 \
                                             ~~~    ^~~~
   drivers/gpu/drm/i915/i915_gem.c:3324:29: error: format specifies type 'int' but the argument has type 'u64' (aka 'unsigned long long') [-Werror,-Wformat]
                     request->fence.context, request->fence.seqno);
                                             ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.h:64:37: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                                       ^~~~~~~~~~~
   include/linux/kernel.h:719:26: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                                   ~~~    ^~~~~~~~~~~
   include/linux/kernel.h:730:37: note: expanded from macro 'do_trace_printk'
           __trace_printk_check_format(fmt, ##args);                       \
                                       ~~~    ^~~~
   include/linux/kernel.h:682:40: note: expanded from macro '__trace_printk_check_format'
                   ____trace_printk_check_format(fmt, ##args);             \
                                                 ~~~    ^~~~
   drivers/gpu/drm/i915/i915_gem.c:3324:29: error: format specifies type 'int' but the argument has type 'u64' (aka 'unsigned long long') [-Werror,-Wformat]
                     request->fence.context, request->fence.seqno);
                                             ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.h:64:37: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                                       ^~~~~~~~~~~
   include/linux/kernel.h:719:26: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                                   ~~~    ^~~~~~~~~~~
   include/linux/kernel.h:735:36: note: expanded from macro 'do_trace_printk'
                   __trace_printk(_THIS_IP_, fmt, ##args);                 \
                                             ~~~    ^~~~
   drivers/gpu/drm/i915/i915_gem.c:3336:29: error: format specifies type 'int' but the argument has type 'u64' (aka 'unsigned long long') [-Werror,-Wformat]
                     request->fence.context, request->fence.seqno);
                                             ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.h:64:37: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                                       ^~~~~~~~~~~
   include/linux/kernel.h:719:26: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                                   ~~~    ^~~~~~~~~~~
   include/linux/kernel.h:730:37: note: expanded from macro 'do_trace_printk'
           __trace_printk_check_format(fmt, ##args);                       \
                                       ~~~    ^~~~
   include/linux/kernel.h:682:40: note: expanded from macro '__trace_printk_check_format'
                   ____trace_printk_check_format(fmt, ##args);             \
                                                 ~~~    ^~~~
   drivers/gpu/drm/i915/i915_gem.c:3336:29: error: format specifies type 'int' but the argument has type 'u64' (aka 'unsigned long long') [-Werror,-Wformat]
                     request->fence.context, request->fence.seqno);
                                             ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.h:64:37: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                                       ^~~~~~~~~~~
   include/linux/kernel.h:719:26: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                                   ~~~    ^~~~~~~~~~~
   include/linux/kernel.h:735:36: note: expanded from macro 'do_trace_printk'
                   __trace_printk(_THIS_IP_, fmt, ##args);                 \
                                             ~~~    ^~~~
   drivers/gpu/drm/i915/i915_gem.c:3350:2: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
           GEM_TRACE("start\n");
           ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.h:64:24: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                          ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:719:3: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:733:30: note: expanded from macro 'do_trace_printk'
                   __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
                                              ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.c:3350:2: note: treat the string as an argument to avoid this
   drivers/gpu/drm/i915/i915_gem.h:64:24: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                          ^
   include/linux/kernel.h:719:3: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                   ^
   include/linux/kernel.h:733:30: note: expanded from macro 'do_trace_printk'
                   __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
                                              ^
   drivers/gpu/drm/i915/i915_gem.c:3421:2: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
           GEM_TRACE("end\n");
           ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.h:64:24: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                          ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:719:3: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:733:30: note: expanded from macro 'do_trace_printk'
                   __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
                                              ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.c:3421:2: note: treat the string as an argument to avoid this


vim +3202 drivers/gpu/drm/i915/i915_gem.c

36193acd54bdf1 Mika Kuoppala 2017-01-17  3171  
d1d1ebf4120db0 Chris Wilson  2017-07-21  3172  /* Returns the request if it was guilty of the hang */
e61e0f51ba7974 Chris Wilson  2018-02-21  3173  static struct i915_request *
d1d1ebf4120db0 Chris Wilson  2017-07-21  3174  i915_gem_reset_request(struct intel_engine_cs *engine,
bba0869b18e44f Chris Wilson  2018-04-06  3175  		       struct i915_request *request,
bba0869b18e44f Chris Wilson  2018-04-06  3176  		       bool stalled)
61da536204ca0d Mika Kuoppala 2017-01-17  3177  {
71895a085879d7 Mika Kuoppala 2017-01-17  3178  	/* The guilty request will get skipped on a hung engine.
71895a085879d7 Mika Kuoppala 2017-01-17  3179  	 *
71895a085879d7 Mika Kuoppala 2017-01-17  3180  	 * Users of client default contexts do not rely on logical
71895a085879d7 Mika Kuoppala 2017-01-17  3181  	 * state preserved between batches so it is safe to execute
71895a085879d7 Mika Kuoppala 2017-01-17  3182  	 * queued requests following the hang. Non default contexts
71895a085879d7 Mika Kuoppala 2017-01-17  3183  	 * rely on preserved state, so skipping a batch loses the
71895a085879d7 Mika Kuoppala 2017-01-17  3184  	 * evolution of the state and it needs to be considered corrupted.
71895a085879d7 Mika Kuoppala 2017-01-17  3185  	 * Executing more queued batches on top of corrupted state is
71895a085879d7 Mika Kuoppala 2017-01-17  3186  	 * risky. But we take the risk by trying to advance through
71895a085879d7 Mika Kuoppala 2017-01-17  3187  	 * the queued requests in order to make the client behaviour
71895a085879d7 Mika Kuoppala 2017-01-17  3188  	 * more predictable around resets, by not throwing away random
71895a085879d7 Mika Kuoppala 2017-01-17  3189  	 * amount of batches it has prepared for execution. Sophisticated
71895a085879d7 Mika Kuoppala 2017-01-17  3190  	 * clients can use gem_reset_stats_ioctl and dma fence status
71895a085879d7 Mika Kuoppala 2017-01-17  3191  	 * (exported via sync_file info ioctl on explicit fences) to observe
71895a085879d7 Mika Kuoppala 2017-01-17  3192  	 * when it loses the context state and should rebuild accordingly.
71895a085879d7 Mika Kuoppala 2017-01-17  3193  	 *
71895a085879d7 Mika Kuoppala 2017-01-17  3194  	 * The context ban, and ultimately the client ban, mechanism are safety
71895a085879d7 Mika Kuoppala 2017-01-17  3195  	 * valves if client submission ends up resulting in nothing more than
71895a085879d7 Mika Kuoppala 2017-01-17  3196  	 * subsequent hangs.
71895a085879d7 Mika Kuoppala 2017-01-17  3197  	 */
71895a085879d7 Mika Kuoppala 2017-01-17  3198  
bba0869b18e44f Chris Wilson  2018-04-06  3199  	if (i915_request_completed(request)) {
bba0869b18e44f Chris Wilson  2018-04-06  3200  		GEM_TRACE("%s pardoned global=%d (fence %llx:%d), current %d\n",
bba0869b18e44f Chris Wilson  2018-04-06  3201  			  engine->name, request->global_seqno,
bba0869b18e44f Chris Wilson  2018-04-06 @3202  			  request->fence.context, request->fence.seqno,
bba0869b18e44f Chris Wilson  2018-04-06  3203  			  intel_engine_get_seqno(engine));
bba0869b18e44f Chris Wilson  2018-04-06  3204  		stalled = false;
bba0869b18e44f Chris Wilson  2018-04-06  3205  	}
bba0869b18e44f Chris Wilson  2018-04-06  3206  
bba0869b18e44f Chris Wilson  2018-04-06  3207  	if (stalled) {
4e0d64dba816ad Chris Wilson  2018-05-17  3208  		i915_gem_context_mark_guilty(request->gem_context);
6dd7526f6f6c73 Chris Wilson  2018-07-06  3209  		i915_request_skip(request, -EIO);
d1d1ebf4120db0 Chris Wilson  2017-07-21  3210  
d1d1ebf4120db0 Chris Wilson  2017-07-21  3211  		/* If this context is now banned, skip all pending requests. */
4e0d64dba816ad Chris Wilson  2018-05-17  3212  		if (i915_gem_context_is_banned(request->gem_context))
d1d1ebf4120db0 Chris Wilson  2017-07-21  3213  			engine_skip_context(request);
61da536204ca0d Mika Kuoppala 2017-01-17  3214  	} else {
d1d1ebf4120db0 Chris Wilson  2017-07-21  3215  		/*
d1d1ebf4120db0 Chris Wilson  2017-07-21  3216  		 * Since this is not the hung engine, it may have advanced
d1d1ebf4120db0 Chris Wilson  2017-07-21  3217  		 * since the hang declaration. Double check by refinding
d1d1ebf4120db0 Chris Wilson  2017-07-21  3218  		 * the active request at the time of the reset.
d1d1ebf4120db0 Chris Wilson  2017-07-21  3219  		 */
d1d1ebf4120db0 Chris Wilson  2017-07-21  3220  		request = i915_gem_find_active_request(engine);
d1d1ebf4120db0 Chris Wilson  2017-07-21  3221  		if (request) {
042ed2dbe5b294 Chris Wilson  2018-06-15  3222  			unsigned long flags;
042ed2dbe5b294 Chris Wilson  2018-06-15  3223  
4e0d64dba816ad Chris Wilson  2018-05-17  3224  			i915_gem_context_mark_innocent(request->gem_context);
61da536204ca0d Mika Kuoppala 2017-01-17  3225  			dma_fence_set_error(&request->fence, -EAGAIN);
d1d1ebf4120db0 Chris Wilson  2017-07-21  3226  
d1d1ebf4120db0 Chris Wilson  2017-07-21  3227  			/* Rewind the engine to replay the incomplete rq */
042ed2dbe5b294 Chris Wilson  2018-06-15  3228  			spin_lock_irqsave(&engine->timeline.lock, flags);
d1d1ebf4120db0 Chris Wilson  2017-07-21  3229  			request = list_prev_entry(request, link);
a89d1f921c1593 Chris Wilson  2018-05-02  3230  			if (&request->link == &engine->timeline.requests)
d1d1ebf4120db0 Chris Wilson  2017-07-21  3231  				request = NULL;
042ed2dbe5b294 Chris Wilson  2018-06-15  3232  			spin_unlock_irqrestore(&engine->timeline.lock, flags);
d1d1ebf4120db0 Chris Wilson  2017-07-21  3233  		}
61da536204ca0d Mika Kuoppala 2017-01-17  3234  	}
61da536204ca0d Mika Kuoppala 2017-01-17  3235  
d1d1ebf4120db0 Chris Wilson  2017-07-21  3236  	return request;
61da536204ca0d Mika Kuoppala 2017-01-17  3237  }
61da536204ca0d Mika Kuoppala 2017-01-17  3238  

:::::: The code at line 3202 was first introduced by commit
:::::: bba0869b18e44ff2f713c98575ddad8c7c5e9b10 drm/i915: Treat i915_reset_engine() as guilty until proven innocent

:::::: TO: Chris Wilson <chris@chris-wilson.co.uk>
:::::: CC: Chris Wilson <chris@chris-wilson.co.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

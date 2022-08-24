Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5975A013C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbiHXSRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 14:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240454AbiHXSRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:17:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93546792C0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661365065; x=1692901065;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1EbJt8QGTZbgeVBVRxMer5GSOjtLydOv1UV8iFXX81g=;
  b=PE7SxlzEH6l7Ff5AtpCx/zHZJzoZIadd4gxE4B62cfePOq+HNSPFKZXZ
   SiOh1lwNucBpMC2ecGorDP8uNNtdHsOjUptJq3wPelkgL4VzfDparNoh1
   kYhi0TtIK7/9ZMH9ns/Y/PeCvgz64oCS2NS40oQgqI6BglRcMiVMpTNKO
   pV7FTM3nCvyy6qgfPY+QZ7WIRdztBU7R/H+q1gCfiG2annTCOJ+B9mFvE
   uQwI5yIX4s1ioawvQmUm+uVgc7Mz5X8uwR/gQSv3fAEGYJJ1VNdDFZyvh
   b3VcjHVUC16+GhMcnAL0ao8x3Tsv65NhX3PA6b+V7w5c+l6exoANCMiE5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="291609094"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="291609094"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 11:17:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="642954018"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 24 Aug 2022 11:17:29 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQuwS-0000xv-1d;
        Wed, 24 Aug 2022 18:17:28 +0000
Date:   Thu, 25 Aug 2022 02:17:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: include/trace/trace_events.h:261:16: error: function
 'trace_event_get_offsets_iwlwifi_dbg' might be a candidate for 'gnu_printf'
 format attribute
Message-ID: <202208250229.UZTZVPeu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c40e8341e3b3bb27e3a65b06b5b454626234c4f0
commit: c7c37bb87590886e08d24dec53089f74b89f5fbb tracing/iwlwifi: Use the new __vstring() helper
date:   6 weeks ago
config: x86_64-sof-customedconfig-edison-defconfig (https://download.01.org/0day-ci/archive/20220825/202208250229.UZTZVPeu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7c37bb87590886e08d24dec53089f74b89f5fbb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c7c37bb87590886e08d24dec53089f74b89f5fbb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/wireless/intel/iwlwifi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h:71,
                    from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h:91,
                    from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c:15:
   drivers/net/wireless/intel/iwlwifi/./iwl-devtrace-msg.h: In function 'trace_event_get_offsets_iwlwifi_dbg':
>> include/trace/trace_events.h:261:16: error: function 'trace_event_get_offsets_iwlwifi_dbg' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
     261 |         struct trace_event_raw_##call __maybe_unused *entry;            \
         |                ^~~~~~~~~~~~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/./iwl-devtrace-msg.h:49:1: note: in expansion of macro 'TRACE_EVENT'
      49 | TRACE_EVENT(iwlwifi_dbg,
         | ^~~~~~~~~~~
   In file included from include/trace/define_trace.h:102,
                    from drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h:71,
                    from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h:91,
                    from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c:15:
   drivers/net/wireless/intel/iwlwifi/./iwl-devtrace-msg.h: In function 'trace_event_raw_event_iwlwifi_dbg':
   include/trace/trace_events.h:386:16: error: function 'trace_event_raw_event_iwlwifi_dbg' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
     386 |         struct trace_event_raw_##call *entry;                           \
         |                ^~~~~~~~~~~~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/./iwl-devtrace-msg.h:49:1: note: in expansion of macro 'TRACE_EVENT'
      49 | TRACE_EVENT(iwlwifi_dbg,
         | ^~~~~~~~~~~
   In file included from include/trace/define_trace.h:103,
                    from drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h:71,
                    from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h:91,
                    from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c:15:
   drivers/net/wireless/intel/iwlwifi/./iwl-devtrace-msg.h: In function 'perf_trace_iwlwifi_dbg':
   include/trace/perf.h:64:16: error: function 'perf_trace_iwlwifi_dbg' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
      64 |         struct hlist_head *head;                                        \
         |                ^~~~~~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/./iwl-devtrace-msg.h:49:1: note: in expansion of macro 'TRACE_EVENT'
      49 | TRACE_EVENT(iwlwifi_dbg,
         | ^~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +261 include/trace/trace_events.h

55de2c0b5610cb include/trace/trace_events.h Masami Hiramatsu         2021-11-22  253  
091ad3658e3c76 include/trace/ftrace.h       Ingo Molnar              2009-11-26  254  #undef DECLARE_EVENT_CLASS
091ad3658e3c76 include/trace/ftrace.h       Ingo Molnar              2009-11-26  255  #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
d0ee8f4a1f5f3d include/trace/trace_events.h Steven Rostedt (Red Hat  2015-05-13  256) static inline notrace int trace_event_get_offsets_##call(		\
62323a148fbeb0 include/trace/trace_events.h Steven Rostedt (Red Hat  2015-05-13  257) 	struct trace_event_data_offsets_##call *__data_offsets, proto)	\
7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  258  {									\
7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  259  	int __data_size = 0;						\
114e7b52dee69c include/trace/ftrace.h       Filipe Brandenburger     2014-02-28  260  	int __maybe_unused __item_length;				\
a7237765730a10 include/trace/trace_events.h Steven Rostedt (Red Hat  2015-05-13 @261) 	struct trace_event_raw_##call __maybe_unused *entry;		\
7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  262  									\
7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  263  	tstruct;							\
7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  264  									\
7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  265  	return __data_size;						\
7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  266  }
7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  267  

:::::: The code at line 261 was first introduced by commit
:::::: a7237765730a10d429736f47ac4b89779ec6c534 tracing: Rename ftrace_raw_##call event structures to trace_event_raw_##call

:::::: TO: Steven Rostedt (Red Hat) <rostedt@goodmis.org>
:::::: CC: Steven Rostedt <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

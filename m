Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6F755CCD8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiF0JPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiF0JPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:15:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BD72DE7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656321329; x=1687857329;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VB7YY7FVRbAIjWLJfsn0nRW6CpuRsL13FqjmviNLBgg=;
  b=haPPlO3eugWMKmYmQs1uFQB/iM0nPyCMvkyR0knlEwipHRPdBkjd82VZ
   WThPhPr2pEEATcFk96ytVdqRKSDnmhp97T2SVBYNOgkAER6V1RRFVxfKf
   8/F2PiPwwDDy/N/K+9UK/EiSvoVNE5iarnnhqAJ+MltfTYOgVn4b3XAIn
   kaZpFT/T30ohjPdV6TxxA+OtZSvGf1nJpBAWIL99Jg4xM4dd75GCKq+Up
   CoHQFMEQ1AojBN8rjnC+w8nVtadRG9lLg2qQ3rOvY04TxTl4MzcPqorVT
   C4mQYhPJeMDo4woUN8hhlT9cwT17U6O9BVYcsI37wKA+8GLaedJiN/0AX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="343091925"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="343091925"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 02:15:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="836117897"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2022 02:15:28 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5kq7-0008Od-Rm;
        Mon, 27 Jun 2022 09:15:27 +0000
Date:   Mon, 27 Jun 2022 17:15:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: include/trace/events/rcu.h:724:17: warning: 'strncpy' specified
 bound 8 equals destination size
Message-ID: <202206271718.7yMUDJGI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   03c765b0e3b4cb5063276b086c76f7a612856a9a
commit: 334ef6ed06fa1a54e35296b77b693bcf6d63ee9e init/Kconfig: make COMPILE_TEST depend on !S390
date:   1 year, 7 months ago
config: s390-buildonly-randconfig-r004-20220627 (https://download.01.org/0day-ci/archive/20220627/202206271718.7yMUDJGI-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=334ef6ed06fa1a54e35296b77b693bcf6d63ee9e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 334ef6ed06fa1a54e35296b77b693bcf6d63ee9e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash kernel/rcu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:103,
                    from include/trace/events/rcu.h:785,
                    from kernel/rcu/rcu.h:13,
                    from kernel/rcu/update.c:49:
   include/trace/events/rcu.h: In function 'perf_trace_rcu_torture_read':
>> include/trace/events/rcu.h:724:17: warning: 'strncpy' specified bound 8 equals destination size [-Wstringop-truncation]
     724 |                 strncpy(__entry->rcutorturename, rcutorturename,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     725 |                         RCUTORTURENAME_LEN);
         |                         ~~~~~~~~~~~~~~~~~~~
   include/trace/perf.h:66:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
      66 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:79:30: note: in expansion of macro 'PARAMS'
      79 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/rcu.h:11:25: note: in expansion of macro 'TRACE_EVENT'
      11 | #define TRACE_EVENT_RCU TRACE_EVENT
         |                         ^~~~~~~~~~~
   include/trace/events/rcu.h:723:9: note: in expansion of macro 'TP_fast_assign'
     723 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:102,
                    from include/trace/events/rcu.h:785,
                    from kernel/rcu/rcu.h:13,
                    from kernel/rcu/update.c:49:
   include/trace/events/rcu.h: In function 'trace_event_raw_event_rcu_torture_read':
>> include/trace/events/rcu.h:724:17: warning: 'strncpy' specified bound 8 equals destination size [-Wstringop-truncation]
     724 |                 strncpy(__entry->rcutorturename, rcutorturename,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     725 |                         RCUTORTURENAME_LEN);
         |                         ~~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:695:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
     695 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:79:30: note: in expansion of macro 'PARAMS'
      79 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/rcu.h:11:25: note: in expansion of macro 'TRACE_EVENT'
      11 | #define TRACE_EVENT_RCU TRACE_EVENT
         |                         ^~~~~~~~~~~
   include/trace/events/rcu.h:723:9: note: in expansion of macro 'TP_fast_assign'
     723 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~


vim +/strncpy +724 include/trace/events/rcu.h

91afaf300269aa Paul E. McKenney         2011-10-02  709  
e66c33d579ea56 Steven Rostedt (Red Hat  2013-07-12  710) 	TP_PROTO(const char *rcutorturename, struct rcu_head *rhp,
52494535103986 Paul E. McKenney         2012-11-14  711  		 unsigned long secs, unsigned long c_old, unsigned long c),
91afaf300269aa Paul E. McKenney         2011-10-02  712  
52494535103986 Paul E. McKenney         2012-11-14  713  	TP_ARGS(rcutorturename, rhp, secs, c_old, c),
91afaf300269aa Paul E. McKenney         2011-10-02  714  
91afaf300269aa Paul E. McKenney         2011-10-02  715  	TP_STRUCT__entry(
b3c983142d4584 Paul E. McKenney         2017-06-06  716  		__field(char, rcutorturename[RCUTORTURENAME_LEN])
91afaf300269aa Paul E. McKenney         2011-10-02  717  		__field(struct rcu_head *, rhp)
52494535103986 Paul E. McKenney         2012-11-14  718  		__field(unsigned long, secs)
52494535103986 Paul E. McKenney         2012-11-14  719  		__field(unsigned long, c_old)
52494535103986 Paul E. McKenney         2012-11-14  720  		__field(unsigned long, c)
91afaf300269aa Paul E. McKenney         2011-10-02  721  	),
91afaf300269aa Paul E. McKenney         2011-10-02  722  
91afaf300269aa Paul E. McKenney         2011-10-02  723  	TP_fast_assign(
b3c983142d4584 Paul E. McKenney         2017-06-06 @724  		strncpy(__entry->rcutorturename, rcutorturename,
b3c983142d4584 Paul E. McKenney         2017-06-06  725  			RCUTORTURENAME_LEN);
b3c983142d4584 Paul E. McKenney         2017-06-06  726  		__entry->rcutorturename[RCUTORTURENAME_LEN - 1] = 0;
91afaf300269aa Paul E. McKenney         2011-10-02  727  		__entry->rhp = rhp;
52494535103986 Paul E. McKenney         2012-11-14  728  		__entry->secs = secs;
52494535103986 Paul E. McKenney         2012-11-14  729  		__entry->c_old = c_old;
52494535103986 Paul E. McKenney         2012-11-14  730  		__entry->c = c;
91afaf300269aa Paul E. McKenney         2011-10-02  731  	),
91afaf300269aa Paul E. McKenney         2011-10-02  732  
52494535103986 Paul E. McKenney         2012-11-14  733  	TP_printk("%s torture read %p %luus c: %lu %lu",
52494535103986 Paul E. McKenney         2012-11-14  734  		  __entry->rcutorturename, __entry->rhp,
52494535103986 Paul E. McKenney         2012-11-14  735  		  __entry->secs, __entry->c_old, __entry->c)
91afaf300269aa Paul E. McKenney         2011-10-02  736  );
91afaf300269aa Paul E. McKenney         2011-10-02  737  

:::::: The code at line 724 was first introduced by commit
:::::: b3c983142d4584c9d506b1ed31b65f4292b4aea8 rcutorture: Place event-traced strings into trace buffer

:::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
:::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

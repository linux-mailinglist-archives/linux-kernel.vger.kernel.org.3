Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2059A553AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354001AbiFUTeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353555AbiFUTeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:34:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F282B21E38
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655840053; x=1687376053;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YBoCVbeBdJSh8NO5hiSopuZoPLZH9R9aCRx5PpVAHZA=;
  b=XrewSYjuXbe0cRCDUFWqGnVndtYGyN7To29clgp9Vg5dBB/vwiVjcD5q
   X3BnstSpqgUGgx9YTk4qf0aBNYTvVhlPvHsOrFxZEnJ2NqomLDCwHXdkl
   v3dIJqKDiRZX7SR/HZFW15W3fmvqFLFrW4AE6Z25ULxAF2m4iqzSlUhLj
   InrtwkEciaWk/GV9gozZ/FJ1z8AQ37MctEUoC7I1P/Bg8oe8TMqUH5onU
   2W47pXrp1JTYQFHDZocV0hY3AaNgtBIIJO2+AlJETdffeL5q7ByGNkpg8
   6QjmmP+cSR9kPwcTouH0aO/gmvDqtjutAVYpcsOZiBvAHFySUZi8o75wT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="281285813"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="281285813"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 12:34:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="833730297"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jun 2022 12:34:11 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3jda-0000KX-QA;
        Tue, 21 Jun 2022 19:34:10 +0000
Date:   Wed, 22 Jun 2022 03:34:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/rxrpc-multiqueue 3/5]
 fs/afs/rxrpc.c:155:6: warning: variable 'o' is used uninitialized whenever
 'if' condition is false
Message-ID: <202206220318.jPFg84u7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/rxrpc-multiqueue
head:   f37988fef6da3fdc3545e5a65eb9241f82f539f2
commit: 928631b5285b0aaebed61025256868cd126c9281 [3/5] rxrpc: Allow UDP socket sharing for AF_RXRPC service sockets
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220622/202206220318.jPFg84u7-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/928631b5285b0aaebed61025256868cd126c9281
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/rxrpc-multiqueue
        git checkout 928631b5285b0aaebed61025256868cd126c9281
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/afs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/afs/rxrpc.c:155:6: warning: variable 'o' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (!prealloc)
               ^~~~~~~~~
   fs/afs/rxrpc.c:157:48: note: uninitialized use occurs here
           trace_afs_call(call, afs_call_trace_alloc, 1, o,
                                                         ^
   fs/afs/rxrpc.c:155:2: note: remove the 'if' if its condition is always true
           if (!prealloc)
           ^~~~~~~~~~~~~~
   fs/afs/rxrpc.c:140:7: note: initialize the variable 'o' to silence this warning
           int o;
                ^
                 = 0
   1 warning generated.


vim +155 fs/afs/rxrpc.c

   131	
   132	/*
   133	 * Allocate a call.
   134	 */
   135	static struct afs_call *afs_alloc_call(struct afs_net *net,
   136					       const struct afs_call_type *type,
   137					       bool prealloc, gfp_t gfp)
   138	{
   139		struct afs_call *call;
   140		int o;
   141	
   142		call = kzalloc(sizeof(*call), gfp);
   143		if (!call)
   144			return NULL;
   145	
   146		call->type = type;
   147		call->net = net;
   148		call->debug_id = atomic_inc_return(&rxrpc_debug_id);
   149		atomic_set(&call->usage, 1);
   150		INIT_WORK(&call->async_work, afs_process_async_call);
   151		init_waitqueue_head(&call->waitq);
   152		spin_lock_init(&call->state_lock);
   153		call->iter = &call->def_iter;
   154	
 > 155		if (!prealloc)
   156			o = atomic_inc_return(&net->nr_outstanding_calls);
   157		trace_afs_call(call, afs_call_trace_alloc, 1, o,
   158			       __builtin_return_address(0));
   159		return call;
   160	}
   161	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

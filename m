Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412BF553A10
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343787AbiFUTOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiFUTON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:14:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A198513E09
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655838852; x=1687374852;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F/YHfUAD5msOHrXLRY/OKVTXQnE8y+kyxfToh44viV4=;
  b=ncMrRmyYk2333u2p8lTN8KUBD4QBIcGeOw9Chb3I+AFuzaevNlYa1o6c
   L2AkdvQxFeqJw/PAuCaAPzlbzJRC2NAqm6Pazv5h7/V752HPtA8KxraCY
   YtikmZi9hT3Tqd9qjm51NGpJUvz4vSMpV6WA4HCC2yzTIokWTONmM4J2F
   iNJobuN0JhY6LaNQdDN6/G8dKyQRSShnbyQyjR4E+KTpL4REWx3RTxz0Q
   ZCc2xCanHbtkzAs2B5e7rcGEyma2MTtbEQkIxDvqbPhbZhjQaJLpxNqzC
   mS44G1acJL2uRQJl3bvnnoFWueX1T4ETqxm8UkBEpaZZqR2wJeVOWYAGX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="277763521"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="277763521"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 12:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="677149672"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jun 2022 12:14:10 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3jKE-0000JW-CE;
        Tue, 21 Jun 2022 19:14:10 +0000
Date:   Wed, 22 Jun 2022 03:13:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/rxrpc-multiqueue 3/5]
 net/rxrpc/recvmsg.c:37:19: warning: variable 'sk' is uninitialized when used
 here
Message-ID: <202206220335.rHqLFMRj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220622/202206220335.rHqLFMRj-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/rxrpc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/rxrpc/recvmsg.c:37:19: warning: variable 'sk' is uninitialized when used here [-Wuninitialized]
                   call->notify_rx(sk, call, call->user_call_ID);
                                   ^~
   net/rxrpc/recvmsg.c:26:17: note: initialize the variable 'sk' to silence this warning
           struct sock *sk;
                          ^
                           = NULL
   1 warning generated.


vim +/sk +37 net/rxrpc/recvmsg.c

17926a79320afa net/rxrpc/ar-recvmsg.c David Howells 2007-04-26  18  
17926a79320afa net/rxrpc/ar-recvmsg.c David Howells 2007-04-26  19  /*
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  20   * Post a call for attention by the socket or kernel service.  Further
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  21   * notifications are suppressed by putting recvmsg_link on a dummy queue.
17926a79320afa net/rxrpc/ar-recvmsg.c David Howells 2007-04-26  22   */
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  23  void rxrpc_notify_socket(struct rxrpc_call *call)
17926a79320afa net/rxrpc/ar-recvmsg.c David Howells 2007-04-26  24  {
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  25  	struct rxrpc_sock *rx;
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  26  	struct sock *sk;
17926a79320afa net/rxrpc/ar-recvmsg.c David Howells 2007-04-26  27  
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  28  	_enter("%d", call->debug_id);
17926a79320afa net/rxrpc/ar-recvmsg.c David Howells 2007-04-26  29  
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  30  	if (!list_empty(&call->recvmsg_link))
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  31  		return;
17926a79320afa net/rxrpc/ar-recvmsg.c David Howells 2007-04-26  32  
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  33  	rcu_read_lock();
17926a79320afa net/rxrpc/ar-recvmsg.c David Howells 2007-04-26  34  
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  35  	if (call->notify_rx) {
20acbd9a7aeee0 net/rxrpc/recvmsg.c    David Howells 2017-11-02  36  		spin_lock_bh(&call->notify_lock);
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08 @37  		call->notify_rx(sk, call, call->user_call_ID);
20acbd9a7aeee0 net/rxrpc/recvmsg.c    David Howells 2017-11-02  38  		spin_unlock_bh(&call->notify_lock);
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  39  		goto out;
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  40  	}
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  41  
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  42  	rx = rcu_dereference(call->socket);
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  43  	if (rx) {
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  44  		sk = &rx->sk;
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  45  		if (sk->sk_state >= RXRPC_CLOSE)
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  46  			goto out;
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  47  
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  48  		write_lock_bh(&rx->recvmsg_lock);
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  49  		if (list_empty(&call->recvmsg_link)) {
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  50  			rxrpc_get_call(call, rxrpc_call_got);
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  51  			list_add_tail(&call->recvmsg_link, &rx->recvmsg_q);
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  52  		}
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  53  		write_unlock_bh(&rx->recvmsg_lock);
17926a79320afa net/rxrpc/ar-recvmsg.c David Howells 2007-04-26  54  
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  55  		if (!sock_flag(sk, SOCK_DEAD)) {
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  56  			_debug("call %ps", sk->sk_data_ready);
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  57  			sk->sk_data_ready(sk);
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  58  		}
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  59  		goto out;
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  60  	}
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  61  
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  62  	if (call->service) {
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  63  		struct rxrpc_service *b = call->service;
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  64  
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  65  		spin_lock_bh(&b->incoming_lock);
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  66  		if (list_empty(&call->recvmsg_link)) {
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  67  			list_add_tail(&call->recvmsg_link, &b->to_be_accepted);
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  68  			b->nr_tba++;
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  69  		}
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  70  		list_for_each_entry(rx, &b->waiting_sockets, accept_link) {
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  71  			sk = &rx->sk;
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  72  			if (!sock_flag(sk, SOCK_DEAD))
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  73  				sk->sk_data_ready(sk);
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  74  		}
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  75  		spin_unlock_bh(&b->incoming_lock);
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  76  	}
17926a79320afa net/rxrpc/ar-recvmsg.c David Howells 2007-04-26  77  
928631b5285b0a net/rxrpc/recvmsg.c    David Howells 2022-06-16  78  out:
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  79  	rcu_read_unlock();
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  80  	_leave("");
248f219cb8bcbf net/rxrpc/recvmsg.c    David Howells 2016-09-08  81  }
17926a79320afa net/rxrpc/ar-recvmsg.c David Howells 2007-04-26  82  

:::::: The code at line 37 was first introduced by commit
:::::: 248f219cb8bcbfbd7f132752d44afa2df7c241d1 rxrpc: Rewrite the data and ack handling code

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

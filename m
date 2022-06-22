Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862C6555195
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359404AbiFVQrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376658AbiFVQqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:46:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE69138D8A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655916359; x=1687452359;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6zL8tHWbGxp6vXRCJEQd10MDHQbrRulKnUz4mQ889oU=;
  b=deyURbYRVuw7HX4aQfcO4N9V3XmBBSKRF+VhRZAIy5bEABY0cJmkgq+N
   rFCW3awC8v9GBu7HxyoYjqBUAmxfe4ZNKUyir6XYK5oYUvYnL2GiKBXbx
   +iMBr97PexFlefc924KmXFT2eiDGyGnxuqcaBL5SG27lIPPhUnw3JiA6I
   nqL3CcmZr+vTQN34VHhmyLTo1jbudT2woCr2NWq+GI+Dj0jboWFTeMH60
   mLEeje1LXeoUqFhQQBmSFfXFTBfZyMplsgF7SMhL8dwGY0okrTMqps9FG
   w67Ec0Dn/pBIe5bH07sng/1+RSSzjyBjzSYwUd+hdNjPtthAHRQX4lENz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281547356"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="281547356"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 09:45:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="620981578"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2022 09:45:54 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o43UH-0001UT-SR;
        Wed, 22 Jun 2022 16:45:53 +0000
Date:   Thu, 23 Jun 2022 00:45:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/rxrpc-multiqueue 5/9]
 net/rxrpc/af_rxrpc.c:948:2: warning: #warning compat_setsockopt disappeared
Message-ID: <202206230036.pBsx3VvP-lkp@intel.com>
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
head:   83e1620a43190584ecbc51e8afc8b94a7b14286c
commit: 79ccb581e080d255dae79131e273d2db3cd5b51a [5/9] rxrpc: Allow the call to interact with to be preselected
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220623/202206230036.pBsx3VvP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/79ccb581e080d255dae79131e273d2db3cd5b51a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/rxrpc-multiqueue
        git checkout 79ccb581e080d255dae79131e273d2db3cd5b51a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/rxrpc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/rxrpc/af_rxrpc.c: In function 'rxrpc_setsockopt':
>> net/rxrpc/af_rxrpc.c:948:2: warning: #warning compat_setsockopt disappeared [-Wcpp]
     948 | #warning compat_setsockopt disappeared
         |  ^~~~~~~
--
>> net/rxrpc/af_rxrpc.c:948:2: warning: #warning compat_setsockopt disappeared [-Wcpp]
     948 | #warning compat_setsockopt disappeared
         |  ^~~~~~~


vim +948 net/rxrpc/af_rxrpc.c

   848	
   849	/*
   850	 * set RxRPC socket options
   851	 */
   852	static int rxrpc_setsockopt(struct socket *sock, int level, int optname,
   853				    sockptr_t optval, unsigned int optlen)
   854	{
   855		struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
   856		unsigned long long call_id;
   857		unsigned int min_sec_level;
   858		u16 service_upgrade[2];
   859		int ret, fd;
   860	
   861		_enter(",%d,%d,,%d", level, optname, optlen);
   862	
   863		lock_sock(&rx->sk);
   864		ret = -EOPNOTSUPP;
   865	
   866		if (level == SOL_RXRPC) {
   867			switch (optname) {
   868			case RXRPC_EXCLUSIVE_CONNECTION:
   869				ret = -EINVAL;
   870				if (optlen != 0)
   871					goto error;
   872				ret = -EISCONN;
   873				if (rx->sk.sk_state != RXRPC_UNBOUND)
   874					goto error;
   875				rx->exclusive = true;
   876				goto success;
   877	
   878			case RXRPC_SECURITY_KEY:
   879				ret = -EINVAL;
   880				if (rx->key)
   881					goto error;
   882				ret = -EISCONN;
   883				if (rx->sk.sk_state != RXRPC_UNBOUND)
   884					goto error;
   885				ret = rxrpc_request_key(rx, optval, optlen);
   886				goto error;
   887	
   888			case RXRPC_SECURITY_KEYRING:
   889				ret = -EINVAL;
   890				if (rx->key)
   891					goto error;
   892				ret = -EISCONN;
   893				if (rx->sk.sk_state != RXRPC_UNBOUND)
   894					goto error;
   895				ret = rxrpc_server_keyring(rx, optval, optlen);
   896				goto error;
   897	
   898			case RXRPC_MIN_SECURITY_LEVEL:
   899				ret = -EINVAL;
   900				if (optlen != sizeof(unsigned int))
   901					goto error;
   902				ret = -EISCONN;
   903				if (rx->sk.sk_state != RXRPC_UNBOUND)
   904					goto error;
   905				ret = copy_from_sockptr(&min_sec_level, optval,
   906					       sizeof(unsigned int));
   907				if (ret < 0)
   908					goto error;
   909				ret = -EINVAL;
   910				if (min_sec_level > RXRPC_SECURITY_MAX)
   911					goto error;
   912				rx->min_sec_level = min_sec_level;
   913				goto success;
   914	
   915			case RXRPC_UPGRADEABLE_SERVICE:
   916				ret = -EINVAL;
   917				if (optlen != sizeof(service_upgrade))
   918					goto error;
   919				ret = -EISCONN;
   920				if (rx->sk.sk_state != RXRPC_SERVER_BOUND)
   921					goto error;
   922				ret = -EFAULT;
   923				if (copy_from_sockptr(service_upgrade, optval,
   924						   sizeof(service_upgrade)) != 0)
   925					goto error;
   926				mutex_lock(&rx->local->services_lock);
   927				ret = rxrpc_bind_service_upgrade(rx, service_upgrade[0],
   928								 service_upgrade[1]);
   929				mutex_unlock(&rx->local->services_lock);
   930				if (ret < 0)
   931					goto error;
   932				goto success;
   933	
   934			case RXRPC_BIND_CHANNEL:
   935				ret = -EINVAL;
   936				if (optlen != sizeof(fd))
   937					goto error;
   938				ret = -EFAULT;
   939				if (copy_from_sockptr(&fd, optval, sizeof(fd)) != 0)
   940					goto error;
   941				ret = rxrpc_bind_channel(rx, fd);
   942				if (ret < 0)
   943					goto error;
   944				goto success;
   945	
   946			case RXRPC_SELECT_CALL_FOR_RECV:
   947			case RXRPC_SELECT_CALL_FOR_SEND:
 > 948	#warning compat_setsockopt disappeared
   949				ret = -EINVAL;
   950				if (optlen != sizeof(call_id))
   951					goto error;
   952				ret = -EFAULT;
   953				if (copy_from_sockptr(&call_id, optval,
   954						      sizeof(call_id)) != 0)
   955					goto error;
   956				ret = rxrpc_set_select_call(rx, call_id, optname);
   957				goto error;
   958	
   959			default:
   960				goto error;
   961			}
   962		} else {
   963			goto error;
   964		}
   965	
   966	success:
   967		ret = 0;
   968	error:
   969		release_sock(&rx->sk);
   970		return ret;
   971	}
   972	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

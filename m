Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61699501160
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 16:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349253AbiDNOTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 10:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245737AbiDNNiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:38:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FB4A7764
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649943244; x=1681479244;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UNppWNaeAIa10Dki/dKqomPYngkMUhRRYFw1rQFeEto=;
  b=fsqYLjJMDwNNimsEVg76wQCLe6u9t3iju7mq8/dJKdddMfbSH1JJa500
   PAUctHLbl93OdNsu0XDGX6HMN9nnoGYUHTd6u2s216jCvUZlqWC7O0aXO
   A8khr5MYm3Sv40tf5WZiAGOguuW3mzf3YiErmFkV5bcLDNAFSsm1eDNCD
   MwxwoVMwhyPGeDk0Pb2jQiDk/Pa4QK79sYLIfuykBk3Sh1Q8COw+Pp4g4
   PTv4sTY3Q7kayR8RfH7nnbCl+n0cUrESpBWxIhskNwZ83cq/7KXeq5pf7
   J09Dkk8VmcGQnCr/8I2Q5w0h4M8fm8vh40v47DcCcV/Q6hwIXkSFXqIuT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="243516091"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="243516091"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 06:34:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="508406979"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 Apr 2022 06:34:03 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nezbm-0000zx-Cz;
        Thu, 14 Apr 2022 13:34:02 +0000
Date:   Thu, 14 Apr 2022 21:33:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [axboe-block:sock-nolock.2 5/5] net/mptcp/subflow.c:1796:20: error:
 too few arguments to function call, expected 2, have 1
Message-ID: <202204142114.rOCzHB7d-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git sock-nolock.2
head:   95f2e3bd27b30244f79deacbc1aac49d294bd854
commit: 95f2e3bd27b30244f79deacbc1aac49d294bd854 [5/5] net: allow sk_prot->release_cb() without sock lock held
config: hexagon-randconfig-r041-20220414 (https://download.01.org/0day-ci/archive/20220414/202204142114.rOCzHB7d-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6ea489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=95f2e3bd27b30244f79deacbc1aac49d294bd854
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block sock-nolock.2
        git checkout 95f2e3bd27b30244f79deacbc1aac49d294bd854
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/mptcp/subflow.c:1796:20: error: too few arguments to function call, expected 2, have 1
           tcp_release_cb(ssk);
           ~~~~~~~~~~~~~~    ^
   include/net/tcp.h:337:6: note: 'tcp_release_cb' declared here
   void tcp_release_cb(struct sock *sk, bool locked);
        ^
>> net/mptcp/subflow.c:1841:31: error: incompatible function pointer types assigning to 'void (*)(struct sock *, bool)' (aka 'void (*)(struct sock *, _Bool)') from 'void (struct sock *)' [-Werror,-Wincompatible-function-pointer-types]
           tcp_prot_override.release_cb = tcp_release_cb_override;
                                        ^ ~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +1796 net/mptcp/subflow.c

cec37a6e41aae7 Peter Krystad    2020-01-21  1788  
b19bc2945b40b9 Paolo Abeni      2021-01-20  1789  static void tcp_release_cb_override(struct sock *ssk)
b19bc2945b40b9 Paolo Abeni      2021-01-20  1790  {
b19bc2945b40b9 Paolo Abeni      2021-01-20  1791  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
b19bc2945b40b9 Paolo Abeni      2021-01-20  1792  
b19bc2945b40b9 Paolo Abeni      2021-01-20  1793  	if (mptcp_subflow_has_delegated_action(subflow))
b19bc2945b40b9 Paolo Abeni      2021-01-20  1794  		mptcp_subflow_process_delegated(ssk);
b19bc2945b40b9 Paolo Abeni      2021-01-20  1795  
b19bc2945b40b9 Paolo Abeni      2021-01-20 @1796  	tcp_release_cb(ssk);
b19bc2945b40b9 Paolo Abeni      2021-01-20  1797  }
b19bc2945b40b9 Paolo Abeni      2021-01-20  1798  
2303f994b3e187 Peter Krystad    2020-01-21  1799  static struct tcp_ulp_ops subflow_ulp_ops __read_mostly = {
2303f994b3e187 Peter Krystad    2020-01-21  1800  	.name		= "mptcp",
2303f994b3e187 Peter Krystad    2020-01-21  1801  	.owner		= THIS_MODULE,
2303f994b3e187 Peter Krystad    2020-01-21  1802  	.init		= subflow_ulp_init,
2303f994b3e187 Peter Krystad    2020-01-21  1803  	.release	= subflow_ulp_release,
cec37a6e41aae7 Peter Krystad    2020-01-21  1804  	.clone		= subflow_ulp_clone,
2303f994b3e187 Peter Krystad    2020-01-21  1805  };
2303f994b3e187 Peter Krystad    2020-01-21  1806  
cec37a6e41aae7 Peter Krystad    2020-01-21  1807  static int subflow_ops_init(struct request_sock_ops *subflow_ops)
cec37a6e41aae7 Peter Krystad    2020-01-21  1808  {
cec37a6e41aae7 Peter Krystad    2020-01-21  1809  	subflow_ops->obj_size = sizeof(struct mptcp_subflow_request_sock);
cec37a6e41aae7 Peter Krystad    2020-01-21  1810  	subflow_ops->slab_name = "request_sock_subflow";
cec37a6e41aae7 Peter Krystad    2020-01-21  1811  
cec37a6e41aae7 Peter Krystad    2020-01-21  1812  	subflow_ops->slab = kmem_cache_create(subflow_ops->slab_name,
cec37a6e41aae7 Peter Krystad    2020-01-21  1813  					      subflow_ops->obj_size, 0,
cec37a6e41aae7 Peter Krystad    2020-01-21  1814  					      SLAB_ACCOUNT |
cec37a6e41aae7 Peter Krystad    2020-01-21  1815  					      SLAB_TYPESAFE_BY_RCU,
cec37a6e41aae7 Peter Krystad    2020-01-21  1816  					      NULL);
cec37a6e41aae7 Peter Krystad    2020-01-21  1817  	if (!subflow_ops->slab)
cec37a6e41aae7 Peter Krystad    2020-01-21  1818  		return -ENOMEM;
cec37a6e41aae7 Peter Krystad    2020-01-21  1819  
79c0949e9a09f6 Peter Krystad    2020-01-21  1820  	subflow_ops->destructor = subflow_req_destructor;
79c0949e9a09f6 Peter Krystad    2020-01-21  1821  
cec37a6e41aae7 Peter Krystad    2020-01-21  1822  	return 0;
cec37a6e41aae7 Peter Krystad    2020-01-21  1823  }
cec37a6e41aae7 Peter Krystad    2020-01-21  1824  
d39dceca388ad0 Paolo Abeni      2020-06-26  1825  void __init mptcp_subflow_init(void)
2303f994b3e187 Peter Krystad    2020-01-21  1826  {
08b8d080982fec Florian Westphal 2020-07-30  1827  	mptcp_subflow_request_sock_ops = tcp_request_sock_ops;
08b8d080982fec Florian Westphal 2020-07-30  1828  	if (subflow_ops_init(&mptcp_subflow_request_sock_ops) != 0)
cec37a6e41aae7 Peter Krystad    2020-01-21  1829  		panic("MPTCP: failed to init subflow request sock ops\n");
cec37a6e41aae7 Peter Krystad    2020-01-21  1830  
cec37a6e41aae7 Peter Krystad    2020-01-21  1831  	subflow_request_sock_ipv4_ops = tcp_request_sock_ipv4_ops;
7ea851d19b2359 Florian Westphal 2020-11-30  1832  	subflow_request_sock_ipv4_ops.route_req = subflow_v4_route_req;
cec37a6e41aae7 Peter Krystad    2020-01-21  1833  
cec37a6e41aae7 Peter Krystad    2020-01-21  1834  	subflow_specific = ipv4_specific;
cec37a6e41aae7 Peter Krystad    2020-01-21  1835  	subflow_specific.conn_request = subflow_v4_conn_request;
cec37a6e41aae7 Peter Krystad    2020-01-21  1836  	subflow_specific.syn_recv_sock = subflow_syn_recv_sock;
cec37a6e41aae7 Peter Krystad    2020-01-21  1837  	subflow_specific.sk_rx_dst_set = subflow_finish_connect;
4cf86ae84c7183 Paolo Abeni      2022-03-07  1838  	subflow_specific.rebuild_header = subflow_rebuild_header;
cec37a6e41aae7 Peter Krystad    2020-01-21  1839  
b19bc2945b40b9 Paolo Abeni      2021-01-20  1840  	tcp_prot_override = tcp_prot;
b19bc2945b40b9 Paolo Abeni      2021-01-20 @1841  	tcp_prot_override.release_cb = tcp_release_cb_override;
b19bc2945b40b9 Paolo Abeni      2021-01-20  1842  

:::::: The code at line 1796 was first introduced by commit
:::::: b19bc2945b40b9fd38e835700907ffe8534ef0de mptcp: implement delegated actions

:::::: TO: Paolo Abeni <pabeni@redhat.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

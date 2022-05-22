Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B2752FFE5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 02:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245144AbiEVAH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 20:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbiEVAH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 20:07:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7EF1ADAA
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 17:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653178077; x=1684714077;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tt+5iqgJOfFNcf2mr934A0D8klJ6YykKeKKUISl7fzg=;
  b=YPGe3dT0AHWsnHlMkmWmw4wYeBg/aJy1bhfOyzv4Ckmwc7EOVIts6+qf
   JQ4LIFlNjDitqshtZo0izPSYQ5Yz2YTYHD01rpgWSbQUsTbRrpiGJfeEJ
   173bxw0+u5qRvSYH3FVt6kAOSthCllA8WhVMosQukaBW+ZiFF4SBjYXsz
   2asIcJ2TIHwYvP57gMjVZUjsEMb2EnT7r68apMzAh+adDnr1fs4sR4CPr
   p6g38g3PGlF6QNbwXHYLs05gpTW4qc1Sc1TFnB2jDAS1Z3THZ/DN/Iboq
   mD4bfT4wS5/XZNx3DNwWz5EX2JkhupNJ71aciA85XHJRyHzrnv4qpVcGj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="333550704"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="333550704"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 17:07:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="716111793"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 21 May 2022 17:07:56 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsZ8V-0006kT-F5;
        Sun, 22 May 2022 00:07:55 +0000
Date:   Sun, 22 May 2022 08:07:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [cel:topic-rpc-with-tls-upcall 16/19] net/sunrpc/xprtsock.c:2470:
 undefined reference to `tls_client_hello_psk'
Message-ID: <202205220749.t0IB45zc-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls-upcall
head:   c484b8917f3569f6fdf4026936f9452dbeb1a8c3
commit: ff786916b6c43d3db9b03c15b3379fd96b4bb05c [16/19] SUNRPC: Add RPC-with-TLS support to xprtsock.c
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20220522/202205220749.t0IB45zc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=ff786916b6c43d3db9b03c15b3379fd96b4bb05c
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls-upcall
        git checkout ff786916b6c43d3db9b03c15b3379fd96b4bb05c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/sunrpc/xprtsock.o: in function `xs_tls_handshake_sync':
>> net/sunrpc/xprtsock.c:2470: undefined reference to `tls_client_hello_psk'
>> ld: net/sunrpc/xprtsock.c:2464: undefined reference to `tls_client_hello_x509'


vim +2470 net/sunrpc/xprtsock.c

  2451	
  2452	static int xs_tls_handshake_sync(struct rpc_xprt *xprt, unsigned int xprtsec)
  2453	{
  2454		struct sock_xprt *transport =
  2455					container_of(xprt, struct sock_xprt, xprt);
  2456		int rc;
  2457	
  2458		init_completion(&transport->handshake_done);
  2459		set_bit(XPRT_SOCK_IGNORE_RECV, &transport->sock_state);
  2460	
  2461		transport->xprt_err = -ETIMEDOUT;
  2462		switch (xprtsec) {
  2463		case RPC_XPRTSEC_TLS_X509:
> 2464			rc = tls_client_hello_x509(transport->sock,
  2465						   xs_tls_handshake_done, xprt_get(xprt),
  2466						   TLSH_DEFAULT_PRIORITIES, TLSH_NO_PEERID,
  2467						   TLSH_NO_CERT);
  2468			break;
  2469		case RPC_XPRTSEC_TLS_PSK:
> 2470			rc = tls_client_hello_psk(transport->sock, xs_tls_handshake_done,
  2471						  xprt_get(xprt), TLSH_DEFAULT_PRIORITIES,
  2472						  TLSH_NO_PEERID);
  2473			break;
  2474		default:
  2475			rc = -EACCES;
  2476		}
  2477		if (rc)
  2478			goto out;
  2479	
  2480		rc = wait_for_completion_interruptible_timeout(&transport->handshake_done,
  2481							       XS_TLS_HANDSHAKE_TO);
  2482		if (rc < 0)
  2483			goto out;
  2484	
  2485		rc = transport->xprt_err;
  2486	
  2487	out:
  2488		xs_stream_reset_connect(transport);
  2489		clear_bit(XPRT_SOCK_IGNORE_RECV, &transport->sock_state);
  2490		return rc;
  2491	}
  2492	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

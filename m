Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0C1501374
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346017AbiDNNzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245542AbiDNN3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:29:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90283AD122
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649942588; x=1681478588;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tEoaxobnzOnTCJoW4N/TrqtTP0L+774fqC1hHmkr1N8=;
  b=LcBAgnCS4e9vKDYlBQ038wwdsfccDXNPNateghImxvFquDdMw8ROdIsn
   6inO1Ld/6Hd2KmcgJlAeV1qc0fzGq8r+gtLMkNWNUE09UDw8JrX3ZT2E8
   Vk0X0cpfgtUKGcJd6jb1T63iQmaYn+UqfJVm9e04h2NvLiJvuVmiON46i
   iw4KegN1GzbW4NvVE/S9ELyT2CRJkXZ1DHd06RNPRZSN0Wgf/PgRW3h3s
   qKOnG04dmxbp2IuTmMKaju8kXJpqjqF+og3R816Yzr7dvmqp0rcjccD6c
   a6SmxH/UvEhm0fulkvaw1T9BSZ8U5w4U8BGaOJfSu+yFBT/WiVbm/n+mo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="325832874"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="325832874"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 06:22:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="725361595"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 14 Apr 2022 06:22:53 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nezQz-0000zF-73;
        Thu, 14 Apr 2022 13:22:53 +0000
Date:   Thu, 14 Apr 2022 21:22:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [cel:topic-rpc-with-tls-upcall 18/21] net/sunrpc/clnt.c:2194:2:
 warning: unannotated fall-through between switch labels
Message-ID: <202204142146.JvSVSwxH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls-upcall
head:   77d1002f5a5209bebd901cf895b52730199c0ba4
commit: d7546e246acd3e74b2967985f4cae4df84fdba25 [18/21] SUNRPC: Add FSM machinery to handle RPC_AUTH_TLS on reconnect
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220414/202204142146.JvSVSwxH-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6ea489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=d7546e246acd3e74b2967985f4cae4df84fdba25
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls-upcall
        git checkout d7546e246acd3e74b2967985f4cae4df84fdba25
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/sunrpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/sunrpc/clnt.c:2194:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           default:
           ^
   net/sunrpc/clnt.c:2194:2: note: insert 'break;' to avoid fall-through
           default:
           ^
           break; 
   1 warning generated.


vim +2194 net/sunrpc/clnt.c

  2176	
  2177	static void
  2178	call_start_tls(struct rpc_task *task)
  2179	{
  2180		struct rpc_xprt *xprt = task->tk_rqstp->rq_xprt;
  2181		struct rpc_clnt *clnt = task->tk_client;
  2182	
  2183		task->tk_action = call_transmit;
  2184		if (RPC_IS_TLSPROBE(task))
  2185			return;
  2186	
  2187		switch (clnt->cl_xprtsec_policy) {
  2188		case RPC_XPRTSEC_TLS:
  2189		case RPC_XPRTSEC_MTLS:
  2190			if (xprt->ops->tls_handshake_async) {
  2191				task->tk_action = call_tls_status;
  2192				rpc_starttls_async(task);
  2193			}
> 2194		default:
  2195			break;
  2196		}
  2197	}
  2198	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F4948D71F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiAMMG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:06:58 -0500
Received: from mga12.intel.com ([192.55.52.136]:34006 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234385AbiAMMGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642075607; x=1673611607;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Yq87Afp64FG/fgc06uri6AT2cW3uh4/5BtkWpNNlZ3c=;
  b=JAO+i9o5LCxctq3Lc8R67iwu4PqI2s3QnzITnRTIAaJDSUwf00Vy710x
   yrm+mG8tQbOgRzTKRVcz6zpBpzRri2tbKmowpOytGMsVB2HHGIZUdzTcn
   UNMlQj2X8GuES1+kondZH0swMfza/2cs1uclZXimgQgUfv9AWlG4RKCG9
   ssvKcOCe/0eVFfX62dNw8KsYObE189wU8AYM9uyrkTqFadlbkjvJJbdd0
   +VEiT8R2LqZr/Fos26f7Rrw0/gzy73NS50ns5kfcf/1ZTOUpLnvZfFs2U
   nHoEkgoGgYajzvAwLZUJs+dhDF+whRYxkl0++XLfq6iQx5UDF8r5nxacT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="223976318"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="223976318"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 04:06:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="576918558"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jan 2022 04:06:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7ysO-0007AP-Oq; Thu, 13 Jan 2022 12:06:44 +0000
Date:   Thu, 13 Jan 2022 20:05:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [cel:topic-rpc-with-tls-upcall 18/19] net/sunrpc/xprtsock.c:2257:
 undefined reference to `tls_client_hello_user'
Message-ID: <202201131908.bylSNIA1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls-upcall
head:   0fd328ea53e7d539bf8bb160d773e1d027c60fea
commit: adb54a631895e050da6ed9a18f9b503f927b642d [18/19] SUNRPC: RPC client support for TLS handshake upcall
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220113/202201131908.bylSNIA1-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=adb54a631895e050da6ed9a18f9b503f927b642d
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls-upcall
        git checkout adb54a631895e050da6ed9a18f9b503f927b642d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/sunrpc/xprtsock.o: in function `xs_tcp_tls_handshake_sync':
>> net/sunrpc/xprtsock.c:2257: undefined reference to `tls_client_hello_user'
   ld: net/sunrpc/xprtsock.o: in function `xs_tcp_tls_handshake_async':
   net/sunrpc/xprtsock.c:2296: undefined reference to `tls_client_hello_user'
   pahole: .tmp_vmlinux.btf: No such file or directory
   .btf.vmlinux.bin.o: file not recognized: file format not recognized


vim +2257 net/sunrpc/xprtsock.c

  2239	
  2240	/**
  2241	 * xs_tcp_tls_handshake_sync - Perform a full TLS client handshake
  2242	 * @xprt: transport on which to perform handshake
  2243	 *
  2244	 * Return values:
  2245	 *   %0: Handshake completed successfully.
  2246	 *   Negative errno: handshake not started, or failed.
  2247	 */
  2248	static int xs_tcp_tls_handshake_sync(struct rpc_xprt *xprt)
  2249	{
  2250		struct sock_xprt *transport =
  2251					container_of(xprt, struct sock_xprt, xprt);
  2252		int rc;
  2253	
  2254		init_completion(&transport->handshake_done);
  2255	
  2256		transport->xprt_err = -ETIMEDOUT;
> 2257		rc = tls_client_hello_user(transport->sock,
  2258					   xs_tcp_tls_handshake_done, xprt);
  2259		if (rc)
  2260			return rc;
  2261		rc = wait_for_completion_interruptible_timeout(&transport->handshake_done,
  2262							       XS_TLS_HANDSHAKE_TO);
  2263		if (rc < 0)
  2264			return rc;
  2265	
  2266		return transport->xprt_err;
  2267	}
  2268	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E17B4A9936
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 13:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358744AbiBDMYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 07:24:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:45802 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237442AbiBDMYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643977462; x=1675513462;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HoWb6wEZFJjJjZNegNsf5mO0Agei6dh0WlcVuxjoJro=;
  b=ivXRYDCepvnJX0W0ERI3uG5LCIYP/zF2ONsdRHOV+ED9rppT6cTYeFUl
   Tu733U5H1AvMEaILJh7C+vHbKT4LwG5goZAl9jSdnQeXgUnq1OmYavZEj
   J3UgN5Nnnw3twDiMXvJ2mJCzLzqjgVlBpPM6ZOvuuGP3jIJXA/S7bN2dY
   vEG6LkiTXxBjT+2qHmM+ORcnQwUv6mNvPKZg2iHo/jYNQ6yb756cmrR4D
   yF6hXVDRmmPJNp2c9RhtOmn3rm2tNV8qr+ekVbwQkt/nZTDuXEXFX8UHM
   xygPJnzllhNHMCzYuxp/W1Xq3LOmJW9gvH2lHz7JfI85bRponPfRZEYJp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="228331545"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="228331545"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 04:24:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="772081227"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Feb 2022 04:24:21 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFxdU-000XbQ-I8; Fri, 04 Feb 2022 12:24:20 +0000
Date:   Fri, 4 Feb 2022 20:23:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [cel:topic-rpc-with-tls-upcall 18/20] net/sunrpc/xprtsock.c:2315:
 undefined reference to `tls_client_hello_user'
Message-ID: <202202042046.FoUgDgV1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls-upcall
head:   5a02f5044d5953495b63be854083f501c35e9e11
commit: 7d4a29e2fb46b1ff57accdd5daf93441deaae91c [18/20] SUNRPC: RPC client support for TLS handshake upcall
config: i386-debian-10.3-kselftests (https://download.01.org/0day-ci/archive/20220204/202202042046.FoUgDgV1-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=7d4a29e2fb46b1ff57accdd5daf93441deaae91c
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls-upcall
        git checkout 7d4a29e2fb46b1ff57accdd5daf93441deaae91c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/sunrpc/xprtsock.o: in function `xs_tcp_tls_handshake_async':
>> net/sunrpc/xprtsock.c:2315: undefined reference to `tls_client_hello_user'
   ld: net/sunrpc/xprtsock.o: in function `xs_tcp_tls_handshake_sync':
   net/sunrpc/xprtsock.c:2268: undefined reference to `tls_client_hello_user'
   pahole: .tmp_vmlinux.btf: No such file or directory
   .btf.vmlinux.bin.o: file not recognized: file format not recognized


vim +2315 net/sunrpc/xprtsock.c

  2300	
  2301	/**
  2302	 * xs_tcp_tls_handshake_async - Start a TLS handshake
  2303	 * @xprt: transport on which to perform handshake
  2304	 *
  2305	 * Return values:
  2306	 *   %0: Handshake initiated; @xprt will be awoken when it's done.
  2307	 *   Negative errno: handshake was not started.
  2308	 */
  2309	static int xs_tcp_tls_handshake_async(struct rpc_xprt *xprt)
  2310	{
  2311		struct sock_xprt *transport =
  2312					container_of(xprt, struct sock_xprt, xprt);
  2313	
  2314		transport->recv.handshake_pending = true;
> 2315		return tls_client_hello_user(transport->sock,
  2316					     xs_tcp_tls_handshake_wake, xprt);
  2317	}
  2318	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73839496C56
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 13:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiAVMdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 07:33:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:62848 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbiAVMdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 07:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642854818; x=1674390818;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+yaefs6b7kFOOgjdhrJt0kz2hkELKlXLSjmwxnu5UPk=;
  b=KaJHcHTIJEbqNSmn/ycuNvv9oQjN7wiGunUUZIzWvVPKX9gjVEDlvnd8
   5mJ4/O3edciXWjuUmJpFQYpy9dfHn7+m2XAnX2WOuuj47IP2fu0yYhCRL
   LQ1FOcm4YmKCS+9xnnI4l6cmgZ4bk0o4hwWBmPzDBcLm78h6DIYLoOPc5
   9Ig9UA4Oe+uzB0RgaOsdiQv9JLoJ1MfxiordrsuFvddJp4tvlfFaqzet2
   qo1lqseCH4IiJwn4t18O6o1DgUmnhuQ0RWIDE92Any9OqBGd50JINrqNu
   erVidZvIqWLd7yf02wk9lDgwi7ao73Iwn3b9Tz3XbOS+rX2mqnRcKmy1c
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="245763133"
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="245763133"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 04:33:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="494135000"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Jan 2022 04:33:37 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBFaK-000GOV-DR; Sat, 22 Jan 2022 12:33:36 +0000
Date:   Sat, 22 Jan 2022 20:32:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [cel:topic-rpc-with-tls-upcall 15/18] net/tls/af_tlsh.c:243:
 undefined reference to `inet6_release'
Message-ID: <202201222037.SQYbQlzI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls-upcall
head:   da4c27539d2deaa2b9624c470a903b880497e398
commit: 2d835a81bb38c6378f4cc53d0eb2320248a11a4c [15/18] net/tls: Add support for PF_TLSH (a TLS handshake listener)
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220122/202201222037.SQYbQlzI-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=2d835a81bb38c6378f4cc53d0eb2320248a11a4c
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls-upcall
        git checkout 2d835a81bb38c6378f4cc53d0eb2320248a11a4c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/tls/af_tlsh.o: in function `tlsh_recvmsg':
   net/tls/af_tlsh.c:594: undefined reference to `inet6_recvmsg'
   ld: net/tls/af_tlsh.o: in function `tlsh_sendmsg':
   net/tls/af_tlsh.c:564: undefined reference to `inet6_sendmsg'
   ld: net/tls/af_tlsh.o: in function `tlsh_getname':
   net/tls/af_tlsh.c:404: undefined reference to `inet6_getname'
   ld: net/tls/af_tlsh.o: in function `tlsh_release':
>> net/tls/af_tlsh.c:243: undefined reference to `inet6_release'


vim +243 net/tls/af_tlsh.c

   223	
   224	/**
   225	 * tlsh_release - free an AF_TLSH socket
   226	 * @sock: socket to release
   227	 *
   228	 * Return values:
   229	 *   %0: success
   230	 */
   231	static int tlsh_release(struct socket *sock)
   232	{
   233		struct sock *sk = sock->sk;
   234	
   235		if (!sk)
   236			return 0;
   237	
   238		switch (sk->sk_family) {
   239		case AF_INET:
   240			return inet_release(sock);
   241	#if IS_ENABLED(CONFIG_IPV6)
   242		case AF_INET6:
 > 243			return inet6_release(sock);
   244	#endif
   245		case AF_TLSH:
   246			break;
   247		default:
   248			return 0;
   249		}
   250	
   251		sock_hold(sk);	/* Ref: D */
   252		sock_orphan(sk);
   253		lock_sock(sk);
   254	
   255		tlsh_unregister_listener(sk);
   256		tlsh_accept_drain(sk);
   257	
   258		sk->sk_state = TCP_CLOSE;
   259		sk->sk_shutdown |= SEND_SHUTDOWN;
   260		sk->sk_state_change(sk);
   261	
   262		sk->sk_tls_bind_family = AF_UNSPEC;
   263		sock->sk = NULL;
   264		release_sock(sk);
   265		sock_put(sk);	/* Ref: D */
   266	
   267		sock_put(sk);	/* Ref: A */
   268		return 0;
   269	}
   270	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

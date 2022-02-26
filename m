Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BF44C57D1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 20:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiBZTQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 14:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiBZTQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 14:16:43 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F2750069
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 11:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645902968; x=1677438968;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1p/1o6gucXOC6bJF0xUalZ1MB1DsZ5wL0L6RfliciwY=;
  b=WoWVN0UyjvvUtggxJAEUbWoJMMnP7h737+pIdqpYj8eWFwoCTx58jgeD
   dGeCgO0sFDkws66F8vsgntL0yC6fM85m1sLykdXrXrEBIBEL1FPS3VNSa
   d8ebTUenOMmEsRBfw3EjtZ8DNDB40LNAKT3V+OsvN1cGiJIYQ8Q/yBnZc
   kx+fMpFsTYQy0oW9xRXYAiguhqvUOhuB3THCEpKHxyeAvdHMe3Rp44M/s
   uFtOVZOqNAxgN7MDzqJZGlrKJudNx1q0mYNEASeZBJRxcIuWT4VLL91/7
   N/PS98KZ8ObFvyv7E0KB65l9fQ45UWI8kLeX85PK88tGHRcTLQUFg8IP7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="313396874"
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="313396874"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 11:16:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="509619000"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Feb 2022 11:16:06 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nO2Y2-0005tG-8U; Sat, 26 Feb 2022 19:16:06 +0000
Date:   Sun, 27 Feb 2022 03:15:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [hare-scsi-devel:tls-upcall.v2 135/159] net/tls/af_tlsh.c:593:
 undefined reference to `inet6_recvmsg'
Message-ID: <202202270241.wsRAnnPM-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v2
head:   21b520ae0b338bd30496feb1ca90a2820dab7a65
commit: 49f638e40e8a12b036a9943b76baa0c54c14d504 [135/159] net/tls: Add support for PF_TLSH (a TLS handshake listener)
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220227/202202270241.wsRAnnPM-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=49f638e40e8a12b036a9943b76baa0c54c14d504
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v2
        git checkout 49f638e40e8a12b036a9943b76baa0c54c14d504
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/tls/af_tlsh.o: in function `tlsh_recvmsg':
>> net/tls/af_tlsh.c:593: undefined reference to `inet6_recvmsg'
   ld: net/tls/af_tlsh.o: in function `tlsh_sendmsg':
>> net/tls/af_tlsh.c:565: undefined reference to `inet6_sendmsg'
   ld: net/tls/af_tlsh.o: in function `tlsh_getname':
>> net/tls/af_tlsh.c:407: undefined reference to `inet6_getname'
   ld: net/tls/af_tlsh.o: in function `tlsh_release':
>> net/tls/af_tlsh.c:246: undefined reference to `inet6_release'


vim +593 net/tls/af_tlsh.c

   387	
   388	/**
   389	 * tlsh_getname - retrieve src/dst address information
   390	 * @sock: socket to query
   391	 * @uaddr: buffer to fill in
   392	 * @peer: value indicates which address to retrieve
   393	 *
   394	 * Return values:
   395	 *   On success, a positive length of the address in @uaddr
   396	 *   On error, a negative errno
   397	 */
   398	static int tlsh_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
   399	{
   400		struct sock *sk = sock->sk;
   401	
   402		switch (sk->sk_family) {
   403		case AF_INET:
   404			return inet_getname(sock, uaddr, peer);
   405	#if IS_ENABLED(CONFIG_IPV6)
   406		case AF_INET6:
 > 407			return inet6_getname(sock, uaddr, peer);
   408	#endif
   409		default:
   410			return -EOPNOTSUPP;
   411		}
   412	}
   413	
   414	/**
   415	 * tlsh_poll - check for data ready on an AF_TLSH socket
   416	 * @file: file to check for work
   417	 * @sock: socket associated with @file
   418	 * @wait: poll table
   419	 *
   420	 * Return values:
   421	 *    A mask of flags indicating what type of I/O is ready
   422	 */
   423	static __poll_t tlsh_poll(struct file *file, struct socket *sock,
   424				  poll_table *wait)
   425	{
   426		struct sock *sk = sock->sk;
   427		__poll_t revents;
   428	
   429		sock_poll_wait(file, sock, wait);
   430	
   431		revents = 0;
   432	
   433		if (sk->sk_err)
   434			revents |= EPOLLERR;
   435	
   436		if (sk->sk_shutdown == SHUTDOWN_MASK)
   437			revents |= EPOLLHUP;
   438		if (sk->sk_type == SOCK_STREAM && sk->sk_state == TCP_CLOSE)
   439			revents |= EPOLLHUP;
   440	
   441		if (sk->sk_shutdown & RCV_SHUTDOWN)
   442			revents |= EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
   443		if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
   444			revents |= EPOLLIN | EPOLLRDNORM;
   445		if (sk_is_readable(sk))
   446			revents |= EPOLLIN | EPOLLRDNORM;
   447	
   448		return revents;
   449	}
   450	
   451	/**
   452	 * tlsh_listen - move a PF_TLSH socket into a listening state
   453	 * @sock: socket to transition to listening state
   454	 * @backlog: size of backlog queue
   455	 *
   456	 * Return values:
   457	 *   %0: @sock is now in a listening state
   458	 *   %-EPERM: caller is not privileged
   459	 *   %-EINVAL: invalid parameters
   460	 */
   461	static int tlsh_listen(struct socket *sock, int backlog)
   462	{
   463		struct sock *sk = sock->sk;
   464		unsigned char old_state;
   465		int rc;
   466	
   467		if (!capable(CAP_NET_BIND_SERVICE))
   468			return -EPERM;
   469	
   470		lock_sock(sk);
   471	
   472		rc = -EINVAL;
   473		if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
   474			goto out;
   475		old_state = sk->sk_state;
   476		if (!((1 << old_state) & (TCPF_CLOSE | TCPF_LISTEN)))
   477			goto out;
   478	
   479		sk->sk_max_ack_backlog = backlog;
   480		sk->sk_state = TCP_LISTEN;
   481		tlsh_register_listener(sk);
   482	
   483		rc = 0;
   484	
   485	out:
   486		release_sock(sk);
   487		return rc;
   488	}
   489	
   490	/**
   491	 * tlsh_setsockopt - Set a socket option
   492	 * @sock: socket to act upon
   493	 * @level: which network layer to act upon
   494	 * @optname: which option to set
   495	 * @optval: new value to set
   496	 * @optlen: the size of the new value, in bytes
   497	 *
   498	 * Return values:
   499	 *   %0: Success
   500	 */
   501	static int tlsh_setsockopt(struct socket *sock, int level, int optname,
   502				   sockptr_t optval, unsigned int optlen)
   503	{
   504		struct sock *sk = sock->sk;
   505	
   506		switch (sk->sk_family) {
   507		case AF_INET:
   508	#if IS_ENABLED(CONFIG_IPV6)
   509		case AF_INET6:
   510	#endif
   511			return sock_common_setsockopt(sock, level,
   512						      optname, optval, optlen);
   513		default:
   514			return -EINVAL;
   515		}
   516	}
   517	
   518	/**
   519	 * tlsh_getsockopt - Retrieve a socket option
   520	 * @sock: socket to act upon
   521	 * @level: which network layer to act upon
   522	 * @optname: which option to retrieve
   523	 * @optval: a buffer into which to receive the option's value
   524	 * @optlen: the size of the receive buffer, in bytes
   525	 *
   526	 * Return values:
   527	 *   %0: Success
   528	 */
   529	static int tlsh_getsockopt(struct socket *sock, int level, int optname,
   530				   char __user *optval, int __user *optlen)
   531	{
   532		struct sock *sk = sock->sk;
   533	
   534		switch (sk->sk_family) {
   535		case AF_INET:
   536	#if IS_ENABLED(CONFIG_IPV6)
   537		case AF_INET6:
   538	#endif
   539			return sock_common_getsockopt(sock, level,
   540						      optname, optval, optlen);
   541		default:
   542			return -EINVAL;
   543		}
   544	}
   545	
   546	/**
   547	 * tlsh_sendmsg - Send a message on a socket
   548	 * @sock: socket to send on
   549	 * @msg: message to send
   550	 * @size: size of message, in bytes
   551	 *
   552	 * Return values:
   553	 *   %0: Success
   554	 *   %-EOPNOTSUPP: Address family does not support this operation
   555	 */
   556	static int tlsh_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
   557	{
   558		struct sock *sk = sock->sk;
   559	
   560		switch (sk->sk_family) {
   561		case AF_INET:
   562			return inet_sendmsg(sock, msg, size);
   563	#if IS_ENABLED(CONFIG_IPV6)
   564		case AF_INET6:
 > 565			return inet6_sendmsg(sock, msg, size);
   566	#endif
   567		default:
   568			return -EOPNOTSUPP;
   569		}
   570	}
   571	
   572	/**
   573	 * tlsh_recvmsg - Receive a message from a socket
   574	 * @sock: socket to receive from
   575	 * @msg: buffer into which to receive
   576	 * @size: size of buffer, in bytes
   577	 * @flags: control settings
   578	 *
   579	 * Return values:
   580	 *   %0: Success
   581	 *   %-EOPNOTSUPP: Address family does not support this operation
   582	 */
   583	static int tlsh_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
   584				int flags)
   585	{
   586		struct sock *sk = sock->sk;
   587	
   588		switch (sk->sk_family) {
   589		case AF_INET:
   590			return inet_recvmsg(sock, msg, size, flags);
   591	#if IS_ENABLED(CONFIG_IPV6)
   592		case AF_INET6:
 > 593			return inet6_recvmsg(sock, msg, size, flags);
   594	#endif
   595		default:
   596			return -EOPNOTSUPP;
   597		}
   598	}
   599	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

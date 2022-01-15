Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E20F48F58A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 08:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiAOHBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 02:01:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:29300 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbiAOHBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 02:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642230108; x=1673766108;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MsVlmb6sMEko7CgHp/gswWUg82vSxHuBTFkweYo9oFQ=;
  b=EVEdQcqSzefhTKHInclOzEgAUFzr/jd+YOD3u/9jAWSRWgMhrMgaBAyn
   XMuepz/HyUVlYD8S7YghwbsttxTS8tIDJzubl5Ty+FBVkFpJPrj/DhDLy
   A3Atmlg7EiwAdCJJ5PY+nDdrtTi5sHJVnyAIhL0XduJu33JLiDWKJj5iK
   SBjn3HYcZEudJHMceJVXRv6lzhOaiI5X9EKdCPSr/3718pZ5HGV0riBPY
   1jLfaJN59deCWiSaALgbXlnzVWt16D9ahMdZUUg42XKDDNPYv7XmWDezx
   ZeVZV/IKNX/UJOOUjMC/LH+VVZfrn7lakWOaztAN8zLR+9epUm6ELvoAy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="231736716"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="231736716"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 23:01:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="624591999"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Jan 2022 23:01:47 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8d4M-0009UD-As; Sat, 15 Jan 2022 07:01:46 +0000
Date:   Sat, 15 Jan 2022 15:00:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [cel:topic-rpc-with-tls-upcall 15/18] net/tls/af_tlsh.c:506:
 undefined reference to `inet6_recvmsg'
Message-ID: <202201151407.neTGwaOK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls-upcall
head:   efd60be1122b3ae06572c5cfbe440970ea1fbb3d
commit: dc7c282f13f7d10eb5343d5d9fd2fcaa647ce216 [15/18] net/tls: Add support for PF_TLSH (a TLS handshake listener)
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220115/202201151407.neTGwaOK-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=dc7c282f13f7d10eb5343d5d9fd2fcaa647ce216
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls-upcall
        git checkout dc7c282f13f7d10eb5343d5d9fd2fcaa647ce216
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/tls/af_tlsh.o: in function `tlsh_recvmsg':
>> net/tls/af_tlsh.c:506: undefined reference to `inet6_recvmsg'
   ld: net/tls/af_tlsh.o: in function `tlsh_sendmsg':
>> net/tls/af_tlsh.c:476: undefined reference to `inet6_sendmsg'
   ld: net/tls/af_tlsh.o: in function `tlsh_getname':
>> net/tls/af_tlsh.c:316: undefined reference to `inet6_getname'


vim +506 net/tls/af_tlsh.c

   296	
   297	/**
   298	 * tlsh_getname - retrieve src/dst address information
   299	 * @sock: socket to query
   300	 * @uaddr: buffer to fill in
   301	 * @peer: value indicates which address to retrieve
   302	 *
   303	 * Return values:
   304	 *   On success, a positive length of the address in @uaddr
   305	 *   On error, a negative errno
   306	 */
   307	static int tlsh_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
   308	{
   309		struct sock *sk = sock->sk;
   310	
   311		switch (sk->sk_family) {
   312		case AF_INET:
   313			return inet_getname(sock, uaddr, peer);
   314	#if IS_ENABLED(CONFIG_IPV6)
   315		case AF_INET6:
 > 316			return inet6_getname(sock, uaddr, peer);
   317	#endif
   318		default:
   319			return -EOPNOTSUPP;
   320		}
   321	}
   322	
   323	/**
   324	 * tlsh_poll - check for data ready on an AF_TLSH socket
   325	 * @file: file to check for work
   326	 * @sock: socket associated with @file
   327	 * @wait: poll table
   328	 *
   329	 * Return values:
   330	 *    A mask of flags indicating what type of I/O is ready
   331	 */
   332	static __poll_t tlsh_poll(struct file *file, struct socket *sock,
   333				  poll_table *wait)
   334	{
   335		struct sock *sk = sock->sk;
   336		__poll_t revents;
   337	
   338		sock_poll_wait(file, sock, wait);
   339	
   340		revents = 0;
   341	
   342		if (sk->sk_err)
   343			revents |= EPOLLERR;
   344	
   345		if (sk->sk_shutdown == SHUTDOWN_MASK)
   346			revents |= EPOLLHUP;
   347		if (sk->sk_type == SOCK_STREAM && sk->sk_state == TCP_CLOSE)
   348			revents |= EPOLLHUP;
   349	
   350		if (sk->sk_shutdown & RCV_SHUTDOWN)
   351			revents |= EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
   352		if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
   353			revents |= EPOLLIN | EPOLLRDNORM;
   354		if (sk_is_readable(sk))
   355			revents |= EPOLLIN | EPOLLRDNORM;
   356	
   357		return revents;
   358	}
   359	
   360	/**
   361	 * tlsh_listen - move a PF_TLSH socket into a listening state
   362	 * @sock: socket to transition to listening state
   363	 * @backlog: size of backlog queue
   364	 *
   365	 * Return values:
   366	 *   %0: @sock is now in a listening state
   367	 *   %-EPERM: caller is not privileged
   368	 *   %-EINVAL: invalid parameters
   369	 */
   370	static int tlsh_listen(struct socket *sock, int backlog)
   371	{
   372		struct sock *sk = sock->sk;
   373		unsigned char old_state;
   374		int rc;
   375	
   376		if (!capable(CAP_NET_BIND_SERVICE))
   377			return -EPERM;
   378	
   379		lock_sock(sk);
   380	
   381		rc = -EINVAL;
   382		if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
   383			goto out;
   384		old_state = sk->sk_state;
   385		if (!((1 << old_state) & (TCPF_CLOSE | TCPF_LISTEN)))
   386			goto out;
   387	
   388		sk->sk_max_ack_backlog = backlog;
   389		sk->sk_state = TCP_LISTEN;
   390		tlsh_register_listener(sk);
   391	
   392		rc = 0;
   393	
   394	out:
   395		release_sock(sk);
   396		return rc;
   397	}
   398	
   399	/**
   400	 * tlsh_setsockopt - Set a socket option
   401	 * @sock: socket to act upon
   402	 * @level: which network layer to act upon
   403	 * @optname: which option to set
   404	 * @optval: new value to set
   405	 * @optlen: the size of the new value, in bytes
   406	 *
   407	 * Return values:
   408	 *   %0: Success
   409	 */
   410	static int tlsh_setsockopt(struct socket *sock, int level, int optname,
   411				   sockptr_t optval, unsigned int optlen)
   412	{
   413		struct sock *sk = sock->sk;
   414	
   415		switch (sk->sk_family) {
   416		case AF_INET:
   417	#if IS_ENABLED(CONFIG_IPV6)
   418		case AF_INET6:
   419	#endif
   420			return sock_common_setsockopt(sock, level,
   421						      optname, optval, optlen);
   422		default:
   423			return -EINVAL;
   424		}
   425	}
   426	
   427	/**
   428	 * tlsh_getsockopt - Retrieve a socket option
   429	 * @sock: socket to act upon
   430	 * @level: which network layer to act upon
   431	 * @optname: which option to retrieve
   432	 * @optval: a buffer into which to receive the option's value
   433	 * @optlen: the size of the receive buffer, in bytes
   434	 *
   435	 * Return values:
   436	 *   %0: Success
   437	 */
   438	static int tlsh_getsockopt(struct socket *sock, int level, int optname,
   439				   char __user *optval, int __user *optlen)
   440	{
   441		struct sock *sk = sock->sk;
   442	
   443		switch (sk->sk_family) {
   444		case AF_INET:
   445	#if IS_ENABLED(CONFIG_IPV6)
   446		case AF_INET6:
   447	#endif
   448			return sock_common_getsockopt(sock, level,
   449						      optname, optval, optlen);
   450		default:
   451			return -EINVAL;
   452		}
   453	}
   454	
   455	/**
   456	 * tlsh_sendmsg - Send a message on a socket
   457	 * @sock: socket to send on
   458	 * @msg: message to send
   459	 * @size: size of message, in bytes
   460	 *
   461	 * Return values:
   462	 *   %0: Success
   463	 *   %-EOPNOTSUPP: Address family does not support this operation
   464	 */
   465	static int tlsh_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
   466	{
   467		struct sock *sk = sock->sk;
   468	
   469		trace_printk("sk=%p family=%u\n", sk, sk->sk_family);
   470	
   471		switch (sk->sk_family) {
   472		case AF_INET:
   473			return inet_sendmsg(sock, msg, size);
   474	#if IS_ENABLED(CONFIG_IPV6)
   475		case AF_INET6:
 > 476			return inet6_sendmsg(sock, msg, size);
   477	#endif
   478		default:
   479			return -EOPNOTSUPP;
   480		}
   481	}
   482	
   483	/**
   484	 * tlsh_recvmsg - Receive a message from a socket
   485	 * @sock: socket to receive from
   486	 * @msg: buffer into which to receive
   487	 * @size: size of buffer, in bytes
   488	 * @flags: control settings
   489	 *
   490	 * Return values:
   491	 *   %0: Success
   492	 *   %-EOPNOTSUPP: Address family does not support this operation
   493	 */
   494	static int tlsh_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
   495				int flags)
   496	{
   497		struct sock *sk = sock->sk;
   498	
   499		trace_printk("sk=%p family=%u\n", sk, sk->sk_family);
   500	
   501		switch (sk->sk_family) {
   502		case AF_INET:
   503			return inet_recvmsg(sock, msg, size, flags);
   504	#if IS_ENABLED(CONFIG_IPV6)
   505		case AF_INET6:
 > 506			return inet6_recvmsg(sock, msg, size, flags);
   507	#endif
   508		default:
   509			return -EOPNOTSUPP;
   510		}
   511	}
   512	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

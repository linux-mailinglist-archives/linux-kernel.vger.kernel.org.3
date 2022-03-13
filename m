Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD684D75E5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 15:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbiCMOhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 10:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiCMOhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 10:37:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D1D7E583
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647182160; x=1678718160;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xowV+94AKlePEPfVcZV+VxLoVWYZ92R6m7A/HpWh13s=;
  b=l4UiQTfT8vW2WEfhkgJ8wl7wg23L5j29P4x0DQAlHenXkJB2S8ysUMoM
   mK8fbd0uAubxkV/Jc5Ei8sz5p0PKrA7z/nrVfNq2CFaW13+80sF4nZYWH
   E1up15UXNrMuOPOsQU4y49jDEyW5J15h1JVNKdnyuxttNsRPIFHhmnOS5
   OKcVP5stpAPbZdN6DjIt1qCm0uftj9PNANuKgNNbiO/KfPsR58wR9XcNV
   e2ZuMGUl7YPZJeJWi5m7zokYtc/7pC9IZMnWNFgkv2jhgtAnUV4cvHf+U
   IoH2s6zbNGqpEpstho6vcae6FFIDbDbbmsJQ1sUJA+mRSTmYkpPhTiCz/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="238046042"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="238046042"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 07:36:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="511921507"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Mar 2022 07:35:58 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTPKA-00091d-4o; Sun, 13 Mar 2022 14:35:58 +0000
Date:   Sun, 13 Mar 2022 22:35:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [hare-scsi-devel:tls-upcall.v4 121/156] net/tls/af_tlsh.c:452:
 undefined reference to `inet6_getname'
Message-ID: <202203132205.eE6eTsBS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v4
head:   d2416ecdb6b03fc2e4aa40b20cdf919322713224
commit: 33ec82590b0b919215a255fb431d661be4807b45 [121/156] net/tls: Add support for PF_TLSH (a TLS handshake listener)
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220313/202203132205.eE6eTsBS-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=33ec82590b0b919215a255fb431d661be4807b45
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v4
        git checkout 33ec82590b0b919215a255fb431d661be4807b45
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/tls/af_tlsh.o: in function `tlsh_getname':
>> net/tls/af_tlsh.c:452: undefined reference to `inet6_getname'
   ld: net/tls/af_tlsh.o: in function `tlsh_release':
>> net/tls/af_tlsh.c:283: undefined reference to `inet6_release'


vim +452 net/tls/af_tlsh.c

   259	
   260	/**
   261	 * tlsh_release - free an AF_TLSH socket
   262	 * @sock: socket to release
   263	 *
   264	 * Return values:
   265	 *   %0: success
   266	 */
   267	static int tlsh_release(struct socket *sock)
   268	{
   269		struct sock *sk = sock->sk;
   270		struct tlsh_sock *tsk = tlsh_sk(sk);
   271	
   272		if (!sk)
   273			return 0;
   274	
   275		switch (sk->sk_family) {
   276		case AF_INET:
   277			if (!tlsh_handshake_done(sk))
   278				return inet_release(sock);
   279			return 0;
   280	#if IS_ENABLED(CONFIG_IPV6)
   281		case AF_INET6:
   282			if (!tlsh_handshake_done(sk))
 > 283				return inet6_release(sock);
   284			return 0;
   285	#endif
   286		case AF_TLSH:
   287			break;
   288		default:
   289			return 0;
   290		}
   291	
   292		sock_hold(sk);	/* Ref: D */
   293		sock_orphan(sk);
   294		lock_sock(sk);
   295	
   296		tlsh_unregister_listener(sk);
   297		tlsh_accept_drain(sk);
   298	
   299		sk->sk_state = TCP_CLOSE;
   300		sk->sk_shutdown |= SEND_SHUTDOWN;
   301		sk->sk_state_change(sk);
   302	
   303		tsk->th_bind_family = AF_UNSPEC;
   304		sock->sk = NULL;
   305		release_sock(sk);
   306		sock_put(sk);	/* Ref: D */
   307	
   308		sock_put(sk);	/* Ref: A */
   309		return 0;
   310	}
   311	
   312	/**
   313	 * tlsh_bind - bind a name to an AF_TLSH socket
   314	 * @sock: socket to be bound
   315	 * @uaddr: address to bind to
   316	 * @addrlen: length in bytes of @uaddr
   317	 *
   318	 * Binding an AF_TLSH socket defines the family of addresses that
   319	 * are able to be accept(2)'d. So, AF_INET for ipv4, AF_INET6 for
   320	 * ipv6.
   321	 *
   322	 * Return values:
   323	 *   %0: binding was successful.
   324	 *   %-EPERM: Caller not privileged
   325	 *   %-EINVAL: Family of @sock or @uaddr not supported
   326	 */
   327	static int tlsh_bind(struct socket *sock, struct sockaddr *uaddr, int addrlen)
   328	{
   329		struct sock *listener, *sk = sock->sk;
   330		struct tlsh_sock *tsk = tlsh_sk(sk);
   331	
   332		if (!capable(CAP_NET_BIND_SERVICE))
   333			return -EPERM;
   334	
   335		switch (uaddr->sa_family) {
   336		case AF_INET:
   337			if (addrlen != sizeof(struct sockaddr_in))
   338				return -EINVAL;
   339			break;
   340	#if IS_ENABLED(CONFIG_IPV6)
   341		case AF_INET6:
   342			if (addrlen != sizeof(struct sockaddr_in6))
   343				return -EINVAL;
   344			break;
   345	#endif
   346		default:
   347			return -EAFNOSUPPORT;
   348		}
   349	
   350		listener = tlsh_find_listener(sock_net(sk), uaddr->sa_family);
   351		if (listener) {
   352			sock_put(listener);	/* Ref: C */
   353			return -EADDRINUSE;
   354		}
   355	
   356		tsk->th_bind_family = uaddr->sa_family;
   357		return 0;
   358	}
   359	
   360	/**
   361	 * tlsh_accept - return a connection waiting for a TLS handshake
   362	 * @listener: listener socket which connection requests arrive on
   363	 * @newsock: socket to move incoming connection to
   364	 * @flags: SOCK_NONBLOCK and/or SOCK_CLOEXEC
   365	 * @kern: "boolean": 1 for kernel-internal sockets
   366	 *
   367	 * Return values:
   368	 *   %0: @newsock has been initialized.
   369	 *   %-EPERM: caller is not privileged
   370	 */
   371	static int tlsh_accept(struct socket *listener, struct socket *newsock, int flags,
   372			       bool kern)
   373	{
   374		struct sock *sk = listener->sk, *newsk;
   375		DECLARE_WAITQUEUE(wait, current);
   376		long timeo;
   377		int rc;
   378	
   379		rc = -EPERM;
   380		if (!capable(CAP_NET_BIND_SERVICE))
   381			goto out;
   382	
   383		lock_sock(sk);
   384	
   385		if (sk->sk_state != TCP_LISTEN) {
   386			rc = -EBADF;
   387			goto out_release;
   388		}
   389	
   390		timeo = sock_rcvtimeo(sk, flags & O_NONBLOCK);
   391	
   392		rc = 0;
   393		add_wait_queue_exclusive(sk_sleep(sk), &wait);
   394		while (!(newsk = tlsh_accept_dequeue(sk))) {
   395			set_current_state(TASK_INTERRUPTIBLE);
   396			if (!timeo) {
   397				rc = -EAGAIN;
   398				break;
   399			}
   400			release_sock(sk);
   401	
   402			timeo = schedule_timeout(timeo);
   403	
   404			lock_sock(sk);
   405			if (sk->sk_state != TCP_LISTEN) {
   406				rc = -EBADF;
   407				break;
   408			}
   409			if (signal_pending(current)) {
   410				rc = sock_intr_errno(timeo);
   411				break;
   412			}
   413		}
   414		set_current_state(TASK_RUNNING);
   415		remove_wait_queue(sk_sleep(sk), &wait);
   416		if (rc) {
   417			tlsh_handshake_done(sk);
   418			goto out_release;
   419		}
   420	
   421		sock_graft(newsk, newsock);
   422	
   423		/* prevent user agent close from releasing the kernel socket */
   424		__module_get(THIS_MODULE);
   425		sock_hold(newsk);
   426	
   427	out_release:
   428		release_sock(sk);
   429	out:
   430		return rc;
   431	}
   432	
   433	/**
   434	 * tlsh_getname - retrieve src/dst address information from an AF_TLSH socket
   435	 * @sock: socket to query
   436	 * @uaddr: buffer to fill in
   437	 * @peer: value indicates which address to retrieve
   438	 *
   439	 * Return values:
   440	 *   On success, a positive length of the address in @uaddr
   441	 *   On error, a negative errno
   442	 */
   443	static int tlsh_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
   444	{
   445		struct sock *sk = sock->sk;
   446	
   447		switch (sk->sk_family) {
   448		case AF_INET:
   449			return inet_getname(sock, uaddr, peer);
   450	#if IS_ENABLED(CONFIG_IPV6)
   451		case AF_INET6:
 > 452			return inet6_getname(sock, uaddr, peer);
   453	#endif
   454		default:
   455			return -EOPNOTSUPP;
   456		}
   457	}
   458	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

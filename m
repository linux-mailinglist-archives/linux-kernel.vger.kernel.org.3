Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2D753C27D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbiFCBC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 21:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241449AbiFCBAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 21:00:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE47366B5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654217938; x=1685753938;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u42lKPtUeB0K407xW0tJS4iap7ZMWvirw3F/XDcA9Ss=;
  b=mhdxKPZY1qA0Nce8EmCVLeYY96pxLaIayE55Op430Gd7ErLvycLB6KdZ
   yLmTk3Xz9kECcqqbECn6z9Qg+fqw6doBgD0APKjwAod/2PvBGwKXHhmCQ
   ROU8DVeLT1eXTIyL0h7j/0ibrlW+EVyof+dNjulysbPUdmz+GD411mVE/
   GXsFMYJ7k8l+s0uWSF8kC6cHsgzPnIh8C3452YqoRur00IBJzkwhwqpl+
   KfXJa/OeGXtuHHOT2WWSfKD7cmECpPHB12H3yVhACpB/jl/BKzQPWkgP4
   GFTPnalN54kXChYph7052c2+rE4o7oJQT9iIA1fJYi17E1ylzQUo7uIBA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="256609294"
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="256609294"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 17:58:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="613070757"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Jun 2022 17:58:56 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwveR-0005ZO-Ey;
        Fri, 03 Jun 2022 00:58:55 +0000
Date:   Fri, 3 Jun 2022 08:58:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <cong.wang@bytedance.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [congwang:sk_data_ready 6/7] drivers/nvme/target/tcp.c:1421:26:
 error: incompatible function pointer types assigning to 'int (*)(struct sock
 *)' from 'void (*)(struct sock *)'
Message-ID: <202206030832.d2KKiNDN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/congwang/linux.git sk_data_ready
head:   9c95f9de643d020bc671ae23c5723d811d6f11f7
commit: 55e436c5d3f795345e5b0d946f98fa64540c496e [6/7] net: make ->sk_data_ready() return int
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220603/202206030832.d2KKiNDN-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364c76683f8ef241025a9556300778c07b590c2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/congwang/linux/commit/55e436c5d3f795345e5b0d946f98fa64540c496e
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang sk_data_ready
        git checkout 55e436c5d3f795345e5b0d946f98fa64540c496e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/nvme/target/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/nvme/target/tcp.c:1421:26: error: incompatible function pointer types assigning to 'int (*)(struct sock *)' from 'void (*)(struct sock *)' [-Werror,-Wincompatible-function-pointer-types]
           sock->sk->sk_data_ready =  queue->data_ready;
                                   ^  ~~~~~~~~~~~~~~~~~
>> drivers/nvme/target/tcp.c:1581:21: error: incompatible function pointer types assigning to 'void (*)(struct sock *)' from 'int (*)(struct sock *)' [-Werror,-Wincompatible-function-pointer-types]
                   queue->data_ready = sock->sk->sk_data_ready;
                                     ^ ~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/target/tcp.c:1739:19: error: incompatible function pointer types assigning to 'void (*)(struct sock *)' from 'int (*)(struct sock *)' [-Werror,-Wincompatible-function-pointer-types]
           port->data_ready = port->sock->sk->sk_data_ready;
                            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/target/tcp.c:1788:32: error: incompatible function pointer types assigning to 'int (*)(struct sock *)' from 'void (*)(struct sock *)' [-Werror,-Wincompatible-function-pointer-types]
           port->sock->sk->sk_data_ready = port->data_ready;
                                         ^ ~~~~~~~~~~~~~~~~
   4 errors generated.


vim +1421 drivers/nvme/target/tcp.c

872d26a391da92 Sagi Grimberg     2018-12-03  1415  
872d26a391da92 Sagi Grimberg     2018-12-03  1416  static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
872d26a391da92 Sagi Grimberg     2018-12-03  1417  {
872d26a391da92 Sagi Grimberg     2018-12-03  1418  	struct socket *sock = queue->sock;
872d26a391da92 Sagi Grimberg     2018-12-03  1419  
872d26a391da92 Sagi Grimberg     2018-12-03  1420  	write_lock_bh(&sock->sk->sk_callback_lock);
872d26a391da92 Sagi Grimberg     2018-12-03 @1421  	sock->sk->sk_data_ready =  queue->data_ready;
872d26a391da92 Sagi Grimberg     2018-12-03  1422  	sock->sk->sk_state_change = queue->state_change;
872d26a391da92 Sagi Grimberg     2018-12-03  1423  	sock->sk->sk_write_space = queue->write_space;
872d26a391da92 Sagi Grimberg     2018-12-03  1424  	sock->sk->sk_user_data = NULL;
872d26a391da92 Sagi Grimberg     2018-12-03  1425  	write_unlock_bh(&sock->sk->sk_callback_lock);
872d26a391da92 Sagi Grimberg     2018-12-03  1426  }
872d26a391da92 Sagi Grimberg     2018-12-03  1427  
872d26a391da92 Sagi Grimberg     2018-12-03  1428  static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
872d26a391da92 Sagi Grimberg     2018-12-03  1429  {
872d26a391da92 Sagi Grimberg     2018-12-03  1430  	nvmet_req_uninit(&cmd->req);
872d26a391da92 Sagi Grimberg     2018-12-03  1431  	nvmet_tcp_unmap_pdu_iovec(cmd);
69b85e1f1d1d1e Maurizio Lombardi 2021-11-16  1432  	nvmet_tcp_free_cmd_buffers(cmd);
872d26a391da92 Sagi Grimberg     2018-12-03  1433  }
872d26a391da92 Sagi Grimberg     2018-12-03  1434  
872d26a391da92 Sagi Grimberg     2018-12-03  1435  static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
872d26a391da92 Sagi Grimberg     2018-12-03  1436  {
872d26a391da92 Sagi Grimberg     2018-12-03  1437  	struct nvmet_tcp_cmd *cmd = queue->cmds;
872d26a391da92 Sagi Grimberg     2018-12-03  1438  	int i;
872d26a391da92 Sagi Grimberg     2018-12-03  1439  
872d26a391da92 Sagi Grimberg     2018-12-03  1440  	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
872d26a391da92 Sagi Grimberg     2018-12-03  1441  		if (nvmet_tcp_need_data_in(cmd))
af21250bb503a0 Maurizio Lombardi 2021-11-16  1442  			nvmet_req_uninit(&cmd->req);
af21250bb503a0 Maurizio Lombardi 2021-11-16  1443  
af21250bb503a0 Maurizio Lombardi 2021-11-16  1444  		nvmet_tcp_unmap_pdu_iovec(cmd);
af21250bb503a0 Maurizio Lombardi 2021-11-16  1445  		nvmet_tcp_free_cmd_buffers(cmd);
872d26a391da92 Sagi Grimberg     2018-12-03  1446  	}
872d26a391da92 Sagi Grimberg     2018-12-03  1447  
872d26a391da92 Sagi Grimberg     2018-12-03  1448  	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
872d26a391da92 Sagi Grimberg     2018-12-03  1449  		/* failed in connect */
872d26a391da92 Sagi Grimberg     2018-12-03  1450  		nvmet_tcp_finish_cmd(&queue->connect);
872d26a391da92 Sagi Grimberg     2018-12-03  1451  	}
872d26a391da92 Sagi Grimberg     2018-12-03  1452  }
872d26a391da92 Sagi Grimberg     2018-12-03  1453  
872d26a391da92 Sagi Grimberg     2018-12-03  1454  static void nvmet_tcp_release_queue_work(struct work_struct *w)
872d26a391da92 Sagi Grimberg     2018-12-03  1455  {
926245c7d22271 Maurizio Lombardi 2021-10-15  1456  	struct page *page;
872d26a391da92 Sagi Grimberg     2018-12-03  1457  	struct nvmet_tcp_queue *queue =
872d26a391da92 Sagi Grimberg     2018-12-03  1458  		container_of(w, struct nvmet_tcp_queue, release_work);
872d26a391da92 Sagi Grimberg     2018-12-03  1459  
872d26a391da92 Sagi Grimberg     2018-12-03  1460  	mutex_lock(&nvmet_tcp_queue_mutex);
872d26a391da92 Sagi Grimberg     2018-12-03  1461  	list_del_init(&queue->queue_list);
872d26a391da92 Sagi Grimberg     2018-12-03  1462  	mutex_unlock(&nvmet_tcp_queue_mutex);
872d26a391da92 Sagi Grimberg     2018-12-03  1463  
872d26a391da92 Sagi Grimberg     2018-12-03  1464  	nvmet_tcp_restore_socket_callbacks(queue);
a208fc56721775 Maurizio Lombardi 2021-11-16  1465  	cancel_work_sync(&queue->io_work);
a208fc56721775 Maurizio Lombardi 2021-11-16  1466  	/* stop accepting incoming data */
a208fc56721775 Maurizio Lombardi 2021-11-16  1467  	queue->rcv_state = NVMET_TCP_RECV_ERR;
872d26a391da92 Sagi Grimberg     2018-12-03  1468  
872d26a391da92 Sagi Grimberg     2018-12-03  1469  	nvmet_tcp_uninit_data_in_cmds(queue);
872d26a391da92 Sagi Grimberg     2018-12-03  1470  	nvmet_sq_destroy(&queue->nvme_sq);
872d26a391da92 Sagi Grimberg     2018-12-03  1471  	cancel_work_sync(&queue->io_work);
872d26a391da92 Sagi Grimberg     2018-12-03  1472  	sock_release(queue->sock);
872d26a391da92 Sagi Grimberg     2018-12-03  1473  	nvmet_tcp_free_cmds(queue);
872d26a391da92 Sagi Grimberg     2018-12-03  1474  	if (queue->hdr_digest || queue->data_digest)
872d26a391da92 Sagi Grimberg     2018-12-03  1475  		nvmet_tcp_free_crypto(queue);
44f331a630bdc7 Sagi Grimberg     2022-02-14  1476  	ida_free(&nvmet_tcp_queue_ida, queue->idx);
872d26a391da92 Sagi Grimberg     2018-12-03  1477  
926245c7d22271 Maurizio Lombardi 2021-10-15  1478  	page = virt_to_head_page(queue->pf_cache.va);
926245c7d22271 Maurizio Lombardi 2021-10-15  1479  	__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
872d26a391da92 Sagi Grimberg     2018-12-03  1480  	kfree(queue);
872d26a391da92 Sagi Grimberg     2018-12-03  1481  }
872d26a391da92 Sagi Grimberg     2018-12-03  1482  
55e436c5d3f795 Cong Wang         2022-05-02  1483  static int nvmet_tcp_data_ready(struct sock *sk)
872d26a391da92 Sagi Grimberg     2018-12-03  1484  {
872d26a391da92 Sagi Grimberg     2018-12-03  1485  	struct nvmet_tcp_queue *queue;
872d26a391da92 Sagi Grimberg     2018-12-03  1486  
872d26a391da92 Sagi Grimberg     2018-12-03  1487  	read_lock_bh(&sk->sk_callback_lock);
872d26a391da92 Sagi Grimberg     2018-12-03  1488  	queue = sk->sk_user_data;
872d26a391da92 Sagi Grimberg     2018-12-03  1489  	if (likely(queue))
f7790e5de92a3b Mark Wunderlich   2020-08-28  1490  		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
872d26a391da92 Sagi Grimberg     2018-12-03  1491  	read_unlock_bh(&sk->sk_callback_lock);
55e436c5d3f795 Cong Wang         2022-05-02  1492  	return 0;
872d26a391da92 Sagi Grimberg     2018-12-03  1493  }
872d26a391da92 Sagi Grimberg     2018-12-03  1494  
872d26a391da92 Sagi Grimberg     2018-12-03  1495  static void nvmet_tcp_write_space(struct sock *sk)
872d26a391da92 Sagi Grimberg     2018-12-03  1496  {
872d26a391da92 Sagi Grimberg     2018-12-03  1497  	struct nvmet_tcp_queue *queue;
872d26a391da92 Sagi Grimberg     2018-12-03  1498  
872d26a391da92 Sagi Grimberg     2018-12-03  1499  	read_lock_bh(&sk->sk_callback_lock);
872d26a391da92 Sagi Grimberg     2018-12-03  1500  	queue = sk->sk_user_data;
872d26a391da92 Sagi Grimberg     2018-12-03  1501  	if (unlikely(!queue))
872d26a391da92 Sagi Grimberg     2018-12-03  1502  		goto out;
872d26a391da92 Sagi Grimberg     2018-12-03  1503  
872d26a391da92 Sagi Grimberg     2018-12-03  1504  	if (unlikely(queue->state == NVMET_TCP_Q_CONNECTING)) {
872d26a391da92 Sagi Grimberg     2018-12-03  1505  		queue->write_space(sk);
872d26a391da92 Sagi Grimberg     2018-12-03  1506  		goto out;
872d26a391da92 Sagi Grimberg     2018-12-03  1507  	}
872d26a391da92 Sagi Grimberg     2018-12-03  1508  
872d26a391da92 Sagi Grimberg     2018-12-03  1509  	if (sk_stream_is_writeable(sk)) {
872d26a391da92 Sagi Grimberg     2018-12-03  1510  		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
f7790e5de92a3b Mark Wunderlich   2020-08-28  1511  		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
872d26a391da92 Sagi Grimberg     2018-12-03  1512  	}
872d26a391da92 Sagi Grimberg     2018-12-03  1513  out:
872d26a391da92 Sagi Grimberg     2018-12-03  1514  	read_unlock_bh(&sk->sk_callback_lock);
872d26a391da92 Sagi Grimberg     2018-12-03  1515  }
872d26a391da92 Sagi Grimberg     2018-12-03  1516  
872d26a391da92 Sagi Grimberg     2018-12-03  1517  static void nvmet_tcp_state_change(struct sock *sk)
872d26a391da92 Sagi Grimberg     2018-12-03  1518  {
872d26a391da92 Sagi Grimberg     2018-12-03  1519  	struct nvmet_tcp_queue *queue;
872d26a391da92 Sagi Grimberg     2018-12-03  1520  
b5332a9f3f3d88 Sagi Grimberg     2021-03-21  1521  	read_lock_bh(&sk->sk_callback_lock);
872d26a391da92 Sagi Grimberg     2018-12-03  1522  	queue = sk->sk_user_data;
872d26a391da92 Sagi Grimberg     2018-12-03  1523  	if (!queue)
872d26a391da92 Sagi Grimberg     2018-12-03  1524  		goto done;
872d26a391da92 Sagi Grimberg     2018-12-03  1525  
872d26a391da92 Sagi Grimberg     2018-12-03  1526  	switch (sk->sk_state) {
872d26a391da92 Sagi Grimberg     2018-12-03  1527  	case TCP_FIN_WAIT1:
872d26a391da92 Sagi Grimberg     2018-12-03  1528  	case TCP_CLOSE_WAIT:
872d26a391da92 Sagi Grimberg     2018-12-03  1529  	case TCP_CLOSE:
872d26a391da92 Sagi Grimberg     2018-12-03  1530  		/* FALLTHRU */
872d26a391da92 Sagi Grimberg     2018-12-03  1531  		nvmet_tcp_schedule_release_queue(queue);
872d26a391da92 Sagi Grimberg     2018-12-03  1532  		break;
872d26a391da92 Sagi Grimberg     2018-12-03  1533  	default:
872d26a391da92 Sagi Grimberg     2018-12-03  1534  		pr_warn("queue %d unhandled state %d\n",
872d26a391da92 Sagi Grimberg     2018-12-03  1535  			queue->idx, sk->sk_state);
872d26a391da92 Sagi Grimberg     2018-12-03  1536  	}
872d26a391da92 Sagi Grimberg     2018-12-03  1537  done:
b5332a9f3f3d88 Sagi Grimberg     2021-03-21  1538  	read_unlock_bh(&sk->sk_callback_lock);
872d26a391da92 Sagi Grimberg     2018-12-03  1539  }
872d26a391da92 Sagi Grimberg     2018-12-03  1540  
872d26a391da92 Sagi Grimberg     2018-12-03  1541  static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
872d26a391da92 Sagi Grimberg     2018-12-03  1542  {
872d26a391da92 Sagi Grimberg     2018-12-03  1543  	struct socket *sock = queue->sock;
89275a9659fe57 Israel Rukshin    2019-08-18  1544  	struct inet_sock *inet = inet_sk(sock->sk);
872d26a391da92 Sagi Grimberg     2018-12-03  1545  	int ret;
872d26a391da92 Sagi Grimberg     2018-12-03  1546  
872d26a391da92 Sagi Grimberg     2018-12-03  1547  	ret = kernel_getsockname(sock,
872d26a391da92 Sagi Grimberg     2018-12-03  1548  		(struct sockaddr *)&queue->sockaddr);
872d26a391da92 Sagi Grimberg     2018-12-03  1549  	if (ret < 0)
872d26a391da92 Sagi Grimberg     2018-12-03  1550  		return ret;
872d26a391da92 Sagi Grimberg     2018-12-03  1551  
872d26a391da92 Sagi Grimberg     2018-12-03  1552  	ret = kernel_getpeername(sock,
872d26a391da92 Sagi Grimberg     2018-12-03  1553  		(struct sockaddr *)&queue->sockaddr_peer);
872d26a391da92 Sagi Grimberg     2018-12-03  1554  	if (ret < 0)
872d26a391da92 Sagi Grimberg     2018-12-03  1555  		return ret;
872d26a391da92 Sagi Grimberg     2018-12-03  1556  
872d26a391da92 Sagi Grimberg     2018-12-03  1557  	/*
872d26a391da92 Sagi Grimberg     2018-12-03  1558  	 * Cleanup whatever is sitting in the TCP transmit queue on socket
872d26a391da92 Sagi Grimberg     2018-12-03  1559  	 * close. This is done to prevent stale data from being sent should
872d26a391da92 Sagi Grimberg     2018-12-03  1560  	 * the network connection be restored before TCP times out.
872d26a391da92 Sagi Grimberg     2018-12-03  1561  	 */
c433594c07457d Christoph Hellwig 2020-05-28  1562  	sock_no_linger(sock->sk);
872d26a391da92 Sagi Grimberg     2018-12-03  1563  
6e43496745e75a Christoph Hellwig 2020-05-28  1564  	if (so_priority > 0)
6e43496745e75a Christoph Hellwig 2020-05-28  1565  		sock_set_priority(sock->sk, so_priority);
43cc66892e81bb Wunderlich, Mark  2020-01-16  1566  
89275a9659fe57 Israel Rukshin    2019-08-18  1567  	/* Set socket type of service */
6ebf71bab9fb47 Christoph Hellwig 2020-05-28  1568  	if (inet->rcv_tos > 0)
6ebf71bab9fb47 Christoph Hellwig 2020-05-28  1569  		ip_sock_set_tos(sock->sk, inet->rcv_tos);
89275a9659fe57 Israel Rukshin    2019-08-18  1570  
0fbcfb089a3f2f Sagi Grimberg     2021-02-05  1571  	ret = 0;
872d26a391da92 Sagi Grimberg     2018-12-03  1572  	write_lock_bh(&sock->sk->sk_callback_lock);
0fbcfb089a3f2f Sagi Grimberg     2021-02-05  1573  	if (sock->sk->sk_state != TCP_ESTABLISHED) {
0fbcfb089a3f2f Sagi Grimberg     2021-02-05  1574  		/*
0fbcfb089a3f2f Sagi Grimberg     2021-02-05  1575  		 * If the socket is already closing, don't even start
0fbcfb089a3f2f Sagi Grimberg     2021-02-05  1576  		 * consuming it
0fbcfb089a3f2f Sagi Grimberg     2021-02-05  1577  		 */
0fbcfb089a3f2f Sagi Grimberg     2021-02-05  1578  		ret = -ENOTCONN;
0fbcfb089a3f2f Sagi Grimberg     2021-02-05  1579  	} else {
872d26a391da92 Sagi Grimberg     2018-12-03  1580  		sock->sk->sk_user_data = queue;
872d26a391da92 Sagi Grimberg     2018-12-03 @1581  		queue->data_ready = sock->sk->sk_data_ready;
872d26a391da92 Sagi Grimberg     2018-12-03  1582  		sock->sk->sk_data_ready = nvmet_tcp_data_ready;
872d26a391da92 Sagi Grimberg     2018-12-03  1583  		queue->state_change = sock->sk->sk_state_change;
872d26a391da92 Sagi Grimberg     2018-12-03  1584  		sock->sk->sk_state_change = nvmet_tcp_state_change;
872d26a391da92 Sagi Grimberg     2018-12-03  1585  		queue->write_space = sock->sk->sk_write_space;
872d26a391da92 Sagi Grimberg     2018-12-03  1586  		sock->sk->sk_write_space = nvmet_tcp_write_space;
d8e7b462f5b8b9 Wunderlich, Mark  2021-03-31  1587  		if (idle_poll_period_usecs)
d8e7b462f5b8b9 Wunderlich, Mark  2021-03-31  1588  			nvmet_tcp_arm_queue_deadline(queue);
0fbcfb089a3f2f Sagi Grimberg     2021-02-05  1589  		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
0fbcfb089a3f2f Sagi Grimberg     2021-02-05  1590  	}
872d26a391da92 Sagi Grimberg     2018-12-03  1591  	write_unlock_bh(&sock->sk->sk_callback_lock);
872d26a391da92 Sagi Grimberg     2018-12-03  1592  
0fbcfb089a3f2f Sagi Grimberg     2021-02-05  1593  	return ret;
872d26a391da92 Sagi Grimberg     2018-12-03  1594  }
872d26a391da92 Sagi Grimberg     2018-12-03  1595  

:::::: The code at line 1421 was first introduced by commit
:::::: 872d26a391da92ed8f0c0f5cb5fef428067b7f30 nvmet-tcp: add NVMe over TCP target driver

:::::: TO: Sagi Grimberg <sagi@lightbitslabs.com>
:::::: CC: Christoph Hellwig <hch@lst.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

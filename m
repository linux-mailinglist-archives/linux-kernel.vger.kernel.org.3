Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23655205E4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 22:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiEIUeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 16:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiEIUeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 16:34:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C932D290B
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652127838; x=1683663838;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=czf2o3k7Xf6xtJpkKwmdLGOhbCJ0lrDWAGtnkKq+nvs=;
  b=UnEG7ceFdlp5RPTc0yh53XbfE5sfrB6eOq8WJlmX5/ZvsDjPlOXghsWY
   S+D+GpZFsvP3npmc+Ej/qbA2kTqb0/a+s86RynMuKlouRXGT9m+TbjVez
   qrV2Q2xa6kKgVP4Yyf+0HUQnpNDrFnupGR3NcIraGOZn9FwxbYsJl8VSY
   45SIht03RQ174QjdTNFijQLkMQHCP/tR7fICoVX6Z/e4lIA6h2nYf75GZ
   e0YZvhSGmIhGfHkiG5zSNS6dhsC0JTOxvQ6G3kaQRe0HlwH0vP09oM0OG
   w45Q62JbHfsfuj61QY5Gy2LXBii6ph1BaTRt56jHTGzhOHQMZQzXziP/+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="329755163"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="329755163"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 13:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="657301509"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 May 2022 13:23:56 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no9v9-000Gre-TZ;
        Mon, 09 May 2022 20:23:55 +0000
Date:   Tue, 10 May 2022 04:23:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/rxrpc-ringless 30/30]
 net/rxrpc/call_event.c:222:28: sparse: sparse: cast from restricted __be32
Message-ID: <202205100458.DxYf2dyr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/rxrpc-ringless
head:   6c602b75eb616db42db08a634ed6e17ecd3a20d0
commit: 6c602b75eb616db42db08a634ed6e17ecd3a20d0 [30/30] rxrpc: Fix Tx resend by saving last ACK packet rather than marking packet ring
config: x86_64-randconfig-s021-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100458.DxYf2dyr-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/6c602b75eb616db42db08a634ed6e17ecd3a20d0
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/rxrpc-ringless
        git checkout 6c602b75eb616db42db08a634ed6e17ecd3a20d0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash net/rxrpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> net/rxrpc/call_event.c:222:28: sparse: sparse: cast from restricted __be32
>> net/rxrpc/call_event.c:222:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] seq1 @@     got restricted __be32 [usertype] @@
   net/rxrpc/call_event.c:222:28: sparse:     expected unsigned int [usertype] seq1
   net/rxrpc/call_event.c:222:28: sparse:     got restricted __be32 [usertype]
   net/rxrpc/call_event.c:222:53: sparse: sparse: cast from restricted __be32
>> net/rxrpc/call_event.c:222:53: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] seq2 @@     got restricted __be32 [usertype] @@
   net/rxrpc/call_event.c:222:53: sparse:     expected unsigned int [usertype] seq2
   net/rxrpc/call_event.c:222:53: sparse:     got restricted __be32 [usertype]

vim +222 net/rxrpc/call_event.c

   122	
   123	/*
   124	 * Perform retransmission of NAK'd and unack'd packets.
   125	 */
   126	static void rxrpc_resend(struct rxrpc_call *call, unsigned long now_j)
   127	{
   128		struct rxrpc_ackpacket *ack = NULL;
   129		struct rxrpc_local *local = call->peer->local;
   130		struct rxrpc_txbuf *txb;
   131		struct sk_buff *ack_skb = NULL;
   132		unsigned long resend_at;
   133		rxrpc_seq_t transmitted = READ_ONCE(call->tx_transmitted);
   134		ktime_t now, max_age, oldest, ack_ts;
   135		bool unacked = false;
   136		unsigned int i;
   137		LIST_HEAD(retrans_queue);
   138	
   139		_enter("{%d,%d}", call->acks_hard_ack, call->tx_top);
   140	
   141		now = ktime_get_real();
   142		max_age = ktime_sub_us(now, jiffies_to_usecs(call->peer->rto_j));
   143	
   144		/* See if there's an ACK saved with a soft-ACK table in it. */
   145		if (call->acks_soft_tbl) {
   146			spin_lock_bh(&call->acks_ack_lock);
   147			ack_skb = call->acks_soft_tbl;
   148			if (ack_skb) {
   149				rxrpc_get_skb(ack_skb, rxrpc_skb_ack);
   150				ack = (void *)ack_skb->data + sizeof(struct rxrpc_wire_header);
   151			}
   152			spin_unlock_bh(&call->acks_ack_lock);
   153		}
   154	
   155		spin_lock(&call->tx_lock);
   156	
   157		if (list_empty(&call->tx_queue))
   158			goto no_resend;
   159	
   160		trace_rxrpc_resend(call);
   161		txb = list_first_entry(&call->tx_queue, struct rxrpc_txbuf, call_link);
   162		oldest = now;
   163	
   164		/* Scan the soft ACK table without dropping the lock and resend any
   165		 * explicitly NAK'd packets.
   166		 */
   167		if (ack) {
   168			for (i = 0; i < ack->nAcks; i++) {
   169				rxrpc_seq_t seq;
   170	
   171				if (ack->acks[i] & 1)
   172					continue;
   173				seq = ntohl(ack->firstPacket) + i;
   174				if (after(txb->seq, transmitted))
   175					break;
   176				if (after(txb->seq, seq))
   177					continue; /* A new hard ACK probably came in */
   178				if (before(txb->seq, seq)) {
   179					list_for_each_entry_continue(txb, &call->tx_queue, call_link) {
   180						if (txb->seq == seq)
   181							goto found_txb;
   182					}
   183					goto no_resend;
   184				}
   185	
   186			found_txb:
   187				if (after(ntohl(txb->wire.serial), call->acks_highest_serial))
   188					continue; /* Ack point not yet reached */
   189	
   190				rxrpc_see_txbuf(txb, rxrpc_txbuf_see_unacked);
   191	
   192				if (list_empty(&txb->tx_link)) {
   193					rxrpc_get_txbuf(txb, rxrpc_txbuf_get_retrans);
   194					rxrpc_get_call(call, rxrpc_call_got_tx);
   195					list_add_tail(&txb->tx_link, &retrans_queue);
   196					set_bit(RXRPC_TXBUF_RESENT, &txb->flags);
   197				}
   198	
   199				trace_rxrpc_retransmit(call, txb->seq,
   200						       ktime_to_ns(ktime_sub(txb->last_sent,
   201									     max_age)));
   202			}
   203		}
   204	
   205		/* Fast-forward through the Tx queue to the point the peer says it has
   206		 * seen.  Anything between the soft-ACK table and that point will get
   207		 * ACK'd or NACK'd in due course, so don't worry about it here; here we
   208		 * need to consider retransmitting anything beyond that point.
   209		 *
   210		 * Note that ACK for a packet can beat the update of tx_transmitted.
   211		 */
   212		if (after_eq(READ_ONCE(call->acks_prev_seq), READ_ONCE(call->tx_transmitted)))
   213			goto no_resend;
   214	
   215		list_for_each_entry_continue(txb, &call->tx_queue, call_link) {
   216			if (before_eq(txb->seq, READ_ONCE(call->acks_prev_seq)))
   217				continue;
   218			if (after(txb->seq, READ_ONCE(call->tx_transmitted)))
   219				break; /* Not transmitted yet */
   220	
   221			if (ack && ack->reason == RXRPC_ACK_PING_RESPONSE &&
 > 222			    before(htonl(txb->wire.serial), htonl(ack->serial)))
   223				goto do_resend; /* Wasn't accounted for by a more recent ping. */
   224	
   225			if (ktime_after(txb->last_sent, max_age)) {
   226				if (ktime_before(txb->last_sent, oldest))
   227					oldest = txb->last_sent;
   228				continue;
   229			}
   230	
   231		do_resend:
   232			unacked = true;
   233			if (list_empty(&txb->tx_link)) {
   234				rxrpc_get_txbuf(txb, rxrpc_txbuf_get_retrans);
   235				rxrpc_get_call(call, rxrpc_call_got_tx);
   236				list_add_tail(&txb->tx_link, &retrans_queue);
   237				set_bit(RXRPC_TXBUF_RESENT, &txb->flags);
   238			}
   239		}
   240	
   241	
   242	
   243	no_resend:
   244		spin_unlock(&call->tx_lock);
   245		rxrpc_free_skb(ack_skb, rxrpc_skb_freed);
   246	
   247		resend_at = nsecs_to_jiffies(ktime_to_ns(ktime_sub(now, oldest)));
   248		resend_at += jiffies + rxrpc_get_rto_backoff(call->peer,
   249							     !list_empty(&retrans_queue));
   250		WRITE_ONCE(call->resend_at, resend_at);
   251	
   252		if (unacked)
   253			rxrpc_congestion_timeout(call);
   254	
   255		/* If there was nothing that needed retransmission then it's likely
   256		 * that an ACK got lost somewhere.  Send a ping to find out instead of
   257		 * retransmitting data.
   258		 */
   259		if (list_empty(&retrans_queue)) {
   260			rxrpc_reduce_call_timer(call, resend_at, now_j,
   261						rxrpc_timer_set_for_resend);
   262			ack_ts = ktime_sub(now, call->acks_latest_ts);
   263			if (ktime_to_us(ack_ts) < (call->peer->srtt_us >> 3))
   264				goto out;
   265			rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
   266				       rxrpc_propose_ack_ping_for_lost_ack);
   267			goto out;
   268		}
   269	
   270		/* Push the packets to be retransmitted onto the transmission queue and
   271		 * wake up the transmitter worker.  Note that it's possible that an ACK
   272		 * might come in whilst a packet is on the queue.
   273		 */
   274		spin_lock(&local->tx_lock);
   275		if (rxrpc_is_client_call(call))
   276			rxrpc_expose_client_call(call);
   277		list_splice_tail(&retrans_queue, &local->tx_queue);
   278		spin_unlock(&local->tx_lock);
   279		rxrpc_wake_up_transmitter(local);
   280	
   281	out:
   282		_leave("");
   283	}
   284	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

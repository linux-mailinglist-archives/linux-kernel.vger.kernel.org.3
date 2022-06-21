Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2699D553EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 01:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355071AbiFUXSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 19:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354433AbiFUXSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 19:18:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98A72F645
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 16:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655853499; x=1687389499;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aWvQ3BXDydfRWM3mfL+Splg/J9tZSdeD/le9SPlrkTo=;
  b=SFl26I5Fn1n/GBG1SzjM09940NaLefSFcxk76rwlbf2zkevO0FcERF1B
   zGsEDV0Jsi+WKohRnOOjgZ3MlUCtEHgu9RhD19v30xJbiLGankdrnDcTW
   iwd0KAw6LbfmtS6yYMNWJrb6bwBokiad6SJt0V7CEQmSPL7OhlYi1Ynjf
   33JNUfArNc99yxIZLYSLvXfb+h1oEAiDnLojl5v9irSzNsR5xrxU/RZsa
   mG2/RxEpAi/PEzjvGijJfGirtzeIlmfLBc3bkKpVDFETHj7L+DniYEA+k
   sYS8/LH6vD8qoZkEwYJocMXiHI4XMF2s4g7b4uUQJYZNtu3ZkUw+krZE4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="260083163"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="260083163"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 16:18:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="690182136"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2022 16:18:18 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3n8T-0000Xt-KE;
        Tue, 21 Jun 2022 23:18:17 +0000
Date:   Wed, 22 Jun 2022 07:18:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/rxrpc-ringless-2 14/24]
 net/rxrpc/call_event.c:230:28: sparse: sparse: incorrect type in argument 1
 (different base types)
Message-ID: <202206220720.FhrGez0q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/rxrpc-ringless-2
head:   3f41f1279858b9676cd6724d54e4323696e1ac07
commit: 2b15e54aaf0e0c739cb4d55f77d7f7d9d80eeedc [14/24] rxrpc: Fix Tx resend by saving last ACK packet rather than marking packet ring
config: nios2-randconfig-s032-20220622 (https://download.01.org/0day-ci/archive/20220622/202206220720.FhrGez0q-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/2b15e54aaf0e0c739cb4d55f77d7f7d9d80eeedc
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/rxrpc-ringless-2
        git checkout 2b15e54aaf0e0c739cb4d55f77d7f7d9d80eeedc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash net/rxrpc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   net/rxrpc/call_event.c:230:28: sparse: sparse: cast from restricted __be32
>> net/rxrpc/call_event.c:230:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] serial @@
   net/rxrpc/call_event.c:230:28: sparse:     expected unsigned int [usertype] val
   net/rxrpc/call_event.c:230:28: sparse:     got restricted __be32 [usertype] serial
   net/rxrpc/call_event.c:230:28: sparse: sparse: cast from restricted __be32
   net/rxrpc/call_event.c:230:28: sparse: sparse: cast from restricted __be32
   net/rxrpc/call_event.c:230:28: sparse: sparse: cast from restricted __be32
   net/rxrpc/call_event.c:230:28: sparse: sparse: cast from restricted __be32
   net/rxrpc/call_event.c:230:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] seq1 @@     got restricted __be32 [usertype] @@
   net/rxrpc/call_event.c:230:28: sparse:     expected unsigned int [usertype] seq1
   net/rxrpc/call_event.c:230:28: sparse:     got restricted __be32 [usertype]
   net/rxrpc/call_event.c:230:53: sparse: sparse: cast from restricted __be32
   net/rxrpc/call_event.c:230:53: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] serial @@
   net/rxrpc/call_event.c:230:53: sparse:     expected unsigned int [usertype] val
   net/rxrpc/call_event.c:230:53: sparse:     got restricted __be32 [usertype] serial
   net/rxrpc/call_event.c:230:53: sparse: sparse: cast from restricted __be32
   net/rxrpc/call_event.c:230:53: sparse: sparse: cast from restricted __be32
   net/rxrpc/call_event.c:230:53: sparse: sparse: cast from restricted __be32
   net/rxrpc/call_event.c:230:53: sparse: sparse: cast from restricted __be32
   net/rxrpc/call_event.c:230:53: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] seq2 @@     got restricted __be32 [usertype] @@
   net/rxrpc/call_event.c:230:53: sparse:     expected unsigned int [usertype] seq2
   net/rxrpc/call_event.c:230:53: sparse:     got restricted __be32 [usertype]
   net/rxrpc/call_event.c: note: in included file (through include/uapi/linux/swab.h, include/linux/swab.h, include/uapi/linux/byteorder/little_endian.h, ...):
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini

vim +230 net/rxrpc/call_event.c

   126	
   127	/*
   128	 * Perform retransmission of NAK'd and unack'd packets.
   129	 */
   130	static void rxrpc_resend(struct rxrpc_call *call, unsigned long now_j)
   131	{
   132		struct rxrpc_ackpacket *ack = NULL;
   133		struct rxrpc_txbuf *txb;
   134		struct sk_buff *ack_skb = NULL;
   135		unsigned long resend_at;
   136		rxrpc_seq_t transmitted = READ_ONCE(call->tx_transmitted);
   137		ktime_t now, max_age, oldest, ack_ts;
   138		bool unacked = false;
   139		unsigned int i;
   140		LIST_HEAD(retrans_queue);
   141	
   142		_enter("{%d,%d}", call->acks_hard_ack, call->tx_top);
   143	
   144		now = ktime_get_real();
   145		max_age = ktime_sub_us(now, jiffies_to_usecs(call->peer->rto_j));
   146		oldest = now;
   147	
   148		/* See if there's an ACK saved with a soft-ACK table in it. */
   149		if (call->acks_soft_tbl) {
   150			spin_lock_bh(&call->acks_ack_lock);
   151			ack_skb = call->acks_soft_tbl;
   152			if (ack_skb) {
   153				rxrpc_get_skb(ack_skb, rxrpc_skb_ack);
   154				ack = (void *)ack_skb->data + sizeof(struct rxrpc_wire_header);
   155			}
   156			spin_unlock_bh(&call->acks_ack_lock);
   157		}
   158	
   159		if (list_empty(&call->tx_buffer))
   160			goto no_resend;
   161	
   162		spin_lock(&call->tx_lock);
   163	
   164		if (list_empty(&call->tx_buffer))
   165			goto no_further_resend;
   166	
   167		trace_rxrpc_resend(call);
   168		txb = list_first_entry(&call->tx_buffer, struct rxrpc_txbuf, call_link);
   169	
   170		/* Scan the soft ACK table without dropping the lock and resend any
   171		 * explicitly NAK'd packets.
   172		 */
   173		if (ack) {
   174			for (i = 0; i < ack->nAcks; i++) {
   175				rxrpc_seq_t seq;
   176	
   177				if (ack->acks[i] & 1)
   178					continue;
   179				seq = ntohl(ack->firstPacket) + i;
   180				if (after(txb->seq, transmitted))
   181					break;
   182				if (after(txb->seq, seq))
   183					continue; /* A new hard ACK probably came in */
   184				list_for_each_entry_from(txb, &call->tx_buffer, call_link) {
   185					if (txb->seq == seq)
   186						goto found_txb;
   187				}
   188				goto no_further_resend;
   189	
   190			found_txb:
   191				if (after(ntohl(txb->wire.serial), call->acks_highest_serial))
   192					continue; /* Ack point not yet reached */
   193	
   194				rxrpc_see_txbuf(txb, rxrpc_txbuf_see_unacked);
   195	
   196				if (list_empty(&txb->tx_link)) {
   197					rxrpc_get_txbuf(txb, rxrpc_txbuf_get_retrans);
   198					rxrpc_get_call(call, rxrpc_call_got_tx);
   199					list_add_tail(&txb->tx_link, &retrans_queue);
   200					set_bit(RXRPC_TXBUF_RESENT, &txb->flags);
   201				}
   202	
   203				trace_rxrpc_retransmit(call, txb->seq,
   204						       ktime_to_ns(ktime_sub(txb->last_sent,
   205									     max_age)));
   206	
   207				if (list_is_last(&txb->call_link, &call->tx_buffer))
   208					goto no_further_resend;
   209				txb = list_next_entry(txb, call_link);
   210			}
   211		}
   212	
   213		/* Fast-forward through the Tx queue to the point the peer says it has
   214		 * seen.  Anything between the soft-ACK table and that point will get
   215		 * ACK'd or NACK'd in due course, so don't worry about it here; here we
   216		 * need to consider retransmitting anything beyond that point.
   217		 *
   218		 * Note that ACK for a packet can beat the update of tx_transmitted.
   219		 */
   220		if (after_eq(READ_ONCE(call->acks_prev_seq), READ_ONCE(call->tx_transmitted)))
   221			goto no_further_resend;
   222	
   223		list_for_each_entry_from(txb, &call->tx_buffer, call_link) {
   224			if (before_eq(txb->seq, READ_ONCE(call->acks_prev_seq)))
   225				continue;
   226			if (after(txb->seq, READ_ONCE(call->tx_transmitted)))
   227				break; /* Not transmitted yet */
   228	
   229			if (ack && ack->reason == RXRPC_ACK_PING_RESPONSE &&
 > 230			    before(htonl(txb->wire.serial), htonl(ack->serial)))
   231				goto do_resend; /* Wasn't accounted for by a more recent ping. */
   232	
   233			if (ktime_after(txb->last_sent, max_age)) {
   234				if (ktime_before(txb->last_sent, oldest))
   235					oldest = txb->last_sent;
   236				continue;
   237			}
   238	
   239		do_resend:
   240			unacked = true;
   241			if (list_empty(&txb->tx_link)) {
   242				rxrpc_get_txbuf(txb, rxrpc_txbuf_get_retrans);
   243				list_add_tail(&txb->tx_link, &retrans_queue);
   244				set_bit(RXRPC_TXBUF_RESENT, &txb->flags);
   245			}
   246		}
   247	
   248	no_further_resend:
   249		spin_unlock(&call->tx_lock);
   250	no_resend:
   251		rxrpc_free_skb(ack_skb, rxrpc_skb_freed);
   252	
   253		resend_at = nsecs_to_jiffies(ktime_to_ns(ktime_sub(now, oldest)));
   254		resend_at += jiffies + rxrpc_get_rto_backoff(call->peer,
   255							     !list_empty(&retrans_queue));
   256		WRITE_ONCE(call->resend_at, resend_at);
   257	
   258		if (unacked)
   259			rxrpc_congestion_timeout(call);
   260	
   261		/* If there was nothing that needed retransmission then it's likely
   262		 * that an ACK got lost somewhere.  Send a ping to find out instead of
   263		 * retransmitting data.
   264		 */
   265		if (list_empty(&retrans_queue)) {
   266			rxrpc_reduce_call_timer(call, resend_at, now_j,
   267						rxrpc_timer_set_for_resend);
   268			ack_ts = ktime_sub(now, call->acks_latest_ts);
   269			if (ktime_to_us(ack_ts) < (call->peer->srtt_us >> 3))
   270				goto out;
   271			rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
   272				       rxrpc_propose_ack_ping_for_lost_ack);
   273		}
   274	
   275		while ((txb = list_first_entry_or_null(&retrans_queue,
   276						       struct rxrpc_txbuf, tx_link))) {
   277			list_del_init(&txb->tx_link);
   278			rxrpc_send_data_packet(call, txb);
   279			rxrpc_put_txbuf(txb, rxrpc_txbuf_put_trans);
   280	
   281			trace_rxrpc_retransmit(call, txb->seq,
   282					       ktime_to_ns(ktime_sub(txb->last_sent,
   283								     max_age)));
   284		}
   285	
   286	out:
   287		_leave("");
   288	}
   289	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

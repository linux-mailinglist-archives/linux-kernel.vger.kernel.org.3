Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00EC5A965E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiIAMIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiIAMIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:08:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56C5EA30B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662034108; x=1693570108;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mnRVMPj/RlcCAXcBxNVoEW9oXA+/0zVa6EAxdRCFHKY=;
  b=BuBrG+OVu3fmhSyjRr2pGjU1yI1itqI4nfKFEly+gq63RAxJkhpX5e0S
   hVLOcii9K+mnDJzWQ4dKiroU4zXZUik6wpUp75ot8dxc1R6TFqEwREHrz
   LL9vDAhru+s5OzsmUw5ReIy5Ho5XmIuh1yGzJeFM3igrGcTcFLR/73elF
   UuhsWBUxzFG3yBRbDouh5RLuDxf28ouS+uxMrj5mDMPUE2ell0VcPsKKJ
   FDf2v1uPY9K4EyRVr/q/U/khsu9/o9E5MfKXqOcLt5odrSc8Z4zzW2NKe
   Fwk8OPag9ApL6I6nOMl1ae6RnjWfs5dCh7tPx3hWKhfkP1KwtlFha7nMi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="282675234"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="282675234"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 05:08:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="642304959"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 01 Sep 2022 05:08:27 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTizi-0000Gh-18;
        Thu, 01 Sep 2022 12:08:26 +0000
Date:   Thu, 1 Sep 2022 20:08:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [netfilter-nf-next:testing 1/6]
 net/netfilter/nf_conntrack_proto_tcp.c:592:32: warning: implicit conversion
 from 'enum <anonymous>' to 'enum nf_ct_tcp_action'
Message-ID: <202209012010.OWTXJac6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git testing
head:   655d797bf5e11676f7ef9e68af3e9700404f8695
commit: 83d3b17508cc0f1a53b73080c51e57054ddf3499 [1/6] netfilter: conntrack: prepare tcp_in_window for ternary return value
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220901/202209012010.OWTXJac6-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?id=83d3b17508cc0f1a53b73080c51e57054ddf3499
        git remote add netfilter-nf-next git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git
        git fetch --no-tags netfilter-nf-next testing
        git checkout 83d3b17508cc0f1a53b73080c51e57054ddf3499
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash net/netfilter/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/netfilter/nf_conntrack_proto_tcp.c: In function 'tcp_in_window':
>> net/netfilter/nf_conntrack_proto_tcp.c:592:32: warning: implicit conversion from 'enum <anonymous>' to 'enum nf_ct_tcp_action' [-Wenum-conversion]
     592 |                         return true;
         |                                ^~~~


vim +592 net/netfilter/nf_conntrack_proto_tcp.c

83d3b17508cc0f Florian Westphal  2022-08-26  505  
83d3b17508cc0f Florian Westphal  2022-08-26  506  static enum nf_ct_tcp_action
83d3b17508cc0f Florian Westphal  2022-08-26  507  tcp_in_window(struct nf_conn *ct, enum ip_conntrack_dir dir,
83d3b17508cc0f Florian Westphal  2022-08-26  508  	      unsigned int index, const struct sk_buff *skb,
83d3b17508cc0f Florian Westphal  2022-08-26  509  	      unsigned int dataoff, const struct tcphdr *tcph,
62eec0d73393a1 Florian Westphal  2021-06-16  510  	      const struct nf_hook_state *hook_state)
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  511  {
62eec0d73393a1 Florian Westphal  2021-06-16  512  	struct ip_ct_tcp *state = &ct->proto.tcp;
c2a2c7e0cc39e7 Alexey Dobriyan   2008-10-08  513  	struct net *net = nf_ct_net(ct);
a95a7774d51e13 Pablo Neira Ayuso 2018-11-02  514  	struct nf_tcp_net *tn = nf_tcp_pernet(net);
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  515  	struct ip_ct_tcp_state *sender = &state->seen[dir];
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  516  	struct ip_ct_tcp_state *receiver = &state->seen[!dir];
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  517  	__u32 seq, ack, sack, end, win, swin;
83d3b17508cc0f Florian Westphal  2022-08-26  518  	bool in_recv_win, seq_ok;
2d89c68ac78ae4 Patrick McHardy   2013-07-28  519  	s32 receiver_offset;
83d3b17508cc0f Florian Westphal  2022-08-26  520  	u16 win_raw;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  521  
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  522  	/*
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  523  	 * Get the required data from the packet.
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  524  	 */
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  525  	seq = ntohl(tcph->seq);
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  526  	ack = sack = ntohl(tcph->ack_seq);
959b69ef57db00 Florian Westphal  2019-07-12  527  	win_raw = ntohs(tcph->window);
959b69ef57db00 Florian Westphal  2019-07-12  528  	win = win_raw;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  529  	end = segment_seq_plus_len(seq, skb->len, dataoff, tcph);
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  530  
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  531  	if (receiver->flags & IP_CT_TCP_FLAG_SACK_PERM)
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  532  		tcp_sack(skb, dataoff, tcph, &sack);
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  533  
f9dd09c7f71996 Jozsef Kadlecsik  2009-11-06  534  	/* Take into account NAT sequence number mangling */
41d73ec053d242 Patrick McHardy   2013-08-27  535  	receiver_offset = nf_ct_seq_offset(ct, !dir, ack - 1);
f9dd09c7f71996 Jozsef Kadlecsik  2009-11-06  536  	ack -= receiver_offset;
f9dd09c7f71996 Jozsef Kadlecsik  2009-11-06  537  	sack -= receiver_offset;
f9dd09c7f71996 Jozsef Kadlecsik  2009-11-06  538  
874ab9233eeddb Jozsef Kadlecsik  2009-06-02  539  	if (sender->td_maxwin == 0) {
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  540  		/*
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  541  		 * Initialize sender data.
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  542  		 */
874ab9233eeddb Jozsef Kadlecsik  2009-06-02  543  		if (tcph->syn) {
cc4f9d62037ebc Florian Westphal  2022-01-29  544  			tcp_init_sender(sender, receiver,
cc4f9d62037ebc Florian Westphal  2022-01-29  545  					skb, dataoff, tcph,
cc4f9d62037ebc Florian Westphal  2022-01-29  546  					end, win);
874ab9233eeddb Jozsef Kadlecsik  2009-06-02  547  			if (!tcph->ack)
874ab9233eeddb Jozsef Kadlecsik  2009-06-02  548  				/* Simultaneous open */
83d3b17508cc0f Florian Westphal  2022-08-26  549  				return NFCT_TCP_ACCEPT;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  550  		} else {
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  551  			/*
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  552  			 * We are in the middle of a connection,
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  553  			 * its history is lost for us.
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  554  			 * Let's try to use the data from the packet.
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  555  			 */
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  556  			sender->td_end = end;
6ee0b693bdb8ec Changli Gao       2012-04-01  557  			swin = win << sender->td_scale;
6ee0b693bdb8ec Changli Gao       2012-04-01  558  			sender->td_maxwin = (swin == 0 ? 1 : swin);
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  559  			sender->td_maxend = end + sender->td_maxwin;
4f25434bccc28c Francesco Ruggeri 2020-10-07  560  			if (receiver->td_maxwin == 0) {
4f25434bccc28c Francesco Ruggeri 2020-10-07  561  				/* We haven't seen traffic in the other
4f25434bccc28c Francesco Ruggeri 2020-10-07  562  				 * direction yet but we have to tweak window
4f25434bccc28c Francesco Ruggeri 2020-10-07  563  				 * tracking to pass III and IV until that
4f25434bccc28c Francesco Ruggeri 2020-10-07  564  				 * happens.
fac42a9a922fe5 Pablo Neira Ayuso 2010-07-15  565  				 */
fac42a9a922fe5 Pablo Neira Ayuso 2010-07-15  566  				receiver->td_end = receiver->td_maxend = sack;
4f25434bccc28c Francesco Ruggeri 2020-10-07  567  			} else if (sack == receiver->td_end + 1) {
4f25434bccc28c Francesco Ruggeri 2020-10-07  568  				/* Likely a reply to a keepalive.
4f25434bccc28c Francesco Ruggeri 2020-10-07  569  				 * Needed for III.
4f25434bccc28c Francesco Ruggeri 2020-10-07  570  				 */
4f25434bccc28c Francesco Ruggeri 2020-10-07  571  				receiver->td_end++;
4f25434bccc28c Francesco Ruggeri 2020-10-07  572  			}
4f25434bccc28c Francesco Ruggeri 2020-10-07  573  
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  574  		}
c7aab4f17021b6 Florian Westphal  2022-04-25  575  	} else if (tcph->syn &&
c7aab4f17021b6 Florian Westphal  2022-04-25  576  		   after(end, sender->td_end) &&
c7aab4f17021b6 Florian Westphal  2022-04-25  577  		   (state->state == TCP_CONNTRACK_SYN_SENT ||
c7aab4f17021b6 Florian Westphal  2022-04-25  578  		    state->state == TCP_CONNTRACK_SYN_RECV)) {
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  579  		/*
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  580  		 * RFC 793: "if a TCP is reinitialized ... then it need
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  581  		 * not wait at all; it must only be sure to use sequence
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  582  		 * numbers larger than those recently used."
82b72cb94666b3 Florian Westphal  2022-01-29  583  		 *
82b72cb94666b3 Florian Westphal  2022-01-29  584  		 * Re-init state for this direction, just like for the first
82b72cb94666b3 Florian Westphal  2022-01-29  585  		 * syn(-ack) reply, it might differ in seq, ack or tcp options.
82b72cb94666b3 Florian Westphal  2022-01-29  586  		 */
82b72cb94666b3 Florian Westphal  2022-01-29  587  		tcp_init_sender(sender, receiver,
82b72cb94666b3 Florian Westphal  2022-01-29  588  				skb, dataoff, tcph,
82b72cb94666b3 Florian Westphal  2022-01-29  589  				end, win);
c7aab4f17021b6 Florian Westphal  2022-04-25  590  
c7aab4f17021b6 Florian Westphal  2022-04-25  591  		if (dir == IP_CT_DIR_REPLY && !tcph->ack)
82b72cb94666b3 Florian Westphal  2022-01-29 @592  			return true;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  593  	}
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  594  
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  595  	if (!(tcph->ack)) {
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  596  		/*
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  597  		 * If there is no ACK, just pretend it was set and OK.
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  598  		 */
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  599  		ack = sack = receiver->td_end;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  600  	} else if (((tcp_flag_word(tcph) & (TCP_FLAG_ACK|TCP_FLAG_RST)) ==
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  601  		    (TCP_FLAG_ACK|TCP_FLAG_RST))
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  602  		   && (ack == 0)) {
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  603  		/*
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  604  		 * Broken TCP stacks, that set ACK in RST packets as well
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  605  		 * with zero ack value.
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  606  		 */
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  607  		ack = sack = receiver->td_end;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  608  	}
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  609  
4a70bbfaef0361 Jozsef Kadlecsik  2012-08-31  610  	if (tcph->rst && seq == 0 && state->state == TCP_CONNTRACK_SYN_SENT)
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  611  		/*
4a70bbfaef0361 Jozsef Kadlecsik  2012-08-31  612  		 * RST sent answering SYN.
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  613  		 */
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  614  		seq = end = sender->td_end;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  615  
83d3b17508cc0f Florian Westphal  2022-08-26  616  	seq_ok = before(seq, sender->td_maxend + 1);
83d3b17508cc0f Florian Westphal  2022-08-26  617  	if (!seq_ok) {
83d3b17508cc0f Florian Westphal  2022-08-26  618  		u32 overshot = end - sender->td_maxend + 1;
83d3b17508cc0f Florian Westphal  2022-08-26  619  		bool ack_ok;
83d3b17508cc0f Florian Westphal  2022-08-26  620  
83d3b17508cc0f Florian Westphal  2022-08-26  621  		ack_ok = after(sack, receiver->td_end - MAXACKWINDOW(sender) - 1);
83d3b17508cc0f Florian Westphal  2022-08-26  622  		in_recv_win = receiver->td_maxwin &&
83d3b17508cc0f Florian Westphal  2022-08-26  623  			      after(end, sender->td_end - receiver->td_maxwin - 1);
83d3b17508cc0f Florian Westphal  2022-08-26  624  
83d3b17508cc0f Florian Westphal  2022-08-26  625  		if (in_recv_win &&
83d3b17508cc0f Florian Westphal  2022-08-26  626  		    ack_ok &&
83d3b17508cc0f Florian Westphal  2022-08-26  627  		    overshot <= receiver->td_maxwin &&
83d3b17508cc0f Florian Westphal  2022-08-26  628  		    before(sack, receiver->td_end + 1)) {
83d3b17508cc0f Florian Westphal  2022-08-26  629  			/* Work around TCPs that send more bytes than allowed by
83d3b17508cc0f Florian Westphal  2022-08-26  630  			 * the receive window.
83d3b17508cc0f Florian Westphal  2022-08-26  631  			 *
83d3b17508cc0f Florian Westphal  2022-08-26  632  			 * If the (marked as invalid) packet is allowed to pass by
83d3b17508cc0f Florian Westphal  2022-08-26  633  			 * the ruleset and the peer acks this data, then its possible
83d3b17508cc0f Florian Westphal  2022-08-26  634  			 * all future packets will trigger 'ACK is over upper bound' check.
83d3b17508cc0f Florian Westphal  2022-08-26  635  			 *
83d3b17508cc0f Florian Westphal  2022-08-26  636  			 * Thus if only the sequence check fails then do update td_end so
83d3b17508cc0f Florian Westphal  2022-08-26  637  			 * possible ACK for this data can update internal state.
83d3b17508cc0f Florian Westphal  2022-08-26  638  			 */
83d3b17508cc0f Florian Westphal  2022-08-26  639  			sender->td_end = end;
83d3b17508cc0f Florian Westphal  2022-08-26  640  			sender->flags |= IP_CT_TCP_FLAG_DATA_UNACKNOWLEDGED;
83d3b17508cc0f Florian Westphal  2022-08-26  641  
83d3b17508cc0f Florian Westphal  2022-08-26  642  			nf_ct_l4proto_log_invalid(skb, ct, hook_state,
83d3b17508cc0f Florian Westphal  2022-08-26  643  						  "%u bytes more than expected", overshot);
83d3b17508cc0f Florian Westphal  2022-08-26  644  			return NFCT_TCP_ACCEPT;
83d3b17508cc0f Florian Westphal  2022-08-26  645  		}
83d3b17508cc0f Florian Westphal  2022-08-26  646  
83d3b17508cc0f Florian Westphal  2022-08-26  647  		return nf_tcp_log_invalid(skb, ct, hook_state, sender, NFCT_TCP_INVALID,
83d3b17508cc0f Florian Westphal  2022-08-26  648  					  "SEQ is over upper bound %u (over the window of the receiver)",
83d3b17508cc0f Florian Westphal  2022-08-26  649  					  sender->td_maxend + 1);
83d3b17508cc0f Florian Westphal  2022-08-26  650  	}
83d3b17508cc0f Florian Westphal  2022-08-26  651  
83d3b17508cc0f Florian Westphal  2022-08-26  652  	if (!before(sack, receiver->td_end + 1))
83d3b17508cc0f Florian Westphal  2022-08-26  653  		return nf_tcp_log_invalid(skb, ct, hook_state, sender, NFCT_TCP_INVALID,
83d3b17508cc0f Florian Westphal  2022-08-26  654  					  "ACK is over upper bound %u (ACKed data not seen yet)",
83d3b17508cc0f Florian Westphal  2022-08-26  655  					  receiver->td_end + 1);
83d3b17508cc0f Florian Westphal  2022-08-26  656  
356d7d88e08868 Yuchung Cheng     2013-08-09  657  	/* Is the ending sequence in the receive window (if available)? */
356d7d88e08868 Yuchung Cheng     2013-08-09  658  	in_recv_win = !receiver->td_maxwin ||
356d7d88e08868 Yuchung Cheng     2013-08-09  659  		      after(end, sender->td_end - receiver->td_maxwin - 1);
356d7d88e08868 Yuchung Cheng     2013-08-09  660  
83d3b17508cc0f Florian Westphal  2022-08-26  661  	if (in_recv_win &&
84ebe1cdae5670 Jozsef Kadlecsik  2008-06-30  662  	    after(sack, receiver->td_end - MAXACKWINDOW(sender) - 1)) {
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  663  		/*
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  664  		 * Take into account window scaling (RFC 1323).
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  665  		 */
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  666  		if (!tcph->syn)
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  667  			win <<= sender->td_scale;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  668  
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  669  		/*
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  670  		 * Update sender data.
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  671  		 */
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  672  		swin = win + (sack - ack);
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  673  		if (sender->td_maxwin < swin)
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  674  			sender->td_maxwin = swin;
ae375044d31075 Patrick McHardy   2008-07-31  675  		if (after(end, sender->td_end)) {
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  676  			sender->td_end = end;
ae375044d31075 Patrick McHardy   2008-07-31  677  			sender->flags |= IP_CT_TCP_FLAG_DATA_UNACKNOWLEDGED;
ae375044d31075 Patrick McHardy   2008-07-31  678  		}
bfcaa50270e18f Jozsef Kadlecsik  2009-05-25  679  		if (tcph->ack) {
bfcaa50270e18f Jozsef Kadlecsik  2009-05-25  680  			if (!(sender->flags & IP_CT_TCP_FLAG_MAXACK_SET)) {
bfcaa50270e18f Jozsef Kadlecsik  2009-05-25  681  				sender->td_maxack = ack;
bfcaa50270e18f Jozsef Kadlecsik  2009-05-25  682  				sender->flags |= IP_CT_TCP_FLAG_MAXACK_SET;
bfcaa50270e18f Jozsef Kadlecsik  2009-05-25  683  			} else if (after(ack, sender->td_maxack))
bfcaa50270e18f Jozsef Kadlecsik  2009-05-25  684  				sender->td_maxack = ack;
bfcaa50270e18f Jozsef Kadlecsik  2009-05-25  685  		}
bfcaa50270e18f Jozsef Kadlecsik  2009-05-25  686  
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  687  		/*
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  688  		 * Update receiver data.
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  689  		 */
fac42a9a922fe5 Pablo Neira Ayuso 2010-07-15  690  		if (receiver->td_maxwin != 0 && after(end, sender->td_maxend))
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  691  			receiver->td_maxwin += end - sender->td_maxend;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  692  		if (after(sack + win, receiver->td_maxend - 1)) {
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  693  			receiver->td_maxend = sack + win;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  694  			if (win == 0)
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  695  				receiver->td_maxend++;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  696  		}
ae375044d31075 Patrick McHardy   2008-07-31  697  		if (ack == receiver->td_end)
ae375044d31075 Patrick McHardy   2008-07-31  698  			receiver->flags &= ~IP_CT_TCP_FLAG_DATA_UNACKNOWLEDGED;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  699  
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  700  		/*
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  701  		 * Check retransmissions.
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  702  		 */
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  703  		if (index == TCP_ACK_SET) {
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  704  			if (state->last_dir == dir
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  705  			    && state->last_seq == seq
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  706  			    && state->last_ack == ack
c1fe3ca5106d95 George Hansper    2006-09-20  707  			    && state->last_end == end
959b69ef57db00 Florian Westphal  2019-07-12  708  			    && state->last_win == win_raw)
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  709  				state->retrans++;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  710  			else {
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  711  				state->last_dir = dir;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  712  				state->last_seq = seq;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  713  				state->last_ack = ack;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  714  				state->last_end = end;
959b69ef57db00 Florian Westphal  2019-07-12  715  				state->last_win = win_raw;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  716  				state->retrans = 0;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  717  			}
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  718  		}
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  719  	} else {
a09113c2c8ec59 Patrick McHardy   2007-02-07  720  		if (sender->flags & IP_CT_TCP_FLAG_BE_LIBERAL ||
d2ba1fde42af44 Gao feng          2012-05-28  721  		    tn->tcp_be_liberal)
83d3b17508cc0f Florian Westphal  2022-08-26  722  			return NFCT_TCP_ACCEPT;
cf97769c761abf Florian Westphal  2022-08-19  723  
83d3b17508cc0f Florian Westphal  2022-08-26  724  		{
62eec0d73393a1 Florian Westphal  2021-06-16  725  			nf_ct_l4proto_log_invalid(skb, ct, hook_state,
3d0b527bc9dc0e Florian Westphal  2017-10-11  726  			"%s",
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  727  			before(seq, sender->td_maxend + 1) ?
356d7d88e08868 Yuchung Cheng     2013-08-09  728  			in_recv_win ?
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  729  			before(sack, receiver->td_end + 1) ?
f9dd09c7f71996 Jozsef Kadlecsik  2009-11-06  730  			after(sack, receiver->td_end - MAXACKWINDOW(sender) - 1) ? "BUG"
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  731  			: "ACK is under the lower bound (possible overly delayed ACK)"
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  732  			: "ACK is over the upper bound (ACKed data not seen yet)"
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  733  			: "SEQ is under the lower bound (already ACKed data retransmitted)"
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  734  			: "SEQ is over the upper bound (over the window of the receiver)");
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  735  		}
83d3b17508cc0f Florian Westphal  2022-08-26  736  
83d3b17508cc0f Florian Westphal  2022-08-26  737  		return NFCT_TCP_INVALID;
3d0b527bc9dc0e Florian Westphal  2017-10-11  738  	}
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  739  
83d3b17508cc0f Florian Westphal  2022-08-26  740  	return NFCT_TCP_ACCEPT;
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  741  }
9fb9cbb1082d6b Yasuyuki Kozakai  2005-11-09  742  

:::::: The code at line 592 was first introduced by commit
:::::: 82b72cb94666b3dbd7152bb9f441b068af7a921b netfilter: conntrack: re-init state for retransmitted syn-ack

:::::: TO: Florian Westphal <fw@strlen.de>
:::::: CC: Pablo Neira Ayuso <pablo@netfilter.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

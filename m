Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E2D573C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbiGMSbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGMSbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:31:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB811573F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657737071; x=1689273071;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3QnRhPh64HeXfzpympnk2nkM2z7KH7tJ3nEujSkU3Ow=;
  b=FW8Z/qfKgVFY91reSAOObI6VnkF/3fvhyz/xz9XUljJE4cQfgObYuptz
   Vj+cQ7jTHlSq+8ObKfm1/45s87Zw6lNI4VDgIb/Ejyfu19opF5u0Prnpw
   R03QDbb5/OgXNQ8SmX3nVFhrVbSuQju32FEsJrQJR2COcLh6SCxsifc1U
   fTDO6w64U+t+hPg0F9Rg3ExsaCl1ynW8YOd6PxLbHwjmdvxI9JcaeIOZh
   Q2UtPgCkoDfo6LpV3+WNKGd1rGuM4jI1mvRKctploZEoSWAJmGt4zNQvS
   xnlNqjJ9/HM1nY53P9rjLySQXvvhqLHwOC8jE8uKrF/SfnoRk7SwOEZIk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="346994622"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="346994622"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 11:31:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="663477838"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jul 2022 11:31:07 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBh8c-0003j0-MY;
        Wed, 13 Jul 2022 18:31:06 +0000
Date:   Thu, 14 Jul 2022 02:30:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     kbuild-all@lists.01.org, Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: [cilium:pr/meta5 4/4] net/sched/act_mirred.c:305:46: error: 'struct
 sk_buff' has no member named 'tc_at_ingress'
Message-ID: <202207140217.zh4joV8I-lkp@intel.com>
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

tree:   https://github.com/cilium/linux.git pr/meta5
head:   64ddc454b2645e9b3ed3129dc4970b618bbee2b4
commit: 64ddc454b2645e9b3ed3129dc4970b618bbee2b4 [4/4] bpf: Add initial fd-based API to attach tc BPF programs
config: alpha-randconfig-c003-20220712 (https://download.01.org/0day-ci/archive/20220714/202207140217.zh4joV8I-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/cilium/linux/commit/64ddc454b2645e9b3ed3129dc4970b618bbee2b4
        git remote add cilium https://github.com/cilium/linux.git
        git fetch --no-tags cilium pr/meta5
        git checkout 64ddc454b2645e9b3ed3129dc4970b618bbee2b4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash net/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/net/pkt_sched.h:9,
                    from net/sched/act_mirred.c:23:
   include/net/sch_generic.h: In function 'skb_at_tc_ingress':
   include/net/sch_generic.h:718:19: error: 'const struct sk_buff' has no member named 'tc_at_ingress'
     718 |         return skb->tc_at_ingress;
         |                   ^~
   include/net/sch_generic.h: In function 'skb_skip_tc_classify':
   include/net/sch_generic.h:727:16: error: 'struct sk_buff' has no member named 'tc_skip_classify'
     727 |         if (skb->tc_skip_classify) {
         |                ^~
   include/net/sch_generic.h:728:20: error: 'struct sk_buff' has no member named 'tc_skip_classify'
     728 |                 skb->tc_skip_classify = 0;
         |                    ^~
   net/sched/act_mirred.c: In function 'tcf_mirred_act':
>> net/sched/act_mirred.c:305:46: error: 'struct sk_buff' has no member named 'tc_at_ingress'
     305 |                 skb_set_redirected(skb2, skb2->tc_at_ingress);
         |                                              ^~
   In file included from include/net/pkt_sched.h:9,
                    from net/sched/act_mirred.c:23:
   include/net/sch_generic.h: In function 'skb_at_tc_ingress':
   include/net/sch_generic.h:722:1: error: control reaches end of non-void function [-Werror=return-type]
     722 | }
         | ^
   cc1: some warnings being treated as errors


vim +305 net/sched/act_mirred.c

fa6d639930ee5c net/sched/act_mirred.c wenxu             2020-11-25  220  
7c5790c4da0e5b net/sched/act_mirred.c Jamal Hadi Salim  2018-08-12  221  static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
e9ce1cd3cf6cf3 net/sched/act_mirred.c David S. Miller   2006-08-21  222  			  struct tcf_result *res)
^1da177e4c3f41 net/sched/mirred.c     Linus Torvalds    2005-04-16  223  {
a85a970af265f1 net/sched/act_mirred.c WANG Cong         2016-07-25  224  	struct tcf_mirred *m = to_mirred(a);
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  225  	struct sk_buff *skb2 = skb;
53592b3640019f net/sched/act_mirred.c Shmulik Ladkani   2016-10-13  226  	bool m_mac_header_xmit;
^1da177e4c3f41 net/sched/mirred.c     Linus Torvalds    2005-04-16  227  	struct net_device *dev;
e2ca070f89ecd9 net/sched/act_mirred.c John Hurley       2019-06-24  228  	unsigned int rec_level;
53592b3640019f net/sched/act_mirred.c Shmulik Ladkani   2016-10-13  229  	int retval, err = 0;
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  230  	bool use_reinsert;
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  231  	bool want_ingress;
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  232  	bool is_redirect;
70cf3dc7313207 net/sched/act_mirred.c Shmulik Ladkani   2019-12-25  233  	bool expects_nh;
f799ada6bf2397 net/sched/act_mirred.c Xin Long          2021-11-12  234  	bool at_ingress;
53592b3640019f net/sched/act_mirred.c Shmulik Ladkani   2016-10-13  235  	int m_eaction;
53592b3640019f net/sched/act_mirred.c Shmulik Ladkani   2016-10-13  236  	int mac_len;
70cf3dc7313207 net/sched/act_mirred.c Shmulik Ladkani   2019-12-25  237  	bool at_nh;
^1da177e4c3f41 net/sched/mirred.c     Linus Torvalds    2005-04-16  238  
e2ca070f89ecd9 net/sched/act_mirred.c John Hurley       2019-06-24  239  	rec_level = __this_cpu_inc_return(mirred_rec_level);
e2ca070f89ecd9 net/sched/act_mirred.c John Hurley       2019-06-24  240  	if (unlikely(rec_level > MIRRED_RECURSION_LIMIT)) {
e2ca070f89ecd9 net/sched/act_mirred.c John Hurley       2019-06-24  241  		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n",
e2ca070f89ecd9 net/sched/act_mirred.c John Hurley       2019-06-24  242  				     netdev_name(skb->dev));
e2ca070f89ecd9 net/sched/act_mirred.c John Hurley       2019-06-24  243  		__this_cpu_dec(mirred_rec_level);
e2ca070f89ecd9 net/sched/act_mirred.c John Hurley       2019-06-24  244  		return TC_ACT_SHOT;
e2ca070f89ecd9 net/sched/act_mirred.c John Hurley       2019-06-24  245  	}
e2ca070f89ecd9 net/sched/act_mirred.c John Hurley       2019-06-24  246  
2ee22a90c7afac net/sched/act_mirred.c Eric Dumazet      2015-07-06  247  	tcf_lastuse_update(&m->tcf_tm);
5e1ad95b630e65 net/sched/act_mirred.c Vlad Buslov       2019-10-30  248  	tcf_action_update_bstats(&m->common, skb);
^1da177e4c3f41 net/sched/mirred.c     Linus Torvalds    2005-04-16  249  
53592b3640019f net/sched/act_mirred.c Shmulik Ladkani   2016-10-13  250  	m_mac_header_xmit = READ_ONCE(m->tcfm_mac_header_xmit);
53592b3640019f net/sched/act_mirred.c Shmulik Ladkani   2016-10-13  251  	m_eaction = READ_ONCE(m->tcfm_eaction);
2ee22a90c7afac net/sched/act_mirred.c Eric Dumazet      2015-07-06  252  	retval = READ_ONCE(m->tcf_action);
7fd4b288ea6a3e net/sched/act_mirred.c Paolo Abeni       2018-07-30  253  	dev = rcu_dereference_bh(m->tcfm_dev);
2ee22a90c7afac net/sched/act_mirred.c Eric Dumazet      2015-07-06  254  	if (unlikely(!dev)) {
2ee22a90c7afac net/sched/act_mirred.c Eric Dumazet      2015-07-06  255  		pr_notice_once("tc mirred: target device is gone\n");
3b87956ea645fb net/sched/act_mirred.c stephen hemminger 2010-07-22  256  		goto out;
3b87956ea645fb net/sched/act_mirred.c stephen hemminger 2010-07-22  257  	}
3b87956ea645fb net/sched/act_mirred.c stephen hemminger 2010-07-22  258  
2ee22a90c7afac net/sched/act_mirred.c Eric Dumazet      2015-07-06  259  	if (unlikely(!(dev->flags & IFF_UP))) {
e87cc4728f0e2f net/sched/act_mirred.c Joe Perches       2012-05-13  260  		net_notice_ratelimited("tc mirred to Houston: device %s is down\n",
^1da177e4c3f41 net/sched/mirred.c     Linus Torvalds    2005-04-16  261  				       dev->name);
feed1f17241d26 net/sched/act_mirred.c Changli Gao       2009-11-17  262  		goto out;
^1da177e4c3f41 net/sched/mirred.c     Linus Torvalds    2005-04-16  263  	}
^1da177e4c3f41 net/sched/mirred.c     Linus Torvalds    2005-04-16  264  
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  265  	/* we could easily avoid the clone only if called by ingress and clsact;
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  266  	 * since we can't easily detect the clsact caller, skip clone only for
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  267  	 * ingress - that covers the TC S/W datapath.
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  268  	 */
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  269  	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
f799ada6bf2397 net/sched/act_mirred.c Xin Long          2021-11-12  270  	at_ingress = skb_at_tc_ingress(skb);
f799ada6bf2397 net/sched/act_mirred.c Xin Long          2021-11-12  271  	use_reinsert = at_ingress && is_redirect &&
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  272  		       tcf_mirred_can_reinsert(retval);
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  273  	if (!use_reinsert) {
e578d9c02587d5 net/sched/act_mirred.c Florian Westphal  2015-05-11  274  		skb2 = skb_clone(skb, GFP_ATOMIC);
2ee22a90c7afac net/sched/act_mirred.c Eric Dumazet      2015-07-06  275  		if (!skb2)
feed1f17241d26 net/sched/act_mirred.c Changli Gao       2009-11-17  276  			goto out;
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  277  	}
^1da177e4c3f41 net/sched/mirred.c     Linus Torvalds    2005-04-16  278  
f799ada6bf2397 net/sched/act_mirred.c Xin Long          2021-11-12  279  	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
f799ada6bf2397 net/sched/act_mirred.c Xin Long          2021-11-12  280  
d09c548dbf3b31 net/sched/act_mirred.c Hangbin Liu       2021-08-09  281  	/* All mirred/redirected skbs should clear previous ct info */
d09c548dbf3b31 net/sched/act_mirred.c Hangbin Liu       2021-08-09  282  	nf_reset_ct(skb2);
f799ada6bf2397 net/sched/act_mirred.c Xin Long          2021-11-12  283  	if (want_ingress && !at_ingress) /* drop dst for egress -> ingress */
f799ada6bf2397 net/sched/act_mirred.c Xin Long          2021-11-12  284  		skb_dst_drop(skb2);
70cf3dc7313207 net/sched/act_mirred.c Shmulik Ladkani   2019-12-25  285  
70cf3dc7313207 net/sched/act_mirred.c Shmulik Ladkani   2019-12-25  286  	expects_nh = want_ingress || !m_mac_header_xmit;
70cf3dc7313207 net/sched/act_mirred.c Shmulik Ladkani   2019-12-25  287  	at_nh = skb->data == skb_network_header(skb);
70cf3dc7313207 net/sched/act_mirred.c Shmulik Ladkani   2019-12-25  288  	if (at_nh != expects_nh) {
70cf3dc7313207 net/sched/act_mirred.c Shmulik Ladkani   2019-12-25  289  		mac_len = skb_at_tc_ingress(skb) ? skb->mac_len :
70cf3dc7313207 net/sched/act_mirred.c Shmulik Ladkani   2019-12-25  290  			  skb_network_header(skb) - skb_mac_header(skb);
70cf3dc7313207 net/sched/act_mirred.c Shmulik Ladkani   2019-12-25  291  		if (expects_nh) {
70cf3dc7313207 net/sched/act_mirred.c Shmulik Ladkani   2019-12-25  292  			/* target device/action expect data at nh */
53592b3640019f net/sched/act_mirred.c Shmulik Ladkani   2016-10-13  293  			skb_pull_rcsum(skb2, mac_len);
53592b3640019f net/sched/act_mirred.c Shmulik Ladkani   2016-10-13  294  		} else {
70cf3dc7313207 net/sched/act_mirred.c Shmulik Ladkani   2019-12-25  295  			/* target device/action expect data at mac */
70cf3dc7313207 net/sched/act_mirred.c Shmulik Ladkani   2019-12-25  296  			skb_push_rcsum(skb2, mac_len);
feed1f17241d26 net/sched/act_mirred.c Changli Gao       2009-11-17  297  		}
53592b3640019f net/sched/act_mirred.c Shmulik Ladkani   2016-10-13  298  	}
^1da177e4c3f41 net/sched/mirred.c     Linus Torvalds    2005-04-16  299  
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  300  	skb2->skb_iif = skb->dev->ifindex;
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  301  	skb2->dev = dev;
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  302  
^1da177e4c3f41 net/sched/mirred.c     Linus Torvalds    2005-04-16  303  	/* mirror is always swallowed */
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  304  	if (is_redirect) {
2c64605b590eda net/sched/act_mirred.c Pablo Neira Ayuso 2020-03-25 @305  		skb_set_redirected(skb2, skb2->tc_at_ingress);
2c64605b590eda net/sched/act_mirred.c Pablo Neira Ayuso 2020-03-25  306  
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  307  		/* let's the caller reinsert the packet, if possible */
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  308  		if (use_reinsert) {
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  309  			res->ingress = want_ingress;
fa6d639930ee5c net/sched/act_mirred.c wenxu             2020-11-25  310  			err = tcf_mirred_forward(res->ingress, skb);
fa6d639930ee5c net/sched/act_mirred.c wenxu             2020-11-25  311  			if (err)
ef816f3c49c1c4 net/sched/act_mirred.c Vlad Buslov       2019-10-30  312  				tcf_action_inc_overlimit_qstats(&m->common);
e2ca070f89ecd9 net/sched/act_mirred.c John Hurley       2019-06-24  313  			__this_cpu_dec(mirred_rec_level);
720f22fed81bc6 net/sched/act_mirred.c John Hurley       2019-06-24  314  			return TC_ACT_CONSUMED;
e5cf1baf92cb78 net/sched/act_mirred.c Paolo Abeni       2018-07-30  315  		}
bc31c905e946b5 net/sched/act_mirred.c Willem de Bruijn  2017-01-07  316  	}
^1da177e4c3f41 net/sched/mirred.c     Linus Torvalds    2005-04-16  317  
fa6d639930ee5c net/sched/act_mirred.c wenxu             2020-11-25  318  	err = tcf_mirred_forward(want_ingress, skb2);
feed1f17241d26 net/sched/act_mirred.c Changli Gao       2009-11-17  319  	if (err) {
2ee22a90c7afac net/sched/act_mirred.c Eric Dumazet      2015-07-06  320  out:
26b537a88ca5b7 net/sched/act_mirred.c Vlad Buslov       2019-10-30  321  		tcf_action_inc_overlimit_qstats(&m->common);
53592b3640019f net/sched/act_mirred.c Shmulik Ladkani   2016-10-13  322  		if (tcf_mirred_is_act_redirect(m_eaction))
feed1f17241d26 net/sched/act_mirred.c Changli Gao       2009-11-17  323  			retval = TC_ACT_SHOT;
2ee22a90c7afac net/sched/act_mirred.c Eric Dumazet      2015-07-06  324  	}
e2ca070f89ecd9 net/sched/act_mirred.c John Hurley       2019-06-24  325  	__this_cpu_dec(mirred_rec_level);
feed1f17241d26 net/sched/act_mirred.c Changli Gao       2009-11-17  326  
feed1f17241d26 net/sched/act_mirred.c Changli Gao       2009-11-17  327  	return retval;
^1da177e4c3f41 net/sched/mirred.c     Linus Torvalds    2005-04-16  328  }
^1da177e4c3f41 net/sched/mirred.c     Linus Torvalds    2005-04-16  329  

:::::: The code at line 305 was first introduced by commit
:::::: 2c64605b590edadb3fb46d1ec6badb49e940b479 net: Fix CONFIG_NET_CLS_ACT=n and CONFIG_NFT_FWD_NETDEV={y, m} build

:::::: TO: Pablo Neira Ayuso <pablo@netfilter.org>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

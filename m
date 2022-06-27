Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C2C55C906
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbiF0Trw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240752AbiF0Trv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:47:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD281B78F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656359269; x=1687895269;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rLp94nvMX3axrV1ydEh5ID4xXANNNlZtibX0f5HJxVo=;
  b=ZWM1hJFR5q8NCQxnXYuVmRTZg7PmRIOpNib3C1TdueJR/2fhpDdUA+tP
   4yhnTbviT366YC6aHHlymwI2wxzjvSiNX980f5byez+She09+J/RN4k2U
   UICZxqN6/Frx1HFRt192Jz7rxU+PZ3uOMKrW/Znm8azy6wDM1uLXKGYFv
   jyIu1//ejmtcRD4KcdfaivJRNQDqlqg0Mz9QQL03vjuNKG1jC+jF7fxpd
   AYucNAvOcXJTJEB8kAC6u0q8EzieDhHyQAfTJ+uSi6UWl9G7sRFQ4lPYv
   HH/rmVPQV6brIRljoIZRSA910eHUqDCaJGegffXo94PoXAbiqNcO2gbMO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="367861868"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="367861868"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 12:47:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="732458242"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2022 12:47:47 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5ui2-0008wh-Gz;
        Mon, 27 Jun 2022 19:47:46 +0000
Date:   Tue, 28 Jun 2022 03:47:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [linux-stable-rc:linux-4.9.y 1600/2151] net/sched/cls_api.c:272:9:
 warning: unused variable 'name'
Message-ID: <202206280318.h76sjHoX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
head:   e807fcde67db3005d9e23498ad56d0136708298b
commit: 2b29404f4eea7da878a8a8c5b301d9adf6f56d55 [1600/2151] net: sched: prevent UAF on tc_ctl_tfilter when temporarily dropping rtnl_lock
config: i386-buildonly-randconfig-r006-20220627 (https://download.01.org/0day-ci/archive/20220628/202206280318.h76sjHoX-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=2b29404f4eea7da878a8a8c5b301d9adf6f56d55
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-4.9.y
        git checkout 2b29404f4eea7da878a8a8c5b301d9adf6f56d55
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/sched/cls_api.c: In function 'tc_ctl_tfilter':
>> net/sched/cls_api.c:272:9: warning: unused variable 'name' [-Wunused-variable]
       char name[IFNAMSIZ];
            ^~~~
>> net/sched/cls_api.c:271:19: warning: unused variable 'kind' [-Wunused-variable]
       struct nlattr *kind = tca[TCA_KIND];
                      ^~~~


vim +/name +272 net/sched/cls_api.c

^1da177e4c3f41 Linus Torvalds                2005-04-16  131  
661d2967b3f1b3 Thomas Graf                   2013-03-21  132  static int tc_ctl_tfilter(struct sk_buff *skb, struct nlmsghdr *n)
^1da177e4c3f41 Linus Torvalds                2005-04-16  133  {
3b1e0a655f8eba YOSHIFUJI Hideaki             2008-03-26  134  	struct net *net = sock_net(skb->sk);
add93b610a4e66 Patrick McHardy               2008-01-22  135  	struct nlattr *tca[TCA_MAX + 1];
^1da177e4c3f41 Linus Torvalds                2005-04-16  136  	struct tcmsg *t;
^1da177e4c3f41 Linus Torvalds                2005-04-16  137  	u32 protocol;
^1da177e4c3f41 Linus Torvalds                2005-04-16  138  	u32 prio;
^1da177e4c3f41 Linus Torvalds                2005-04-16  139  	u32 nprio;
^1da177e4c3f41 Linus Torvalds                2005-04-16  140  	u32 parent;
^1da177e4c3f41 Linus Torvalds                2005-04-16  141  	struct net_device *dev;
^1da177e4c3f41 Linus Torvalds                2005-04-16  142  	struct Qdisc  *q;
25d8c0d55f241c John Fastabend                2014-09-12  143  	struct tcf_proto __rcu **back;
25d8c0d55f241c John Fastabend                2014-09-12  144  	struct tcf_proto __rcu **chain;
^1da177e4c3f41 Linus Torvalds                2005-04-16  145  	struct tcf_proto *tp;
dc7f9f6e883855 Eric Dumazet                  2011-07-05  146  	const struct tcf_proto_ops *tp_ops;
20fea08b5fb639 Eric Dumazet                  2007-11-14  147  	const struct Qdisc_class_ops *cops;
^1da177e4c3f41 Linus Torvalds                2005-04-16  148  	unsigned long cl;
^1da177e4c3f41 Linus Torvalds                2005-04-16  149  	unsigned long fh;
^1da177e4c3f41 Linus Torvalds                2005-04-16  150  	int err;
09babe4ce12ef1 Daniel Borkmann               2016-12-21  151  	int tp_created;
^1da177e4c3f41 Linus Torvalds                2005-04-16  152  
4e8bbb819d1594 Stéphane Graber               2014-04-30  153  	if ((n->nlmsg_type != RTM_GETTFILTER) &&
5f013c9bc70214 David S. Miller               2014-05-12  154  	    !netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN))
dfc47ef8639fac Eric W. Biederman             2012-11-16  155  		return -EPERM;
de179c8c12e9e5 Hong zhi guo                  2013-03-25  156  
^1da177e4c3f41 Linus Torvalds                2005-04-16  157  replay:
09babe4ce12ef1 Daniel Borkmann               2016-12-21  158  	tp_created = 0;
09babe4ce12ef1 Daniel Borkmann               2016-12-21  159  
de179c8c12e9e5 Hong zhi guo                  2013-03-25  160  	err = nlmsg_parse(n, sizeof(*t), tca, TCA_MAX, NULL);
de179c8c12e9e5 Hong zhi guo                  2013-03-25  161  	if (err < 0)
de179c8c12e9e5 Hong zhi guo                  2013-03-25  162  		return err;
de179c8c12e9e5 Hong zhi guo                  2013-03-25  163  
942b81653a5252 David S. Miller               2012-06-26  164  	t = nlmsg_data(n);
^1da177e4c3f41 Linus Torvalds                2005-04-16  165  	protocol = TC_H_MIN(t->tcm_info);
^1da177e4c3f41 Linus Torvalds                2005-04-16  166  	prio = TC_H_MAJ(t->tcm_info);
^1da177e4c3f41 Linus Torvalds                2005-04-16  167  	nprio = prio;
^1da177e4c3f41 Linus Torvalds                2005-04-16  168  	parent = t->tcm_parent;
^1da177e4c3f41 Linus Torvalds                2005-04-16  169  	cl = 0;
^1da177e4c3f41 Linus Torvalds                2005-04-16  170  
^1da177e4c3f41 Linus Torvalds                2005-04-16  171  	if (prio == 0) {
ea7f8277f9076d Daniel Borkmann               2016-06-10  172  		switch (n->nlmsg_type) {
ea7f8277f9076d Daniel Borkmann               2016-06-10  173  		case RTM_DELTFILTER:
9f6ed032cd951d Daniel Borkmann               2016-06-16  174  			if (protocol || t->tcm_handle || tca[TCA_KIND])
^1da177e4c3f41 Linus Torvalds                2005-04-16  175  				return -ENOENT;
ea7f8277f9076d Daniel Borkmann               2016-06-10  176  			break;
ea7f8277f9076d Daniel Borkmann               2016-06-10  177  		case RTM_NEWTFILTER:
ea7f8277f9076d Daniel Borkmann               2016-06-10  178  			/* If no priority is provided by the user,
ea7f8277f9076d Daniel Borkmann               2016-06-10  179  			 * we allocate one.
ea7f8277f9076d Daniel Borkmann               2016-06-10  180  			 */
ea7f8277f9076d Daniel Borkmann               2016-06-10  181  			if (n->nlmsg_flags & NLM_F_CREATE) {
^1da177e4c3f41 Linus Torvalds                2005-04-16  182  				prio = TC_H_MAKE(0x80000000U, 0U);
ea7f8277f9076d Daniel Borkmann               2016-06-10  183  				break;
ea7f8277f9076d Daniel Borkmann               2016-06-10  184  			}
ea7f8277f9076d Daniel Borkmann               2016-06-10  185  			/* fall-through */
ea7f8277f9076d Daniel Borkmann               2016-06-10  186  		default:
ea7f8277f9076d Daniel Borkmann               2016-06-10  187  			return -ENOENT;
ea7f8277f9076d Daniel Borkmann               2016-06-10  188  		}
^1da177e4c3f41 Linus Torvalds                2005-04-16  189  	}
^1da177e4c3f41 Linus Torvalds                2005-04-16  190  
^1da177e4c3f41 Linus Torvalds                2005-04-16  191  	/* Find head of filter chain. */
^1da177e4c3f41 Linus Torvalds                2005-04-16  192  
^1da177e4c3f41 Linus Torvalds                2005-04-16  193  	/* Find link */
7316ae88c43d47 Tom Goff                      2010-03-19  194  	dev = __dev_get_by_index(net, t->tcm_ifindex);
aa767bfea48289 Stephen Hemminger             2008-01-21  195  	if (dev == NULL)
^1da177e4c3f41 Linus Torvalds                2005-04-16  196  		return -ENODEV;
^1da177e4c3f41 Linus Torvalds                2005-04-16  197  
^1da177e4c3f41 Linus Torvalds                2005-04-16  198  	/* Find qdisc */
^1da177e4c3f41 Linus Torvalds                2005-04-16  199  	if (!parent) {
af356afa010f3c Patrick McHardy               2009-09-04  200  		q = dev->qdisc;
^1da177e4c3f41 Linus Torvalds                2005-04-16  201  		parent = q->handle;
aa767bfea48289 Stephen Hemminger             2008-01-21  202  	} else {
aa767bfea48289 Stephen Hemminger             2008-01-21  203  		q = qdisc_lookup(dev, TC_H_MAJ(t->tcm_parent));
aa767bfea48289 Stephen Hemminger             2008-01-21  204  		if (q == NULL)
^1da177e4c3f41 Linus Torvalds                2005-04-16  205  			return -EINVAL;
aa767bfea48289 Stephen Hemminger             2008-01-21  206  	}
^1da177e4c3f41 Linus Torvalds                2005-04-16  207  
^1da177e4c3f41 Linus Torvalds                2005-04-16  208  	/* Is it classful? */
cc7ec456f82da7 Eric Dumazet                  2011-01-19  209  	cops = q->ops->cl_ops;
cc7ec456f82da7 Eric Dumazet                  2011-01-19  210  	if (!cops)
^1da177e4c3f41 Linus Torvalds                2005-04-16  211  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds                2005-04-16  212  
71ebe5e9194739 Patrick McHardy               2009-09-04  213  	if (cops->tcf_chain == NULL)
71ebe5e9194739 Patrick McHardy               2009-09-04  214  		return -EOPNOTSUPP;
71ebe5e9194739 Patrick McHardy               2009-09-04  215  
^1da177e4c3f41 Linus Torvalds                2005-04-16  216  	/* Do we search for filter, attached to class? */
^1da177e4c3f41 Linus Torvalds                2005-04-16  217  	if (TC_H_MIN(parent)) {
^1da177e4c3f41 Linus Torvalds                2005-04-16  218  		cl = cops->get(q, parent);
^1da177e4c3f41 Linus Torvalds                2005-04-16  219  		if (cl == 0)
^1da177e4c3f41 Linus Torvalds                2005-04-16  220  			return -ENOENT;
^1da177e4c3f41 Linus Torvalds                2005-04-16  221  	}
^1da177e4c3f41 Linus Torvalds                2005-04-16  222  
^1da177e4c3f41 Linus Torvalds                2005-04-16  223  	/* And the last stroke */
^1da177e4c3f41 Linus Torvalds                2005-04-16  224  	chain = cops->tcf_chain(q, cl);
^1da177e4c3f41 Linus Torvalds                2005-04-16  225  	err = -EINVAL;
^1da177e4c3f41 Linus Torvalds                2005-04-16  226  	if (chain == NULL)
^1da177e4c3f41 Linus Torvalds                2005-04-16  227  		goto errout;
ea7f8277f9076d Daniel Borkmann               2016-06-10  228  	if (n->nlmsg_type == RTM_DELTFILTER && prio == 0) {
ea7f8277f9076d Daniel Borkmann               2016-06-10  229  		tfilter_notify_chain(net, skb, n, chain, RTM_DELTFILTER);
ea7f8277f9076d Daniel Borkmann               2016-06-10  230  		tcf_destroy_chain(chain);
ea7f8277f9076d Daniel Borkmann               2016-06-10  231  		err = 0;
ea7f8277f9076d Daniel Borkmann               2016-06-10  232  		goto errout;
ea7f8277f9076d Daniel Borkmann               2016-06-10  233  	}
^1da177e4c3f41 Linus Torvalds                2005-04-16  234  
^1da177e4c3f41 Linus Torvalds                2005-04-16  235  	/* Check the chain for existence of proto-tcf with this priority */
25d8c0d55f241c John Fastabend                2014-09-12  236  	for (back = chain;
25d8c0d55f241c John Fastabend                2014-09-12  237  	     (tp = rtnl_dereference(*back)) != NULL;
25d8c0d55f241c John Fastabend                2014-09-12  238  	     back = &tp->next) {
^1da177e4c3f41 Linus Torvalds                2005-04-16  239  		if (tp->prio >= prio) {
^1da177e4c3f41 Linus Torvalds                2005-04-16  240  			if (tp->prio == prio) {
cc7ec456f82da7 Eric Dumazet                  2011-01-19  241  				if (!nprio ||
cc7ec456f82da7 Eric Dumazet                  2011-01-19  242  				    (tp->protocol != protocol && protocol))
^1da177e4c3f41 Linus Torvalds                2005-04-16  243  					goto errout;
^1da177e4c3f41 Linus Torvalds                2005-04-16  244  			} else
^1da177e4c3f41 Linus Torvalds                2005-04-16  245  				tp = NULL;
^1da177e4c3f41 Linus Torvalds                2005-04-16  246  			break;
^1da177e4c3f41 Linus Torvalds                2005-04-16  247  		}
^1da177e4c3f41 Linus Torvalds                2005-04-16  248  	}
^1da177e4c3f41 Linus Torvalds                2005-04-16  249  
^1da177e4c3f41 Linus Torvalds                2005-04-16  250  	if (tp == NULL) {
^1da177e4c3f41 Linus Torvalds                2005-04-16  251  		/* Proto-tcf does not exist, create new one */
^1da177e4c3f41 Linus Torvalds                2005-04-16  252  
add93b610a4e66 Patrick McHardy               2008-01-22  253  		if (tca[TCA_KIND] == NULL || !protocol)
^1da177e4c3f41 Linus Torvalds                2005-04-16  254  			goto errout;
^1da177e4c3f41 Linus Torvalds                2005-04-16  255  
^1da177e4c3f41 Linus Torvalds                2005-04-16  256  		err = -ENOENT;
cc7ec456f82da7 Eric Dumazet                  2011-01-19  257  		if (n->nlmsg_type != RTM_NEWTFILTER ||
cc7ec456f82da7 Eric Dumazet                  2011-01-19  258  		    !(n->nlmsg_flags & NLM_F_CREATE))
^1da177e4c3f41 Linus Torvalds                2005-04-16  259  			goto errout;
^1da177e4c3f41 Linus Torvalds                2005-04-16  260  
^1da177e4c3f41 Linus Torvalds                2005-04-16  261  
^1da177e4c3f41 Linus Torvalds                2005-04-16  262  		/* Create new proto tcf */
^1da177e4c3f41 Linus Torvalds                2005-04-16  263  
^1da177e4c3f41 Linus Torvalds                2005-04-16  264  		err = -ENOBUFS;
aa767bfea48289 Stephen Hemminger             2008-01-21  265  		tp = kzalloc(sizeof(*tp), GFP_KERNEL);
aa767bfea48289 Stephen Hemminger             2008-01-21  266  		if (tp == NULL)
^1da177e4c3f41 Linus Torvalds                2005-04-16  267  			goto errout;
f2df824948d559 Patrick McHardy               2008-05-20  268  		err = -ENOENT;
add93b610a4e66 Patrick McHardy               2008-01-22  269  		tp_ops = tcf_proto_lookup_ops(tca[TCA_KIND]);
^1da177e4c3f41 Linus Torvalds                2005-04-16  270  		if (tp_ops == NULL) {
add93b610a4e66 Patrick McHardy               2008-01-22 @271  			struct nlattr *kind = tca[TCA_KIND];
^1da177e4c3f41 Linus Torvalds                2005-04-16 @272  			char name[IFNAMSIZ];
^1da177e4c3f41 Linus Torvalds                2005-04-16  273  
2b29404f4eea7d Thadeu Lima de Souza Cascardo 2022-05-02  274  			if (cl)
2b29404f4eea7d Thadeu Lima de Souza Cascardo 2022-05-02  275  				cops->put(q, cl);
2b29404f4eea7d Thadeu Lima de Souza Cascardo 2022-05-02  276  			cl = 0;
2b29404f4eea7d Thadeu Lima de Souza Cascardo 2022-05-02  277  #ifdef CONFIG_MODULES
^1da177e4c3f41 Linus Torvalds                2005-04-16  278  			if (kind != NULL &&
add93b610a4e66 Patrick McHardy               2008-01-22  279  			    nla_strlcpy(name, kind, IFNAMSIZ) < IFNAMSIZ) {
^1da177e4c3f41 Linus Torvalds                2005-04-16  280  				rtnl_unlock();
^1da177e4c3f41 Linus Torvalds                2005-04-16  281  				request_module("cls_%s", name);
^1da177e4c3f41 Linus Torvalds                2005-04-16  282  				rtnl_lock();
^1da177e4c3f41 Linus Torvalds                2005-04-16  283  				tp_ops = tcf_proto_lookup_ops(kind);
^1da177e4c3f41 Linus Torvalds                2005-04-16  284  				/* We dropped the RTNL semaphore in order to
^1da177e4c3f41 Linus Torvalds                2005-04-16  285  				 * perform the module load.  So, even if we
^1da177e4c3f41 Linus Torvalds                2005-04-16  286  				 * succeeded in loading the module we have to
^1da177e4c3f41 Linus Torvalds                2005-04-16  287  				 * replay the request.  We indicate this using
^1da177e4c3f41 Linus Torvalds                2005-04-16  288  				 * -EAGAIN.
^1da177e4c3f41 Linus Torvalds                2005-04-16  289  				 */
^1da177e4c3f41 Linus Torvalds                2005-04-16  290  				if (tp_ops != NULL) {
^1da177e4c3f41 Linus Torvalds                2005-04-16  291  					module_put(tp_ops->owner);
^1da177e4c3f41 Linus Torvalds                2005-04-16  292  					err = -EAGAIN;
^1da177e4c3f41 Linus Torvalds                2005-04-16  293  				}
^1da177e4c3f41 Linus Torvalds                2005-04-16  294  			}
^1da177e4c3f41 Linus Torvalds                2005-04-16  295  #endif
^1da177e4c3f41 Linus Torvalds                2005-04-16  296  			kfree(tp);
^1da177e4c3f41 Linus Torvalds                2005-04-16  297  			goto errout;
^1da177e4c3f41 Linus Torvalds                2005-04-16  298  		}
^1da177e4c3f41 Linus Torvalds                2005-04-16  299  		tp->ops = tp_ops;
^1da177e4c3f41 Linus Torvalds                2005-04-16  300  		tp->protocol = protocol;
25d8c0d55f241c John Fastabend                2014-09-12  301  		tp->prio = nprio ? :
25d8c0d55f241c John Fastabend                2014-09-12  302  			       TC_H_MAJ(tcf_auto_prio(rtnl_dereference(*back)));
^1da177e4c3f41 Linus Torvalds                2005-04-16  303  		tp->q = q;
^1da177e4c3f41 Linus Torvalds                2005-04-16  304  		tp->classify = tp_ops->classify;
^1da177e4c3f41 Linus Torvalds                2005-04-16  305  		tp->classid = parent;
aa767bfea48289 Stephen Hemminger             2008-01-21  306  
aa767bfea48289 Stephen Hemminger             2008-01-21  307  		err = tp_ops->init(tp);
aa767bfea48289 Stephen Hemminger             2008-01-21  308  		if (err != 0) {
^1da177e4c3f41 Linus Torvalds                2005-04-16  309  			module_put(tp_ops->owner);
^1da177e4c3f41 Linus Torvalds                2005-04-16  310  			kfree(tp);
^1da177e4c3f41 Linus Torvalds                2005-04-16  311  			goto errout;
^1da177e4c3f41 Linus Torvalds                2005-04-16  312  		}
^1da177e4c3f41 Linus Torvalds                2005-04-16  313  
12186be7d2e110 Minoru Usui                   2009-06-02  314  		tp_created = 1;
^1da177e4c3f41 Linus Torvalds                2005-04-16  315  
add93b610a4e66 Patrick McHardy               2008-01-22  316  	} else if (tca[TCA_KIND] && nla_strcmp(tca[TCA_KIND], tp->ops->kind))
^1da177e4c3f41 Linus Torvalds                2005-04-16  317  		goto errout;
^1da177e4c3f41 Linus Torvalds                2005-04-16  318  
^1da177e4c3f41 Linus Torvalds                2005-04-16  319  	fh = tp->ops->get(tp, t->tcm_handle);
^1da177e4c3f41 Linus Torvalds                2005-04-16  320  
^1da177e4c3f41 Linus Torvalds                2005-04-16  321  	if (fh == 0) {
^1da177e4c3f41 Linus Torvalds                2005-04-16  322  		if (n->nlmsg_type == RTM_DELTFILTER && t->tcm_handle == 0) {
25d8c0d55f241c John Fastabend                2014-09-12  323  			struct tcf_proto *next = rtnl_dereference(tp->next);
25d8c0d55f241c John Fastabend                2014-09-12  324  
25d8c0d55f241c John Fastabend                2014-09-12  325  			RCU_INIT_POINTER(*back, next);
^1da177e4c3f41 Linus Torvalds                2005-04-16  326  
fa59b27c9d6f84 Eric Dumazet                  2016-10-09  327  			tfilter_notify(net, skb, n, tp, fh,
fa59b27c9d6f84 Eric Dumazet                  2016-10-09  328  				       RTM_DELTFILTER, false);
1e052be69d045c Cong Wang                     2015-03-06  329  			tcf_destroy(tp, true);
^1da177e4c3f41 Linus Torvalds                2005-04-16  330  			err = 0;
^1da177e4c3f41 Linus Torvalds                2005-04-16  331  			goto errout;
^1da177e4c3f41 Linus Torvalds                2005-04-16  332  		}
^1da177e4c3f41 Linus Torvalds                2005-04-16  333  
^1da177e4c3f41 Linus Torvalds                2005-04-16  334  		err = -ENOENT;
aa767bfea48289 Stephen Hemminger             2008-01-21  335  		if (n->nlmsg_type != RTM_NEWTFILTER ||
aa767bfea48289 Stephen Hemminger             2008-01-21  336  		    !(n->nlmsg_flags & NLM_F_CREATE))
^1da177e4c3f41 Linus Torvalds                2005-04-16  337  			goto errout;
^1da177e4c3f41 Linus Torvalds                2005-04-16  338  	} else {
^1da177e4c3f41 Linus Torvalds                2005-04-16  339  		switch (n->nlmsg_type) {
^1da177e4c3f41 Linus Torvalds                2005-04-16  340  		case RTM_NEWTFILTER:
^1da177e4c3f41 Linus Torvalds                2005-04-16  341  			err = -EEXIST;
12186be7d2e110 Minoru Usui                   2009-06-02  342  			if (n->nlmsg_flags & NLM_F_EXCL) {
12186be7d2e110 Minoru Usui                   2009-06-02  343  				if (tp_created)
1e052be69d045c Cong Wang                     2015-03-06  344  					tcf_destroy(tp, true);
^1da177e4c3f41 Linus Torvalds                2005-04-16  345  				goto errout;
12186be7d2e110 Minoru Usui                   2009-06-02  346  			}
^1da177e4c3f41 Linus Torvalds                2005-04-16  347  			break;
^1da177e4c3f41 Linus Torvalds                2005-04-16  348  		case RTM_DELTFILTER:
^1da177e4c3f41 Linus Torvalds                2005-04-16  349  			err = tp->ops->delete(tp, fh);
1e052be69d045c Cong Wang                     2015-03-06  350  			if (err == 0) {
1e052be69d045c Cong Wang                     2015-03-06  351  				struct tcf_proto *next = rtnl_dereference(tp->next);
1e052be69d045c Cong Wang                     2015-03-06  352  
9ee7837449b3d6 Jamal Hadi Salim              2016-10-24  353  				tfilter_notify(net, skb, n, tp,
9ee7837449b3d6 Jamal Hadi Salim              2016-10-24  354  					       t->tcm_handle,
fa59b27c9d6f84 Eric Dumazet                  2016-10-09  355  					       RTM_DELTFILTER, false);
d744318574090c WANG Cong                     2015-05-05  356  				if (tcf_destroy(tp, false))
1e052be69d045c Cong Wang                     2015-03-06  357  					RCU_INIT_POINTER(*back, next);
1e052be69d045c Cong Wang                     2015-03-06  358  			}
^1da177e4c3f41 Linus Torvalds                2005-04-16  359  			goto errout;
^1da177e4c3f41 Linus Torvalds                2005-04-16  360  		case RTM_GETTFILTER:
5a7a5555a362f6 Jamal Hadi Salim              2016-09-18  361  			err = tfilter_notify(net, skb, n, tp, fh,
fa59b27c9d6f84 Eric Dumazet                  2016-10-09  362  					     RTM_NEWTFILTER, true);
^1da177e4c3f41 Linus Torvalds                2005-04-16  363  			goto errout;
^1da177e4c3f41 Linus Torvalds                2005-04-16  364  		default:
^1da177e4c3f41 Linus Torvalds                2005-04-16  365  			err = -EINVAL;
^1da177e4c3f41 Linus Torvalds                2005-04-16  366  			goto errout;
^1da177e4c3f41 Linus Torvalds                2005-04-16  367  		}
^1da177e4c3f41 Linus Torvalds                2005-04-16  368  	}
^1da177e4c3f41 Linus Torvalds                2005-04-16  369  
2f7ef2f8790f5b Cong Wang                     2014-04-25  370  	err = tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh,
2f7ef2f8790f5b Cong Wang                     2014-04-25  371  			      n->nlmsg_flags & NLM_F_CREATE ? TCA_ACT_NOREPLACE : TCA_ACT_REPLACE);
12186be7d2e110 Minoru Usui                   2009-06-02  372  	if (err == 0) {
12186be7d2e110 Minoru Usui                   2009-06-02  373  		if (tp_created) {
25d8c0d55f241c John Fastabend                2014-09-12  374  			RCU_INIT_POINTER(tp->next, rtnl_dereference(*back));
25d8c0d55f241c John Fastabend                2014-09-12  375  			rcu_assign_pointer(*back, tp);
12186be7d2e110 Minoru Usui                   2009-06-02  376  		}
fa59b27c9d6f84 Eric Dumazet                  2016-10-09  377  		tfilter_notify(net, skb, n, tp, fh, RTM_NEWTFILTER, false);
12186be7d2e110 Minoru Usui                   2009-06-02  378  	} else {
12186be7d2e110 Minoru Usui                   2009-06-02  379  		if (tp_created)
1e052be69d045c Cong Wang                     2015-03-06  380  			tcf_destroy(tp, true);
12186be7d2e110 Minoru Usui                   2009-06-02  381  	}
^1da177e4c3f41 Linus Torvalds                2005-04-16  382  
^1da177e4c3f41 Linus Torvalds                2005-04-16  383  errout:
^1da177e4c3f41 Linus Torvalds                2005-04-16  384  	if (cl)
^1da177e4c3f41 Linus Torvalds                2005-04-16  385  		cops->put(q, cl);
^1da177e4c3f41 Linus Torvalds                2005-04-16  386  	if (err == -EAGAIN)
^1da177e4c3f41 Linus Torvalds                2005-04-16  387  		/* Replay the request. */
^1da177e4c3f41 Linus Torvalds                2005-04-16  388  		goto replay;
^1da177e4c3f41 Linus Torvalds                2005-04-16  389  	return err;
^1da177e4c3f41 Linus Torvalds                2005-04-16  390  }
^1da177e4c3f41 Linus Torvalds                2005-04-16  391  

:::::: The code at line 272 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

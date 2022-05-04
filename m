Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A815196AF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 06:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344512AbiEDFBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 01:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237376AbiEDFBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 01:01:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B302D1E0
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 21:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651640262; x=1683176262;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TKbMmqJMecGyQ4357XaOEihsKegdoHeuzCRszZsT7iM=;
  b=CtA7LjnO9R18n/3dWS7GAEH5IUKF2e0N/lnsoedgLUFuzPYvnRJJypnH
   OrZ3cx1dK+VA0p70FVnBF4CvLhZUqrutwtLbKn9SaJXd0JadTv78Clove
   m/HjFlb0LEjAajdpdirkr3oa/mVGwo6bbgw/7HmddFIBWbv9R9c1EaeHN
   KquVzZ82nyJe5L/qaGx6hlfSJKiZuehIDsWpPQMbA2E2C6q4ENkaxHlhE
   +HuglOTC0torh2FFEKKiFk5ULWIcfYWlXX9s7VWuFSJ4c+4b5wRQ9F4G0
   AZTl+Df2laq5G/KJLWPTlYBe9gdlb1yrAzyRN3qVlKsV4cctRNRBmhMsJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="292852155"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="292852155"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 21:57:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="734232612"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 May 2022 21:57:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nm751-000B4l-Uf;
        Wed, 04 May 2022 04:57:39 +0000
Date:   Wed, 4 May 2022 12:57:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kees:for-next/kspp 12/12] net/decnet/dn_route.c:1123:15: error:
 casting from randomized structure pointer type 'struct neighbour *' to
 'struct dn_neigh *'
Message-ID: <202205041247.WKBEHGS5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/kspp
head:   1fe35f29cf8220a5f9ab39ee3e5c722eb716b6fa
commit: 1fe35f29cf8220a5f9ab39ee3e5c722eb716b6fa [12/12] randstruct: Enable Clang support
config: hexagon-randconfig-r034-20220502 (https://download.01.org/0day-ci/archive/20220504/202205041247.WKBEHGS5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=1fe35f29cf8220a5f9ab39ee3e5c722eb716b6fa
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees for-next/kspp
        git checkout 1fe35f29cf8220a5f9ab39ee3e5c722eb716b6fa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash net/decnet/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/decnet/dn_route.c:1123:15: error: casting from randomized structure pointer type 'struct neighbour *' to 'struct dn_neigh *'
                           gateway = ((struct dn_neigh *)neigh)->addr;
                                      ^
   net/decnet/dn_route.c:1432:15: error: casting from randomized structure pointer type 'struct neighbour *' to 'struct dn_neigh *'
                           gateway = ((struct dn_neigh *)neigh)->addr;
                                      ^
   2 errors generated.
--
>> net/decnet/dn_dev.c:857:25: error: casting from randomized structure pointer type 'struct neighbour *' to 'struct dn_neigh *'
                   struct dn_neigh *dn = (struct dn_neigh *)dn_db->router;
                                         ^
   net/decnet/dn_dev.c:905:24: error: casting from randomized structure pointer type 'struct neighbour *' to 'struct dn_neigh *'
           struct dn_neigh *dn = (struct dn_neigh *)dn_db->router;
                                 ^
   2 errors generated.
--
>> net/decnet/dn_neigh.c:429:26: error: casting from randomized structure pointer type 'struct neighbour *' to 'struct dn_neigh *'
                                   if (msg->priority > ((struct dn_neigh *)dn_db->router)->priority)
                                                        ^
   1 error generated.


vim +1123 net/decnet/dn_route.c

^1da177e4c3f41 Linus Torvalds    2005-04-16   952  
bef55aebd560c5 David S. Miller   2011-03-12   953  static int dn_route_output_slow(struct dst_entry **pprt, const struct flowidn *oldflp, int try_hard)
^1da177e4c3f41 Linus Torvalds    2005-04-16   954  {
bef55aebd560c5 David S. Miller   2011-03-12   955  	struct flowidn fld = {
bef55aebd560c5 David S. Miller   2011-03-12   956  		.daddr = oldflp->daddr,
bef55aebd560c5 David S. Miller   2011-03-12   957  		.saddr = oldflp->saddr,
bef55aebd560c5 David S. Miller   2011-03-12   958  		.flowidn_scope = RT_SCOPE_UNIVERSE,
bef55aebd560c5 David S. Miller   2011-03-12   959  		.flowidn_mark = oldflp->flowidn_mark,
1fb9489bf190ce Pavel Emelyanov   2012-08-08   960  		.flowidn_iif = LOOPBACK_IFINDEX,
bef55aebd560c5 David S. Miller   2011-03-12   961  		.flowidn_oif = oldflp->flowidn_oif,
1d28f42c1bd4bb David S. Miller   2011-03-12   962  	};
^1da177e4c3f41 Linus Torvalds    2005-04-16   963  	struct dn_route *rt = NULL;
7562f876cd9380 Pavel Emelianov   2007-05-03   964  	struct net_device *dev_out = NULL, *dev;
^1da177e4c3f41 Linus Torvalds    2005-04-16   965  	struct neighbour *neigh = NULL;
95c961747284a6 Eric Dumazet      2012-04-15   966  	unsigned int hash;
95c961747284a6 Eric Dumazet      2012-04-15   967  	unsigned int flags = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16   968  	struct dn_fib_res res = { .fi = NULL, .type = RTN_UNICAST };
^1da177e4c3f41 Linus Torvalds    2005-04-16   969  	int err;
^1da177e4c3f41 Linus Torvalds    2005-04-16   970  	int free_res = 0;
c4ea94ab3710eb Steven Whitehouse 2006-03-20   971  	__le16 gateway = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16   972  
^1da177e4c3f41 Linus Torvalds    2005-04-16   973  	if (decnet_debug_level & 16)
^1da177e4c3f41 Linus Torvalds    2005-04-16   974  		printk(KERN_DEBUG
^1da177e4c3f41 Linus Torvalds    2005-04-16   975  		       "dn_route_output_slow: dst=%04x src=%04x mark=%d"
bef55aebd560c5 David S. Miller   2011-03-12   976  		       " iif=%d oif=%d\n", le16_to_cpu(oldflp->daddr),
bef55aebd560c5 David S. Miller   2011-03-12   977  		       le16_to_cpu(oldflp->saddr),
1fb9489bf190ce Pavel Emelyanov   2012-08-08   978  		       oldflp->flowidn_mark, LOOPBACK_IFINDEX,
bef55aebd560c5 David S. Miller   2011-03-12   979  		       oldflp->flowidn_oif);
^1da177e4c3f41 Linus Torvalds    2005-04-16   980  
^1da177e4c3f41 Linus Torvalds    2005-04-16   981  	/* If we have an output interface, verify its a DECnet device */
bef55aebd560c5 David S. Miller   2011-03-12   982  	if (oldflp->flowidn_oif) {
bef55aebd560c5 David S. Miller   2011-03-12   983  		dev_out = dev_get_by_index(&init_net, oldflp->flowidn_oif);
^1da177e4c3f41 Linus Torvalds    2005-04-16   984  		err = -ENODEV;
^1da177e4c3f41 Linus Torvalds    2005-04-16   985  		if (dev_out && dev_out->dn_ptr == NULL) {
^1da177e4c3f41 Linus Torvalds    2005-04-16   986  			dev_put(dev_out);
^1da177e4c3f41 Linus Torvalds    2005-04-16   987  			dev_out = NULL;
^1da177e4c3f41 Linus Torvalds    2005-04-16   988  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16   989  		if (dev_out == NULL)
^1da177e4c3f41 Linus Torvalds    2005-04-16   990  			goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16   991  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16   992  
^1da177e4c3f41 Linus Torvalds    2005-04-16   993  	/* If we have a source address, verify that its a local address */
bef55aebd560c5 David S. Miller   2011-03-12   994  	if (oldflp->saddr) {
^1da177e4c3f41 Linus Torvalds    2005-04-16   995  		err = -EADDRNOTAVAIL;
^1da177e4c3f41 Linus Torvalds    2005-04-16   996  
^1da177e4c3f41 Linus Torvalds    2005-04-16   997  		if (dev_out) {
bef55aebd560c5 David S. Miller   2011-03-12   998  			if (dn_dev_islocal(dev_out, oldflp->saddr))
^1da177e4c3f41 Linus Torvalds    2005-04-16   999  				goto source_ok;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1000  			dev_put(dev_out);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1001  			goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1002  		}
c6d14c84566d6b Eric Dumazet      2009-11-04  1003  		rcu_read_lock();
c6d14c84566d6b Eric Dumazet      2009-11-04  1004  		for_each_netdev_rcu(&init_net, dev) {
7562f876cd9380 Pavel Emelianov   2007-05-03  1005  			if (!dev->dn_ptr)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1006  				continue;
bef55aebd560c5 David S. Miller   2011-03-12  1007  			if (!dn_dev_islocal(dev, oldflp->saddr))
9bbf28a1ff7b9d Patrick Caulfield 2006-08-02  1008  				continue;
7562f876cd9380 Pavel Emelianov   2007-05-03  1009  			if ((dev->flags & IFF_LOOPBACK) &&
bef55aebd560c5 David S. Miller   2011-03-12  1010  			    oldflp->daddr &&
bef55aebd560c5 David S. Miller   2011-03-12  1011  			    !dn_dev_islocal(dev, oldflp->daddr))
9bbf28a1ff7b9d Patrick Caulfield 2006-08-02  1012  				continue;
7562f876cd9380 Pavel Emelianov   2007-05-03  1013  
7562f876cd9380 Pavel Emelianov   2007-05-03  1014  			dev_out = dev;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1015  			break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1016  		}
c6d14c84566d6b Eric Dumazet      2009-11-04  1017  		rcu_read_unlock();
^1da177e4c3f41 Linus Torvalds    2005-04-16  1018  		if (dev_out == NULL)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1019  			goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1020  		dev_hold(dev_out);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1021  source_ok:
^1da177e4c3f41 Linus Torvalds    2005-04-16  1022  		;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1023  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  1024  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1025  	/* No destination? Assume its local */
bef55aebd560c5 David S. Miller   2011-03-12  1026  	if (!fld.daddr) {
bef55aebd560c5 David S. Miller   2011-03-12  1027  		fld.daddr = fld.saddr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1028  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1029  		dev_put(dev_out);
a36a0d4008488f David S. Miller   2016-04-10  1030  		err = -EINVAL;
2774c7aba6c97a Eric W. Biederman 2007-09-26  1031  		dev_out = init_net.loopback_dev;
a36a0d4008488f David S. Miller   2016-04-10  1032  		if (!dev_out->dn_ptr)
a36a0d4008488f David S. Miller   2016-04-10  1033  			goto out;
a36a0d4008488f David S. Miller   2016-04-10  1034  		err = -EADDRNOTAVAIL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1035  		dev_hold(dev_out);
bef55aebd560c5 David S. Miller   2011-03-12  1036  		if (!fld.daddr) {
bef55aebd560c5 David S. Miller   2011-03-12  1037  			fld.daddr =
bef55aebd560c5 David S. Miller   2011-03-12  1038  			fld.saddr = dnet_select_source(dev_out, 0,
^1da177e4c3f41 Linus Torvalds    2005-04-16  1039  						       RT_SCOPE_HOST);
bef55aebd560c5 David S. Miller   2011-03-12  1040  			if (!fld.daddr)
3f96d644976825 Vadim Fedorenko   2021-01-26  1041  				goto done;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1042  		}
1fb9489bf190ce Pavel Emelyanov   2012-08-08  1043  		fld.flowidn_oif = LOOPBACK_IFINDEX;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1044  		res.type = RTN_LOCAL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1045  		goto make_route;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1046  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  1047  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1048  	if (decnet_debug_level & 16)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1049  		printk(KERN_DEBUG
^1da177e4c3f41 Linus Torvalds    2005-04-16  1050  		       "dn_route_output_slow: initial checks complete."
46b9e4bb76ee26 Rasmus Villemoes  2015-02-23  1051  		       " dst=%04x src=%04x oif=%d try_hard=%d\n",
bef55aebd560c5 David S. Miller   2011-03-12  1052  		       le16_to_cpu(fld.daddr), le16_to_cpu(fld.saddr),
bef55aebd560c5 David S. Miller   2011-03-12  1053  		       fld.flowidn_oif, try_hard);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1054  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1055  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  1056  	 * N.B. If the kernel is compiled without router support then
^1da177e4c3f41 Linus Torvalds    2005-04-16  1057  	 * dn_fib_lookup() will evaluate to non-zero so this if () block
^1da177e4c3f41 Linus Torvalds    2005-04-16  1058  	 * will always be executed.
^1da177e4c3f41 Linus Torvalds    2005-04-16  1059  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1060  	err = -ESRCH;
bef55aebd560c5 David S. Miller   2011-03-12  1061  	if (try_hard || (err = dn_fib_lookup(&fld, &res)) != 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  1062  		struct dn_dev *dn_db;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1063  		if (err != -ESRCH)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1064  			goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1065  		/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  1066  		 * Here the fallback is basically the standard algorithm for
^1da177e4c3f41 Linus Torvalds    2005-04-16  1067  		 * routing in endnodes which is described in the DECnet routing
^1da177e4c3f41 Linus Torvalds    2005-04-16  1068  		 * docs
^1da177e4c3f41 Linus Torvalds    2005-04-16  1069  		 *
^1da177e4c3f41 Linus Torvalds    2005-04-16  1070  		 * If we are not trying hard, look in neighbour cache.
^1da177e4c3f41 Linus Torvalds    2005-04-16  1071  		 * The result is tested to ensure that if a specific output
^1da177e4c3f41 Linus Torvalds    2005-04-16  1072  		 * device/source address was requested, then we honour that
^1da177e4c3f41 Linus Torvalds    2005-04-16  1073  		 * here
^1da177e4c3f41 Linus Torvalds    2005-04-16  1074  		 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1075  		if (!try_hard) {
bef55aebd560c5 David S. Miller   2011-03-12  1076  			neigh = neigh_lookup_nodev(&dn_neigh_table, &init_net, &fld.daddr);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1077  			if (neigh) {
bef55aebd560c5 David S. Miller   2011-03-12  1078  				if ((oldflp->flowidn_oif &&
bef55aebd560c5 David S. Miller   2011-03-12  1079  				    (neigh->dev->ifindex != oldflp->flowidn_oif)) ||
bef55aebd560c5 David S. Miller   2011-03-12  1080  				    (oldflp->saddr &&
^1da177e4c3f41 Linus Torvalds    2005-04-16  1081  				    (!dn_dev_islocal(neigh->dev,
bef55aebd560c5 David S. Miller   2011-03-12  1082  						     oldflp->saddr)))) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  1083  					neigh_release(neigh);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1084  					neigh = NULL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1085  				} else {
^1da177e4c3f41 Linus Torvalds    2005-04-16  1086  					dev_put(dev_out);
bef55aebd560c5 David S. Miller   2011-03-12  1087  					if (dn_dev_islocal(neigh->dev, fld.daddr)) {
2774c7aba6c97a Eric W. Biederman 2007-09-26  1088  						dev_out = init_net.loopback_dev;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1089  						res.type = RTN_LOCAL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1090  					} else {
^1da177e4c3f41 Linus Torvalds    2005-04-16  1091  						dev_out = neigh->dev;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1092  					}
^1da177e4c3f41 Linus Torvalds    2005-04-16  1093  					dev_hold(dev_out);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1094  					goto select_source;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1095  				}
^1da177e4c3f41 Linus Torvalds    2005-04-16  1096  			}
^1da177e4c3f41 Linus Torvalds    2005-04-16  1097  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  1098  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1099  		/* Not there? Perhaps its a local address */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1100  		if (dev_out == NULL)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1101  			dev_out = dn_dev_get_default();
^1da177e4c3f41 Linus Torvalds    2005-04-16  1102  		err = -ENODEV;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1103  		if (dev_out == NULL)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1104  			goto out;
fc766e4c496591 Eric Dumazet      2010-10-29  1105  		dn_db = rcu_dereference_raw(dev_out->dn_ptr);
a36a0d4008488f David S. Miller   2016-04-10  1106  		if (!dn_db)
a36a0d4008488f David S. Miller   2016-04-10  1107  			goto e_inval;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1108  		/* Possible improvement - check all devices for local addr */
bef55aebd560c5 David S. Miller   2011-03-12  1109  		if (dn_dev_islocal(dev_out, fld.daddr)) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  1110  			dev_put(dev_out);
2774c7aba6c97a Eric W. Biederman 2007-09-26  1111  			dev_out = init_net.loopback_dev;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1112  			dev_hold(dev_out);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1113  			res.type = RTN_LOCAL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1114  			goto select_source;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1115  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  1116  		/* Not local either.... try sending it to the default router */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1117  		neigh = neigh_clone(dn_db->router);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1118  		BUG_ON(neigh && neigh->dev != dev_out);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1119  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1120  		/* Ok then, we assume its directly connected and move on */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1121  select_source:
^1da177e4c3f41 Linus Torvalds    2005-04-16  1122  		if (neigh)
^1da177e4c3f41 Linus Torvalds    2005-04-16 @1123  			gateway = ((struct dn_neigh *)neigh)->addr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1124  		if (gateway == 0)
bef55aebd560c5 David S. Miller   2011-03-12  1125  			gateway = fld.daddr;
bef55aebd560c5 David S. Miller   2011-03-12  1126  		if (fld.saddr == 0) {
bef55aebd560c5 David S. Miller   2011-03-12  1127  			fld.saddr = dnet_select_source(dev_out, gateway,
^1da177e4c3f41 Linus Torvalds    2005-04-16  1128  						       res.type == RTN_LOCAL ?
^1da177e4c3f41 Linus Torvalds    2005-04-16  1129  						       RT_SCOPE_HOST :
^1da177e4c3f41 Linus Torvalds    2005-04-16  1130  						       RT_SCOPE_LINK);
bef55aebd560c5 David S. Miller   2011-03-12  1131  			if (fld.saddr == 0 && res.type != RTN_LOCAL)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1132  				goto e_addr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1133  		}
bef55aebd560c5 David S. Miller   2011-03-12  1134  		fld.flowidn_oif = dev_out->ifindex;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1135  		goto make_route;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1136  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  1137  	free_res = 1;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1138  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1139  	if (res.type == RTN_NAT)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1140  		goto e_inval;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1141  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1142  	if (res.type == RTN_LOCAL) {
bef55aebd560c5 David S. Miller   2011-03-12  1143  		if (!fld.saddr)
bef55aebd560c5 David S. Miller   2011-03-12  1144  			fld.saddr = fld.daddr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1145  		dev_put(dev_out);
2774c7aba6c97a Eric W. Biederman 2007-09-26  1146  		dev_out = init_net.loopback_dev;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1147  		dev_hold(dev_out);
a36a0d4008488f David S. Miller   2016-04-10  1148  		if (!dev_out->dn_ptr)
a36a0d4008488f David S. Miller   2016-04-10  1149  			goto e_inval;
bef55aebd560c5 David S. Miller   2011-03-12  1150  		fld.flowidn_oif = dev_out->ifindex;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1151  		if (res.fi)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1152  			dn_fib_info_put(res.fi);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1153  		res.fi = NULL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1154  		goto make_route;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1155  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  1156  
bef55aebd560c5 David S. Miller   2011-03-12  1157  	if (res.fi->fib_nhs > 1 && fld.flowidn_oif == 0)
bef55aebd560c5 David S. Miller   2011-03-12  1158  		dn_fib_select_multipath(&fld, &res);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1159  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1160  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  1161  	 * We could add some logic to deal with default routes here and
^1da177e4c3f41 Linus Torvalds    2005-04-16  1162  	 * get rid of some of the special casing above.
^1da177e4c3f41 Linus Torvalds    2005-04-16  1163  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1164  
bef55aebd560c5 David S. Miller   2011-03-12  1165  	if (!fld.saddr)
bef55aebd560c5 David S. Miller   2011-03-12  1166  		fld.saddr = DN_FIB_RES_PREFSRC(res);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1167  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1168  	dev_put(dev_out);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1169  	dev_out = DN_FIB_RES_DEV(res);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1170  	dev_hold(dev_out);
bef55aebd560c5 David S. Miller   2011-03-12  1171  	fld.flowidn_oif = dev_out->ifindex;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1172  	gateway = DN_FIB_RES_GW(res);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1173  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1174  make_route:
^1da177e4c3f41 Linus Torvalds    2005-04-16  1175  	if (dev_out->flags & IFF_LOOPBACK)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1176  		flags |= RTCF_LOCAL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1177  
af13b3c338bea6 David Laight      2020-03-23  1178  	rt = dst_alloc(&dn_dst_ops, dev_out, 0, DST_OBSOLETE_NONE, 0);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1179  	if (rt == NULL)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1180  		goto e_nobufs;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1181  
fe736e778c604d David Miller      2017-11-28  1182  	rt->dn_next = NULL;
cf91166223772e David S. Miller   2011-04-28  1183  	memset(&rt->fld, 0, sizeof(rt->fld));
bef55aebd560c5 David S. Miller   2011-03-12  1184  	rt->fld.saddr        = oldflp->saddr;
bef55aebd560c5 David S. Miller   2011-03-12  1185  	rt->fld.daddr        = oldflp->daddr;
bef55aebd560c5 David S. Miller   2011-03-12  1186  	rt->fld.flowidn_oif  = oldflp->flowidn_oif;
bef55aebd560c5 David S. Miller   2011-03-12  1187  	rt->fld.flowidn_iif  = 0;
bef55aebd560c5 David S. Miller   2011-03-12  1188  	rt->fld.flowidn_mark = oldflp->flowidn_mark;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1189  
bef55aebd560c5 David S. Miller   2011-03-12  1190  	rt->rt_saddr      = fld.saddr;
bef55aebd560c5 David S. Miller   2011-03-12  1191  	rt->rt_daddr      = fld.daddr;
bef55aebd560c5 David S. Miller   2011-03-12  1192  	rt->rt_gateway    = gateway ? gateway : fld.daddr;
bef55aebd560c5 David S. Miller   2011-03-12  1193  	rt->rt_local_src  = fld.saddr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1194  
bef55aebd560c5 David S. Miller   2011-03-12  1195  	rt->rt_dst_map    = fld.daddr;
bef55aebd560c5 David S. Miller   2011-03-12  1196  	rt->rt_src_map    = fld.saddr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1197  
fccd7d5c77ff61 David S. Miller   2012-07-02  1198  	rt->n = neigh;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1199  	neigh = NULL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1200  
d8d1f30b95a635 Changli Gao       2010-06-10  1201  	rt->dst.lastuse = jiffies;
d8d1f30b95a635 Changli Gao       2010-06-10  1202  	rt->dst.output  = dn_output;
d8d1f30b95a635 Changli Gao       2010-06-10  1203  	rt->dst.input   = dn_rt_bug;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1204  	rt->rt_flags      = flags;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1205  	if (flags & RTCF_LOCAL)
d8d1f30b95a635 Changli Gao       2010-06-10  1206  		rt->dst.input = dn_nsp_rx;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1207  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1208  	err = dn_rt_set_next_hop(rt, &res);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1209  	if (err)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1210  		goto e_neighbour;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1211  
bef55aebd560c5 David S. Miller   2011-03-12  1212  	hash = dn_hash(rt->fld.saddr, rt->fld.daddr);
560fd93bca66c2 Wei Wang          2017-06-17  1213  	/* dn_insert_route() increments dst->__refcnt */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1214  	dn_insert_route(rt, hash, (struct dn_route **)pprt);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1215  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1216  done:
^1da177e4c3f41 Linus Torvalds    2005-04-16  1217  	if (neigh)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1218  		neigh_release(neigh);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1219  	if (free_res)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1220  		dn_fib_res_put(&res);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1221  	dev_put(dev_out);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1222  out:
^1da177e4c3f41 Linus Torvalds    2005-04-16  1223  	return err;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1224  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1225  e_addr:
^1da177e4c3f41 Linus Torvalds    2005-04-16  1226  	err = -EADDRNOTAVAIL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1227  	goto done;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1228  e_inval:
^1da177e4c3f41 Linus Torvalds    2005-04-16  1229  	err = -EINVAL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1230  	goto done;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1231  e_nobufs:
^1da177e4c3f41 Linus Torvalds    2005-04-16  1232  	err = -ENOBUFS;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1233  	goto done;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1234  e_neighbour:
560fd93bca66c2 Wei Wang          2017-06-17  1235  	dst_release_immediate(&rt->dst);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1236  	goto e_nobufs;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1237  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  1238  

:::::: The code at line 1123 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5805655C3ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiF1LPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiF1LPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:15:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7D52D1CE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656414905; x=1687950905;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1VzVOkwWtWO/RfrVesmDoo26OPyw3HnDy+zwq71hTHA=;
  b=d+9xXpNdGBZQ4tN7zgL7SJzIgAPUstcsXMoX9ZWKj0n1mUEq/IGoI4cx
   oA0chrd9+vM9Q5P3Nco8wNW4LfD/iKShKUFvegcDFdKQ1z9ez6xXVdA6M
   jw1v7kPdcM5iJyYCXAGF7F4rwwAyZGP4fNl5A8hw31moOqnsxCgD/Ufp5
   Tmg6Ho5Au6muzypdcImVV20+wihMLn5YYsgTMRYeUPF1iFKwYCv2eIQt6
   GXAyrRkfrm4bTFRQUyS8A0tOcsiv+9lcLM6XXndBjscdulqldQf/+u7kj
   rA7ABa50xFqOhnH9BOJGEOXrBf78584ELX+SH3uv/c5Y0T3n9S6hDpFyZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="345708833"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="345708833"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:15:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="732712836"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jun 2022 04:15:02 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o69BO-0009xE-3y;
        Tue, 28 Jun 2022 11:15:02 +0000
Date:   Tue, 28 Jun 2022 19:14:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Raed Salem <raeds@nvidia.com>
Subject: [ammarfaizi2-block:mellanox/linux/queue-next 2/14]
 net/xfrm/xfrm_device.c:280:3: error: call to undeclared function
 'dev_put_track'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202206281926.yJ1l888L-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block mellanox/linux/queue-next
head:   62681695cd9969a82026b2b93d0c4ca1a8500eee
commit: 0a1347c1f766cddc63032227434bc7b581904dc2 [2/14] xfrm: add new full offload flag
config: i386-randconfig-a004-20220627 (https://download.01.org/0day-ci/archive/20220628/202206281926.yJ1l888L-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project df18167ac56d05f2ab55f9d874aee7ab6d5bc9a2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/0a1347c1f766cddc63032227434bc7b581904dc2
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block mellanox/linux/queue-next
        git checkout 0a1347c1f766cddc63032227434bc7b581904dc2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/xfrm/xfrm_device.c:280:3: error: call to undeclared function 'dev_put_track'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   dev_put_track(dev, &xso->dev_tracker);
                   ^
   net/xfrm/xfrm_device.c:280:3: note: did you mean 'get_net_track'?
   include/net/net_namespace.h:331:27: note: 'get_net_track' declared here
   static inline struct net *get_net_track(struct net *net,
                             ^
   1 error generated.


vim +/dev_put_track +280 net/xfrm/xfrm_device.c

   208	
   209	int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
   210			       struct xfrm_user_offload *xuo)
   211	{
   212		int err;
   213		struct dst_entry *dst;
   214		struct net_device *dev;
   215		struct xfrm_dev_offload *xso = &x->xso;
   216		xfrm_address_t *saddr;
   217		xfrm_address_t *daddr;
   218	
   219		if (!x->type_offload)
   220			return -EINVAL;
   221	
   222		/* We don't yet support UDP encapsulation and TFC padding. */
   223		if (x->encap || x->tfcpad)
   224			return -EINVAL;
   225	
   226		if (xuo->flags & ~(XFRM_OFFLOAD_IPV6 | XFRM_OFFLOAD_INBOUND))
   227			return -EINVAL;
   228	
   229		dev = dev_get_by_index(net, xuo->ifindex);
   230		if (!dev) {
   231			if (!(xuo->flags & XFRM_OFFLOAD_INBOUND)) {
   232				saddr = &x->props.saddr;
   233				daddr = &x->id.daddr;
   234			} else {
   235				saddr = &x->id.daddr;
   236				daddr = &x->props.saddr;
   237			}
   238	
   239			dst = __xfrm_dst_lookup(net, 0, 0, saddr, daddr,
   240						x->props.family,
   241						xfrm_smark_get(0, x));
   242			if (IS_ERR(dst))
   243				return 0;
   244	
   245			dev = dst->dev;
   246	
   247			dev_hold(dev);
   248			dst_release(dst);
   249		}
   250	
   251		if (!dev->xfrmdev_ops || !dev->xfrmdev_ops->xdo_dev_state_add) {
   252			xso->dev = NULL;
   253			dev_put(dev);
   254			return 0;
   255		}
   256	
   257		if (x->props.flags & XFRM_STATE_ESN &&
   258		    !dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
   259			xso->dev = NULL;
   260			dev_put(dev);
   261			return -EINVAL;
   262		}
   263	
   264		xso->dev = dev;
   265		netdev_tracker_alloc(dev, &xso->dev_tracker, GFP_ATOMIC);
   266		xso->real_dev = dev;
   267	
   268		if (xuo->flags & XFRM_OFFLOAD_INBOUND)
   269			xso->dir = XFRM_DEV_OFFLOAD_IN;
   270		else
   271			xso->dir = XFRM_DEV_OFFLOAD_OUT;
   272	
   273		xso->type = XFRM_DEV_OFFLOAD_CRYPTO;
   274	
   275		err = dev->xfrmdev_ops->xdo_dev_state_add(x);
   276		if (err) {
   277			xso->dev = NULL;
   278			xso->dir = 0;
   279			xso->real_dev = NULL;
 > 280			dev_put_track(dev, &xso->dev_tracker);
   281			xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
   282	
   283			if (err != -EOPNOTSUPP)
   284				return err;
   285		}
   286	
   287		return 0;
   288	}
   289	EXPORT_SYMBOL_GPL(xfrm_dev_state_add);
   290	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

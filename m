Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE36478638
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhLQIcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:32:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:25759 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231342AbhLQIcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639729921; x=1671265921;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iglvLuA70muVTCsH8ovshWuebvD9eTwnQIys6JC1ewQ=;
  b=nsL+8LoJl2sddMTg6tGuOotcGRos38/RRPXMlPwYHKyeQonhy+N7aNVV
   iA1kRMGXrFNJCjP6IIy5ZfuPouPi3Mhak2pqIKzMqCB/2HXOody4e6h/m
   5URjX1151WkLHH/ydZw0NIu3AwmqB/NhhxN/xW3mbODqEynh4fyDVbYI4
   8MAu3Cz0GtUIpcS/Lo0pp4RekN+wyqtS939NobvhJRYYKhCcXFCFjDU4T
   /1eXoW2Es7pvqs97Oiz/Q/RvkwvxLz7vHkxB32cpCvRTHRLVj0tUtXT/b
   Uh5MJSTEPNyHxVrQDBqc2PvEwQACUL+ONm2vFcEu9qRzHJ6whw0/Ul/2s
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="226570573"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="226570573"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 00:32:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="683309750"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Dec 2021 00:32:00 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1my8el-0004UB-IC; Fri, 17 Dec 2021 08:31:59 +0000
Date:   Fri, 17 Dec 2021 16:31:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [pinchartl-media:gmsl/max9286/bindings 44/45]
 drivers/media/v4l2-core/v4l2-subdev.c:1595:41: error: 'struct v4l2_subdev'
 has no member named 'entity'
Message-ID: <202112171621.k6d6CR2S-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/pinchartl/media.git gmsl/max9286/bindings
head:   b551a93fb443867f1a950d6063910639bd303daf
commit: 1bf95761342cbb5585b976194300d58bc6f30000 [44/45] media: subdev: Extend routing validation helper
config: sparc64-randconfig-r014-20211216 (https://download.01.org/0day-ci/archive/20211217/202112171621.k6d6CR2S-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add pinchartl-media git://linuxtv.org/pinchartl/media.git
        git fetch --no-tags pinchartl-media gmsl/max9286/bindings
        git checkout 1bf95761342cbb5585b976194300d58bc6f30000
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/media/v4l2-core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/media/v4l2-core/v4l2-subdev.c: In function '__v4l2_subdev_init_finalize':
   drivers/media/v4l2-core/v4l2-subdev.c:1409:17: error: implicit declaration of function '__v4l2_subdev_state_alloc' [-Werror=implicit-function-declaration]
    1409 |         state = __v4l2_subdev_state_alloc(sd, name, key);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c:1409:15: warning: assignment to 'struct v4l2_subdev_state *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1409 |         state = __v4l2_subdev_state_alloc(sd, name, key);
         |               ^
   drivers/media/v4l2-core/v4l2-subdev.c: In function 'v4l2_subdev_cleanup':
   drivers/media/v4l2-core/v4l2-subdev.c:1421:9: error: implicit declaration of function '__v4l2_subdev_state_free' [-Werror=implicit-function-declaration]
    1421 |         __v4l2_subdev_state_free(sd->active_state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c: In function 'v4l2_subdev_routing_validate':
>> drivers/media/v4l2-core/v4l2-subdev.c:1595:41: error: 'struct v4l2_subdev' has no member named 'entity'
    1595 |                 remote_pads = kcalloc(sd->entity.num_pads, sizeof(*remote_pads),
         |                                         ^~
   drivers/media/v4l2-core/v4l2-subdev.c:1600:35: error: 'struct v4l2_subdev' has no member named 'entity'
    1600 |                 for (i = 0; i < sd->entity.num_pads; ++i)
         |                                   ^~
   drivers/media/v4l2-core/v4l2-subdev.c:1608:42: error: 'struct v4l2_subdev' has no member named 'entity'
    1608 |                 if (route->sink_pad >= sd->entity.num_pads ||
         |                                          ^~
   drivers/media/v4l2-core/v4l2-subdev.c:1609:25: error: 'struct v4l2_subdev' has no member named 'entity'
    1609 |                     !(sd->entity.pads[route->sink_pad].flags & MEDIA_PAD_FL_SINK)) {
         |                         ^~
   drivers/media/v4l2-core/v4l2-subdev.c:1615:44: error: 'struct v4l2_subdev' has no member named 'entity'
    1615 |                 if (route->source_pad >= sd->entity.num_pads ||
         |                                            ^~
   drivers/media/v4l2-core/v4l2-subdev.c:1616:25: error: 'struct v4l2_subdev' has no member named 'entity'
    1616 |                     !(sd->entity.pads[route->source_pad].flags & MEDIA_PAD_FL_SOURCE)) {
         |                         ^~
   cc1: some warnings being treated as errors


vim +1595 drivers/media/v4l2-core/v4l2-subdev.c

  1585	
  1586	int v4l2_subdev_routing_validate(struct v4l2_subdev *sd,
  1587					 const struct v4l2_subdev_krouting *routing,
  1588					 enum v4l2_subdev_routing_restriction disallow)
  1589	{
  1590		u32 *remote_pads = NULL;
  1591		unsigned int i, j;
  1592		int ret = -EINVAL;
  1593	
  1594		if (disallow & V4L2_SUBDEV_ROUTING_NO_STREAM_MIX) {
> 1595			remote_pads = kcalloc(sd->entity.num_pads, sizeof(*remote_pads),
  1596					      GFP_KERNEL);
  1597			if (!remote_pads)
  1598				return -ENOMEM;
  1599	
  1600			for (i = 0; i < sd->entity.num_pads; ++i)
  1601				remote_pads[i] = U32_MAX;
  1602		}
  1603	
  1604		for (i = 0; i < routing->num_routes; ++i) {
  1605			const struct v4l2_subdev_route *route = &routing->routes[i];
  1606	
  1607			/* Validate the sink and source pad numbers. */
  1608			if (route->sink_pad >= sd->entity.num_pads ||
  1609			    !(sd->entity.pads[route->sink_pad].flags & MEDIA_PAD_FL_SINK)) {
  1610				dev_dbg(sd->dev, "route %u sink (%u) is not a sink pad\n",
  1611					i, route->sink_pad);
  1612				goto out;
  1613			}
  1614	
  1615			if (route->source_pad >= sd->entity.num_pads ||
  1616			    !(sd->entity.pads[route->source_pad].flags & MEDIA_PAD_FL_SOURCE)) {
  1617				dev_dbg(sd->dev, "route %u source (%u) is not a source pad\n",
  1618					i, route->source_pad);
  1619				goto out;
  1620			}
  1621	
  1622			/*
  1623			 * V4L2_SUBDEV_ROUTING_NO_STREAM_MIX: Streams on the same pad
  1624			 * may not be routed to streams on different pads.
  1625			 */
  1626			if (disallow & V4L2_SUBDEV_ROUTING_NO_STREAM_MIX) {
  1627				if (remote_pads[route->sink_pad] != U32_MAX &&
  1628				    remote_pads[route->sink_pad] != route->source_pad) {
  1629					dev_dbg(sd->dev,
  1630						"route %u attempts to mix %s streams\n",
  1631						i, "sink");
  1632					goto out;
  1633				}
  1634	
  1635				if (remote_pads[route->source_pad] != U32_MAX &&
  1636				    remote_pads[route->source_pad] != route->sink_pad) {
  1637					dev_dbg(sd->dev,
  1638						"route %u attempts to mix %s streams\n",
  1639						i, "source");
  1640					goto out;
  1641				}
  1642	
  1643				remote_pads[route->sink_pad] = route->source_pad;
  1644				remote_pads[route->source_pad] = route->sink_pad;
  1645			}
  1646	
  1647			for (j = i + 1; j < routing->num_routes; ++j) {
  1648				const struct v4l2_subdev_route *r = &routing->routes[j];
  1649	
  1650				/*
  1651				 * V4L2_SUBDEV_ROUTING_NO_1_TO_N: No two routes can
  1652				 * originate from the same (sink) stream.
  1653				 */
  1654				if ((disallow & V4L2_SUBDEV_ROUTING_NO_1_TO_N) &&
  1655				    route->sink_pad == r->sink_pad &&
  1656				    route->sink_stream == r->sink_stream) {
  1657					dev_dbg(sd->dev,
  1658						"routes %u and %u originate from same sink (%u/%u)\n",
  1659						i, j, route->sink_pad,
  1660						route->sink_stream);
  1661					goto out;
  1662				}
  1663	
  1664				/*
  1665				 * V4L2_SUBDEV_ROUTING_NO_N_TO_1: No two routes can end
  1666				 * at the same (source) stream.
  1667				 */
  1668				if ((disallow & V4L2_SUBDEV_ROUTING_NO_N_TO_1) &&
  1669				    route->source_pad == r->source_pad &&
  1670				    route->source_stream == r->source_stream) {
  1671					dev_dbg(sd->dev,
  1672						"routes %u and %u end at same source (%u/%u)\n",
  1673						i, j, route->source_pad,
  1674						route->source_stream);
  1675					goto out;
  1676				}
  1677			}
  1678		}
  1679	
  1680		ret = 0;
  1681	
  1682	out:
  1683		kfree(remote_pads);
  1684		return ret;
  1685	}
  1686	EXPORT_SYMBOL_GPL(v4l2_subdev_routing_validate);
  1687	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

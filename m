Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A275B10AA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiIGXxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGXxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:53:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D898BCEB34
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662594818; x=1694130818;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=geQL7yN44i5ZPDuP5Zdwiq2TBu3/9jOTsmjZaHFxA8o=;
  b=JaKid0vpw7Gzh3gssGV6Pn9zcp3QoL1HJUl70KqoB2hLpfvz5IHBwN2M
   yuYI0pu7yUfCV6cElMiRv2aj6M+gr7JSUZmF0I2vSWvekPOPKnhwO8vdu
   I1MWJgvBjvucfjuMBDvArHbuGfniNn34psUyp2LxaVljUzox5NP4YIOF5
   sXXOK+q8jKjWQhOwQP1PJBt1Tcg8AtRN8kLkfFXVtaYqx4Q/rP2/RXGPH
   +U87/aZMfR6ToypSssMXMqX0UtkZoB2NR9E2cOy6Oux/zFIkRlyAVFU6E
   FqbqfYBpyLQWmUXwytCygQ/QKd3j+y+YSTZZAtNa5jD/DZP2RLeNiaaFP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="277414944"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="277414944"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 16:53:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="943110495"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 07 Sep 2022 16:53:37 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW4rQ-00076R-1b;
        Wed, 07 Sep 2022 23:53:36 +0000
Date:   Thu, 8 Sep 2022 07:52:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [pinchartl-media:streams/v6.0/v11 35/49]
 drivers/media/v4l2-core/v4l2-subdev.c:1137:4: error: 'continue' statement
 not in loop statement
Message-ID: <202209080730.q64FJGQR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/pinchartl/media.git streams/v6.0/v11
head:   c8cf58f00bee6d4f43462b3e3f83ef516c594d61
commit: 808643c5623005a2502925cca09fd332545ab21b [35/49] media: subdev: use for_each_active_route() in v4l2_link_validate_get_streams()
config: arm-randconfig-r002-20220907 (https://download.01.org/0day-ci/archive/20220908/202209080730.q64FJGQR-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add pinchartl-media git://linuxtv.org/pinchartl/media.git
        git fetch --no-tags pinchartl-media streams/v6.0/v11
        git checkout 808643c5623005a2502925cca09fd332545ab21b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/media/v4l2-core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/media/v4l2-core/v4l2-subdev.c:157:8: error: call to undeclared function 'v4l2_subdev_state_get_stream_format'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   if (!v4l2_subdev_state_get_stream_format(state, pad, stream))
                        ^
   drivers/media/v4l2-core/v4l2-subdev.c:931:2: error: call to undeclared function 'for_each_active_route'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           for_each_active_route(routing, route) {
           ^
   drivers/media/v4l2-core/v4l2-subdev.c:931:39: error: expected ';' after expression
           for_each_active_route(routing, route) {
                                                ^
                                                ;
   drivers/media/v4l2-core/v4l2-subdev.c:955:39: error: expected ';' after expression
           for_each_active_route(routing, route) {
                                                ^
                                                ;
   drivers/media/v4l2-core/v4l2-subdev.c:1120:2: error: call to undeclared function 'for_each_active_route'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           for_each_active_route(routing, route) {
           ^
   drivers/media/v4l2-core/v4l2-subdev.c:1120:39: error: expected ';' after expression
           for_each_active_route(routing, route) {
                                                ^
                                                ;
>> drivers/media/v4l2-core/v4l2-subdev.c:1137:4: error: 'continue' statement not in loop statement
                           continue;
                           ^
   7 errors generated.


vim +/continue +1137 drivers/media/v4l2-core/v4l2-subdev.c

6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1083  
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1084  static int v4l2_link_validate_get_streams(struct media_link *link,
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1085  					  bool is_source, u32 *out_num_streams,
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1086  					  const u32 **out_streams,
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1087  					  bool *allocated)
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1088  {
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1089  	static const u32 default_streams[] = { 0 };
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1090  	struct v4l2_subdev_krouting *routing;
808643c5623005 drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2022-03-17  1091  	struct v4l2_subdev_route *route;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1092  	struct v4l2_subdev *subdev;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1093  	u32 num_streams;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1094  	u32 *streams;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1095  	struct v4l2_subdev_state *state;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1096  	int ret;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1097  
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1098  	if (is_source)
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1099  		subdev = media_entity_to_v4l2_subdev(link->source->entity);
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1100  	else
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1101  		subdev = media_entity_to_v4l2_subdev(link->sink->entity);
8227c92b696884 drivers/media/video/v4l2-subdev.c     Sakari Ailus   2011-10-10  1102  
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1103  	if (!(subdev->flags & V4L2_SUBDEV_FL_MULTIPLEXED)) {
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1104  		*out_num_streams = 1;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1105  		*out_streams = default_streams;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1106  		*allocated = false;
8227c92b696884 drivers/media/video/v4l2-subdev.c     Sakari Ailus   2011-10-10  1107  		return 0;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1108  	}
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1109  
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1110  	state = v4l2_subdev_get_locked_active_state(subdev);
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1111  
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1112  	routing = &state->routing;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1113  
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1114  	streams = kmalloc_array(routing->num_routes, sizeof(u32), GFP_KERNEL);
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1115  	if (!streams)
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1116  		return -ENOMEM;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1117  
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1118  	num_streams = 0;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1119  
808643c5623005 drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2022-03-17  1120  	for_each_active_route(routing, route) {
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1121  		int j;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1122  		u32 route_pad;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1123  		u32 route_stream;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1124  		u32 link_pad;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1125  
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1126  		if (is_source) {
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1127  			route_pad = route->source_pad;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1128  			route_stream = route->source_stream;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1129  			link_pad = link->source->index;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1130  		} else {
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1131  			route_pad = route->sink_pad;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1132  			route_stream = route->sink_stream;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1133  			link_pad = link->sink->index;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1134  		}
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1135  
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1136  		if (route_pad != link_pad)
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15 @1137  			continue;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1138  
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1139  		/* look for duplicates */
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1140  		for (j = 0; j < num_streams; ++j) {
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1141  			if (streams[j] == route_stream) {
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1142  				ret = -EINVAL;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1143  				goto free_streams;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1144  			}
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1145  		}
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1146  
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1147  		streams[num_streams++] = route_stream;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1148  	}
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1149  
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1150  	sort(streams, num_streams, sizeof(u32), &cmp_u32, NULL);
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1151  
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1152  	*out_num_streams = num_streams;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1153  	*out_streams = streams;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1154  	*allocated = true;
8227c92b696884 drivers/media/video/v4l2-subdev.c     Sakari Ailus   2011-10-10  1155  
8227c92b696884 drivers/media/video/v4l2-subdev.c     Sakari Ailus   2011-10-10  1156  	return 0;
8227c92b696884 drivers/media/video/v4l2-subdev.c     Sakari Ailus   2011-10-10  1157  
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1158  free_streams:
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1159  	kfree(streams);
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1160  
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1161  	return ret;
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1162  }
6483812d0a81cc drivers/media/v4l2-core/v4l2-subdev.c Tomi Valkeinen 2021-07-15  1163  

:::::: The code at line 1137 was first introduced by commit
:::::: 6483812d0a81cc28986f25b47055be15e072d147 media: subdev: use streams in v4l2_subdev_link_validate()

:::::: TO: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
:::::: CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

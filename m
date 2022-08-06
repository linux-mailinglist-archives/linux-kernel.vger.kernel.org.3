Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B53258B606
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 16:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiHFOTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 10:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiHFOTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 10:19:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB20B11A22
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659795540; x=1691331540;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lGFG+m2rPaOrC3XzWp68OGLkCRMQUX6JRII3iBPY3NM=;
  b=gVzWWSMcozPGGablHnz6N6bPbRtFGrxWlkLkOrPmMqP0vb+/7X6MM9uw
   d7/xlSFIvJTEpI6DJ6usqJflzpR0qWK3qqICl0J8+nHifwCgMDmI+/qy8
   aDwkiAqO0aOAqjsgeUG0sl2eJY6wvWIvvjB4oVWs3isDwW0eYx6RkZgDK
   qoTarhyXu6dhOiMUKiE/0utXyMZ6K8zMGE0tEfMW158AAgXxMARwpNxAC
   TWgl700CcutyJXUBZ24rCg3PwkN3q6+T2gYqiFNMduhqOAKxXy6A/7yP7
   HFkyYg4nVJd7cJQqI3k/emAa4242rxl01MzerIkZqEedeumbvFPPeN2IY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="291597615"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="291597615"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 07:19:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="931545793"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 06 Aug 2022 07:18:58 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKKdl-000KQq-2h;
        Sat, 06 Aug 2022 14:18:57 +0000
Date:   Sat, 6 Aug 2022 22:18:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xavier Roumegue <xavier.roumegue@oss.nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [hverkuil-media-tree:for-v5.21b 12/13]
 drivers/media/platform/nxp/dw100/dw100.c:382:25: warning: variable 'dh' set
 but not used
Message-ID: <202208062217.dM0Br18Z-lkp@intel.com>
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

tree:   git://linuxtv.org/hverkuil/media_tree.git for-v5.21b
head:   ac27e33a9e4dd1487bde072493d9303358af0507
commit: b92bfb7b8350160895d0ea34a98831ed4f01af1d [12/13] media: dw100: Add i.MX8MP dw100 dewarper driver
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220806/202208062217.dM0Br18Z-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree for-v5.21b
        git checkout b92bfb7b8350160895d0ea34a98831ed4f01af1d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/media/platform/nxp/dw100/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/media/platform/nxp/dw100/dw100.c: In function 'dw100_ctrl_dewarping_map_init':
>> drivers/media/platform/nxp/dw100/dw100.c:382:25: warning: variable 'dh' set but not used [-Wunused-but-set-variable]
     382 |         u32 sw, sh, dw, dh, mw, mh, idx;
         |                         ^~
>> drivers/media/platform/nxp/dw100/dw100.c:382:21: warning: variable 'dw' set but not used [-Wunused-but-set-variable]
     382 |         u32 sw, sh, dw, dh, mw, mh, idx;
         |                     ^~


vim +/dh +382 drivers/media/platform/nxp/dw100/dw100.c

   363	
   364	/*
   365	 * Initialize the dewarping map with an identity mapping.
   366	 *
   367	 * A 16 pixels cell size grid is mapped on the destination image.
   368	 * The last cells width/height might be lesser than 16 if the destination image
   369	 * width/height is not divisible by 16. This dewarping grid map specifies the
   370	 * source image pixel location (x, y) on each grid intersection point.
   371	 * Bilinear interpolation is used to compute inner cell points locations.
   372	 *
   373	 * The coordinates are saved in UQ12.4 fixed point format.
   374	 */
   375	static void dw100_ctrl_dewarping_map_init(const struct v4l2_ctrl *ctrl,
   376						  u32 from_idx, u32 elems,
   377						  union v4l2_ctrl_ptr ptr)
   378	{
   379		struct dw100_ctx *ctx =
   380			container_of(ctrl->handler, struct dw100_ctx, hdl);
   381	
 > 382		u32 sw, sh, dw, dh, mw, mh, idx;
   383		u16 qx, qy, qdx, qdy, qsh, qsw;
   384		u32 *map = ctrl->p_cur.p_u32;
   385	
   386		sw = ctx->q_data[DW100_QUEUE_SRC].pix_fmt.width;
   387		dw = ctx->q_data[DW100_QUEUE_DST].pix_fmt.width;
   388		sh = ctx->q_data[DW100_QUEUE_SRC].pix_fmt.height;
   389		dh = ctx->q_data[DW100_QUEUE_DST].pix_fmt.height;
   390	
   391		mw = ctrl->dims[0];
   392		mh = ctrl->dims[1];
   393	
   394		qsw = dw100_map_convert_to_uq12_4(sw);
   395		qsh = dw100_map_convert_to_uq12_4(sh);
   396		qdx = qsw / (mw - 1);
   397		qdy = qsh / (mh - 1);
   398	
   399		ctx->map_width = mw;
   400		ctx->map_height = mh;
   401		ctx->map_size = mh * mw * sizeof(u32);
   402	
   403		for (idx = from_idx; idx < elems; idx++) {
   404			qy = min_t(u32, (idx / mw) * qdy, qsh);
   405			qx = min_t(u32, (idx % mw) * qdx, qsw);
   406			map[idx] = dw100_map_format_coordinates(qx, qy);
   407		}
   408	
   409		ctx->user_map_is_set = false;
   410	}
   411	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

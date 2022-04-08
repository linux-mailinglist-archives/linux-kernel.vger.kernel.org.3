Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E7A4F9FB3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 00:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239995AbiDHWqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 18:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiDHWp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 18:45:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B426393CD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 15:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649457831; x=1680993831;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dGoMTvsiezYJqKU9jn/Mqy69Un9IVPOuvL8eqv96TcE=;
  b=CoFEXAZEB/qt+MOKKM/CeU3Xb8L4vkuLV27ARedFg9d1sa2nOwsl7GOY
   KAyMpp8+57S5xn6NTcvjCrDphznJ7iIwQiiijiuEawFrTy4MhBDbXQ7YP
   8izsinn+5uDMZf5+aqBmQmUNNVM6fWf3lhKOVgo7xbqboI1EhBdpyK1xo
   XtLx28/ZqfZzgVJltKbZZKRVnsVQ7YjpssDGjeST4enD6iJ3y2FfiECLa
   VRCyhKbz33SxT/SsjxRzlHONvQq9//06kUUgDIBdrJQVRZB2K90QP9SCG
   72fvGE12O0fQMIWmgLEihC8ECptR01AQoG6e+1CrptU6iU7Xy/2B4JmwV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="242305616"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="242305616"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 15:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="852264252"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Apr 2022 15:43:49 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncxKX-0000gs-0j;
        Fri, 08 Apr 2022 22:43:49 +0000
Date:   Sat, 9 Apr 2022 06:43:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [sailus-media-tree:master 29/30]
 drivers/media/v4l2-core/v4l2-subdev.c:1040:15: error: implicit declaration
 of function 'v4l2_subdev_get_pad_format'; did you mean
 'v4l2_subdev_get_fmt'?
Message-ID: <202204090639.C9t6QLg0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/sailus/media_tree.git master
head:   bd1d801f302289ddbf86ff6c38fcc91aef8e7609
commit: c503509891473482b5e88fd8c3d7b81015432f1c [29/30] media: subdev: add v4l2_subdev_get_fmt() helper function
config: ia64-randconfig-r011-20220408 (https://download.01.org/0day-ci/archive/20220409/202204090639.C9t6QLg0-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add sailus-media-tree git://linuxtv.org/sailus/media_tree.git
        git fetch --no-tags sailus-media-tree master
        git checkout c503509891473482b5e88fd8c3d7b81015432f1c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/media/v4l2-core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from drivers/media/v4l2-core/v4l2-subdev.c:12:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c: In function 'v4l2_subdev_get_fmt':
>> drivers/media/v4l2-core/v4l2-subdev.c:1040:15: error: implicit declaration of function 'v4l2_subdev_get_pad_format'; did you mean 'v4l2_subdev_get_fmt'? [-Werror=implicit-function-declaration]
    1040 |         fmt = v4l2_subdev_get_pad_format(sd, state, format->pad);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |               v4l2_subdev_get_fmt
>> drivers/media/v4l2-core/v4l2-subdev.c:1040:13: warning: assignment to 'struct v4l2_mbus_framefmt *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1040 |         fmt = v4l2_subdev_get_pad_format(sd, state, format->pad);
         |             ^
   cc1: some warnings being treated as errors


vim +1040 drivers/media/v4l2-core/v4l2-subdev.c

  1031	
  1032	int v4l2_subdev_get_fmt(struct v4l2_subdev *sd, struct v4l2_subdev_state *state,
  1033				struct v4l2_subdev_format *format)
  1034	{
  1035		struct v4l2_mbus_framefmt *fmt;
  1036	
  1037		if (format->pad >= sd->entity.num_pads)
  1038			return -EINVAL;
  1039	
> 1040		fmt = v4l2_subdev_get_pad_format(sd, state, format->pad);
  1041		if (!fmt)
  1042			return -EINVAL;
  1043	
  1044		format->format = *fmt;
  1045	
  1046		return 0;
  1047	}
  1048	EXPORT_SYMBOL_GPL(v4l2_subdev_get_fmt);
  1049	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

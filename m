Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB8958F379
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 22:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiHJUWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 16:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiHJUWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 16:22:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861CE12AD9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 13:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660162927; x=1691698927;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ihiZiczXoJLr8/d4cifJsJgiNY/aT7mxmMEmLwUyNxM=;
  b=ExVRbmdOI/RiB5j8FN8Ke9sz7KzB7xm/rDjfsfLK64gDsWgv3rgP0Iyv
   HvT4wgKfEEDKQ21DaCyE4vzieJnhINA2QvzVVrmC9Hcf5tVqZS4/Oo8hH
   oOngMe/dh4qzZSUM9FmGVlx0q43SgvQVJDCjASW5HRH7BCQ+LkXZqJpk4
   D8rxqMyO39tiE2scGRO47VB8Nv4h+z8/vJfavZiSCm1RDjv7+Y/9msJkC
   id+t66W4O5ReWYkVeMKKGa8SEkrBpKMZEj+ZTc9Fna5mKU/DeDj3GO7u8
   BI+ohhv3AHrdI5LrBM60/e0zemdRp/341BuuXYXsmUY/CuQylqldD3a83
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="274239798"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="274239798"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 13:22:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="605285668"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Aug 2022 13:22:06 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLsDN-0000gI-0P;
        Wed, 10 Aug 2022 20:22:05 +0000
Date:   Thu, 11 Aug 2022 04:21:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mikhail Khelik <mkhelik@cisco.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [hverkuil-media-tree:hdcp 3/4] drivers/media/i2c/adv7842.c:3449:38:
 warning: 'adv7842_ctrl_hdcp_auth' defined but not used
Message-ID: <202208110420.xBIcVvwn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git hdcp
head:   da521c491aa5d01b7a920ef66c8d9aef36f14a02
commit: aea22ce596846ba20f94105739f3867b8459ae45 [3/4] Added HDCP support for ADV7842
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220811/202208110420.xBIcVvwn-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree hdcp
        git checkout aea22ce596846ba20f94105739f3867b8459ae45
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/media/i2c/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/i2c/adv7842.c:3449:38: warning: 'adv7842_ctrl_hdcp_auth' defined but not used [-Wunused-const-variable=]
    3449 | static const struct v4l2_ctrl_config adv7842_ctrl_hdcp_auth = {
         |                                      ^~~~~~~~~~~~~~~~~~~~~~


vim +/adv7842_ctrl_hdcp_auth +3449 drivers/media/i2c/adv7842.c

  3448	
> 3449	static const struct v4l2_ctrl_config adv7842_ctrl_hdcp_auth = {
  3450		.ops = NULL,
  3451		.id = V4L2_CID_DV_HDCP_RX_AUTH,
  3452		.name = "HDCP Authentication Status",
  3453		.type = V4L2_CTRL_TYPE_BITMASK,
  3454		.min = 0,
  3455		.max = 1,
  3456		.step = 0,
  3457		.def = 0,
  3458		.flags = V4L2_CTRL_FLAG_READ_ONLY
  3459	};
  3460	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

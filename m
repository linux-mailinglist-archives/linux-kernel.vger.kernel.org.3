Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250354F1445
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiDDMEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbiDDME2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:04:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4626D3DA55
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649073752; x=1680609752;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wyMYjzXV6+0+TVWShJ+QuSmrkdWB2HoclgKdHoctNEk=;
  b=NqHQZqvr+4eNQDTwy8wVOZ4cFEJ/sMqbQa2Cew9HtbuxY51Y9O6/lO2G
   o0rspg/gkEnrCVeCGZ8MvaNbbS0O1kBuxwrtqqCFwfeSGcKeuVNWvGWtQ
   GdODfnphhr+1hUiwwJ02d5rCICOpzpXqJ92lXPzdtPL7iaNcm4NpbluAK
   4YOg4pnssCafeygTOHXcuNk+wj1/yqfNtyYp109HxbWVqq28qaoxt2vqt
   cgmwLbvB+rY85qXNLq2pm/ssmnyVkeYH9cQThguFrSllWbj2MdYicImfv
   29+Ry1TDMk4rFPAAp17OXgppwP3w43tU5GGTuagLsad0kRUEW2lbiBI9T
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="248010567"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="248010567"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 05:02:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="587546022"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 04 Apr 2022 05:02:14 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbLPQ-00021p-QQ;
        Mon, 04 Apr 2022 12:02:12 +0000
Date:   Mon, 4 Apr 2022 20:02:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [asahilinux:nvme-v2 5/6] drivers/soc/apple/rtkit.c:591:21: warning:
 no previous prototype for function 'apple_rtkit_init'
Message-ID: <202204041952.mbL4QEVS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux nvme-v2
head:   76835054c23e3e3505f5967d8580d86618aca6ec
commit: 689dd69e59bb68b19066104c34670d5dc272c946 [5/6] soc: apple: Add RTKit IPC library
config: arm64-randconfig-r005-20220404 (https://download.01.org/0day-ci/archive/20220404/202204041952.mbL4QEVS-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/AsahiLinux/linux/commit/689dd69e59bb68b19066104c34670d5dc272c946
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux nvme-v2
        git checkout 689dd69e59bb68b19066104c34670d5dc272c946
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/soc/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/soc/apple/rtkit.c:591:21: warning: no previous prototype for function 'apple_rtkit_init' [-Wmissing-prototypes]
   struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
                       ^
   drivers/soc/apple/rtkit.c:591:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
   ^
   static 
>> drivers/soc/apple/rtkit.c:805:6: warning: no previous prototype for function 'apple_rtkit_free' [-Wmissing-prototypes]
   void apple_rtkit_free(struct apple_rtkit *rtk)
        ^
   drivers/soc/apple/rtkit.c:805:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void apple_rtkit_free(struct apple_rtkit *rtk)
   ^
   static 
   2 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for VIDEO_V4L2_SUBDEV_API
   Depends on MEDIA_SUPPORT && VIDEO_DEV && MEDIA_CONTROLLER
   Selected by
   - VIDEO_IMX_MIPI_CSIS && MEDIA_SUPPORT && MEDIA_PLATFORM_SUPPORT && MEDIA_PLATFORM_DRIVERS && (ARCH_MXC || COMPILE_TEST


vim +/apple_rtkit_init +591 drivers/soc/apple/rtkit.c

   590	
 > 591	struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
   592					     const char *mbox_name, int mbox_idx,
   593					     const struct apple_rtkit_ops *ops)
   594	{
   595		struct apple_rtkit *rtk;
   596		int ret;
   597	
   598		if (!ops)
   599			return ERR_PTR(-EINVAL);
   600	
   601		rtk = kzalloc(sizeof(*rtk), GFP_KERNEL);
   602		if (!rtk)
   603			return ERR_PTR(-ENOMEM);
   604	
   605		rtk->dev = dev;
   606		rtk->cookie = cookie;
   607		rtk->ops = ops;
   608	
   609		init_completion(&rtk->epmap_completion);
   610		init_completion(&rtk->reinit_completion);
   611		init_completion(&rtk->iop_pwr_ack_completion);
   612		init_completion(&rtk->ap_pwr_ack_completion);
   613	
   614		bitmap_zero(rtk->endpoints, APPLE_RTKIT_MAX_ENDPOINTS);
   615		set_bit(APPLE_RTKIT_EP_MGMT, rtk->endpoints);
   616	
   617		rtk->mbox_name = mbox_name;
   618		rtk->mbox_idx = mbox_idx;
   619		rtk->mbox_cl.dev = dev;
   620		rtk->mbox_cl.tx_block = true;
   621		rtk->mbox_cl.knows_txdone = false;
   622		rtk->mbox_cl.rx_callback = &apple_rtkit_rx_callback;
   623	
   624		ret = apple_rtkit_request_mbox_chan(rtk);
   625		if (ret)
   626			return (struct apple_rtkit *)ERR_PTR(ret);
   627	
   628		return rtk;
   629	}
   630	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

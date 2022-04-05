Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DECD4F4CCF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580037AbiDEXdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452785AbiDEPzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:55:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF1479381
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649170635; x=1680706635;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HUuCde5QwQYg6TXe9MSQ6TekH6j3hvkYuaUQC0febew=;
  b=h1L9i1dAUhQ3zGWOYL5d7w7x7Gh6PGKTaCXcttpiOIspqf82hgw53sVM
   z968nfPryvMWAS30LUV7onvmaSSv7HY6dfmn3nJDRKO7iiHsBDezYlMwF
   9v/zru+aeTmZQxcdkNrayM9k2HQDoqlXicRWxxk7gAvC1tpswEPo3dXzG
   rq8fpUi18llLjeTPUZdqmNw+bIxfptUV+/8yHrZTUpY+9P1tf9Wn5lbeh
   /19s/ldOK2i49KhBRzzRZfgWD5koXunrH/URzDliMvBjz6mc/59srtKVO
   iB4m0e1QkTmybzgvD3HhEvQuvQ7jgTk7rLWt+QyGwL5WtHgFBPNUvUP82
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="242909581"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="242909581"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 07:57:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="524025802"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2022 07:57:11 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbkcJ-0003Rz-6j;
        Tue, 05 Apr 2022 14:57:11 +0000
Date:   Tue, 5 Apr 2022 22:56:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:nvme-v2 5/6] drivers/soc/apple/rtkit.c:591:21: warning:
 no previous prototype for 'apple_rtkit_init'
Message-ID: <202204052220.DC2iBfq3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux nvme-v2
head:   76835054c23e3e3505f5967d8580d86618aca6ec
commit: 689dd69e59bb68b19066104c34670d5dc272c946 [5/6] soc: apple: Add RTKit IPC library
config: ia64-buildonly-randconfig-r002-20220405 (https://download.01.org/0day-ci/archive/20220405/202204052220.DC2iBfq3-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/689dd69e59bb68b19066104c34670d5dc272c946
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux nvme-v2
        git checkout 689dd69e59bb68b19066104c34670d5dc272c946
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/soc/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/soc/apple/rtkit.c:591:21: warning: no previous prototype for 'apple_rtkit_init' [-Wmissing-prototypes]
     591 | struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
         |                     ^~~~~~~~~~~~~~~~
>> drivers/soc/apple/rtkit.c:805:6: warning: no previous prototype for 'apple_rtkit_free' [-Wmissing-prototypes]
     805 | void apple_rtkit_free(struct apple_rtkit *rtk)
         |      ^~~~~~~~~~~~~~~~


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

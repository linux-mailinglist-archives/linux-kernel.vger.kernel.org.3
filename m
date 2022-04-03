Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAA24F0A76
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 16:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359104AbiDCPAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353718AbiDCPAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:00:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC86462F8
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648997915; x=1680533915;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ql2CBIN/ch+fTCgmEZ+hEzF4RvLJPE/sdLa1hIHKZYE=;
  b=jReEhjmZusO4a6u/hHFWEel16jp6bBM7XKTZv+dRHMQpXMaFvwcy+LJF
   aXuuaqKAncN1GEA+8rzg7QbmUxsxq+xLn3UgOVVZA25E1SsLdR1eOLJ8B
   I6xTgRu8ATcqAR+Bdt6++SslaLzPfIERhqMtKBePoJd6cc+Fcg63z963W
   9BOrRoeVGJYzXj8r03ROrCSNKV+hFai7E9v/4PeiPTdcXeHVC6wXC9hb1
   CJHjPqqxSjnCv7bMAZEDzb5IIXrA2XWFjF3cVrObc6Cp2o0PBPzE/PYne
   HGmKx787SnMx0rewab8+snfcHivVJIM87vKyhBNkyJrcwADbo48DoEbkq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="240977577"
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="240977577"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 07:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="548373463"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Apr 2022 07:58:32 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nb1gV-00012f-SI;
        Sun, 03 Apr 2022 14:58:31 +0000
Date:   Sun, 3 Apr 2022 22:57:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:nvme-v2 5/6] drivers/soc/apple/rtkit.c:575:21: warning:
 no previous prototype for 'apple_rtkit_init'
Message-ID: <202204032241.T4QW8bQo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux nvme-v2
head:   1c4210208a7dffa2a6697b0be5fa1da9f2bc448c
commit: 49f954ccdfe134d00b9e17b9ff5186a47725c6bf [5/6] soc: apple: Add RTKit IPC library
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20220403/202204032241.T4QW8bQo-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/49f954ccdfe134d00b9e17b9ff5186a47725c6bf
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux nvme-v2
        git checkout 49f954ccdfe134d00b9e17b9ff5186a47725c6bf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash drivers/soc/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/soc/apple/rtkit.c:575:21: warning: no previous prototype for 'apple_rtkit_init' [-Wmissing-prototypes]
     575 | struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
         |                     ^~~~~~~~~~~~~~~~
>> drivers/soc/apple/rtkit.c:789:6: warning: no previous prototype for 'apple_rtkit_free' [-Wmissing-prototypes]
     789 | void apple_rtkit_free(struct apple_rtkit *rtk)
         |      ^~~~~~~~~~~~~~~~


vim +/apple_rtkit_init +575 drivers/soc/apple/rtkit.c

   574	
 > 575	struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
   576					     const char *mbox_name, int mbox_idx,
   577					     const struct apple_rtkit_ops *ops)
   578	{
   579		struct apple_rtkit *rtk;
   580		int ret;
   581	
   582		if (!ops)
   583			return ERR_PTR(-EINVAL);
   584	
   585		rtk = kzalloc(sizeof(*rtk), GFP_KERNEL);
   586		if (!rtk)
   587			return ERR_PTR(-ENOMEM);
   588	
   589		rtk->dev = dev;
   590		rtk->cookie = cookie;
   591		rtk->ops = ops;
   592	
   593		init_completion(&rtk->epmap_completion);
   594		init_completion(&rtk->reinit_completion);
   595		init_completion(&rtk->iop_pwr_ack_completion);
   596		init_completion(&rtk->ap_pwr_ack_completion);
   597	
   598		bitmap_zero(rtk->endpoints, APPLE_RTKIT_MAX_ENDPOINTS);
   599		set_bit(APPLE_RTKIT_EP_MGMT, rtk->endpoints);
   600	
   601		rtk->mbox_name = mbox_name;
   602		rtk->mbox_idx = mbox_idx;
   603		rtk->mbox_cl.dev = dev;
   604		rtk->mbox_cl.tx_block = true;
   605		rtk->mbox_cl.knows_txdone = false;
   606		rtk->mbox_cl.rx_callback = &apple_rtkit_rx_callback;
   607	
   608		ret = apple_rtkit_request_mbox_chan(rtk);
   609		if (ret)
   610			return (struct apple_rtkit *)ERR_PTR(ret);
   611	
   612		return rtk;
   613	}
   614	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

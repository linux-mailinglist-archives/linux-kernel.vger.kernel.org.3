Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D070B4F9E68
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbiDHUxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239544AbiDHUx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:53:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ED52EF172
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649451083; x=1680987083;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I/DHdp9xZEEBb2Xk0bi5vzCAGsazyUmposPGXbwPmyw=;
  b=U7pama++2vP0wVIsd134MfXQG8ynpLdxAZBWGTH+bs5pUs1sEH4wLBRD
   B7P+wqE5P/0n6IQk+PlXqfn+0Q0OXnMcaovOYy9MQxIQ7Tw2nPdoZcwnT
   5UIVqFo4FiZOOURZ5/6Q/eCmvm4U8XPb03EBdG/RtHR0LxFiyA2L9IXNi
   B7R6+0zSSVemxvJWHWWBU8ccobCGk3ldC0pT9uKkEia1y6ErMJmpMac5r
   H+FNLFyGOwIjGVWaM1otoT7tW6kVohVWZlH+UKUTvX0HaRsyYt2ioi7HQ
   gHWQ3zVvRuwMRz30pMz2z3zQiYyAWZCwI6wH2IfuRKIdnEdzB5qAinfAE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="261674633"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261674633"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 13:51:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="659620660"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Apr 2022 13:51:19 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncvZe-0000dE-Gi;
        Fri, 08 Apr 2022 20:51:18 +0000
Date:   Sat, 9 Apr 2022 04:50:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     popcornmix <popcornmix@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kari Suvanto <karis79@gmail.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Phil Elwell <phil@raspberrypi.org>,
        Malik Olivier Boussejra <malik@boussejra.com>,
        Paul Zimmerman <paulz@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Michael Zoran <mzoran@crowfest.net>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Jonathan Bell <jonathan@raspberrypi.org>,
        Hui Wang <hui.wang@canonical.com>,
        Zixuan Wang <wangzixuan@sjtu.edu.cn>
Subject: [l1k:smsc95xx_5.17 56/887]
 drivers/usb/host/dwc_otg/dwc_otg_hcd_linux.c:423:13: warning: no previous
 prototype for 'fiq_irq_handler'
Message-ID: <202204090452.Pg7hes1b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: a8197852bb8f1f6804cff9442d426888e97aaed3 [56/887] Add dwc_otg driver
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220409/202204090452.Pg7hes1b-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/a8197852bb8f1f6804cff9442d426888e97aaed3
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout a8197852bb8f1f6804cff9442d426888e97aaed3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/usb/host/dwc_otg/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/usb/host/dwc_otg/dwc_otg_hcd_linux.c:423:13: warning: no previous prototype for 'fiq_irq_handler' [-Wmissing-prototypes]
     423 | irqreturn_t fiq_irq_handler(int irq, void *dev_id)
         |             ^~~~~~~~~~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_hcd_linux.c:552:5: warning: no previous prototype for 'hcd_init' [-Wmissing-prototypes]
     552 | int hcd_init(dwc_bus_dev_t *_dev)
         |     ^~~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_hcd_linux.c:662:6: warning: no previous prototype for 'hcd_remove' [-Wmissing-prototypes]
     662 | void hcd_remove(dwc_bus_dev_t *_dev)
         |      ^~~~~~~~~~


vim +/fiq_irq_handler +423 drivers/usb/host/dwc_otg/dwc_otg_hcd_linux.c

   422	
 > 423	irqreturn_t fiq_irq_handler(int irq, void *dev_id)
   424	{
   425		dwc_otg_hcd_t *dwc_otg_hcd = (dwc_otg_hcd_t *)dev_id;
   426	
   427		if (fiq_fsm_enable)
   428			dwc_otg_fiq_fsm(dwc_otg_hcd->fiq_state, dwc_otg_hcd->core_if->core_params->host_channels);
   429		else
   430			dwc_otg_fiq_nop(dwc_otg_hcd->fiq_state);
   431	
   432		return IRQ_HANDLED;
   433	}
   434	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

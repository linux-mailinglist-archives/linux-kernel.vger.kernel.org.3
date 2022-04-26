Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C984851060E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349418AbiDZR7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353649AbiDZR7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:59:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A6D3DDD3;
        Tue, 26 Apr 2022 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650995760; x=1682531760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lFNYjYV0TGvX9dxBXO+JQ/DdIQG+A42esjoVfyX+w7g=;
  b=JmGKDruC911skrHkCTcsPUfbqV3H2ZrFqPLLPRuDSOiP6xI00JCg4qdc
   tY/01eY8Dsga78l9nxI1DSyNSVxQ4+/1H3n6MYMY1Elw3tM+20YAxvFFc
   uy7ryM2CH3WDZ0gILislzAFSw9Y6mmZjzGcaNMaToLdBHKRcJZFXlO1OA
   YqQwYVIFCoS1KgpnEYREnPOolDRyDLxVvZX6GAXktsS2kc+NQLLaD5PiS
   gXqvSzJM4EMLnLFG1cypjumUz0rmFG8xaLE+5BPrUQFT77zxWyqRdh9ss
   SSiYKUdnjr2Ru092bYtz5zKKC/79DpIbIA7WhzHuswbWBXACbpHQKXyQW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="326163445"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="326163445"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 10:56:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="513280755"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Apr 2022 10:55:57 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njPPo-0003s8-Dm;
        Tue, 26 Apr 2022 17:55:56 +0000
Date:   Wed, 27 Apr 2022 01:55:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        Daehwan Jung <dh10.jung@samsung.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 5/5] usb: host: add xhci-exynos driver
Message-ID: <202204270151.wJnsbJBF-lkp@intel.com>
References: <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daehwan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on krzk/for-next char-misc/char-misc-testing v5.18-rc4 next-20220426]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Daehwan-Jung/usb-host-export-symbols-for-xhci-exynos-to-use-xhci-hooks/20220426-181936
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220427/202204270151.wJnsbJBF-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6beb993f823c7c9a71f0b539a34d0ef5c64bd73d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daehwan-Jung/usb-host-export-symbols-for-xhci-exynos-to-use-xhci-hooks/20220426-181936
        git checkout 6beb993f823c7c9a71f0b539a34d0ef5c64bd73d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/usb/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/host/xhci-exynos.c: In function 'xhci_exynos_address_device':
>> drivers/usb/host/xhci-exynos.c:112:26: warning: variable 'xhci' set but not used [-Wunused-but-set-variable]
     112 |         struct xhci_hcd *xhci;
         |                          ^~~~
   drivers/usb/host/xhci-exynos.c: In function 'xhci_exynos_vendor_init':
>> drivers/usb/host/xhci-exynos.c:205:34: warning: variable 'pdev' set but not used [-Wunused-but-set-variable]
     205 |         struct platform_device  *pdev;
         |                                  ^~~~
   drivers/usb/host/xhci-exynos.c: In function 'xhci_exynos_parse_endpoint':
>> drivers/usb/host/xhci-exynos.c:353:29: warning: variable 'ep_ctx' set but not used [-Wunused-but-set-variable]
     353 |         struct xhci_ep_ctx *ep_ctx;
         |                             ^~~~~~
   At top level:
   drivers/usb/host/xhci-exynos.c:543:12: warning: 'xhci_exynos_resume' defined but not used [-Wunused-function]
     543 | static int xhci_exynos_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~
   drivers/usb/host/xhci-exynos.c:533:12: warning: 'xhci_exynos_suspend' defined but not used [-Wunused-function]
     533 | static int xhci_exynos_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~
   drivers/usb/host/xhci-exynos.c:30:12: warning: 'xhci_exynos_register_vendor_ops' defined but not used [-Wunused-function]
      30 | static int xhci_exynos_register_vendor_ops(struct xhci_vendor_ops *vendor_ops)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/xhci +112 drivers/usb/host/xhci-exynos.c

   109	
   110	static int xhci_exynos_address_device(struct usb_hcd *hcd, struct usb_device *udev)
   111	{
 > 112		struct xhci_hcd *xhci;
   113		int ret;
   114	
   115		ret = xhci_address_device(hcd, udev);
   116		xhci = hcd_to_xhci(hcd);
   117	
   118		/* TODO: store and pass hw info to Co-Processor here*/
   119	
   120		return ret;
   121	}
   122	
   123	static int xhci_exynos_wake_lock(struct xhci_hcd_exynos *xhci_exynos,
   124					   int is_main_hcd, int is_lock)
   125	{
   126		struct usb_hcd	*hcd = xhci_exynos->hcd;
   127		struct xhci_hcd *xhci = hcd_to_xhci(hcd);
   128		struct wakeup_source *main_wakelock, *shared_wakelock;
   129	
   130		main_wakelock = xhci_exynos->main_wakelock;
   131		shared_wakelock = xhci_exynos->shared_wakelock;
   132	
   133		if (xhci->xhc_state & XHCI_STATE_REMOVING)
   134			return -ESHUTDOWN;
   135	
   136		if (is_lock) {
   137			if (is_main_hcd)
   138				__pm_stay_awake(main_wakelock);
   139			else
   140				__pm_stay_awake(shared_wakelock);
   141		} else {
   142			if (is_main_hcd)
   143				__pm_relax(main_wakelock);
   144			else
   145				__pm_relax(shared_wakelock);
   146		}
   147	
   148		return 0;
   149	}
   150	
   151	static int xhci_exynos_bus_suspend(struct usb_hcd *hcd)
   152	{
   153		struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
   154		struct xhci_hcd_exynos *xhci_exynos = priv->vendor_priv;
   155		struct xhci_hcd *xhci = hcd_to_xhci(hcd);
   156	
   157	
   158		int ret, main_hcd;
   159	
   160		if (hcd == xhci->main_hcd)
   161			main_hcd = 1;
   162		else
   163			main_hcd = 0;
   164	
   165		ret = xhci_bus_suspend(hcd);
   166		xhci_exynos_wake_lock(xhci_exynos, main_hcd, 0);
   167	
   168		return ret;
   169	}
   170	
   171	static int xhci_exynos_bus_resume(struct usb_hcd *hcd)
   172	{
   173		struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
   174		struct xhci_hcd_exynos *xhci_exynos = priv->vendor_priv;
   175		struct xhci_hcd *xhci = hcd_to_xhci(hcd);
   176	
   177		int ret, main_hcd;
   178	
   179		if (hcd == xhci->main_hcd)
   180			main_hcd = 1;
   181		else
   182			main_hcd = 0;
   183	
   184		ret = xhci_bus_resume(hcd);
   185		xhci_exynos_wake_lock(xhci_exynos, main_hcd, 1);
   186	
   187		return ret;
   188	}
   189	
   190	const struct xhci_driver_overrides xhci_exynos_overrides = {
   191		.reset = xhci_exynos_setup,
   192		.start = xhci_exynos_start,
   193		.add_endpoint = xhci_exynos_add_endpoint,
   194		.address_device = xhci_exynos_address_device,
   195		.bus_suspend = xhci_exynos_bus_suspend,
   196		.bus_resume = xhci_exynos_bus_resume,
   197	};
   198	
   199	static int xhci_exynos_vendor_init(struct xhci_hcd *xhci, struct device *dev)
   200	{
   201		struct usb_hcd		*hcd;
   202		struct xhci_hcd_exynos	*xhci_exynos;
   203		struct xhci_plat_priv *priv;
   204		struct wakeup_source	*main_wakelock, *shared_wakelock;
 > 205		struct platform_device	*pdev;
   206	
   207		pdev = to_platform_device(dev);
   208	
   209		xhci_plat_override_driver(&xhci_exynos_overrides);
   210		dev->driver->pm = &xhci_exynos_pm_ops;
   211	
   212		main_wakelock = wakeup_source_register(dev, dev_name(dev));
   213		__pm_stay_awake(main_wakelock);
   214	
   215		/* Initialization shared wakelock for SS HCD */
   216		shared_wakelock = wakeup_source_register(dev, dev_name(dev));
   217		__pm_stay_awake(shared_wakelock);
   218	
   219		hcd = xhci->main_hcd;
   220	
   221		priv = hcd_to_xhci_priv(hcd);
   222		xhci_exynos = priv->vendor_priv;
   223		xhci_exynos->dev = dev;
   224		xhci_exynos->main_wakelock = main_wakelock;
   225		xhci_exynos->shared_wakelock = shared_wakelock;
   226	
   227		return 0;
   228	}
   229	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

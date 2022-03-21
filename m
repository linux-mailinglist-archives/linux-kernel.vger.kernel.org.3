Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A723F4E2E32
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351287AbiCUQjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351284AbiCUQjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:39:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE4C140CB;
        Mon, 21 Mar 2022 09:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647880693; x=1679416693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1SHt+fk2mBoD22kwltECjij4B6KkTs/bLLsGHAHaOZI=;
  b=Vi44FdVjiJkaO03owuOYK8vVpSoXz+L308/AmsA920DfuFijLk+A7neI
   ErJTSV0mKDE6XHQ25GxC2g3Wz4DwT5OYlxzWZBhjk0OeJykiXQwQ2iFpK
   jw5mFlLXDonVPbNo/KhzXGSI4CTUI6qJ1L/XKl6yKn6qKbcjw8uQ/Iw/e
   2TqEai3ZVfd8jQYXg5wyrID7U9dd3kWphpF83CTtB4O6YWPawF1/bCaiE
   1AKrT5deVPrOntq0QBY8FuBhtSYgPKP+vqTCra/1K5mc/WWcuE3P4qas4
   azRyJESNdKDBugjSgdeTSigDv46/v6xb4x65L94s1pjPTpM1h2ZpdYuZy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="238200349"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="238200349"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 09:38:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="648624369"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 Mar 2022 09:38:10 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWL2n-000HzH-CN; Mon, 21 Mar 2022 16:38:09 +0000
Date:   Tue, 22 Mar 2022 00:37:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        Daehwan Jung <dh10.jung@samsung.com>, sc.suh@samsung.com
Subject: Re: [PATCH v3 4/4] usb: host: add xhci-exynos driver
Message-ID: <202203220027.WbsbZkyk-lkp@intel.com>
References: <1647853194-62147-5-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647853194-62147-5-git-send-email-dh10.jung@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daehwan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220318]
[also build test ERROR on v5.17]
[cannot apply to usb/usb-testing krzk/for-next char-misc/char-misc-testing v5.17 v5.17-rc8 v5.17-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Daehwan-Jung/usb-host-export-symbols-for-xhci-hooks-usage/20220321-180046
base:    6d72dda014a4753974eb08950089ddf71fec4f60
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220322/202203220027.WbsbZkyk-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/517a7258fc6a2861b66ae9893b39d8bd4d6739e7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Daehwan-Jung/usb-host-export-symbols-for-xhci-hooks-usage/20220321-180046
        git checkout 517a7258fc6a2861b66ae9893b39d8bd4d6739e7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/usb/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/usb/host/xhci-exynos.c: In function 'xhci_priv_exynos_setup':
>> drivers/usb/host/xhci-exynos.c:55:18: error: 'struct xhci_plat_priv' has no member named 'plat_setup'
      55 |         if (!priv->plat_setup)
         |                  ^~
   drivers/usb/host/xhci-exynos.c:58:20: error: 'struct xhci_plat_priv' has no member named 'plat_setup'
      58 |         return priv->plat_setup(hcd);
         |                    ^~
   drivers/usb/host/xhci-exynos.c: In function 'xhci_exynos_address_device':
>> drivers/usb/host/xhci-exynos.c:260:26: warning: variable 'xhci' set but not used [-Wunused-but-set-variable]
     260 |         struct xhci_hcd *xhci;
         |                          ^~~~
   drivers/usb/host/xhci-exynos.c: In function 'xhci_exynos_parse_endpoint':
>> drivers/usb/host/xhci-exynos.c:276:29: warning: variable 'ep_ctx' set but not used [-Wunused-but-set-variable]
     276 |         struct xhci_ep_ctx *ep_ctx;
         |                             ^~~~~~
   drivers/usb/host/xhci-exynos.c: In function 'xhci_exynos_set_hc_event_deq_audio':
>> drivers/usb/host/xhci-exynos.c:370:20: warning: variable 'deq' set but not used [-Wunused-but-set-variable]
     370 |         dma_addr_t deq;
         |                    ^~~
   drivers/usb/host/xhci-exynos.c: At top level:
>> drivers/usb/host/xhci-exynos.c:576:10: error: 'const struct xhci_plat_priv' has no member named 'plat_setup'
     576 |         .plat_setup = xhci_mvebu_a3700_plat_setup,
         |          ^~~~~~~~~~
>> drivers/usb/host/xhci-exynos.c:576:23: error: 'xhci_mvebu_a3700_plat_setup' undeclared here (not in a function); did you mean 'xhci_mvebu_a3700_init_quirk'?
     576 |         .plat_setup = xhci_mvebu_a3700_plat_setup,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                       xhci_mvebu_a3700_init_quirk
   drivers/usb/host/xhci-exynos.c: In function 'xhci_priv_exynos_setup':
   drivers/usb/host/xhci-exynos.c:59:1: error: control reaches end of non-void function [-Werror=return-type]
      59 | }
         | ^
   At top level:
   drivers/usb/host/xhci-exynos.c:588:36: warning: 'xhci_plat_brcm' defined but not used [-Wunused-const-variable=]
     588 | static const struct xhci_plat_priv xhci_plat_brcm = {
         |                                    ^~~~~~~~~~~~~~
   drivers/usb/host/xhci-exynos.c:584:36: warning: 'xhci_plat_renesas_rcar_gen3' defined but not used [-Wunused-const-variable=]
     584 | static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen3 = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/xhci-exynos.c:580:36: warning: 'xhci_plat_renesas_rcar_gen2' defined but not used [-Wunused-const-variable=]
     580 | static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen2 = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/xhci-exynos.c:575:36: warning: 'xhci_plat_marvell_armada3700' defined but not used [-Wunused-const-variable=]
     575 | static const struct xhci_plat_priv xhci_plat_marvell_armada3700 = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/xhci-exynos.c:571:36: warning: 'xhci_plat_marvell_armada' defined but not used [-Wunused-const-variable=]
     571 | static const struct xhci_plat_priv xhci_plat_marvell_armada = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +55 drivers/usb/host/xhci-exynos.c

    50	
    51	static int xhci_priv_exynos_setup(struct usb_hcd *hcd)
    52	{
    53		struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
    54	
  > 55		if (!priv->plat_setup)
    56			return 0;
    57	
    58		return priv->plat_setup(hcd);
    59	}
    60	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

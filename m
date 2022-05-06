Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE23451E08F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444306AbiEFVDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444314AbiEFVD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:03:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B976F494
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 13:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651870776; x=1683406776;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x13dD3VLjjzATCduoANTxtyBjtiJnWJBZDCR6LHKV9E=;
  b=fTw8t3cDIf50fH8IH7Wjy+BJ/jye6zna+UXIdbQUOKHjUb2U7zTLhl5+
   bX9j3UAAZjCk7ZpyatK6MZrY/GgxeOTbDZ33mECEli/EB2PVEUTSoJjXa
   8ZSJn/J5n3xNzA3diLeHYX1PRcMt98D4ALfmnEgpejDurQFYru/EC8N/j
   ARuQKAL13W87XvLM++kLmWo4v4BL7R2tksLICqC+eEB+6317iA7uI0ZIq
   2wiEQj7hppVttPzI/mTUj5zF+bW6B+Gizkghbk4vL3o+dbASDG/ZQqFhs
   ngv81NRzvQoq0mPEvpArecmEJNRCX4Mmp7bsuChv+JQaaqmf+7icdtgCs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="248477860"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="248477860"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 13:59:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="709626014"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2022 13:59:35 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn530-000Dtl-V8;
        Fri, 06 May 2022 20:59:34 +0000
Date:   Sat, 7 May 2022 04:58:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mnyman-xhci:for-usb-next 8/8] drivers/usb/host/xhci-ring.c:1473:24:
 warning: variable 'drop_flags' set but not used
Message-ID: <202205070456.Hl6TmJVF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git for-usb-next
head:   3eacb1f2e43e3cb7344e4a80721bdbfcb52cb7db
commit: 3eacb1f2e43e3cb7344e4a80721bdbfcb52cb7db [8/8] xhci: Remove quirk for over 10 year old evaluation hardware
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220507/202205070456.Hl6TmJVF-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/commit/?id=3eacb1f2e43e3cb7344e4a80721bdbfcb52cb7db
        git remote add mnyman-xhci https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git
        git fetch --no-tags mnyman-xhci for-usb-next
        git checkout 3eacb1f2e43e3cb7344e4a80721bdbfcb52cb7db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/usb/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/host/xhci-ring.c: In function 'xhci_handle_cmd_config_ep':
>> drivers/usb/host/xhci-ring.c:1473:24: warning: variable 'drop_flags' set but not used [-Wunused-but-set-variable]
    1473 |         u32 add_flags, drop_flags;
         |                        ^~~~~~~~~~
   drivers/usb/host/xhci-ring.c:1472:22: warning: unused variable 'ep_state' [-Wunused-variable]
    1472 |         unsigned int ep_state;
         |                      ^~~~~~~~


vim +/drop_flags +1473 drivers/usb/host/xhci-ring.c

6c02dd147a7a3d Xenia Ragiadakou 2013-09-09  1464  
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1465  static void xhci_handle_cmd_config_ep(struct xhci_hcd *xhci, int slot_id,
a181030703df18 Mathias Nyman    2021-01-29  1466  		u32 cmd_comp_code)
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1467  {
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1468  	struct xhci_virt_device *virt_dev;
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1469  	struct xhci_input_control_ctx *ctrl_ctx;
19a7d0d65c4a81 Felipe Balbi     2017-04-07  1470  	struct xhci_ep_ctx *ep_ctx;
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1471  	unsigned int ep_index;
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1472  	unsigned int ep_state;
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09 @1473  	u32 add_flags, drop_flags;
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1474  
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1475  	/*
3eacb1f2e43e3c Mathias Nyman    2022-05-02  1476  	 * Configure endpoint commands can come from the USB core configuration
3eacb1f2e43e3c Mathias Nyman    2022-05-02  1477  	 * or alt setting changes, or when streams were being configured.
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1478  	 */
3eacb1f2e43e3c Mathias Nyman    2022-05-02  1479  
9ea1833e4c210a Mathias Nyman    2014-05-08  1480  	virt_dev = xhci->devs[slot_id];
03ed579d9d51aa Mathias Nyman    2021-01-29  1481  	if (!virt_dev)
03ed579d9d51aa Mathias Nyman    2021-01-29  1482  		return;
4daf9df51fbfb0 Lin Wang         2015-01-09  1483  	ctrl_ctx = xhci_get_input_control_ctx(virt_dev->in_ctx);
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1484  	if (!ctrl_ctx) {
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1485  		xhci_warn(xhci, "Could not get input context, bad type.\n");
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1486  		return;
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1487  	}
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1488  
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1489  	add_flags = le32_to_cpu(ctrl_ctx->add_flags);
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1490  	drop_flags = le32_to_cpu(ctrl_ctx->drop_flags);
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1491  	/* Input ctx add_flags are the endpoint index plus one */
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1492  	ep_index = xhci_last_valid_endpoint(add_flags) - 1;
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1493  
19a7d0d65c4a81 Felipe Balbi     2017-04-07  1494  	ep_ctx = xhci_get_ep_ctx(xhci, virt_dev->out_ctx, ep_index);
19a7d0d65c4a81 Felipe Balbi     2017-04-07  1495  	trace_xhci_handle_cmd_config_ep(ep_ctx);
19a7d0d65c4a81 Felipe Balbi     2017-04-07  1496  
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1497  	return;
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1498  }
6ed46d3337b1f4 Xenia Ragiadakou 2013-09-09  1499  

:::::: The code at line 1473 was first introduced by commit
:::::: 6ed46d3337b1f4a8f9fa7438589cab5f1bb75e98 xhci: refactor TRB_CONFIG_EP case into function

:::::: TO: Xenia Ragiadakou <burzalodowa@gmail.com>
:::::: CC: Sarah Sharp <sarah.a.sharp@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

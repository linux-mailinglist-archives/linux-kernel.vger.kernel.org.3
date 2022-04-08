Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E3C4F9FA0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 00:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiDHWf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 18:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiDHWf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 18:35:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1906B29A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 15:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649457231; x=1680993231;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Eyr3rnHZFWM8Kq5tlkOFbVPOWSflB44fUC999WLRy6w=;
  b=EB/FbOI/OqbVCDQLImUe+DTbHErrXd+vMfHP60Z2EMkGlD1SkzFydEDN
   9MoJ+F1g4Qw1hJAZreFp8lnmxwvC7GOrCOBZMflEz7Xp2t51vY7rlssHn
   qE5fTCNZWK5bGpOvxB2RdUBziR6KEERqRHKJ/4gBdY19uEhyGGp22yQpP
   fZcM6mMWEDH5jfX9EtF6m7WpGla2wjzjQI4gNhKhfdyLK0qPsxd6TJFbw
   sTWXOKZysHRrSnbFHzegsTBOjo1EM0ixrhQhs12dS69pselIr7iYs2i6e
   Tu18sozvCayNQaUgZogaYpR/kbigXBgyktVCBR4owusW1MAsCrbsCflXy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="259307176"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="259307176"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 15:33:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="621815434"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2022 15:33:49 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncxAq-0000gb-Rf;
        Fri, 08 Apr 2022 22:33:48 +0000
Date:   Sat, 9 Apr 2022 06:32:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Bell <jonathan@raspberrypi.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>
Subject: [l1k:smsc95xx_5.17 140/888] drivers/usb/host/xhci.c:1689:29: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202204090637.J4hjtLu2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   240f56c27361c195cd502d95aba51c6b8e5b808c
commit: 18a0d6abec9adca77be3ce06941448e33250e4ed [140/888] xhci: implement xhci_fixup_endpoint for interval adjustments
config: nios2-randconfig-s032-20220408 (https://download.01.org/0day-ci/archive/20220409/202204090637.J4hjtLu2-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/l1k/linux/commit/18a0d6abec9adca77be3ce06941448e33250e4ed
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 18a0d6abec9adca77be3ce06941448e33250e4ed
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/usb/host/xhci.c:1689:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] add_flags @@     got unsigned int @@
   drivers/usb/host/xhci.c:1689:29: sparse:     expected restricted __le32 [usertype] add_flags
   drivers/usb/host/xhci.c:1689:29: sparse:     got unsigned int

vim +1689 drivers/usb/host/xhci.c

  1612	
  1613	static void xhci_fixup_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
  1614					struct usb_host_endpoint *ep, int interval)
  1615	{
  1616		struct xhci_hcd *xhci;
  1617		struct xhci_ep_ctx *ep_ctx_out, *ep_ctx_in;
  1618		struct xhci_command *command;
  1619		struct xhci_input_control_ctx *ctrl_ctx;
  1620		struct xhci_virt_device *vdev;
  1621		int xhci_interval;
  1622		int ret;
  1623		int ep_index;
  1624		unsigned long flags;
  1625		u32 ep_info_tmp;
  1626	
  1627		xhci = hcd_to_xhci(hcd);
  1628		ep_index = xhci_get_endpoint_index(&ep->desc);
  1629	
  1630		/* FS/LS interval translations */
  1631		if ((udev->speed == USB_SPEED_FULL ||
  1632		     udev->speed == USB_SPEED_LOW))
  1633			interval *= 8;
  1634	
  1635		mutex_lock(&xhci->mutex);
  1636	
  1637		spin_lock_irqsave(&xhci->lock, flags);
  1638	
  1639		vdev = xhci->devs[udev->slot_id];
  1640		/* Get context-derived endpoint interval */
  1641		ep_ctx_out = xhci_get_ep_ctx(xhci, vdev->out_ctx, ep_index);
  1642		ep_ctx_in = xhci_get_ep_ctx(xhci, vdev->in_ctx, ep_index);
  1643		xhci_interval = EP_INTERVAL_TO_UFRAMES(le32_to_cpu(ep_ctx_out->ep_info));
  1644	
  1645		if (interval == xhci_interval) {
  1646			spin_unlock_irqrestore(&xhci->lock, flags);
  1647			mutex_unlock(&xhci->mutex);
  1648			return;
  1649		}
  1650	
  1651		xhci_dbg(xhci, "Fixup interval=%d xhci_interval=%d\n",
  1652			 interval, xhci_interval);
  1653		command = xhci_alloc_command_with_ctx(xhci, true, GFP_ATOMIC);
  1654		if (!command) {
  1655			/* Failure here is benign, poll at the original rate */
  1656			spin_unlock_irqrestore(&xhci->lock, flags);
  1657			mutex_unlock(&xhci->mutex);
  1658			return;
  1659		}
  1660	
  1661		/* xHCI uses exponents for intervals... */
  1662		xhci_interval = fls(interval) - 1;
  1663		xhci_interval = clamp_val(xhci_interval, 3, 10);
  1664		ep_info_tmp = le32_to_cpu(ep_ctx_out->ep_info);
  1665		ep_info_tmp &= ~EP_INTERVAL(255);
  1666		ep_info_tmp |= EP_INTERVAL(xhci_interval);
  1667	
  1668		/* Keep the endpoint context up-to-date while issuing the command. */
  1669		xhci_endpoint_copy(xhci, vdev->in_ctx,
  1670				   vdev->out_ctx, ep_index);
  1671		ep_ctx_in->ep_info = cpu_to_le32(ep_info_tmp);
  1672	
  1673		/*
  1674		 * We need to drop the lock, so take an explicit copy
  1675		 * of the ep context.
  1676		 */
  1677		xhci_endpoint_copy(xhci, command->in_ctx, vdev->in_ctx, ep_index);
  1678	
  1679		ctrl_ctx = xhci_get_input_control_ctx(command->in_ctx);
  1680		if (!ctrl_ctx) {
  1681			xhci_warn(xhci,
  1682				  "%s: Could not get input context, bad type.\n",
  1683				  __func__);
  1684			spin_unlock_irqrestore(&xhci->lock, flags);
  1685			xhci_free_command(xhci, command);
  1686			mutex_unlock(&xhci->mutex);
  1687			return;
  1688		}
> 1689		ctrl_ctx->add_flags = xhci_get_endpoint_flag_from_index(ep_index);
  1690		ctrl_ctx->drop_flags = 0;
  1691	
  1692		spin_unlock_irqrestore(&xhci->lock, flags);
  1693	
  1694		ret = xhci_configure_endpoint(xhci, udev, command,
  1695					      false, false);
  1696		if (ret)
  1697			xhci_warn(xhci, "%s: Configure endpoint failed: %d\n",
  1698				  __func__, ret);
  1699		xhci_free_command(xhci, command);
  1700		mutex_unlock(&xhci->mutex);
  1701	}
  1702	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

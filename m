Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1001C4854FA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 15:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbiAEOrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 09:47:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:26189 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240844AbiAEOrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 09:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641394066; x=1672930066;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d6eTXQUcA7jU2w8PviNLMOMDZGFWBUC58QjrOWlvlVg=;
  b=LDXgqO7I2mjZPB6esbhgWGQ4cXKJwNuHcOTch78F1h6N960UWWlddpCI
   YYihCQ0BikG8thL1cVGVXkTWMC9Z31SeQe4mRu4vyXxzP2N2/eqVoQsYq
   CtXEha88AGJm2OM45GmxqQl6t7WvqZrr7diGzyfpJmwKZoElymgoepoDQ
   XPne53eQubZXE/hNIj3AmjRaT5ImVow2VnUXoM5GnzNwQJiCUCNuXLC5X
   AWHIl2yjEo+w1/V6pAseopwRqZDAGaBZGJTLs8Y5fcpv9m4fmzMf6TlSy
   Or3mX8xirM18i7HMQaB5j1jcwE0mJI+uJ0UfVo1NlVNufggqVDLwi4AgD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="239998171"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="239998171"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 06:47:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="472518827"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Jan 2022 06:47:44 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n57Zn-000Gl8-CT; Wed, 05 Jan 2022 14:47:43 +0000
Date:   Wed, 5 Jan 2022 22:46:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ronak Vijay Raheja <rraheja@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Jack Pham <jackp@codeaurora.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10-2022-01
 5703/9999] drivers/usb/gadget/configfs.c:1620:9: error: implicit declaration
 of function 'acc_disconnect'
Message-ID: <202201052253.4WGSj343-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ronak,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10-2022-01
head:   47874cc690dc05182eefd0688cc627ffca746b8f
commit: 80fef39de7e9dbe706d0cbc820a09b5c05dc366f [5703/9999] ANDROID: usb: gadget: Resolve NULL pointer dereference in composite_disconnect
config: arm-buildonly-randconfig-r002-20220105 (https://download.01.org/0day-ci/archive/20220105/202201052253.4WGSj343-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/80fef39de7e9dbe706d0cbc820a09b5c05dc366f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10-2022-01
        git checkout 80fef39de7e9dbe706d0cbc820a09b5c05dc366f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/usb/gadget/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/usb/gadget/configfs.c: In function 'configfs_composite_disconnect':
>> drivers/usb/gadget/configfs.c:1620:9: error: implicit declaration of function 'acc_disconnect' [-Werror=implicit-function-declaration]
    1620 |         acc_disconnect();
         |         ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for WIRELESS_EXT
   Depends on NET && WIRELESS
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for WEXT_CORE
   Depends on NET && WIRELESS && (CFG80211_WEXT || WIRELESS_EXT
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for DRM_TTM
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - GKI_HIDDEN_DRM_CONFIGS && HAS_IOMEM && DRM
   WARNING: unmet direct dependencies detected for WEXT_PROC
   Depends on NET && WIRELESS && PROC_FS && WEXT_CORE
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for WEXT_PRIV
   Depends on NET && WIRELESS
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for BALLOON_COMPACTION
   Depends on COMPACTION && MEMORY_BALLOON
   Selected by
   - GKI_HIDDEN_MM_CONFIGS
   WARNING: unmet direct dependencies detected for WEXT_SPY
   Depends on NET && WIRELESS
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG


vim +/acc_disconnect +1620 drivers/usb/gadget/configfs.c

  1603	
  1604	static void configfs_composite_disconnect(struct usb_gadget *gadget)
  1605	{
  1606		struct usb_composite_dev *cdev;
  1607		struct gadget_info *gi;
  1608		unsigned long flags;
  1609	
  1610		cdev = get_gadget_data(gadget);
  1611		if (!cdev)
  1612			return;
  1613	
  1614	#ifdef CONFIG_USB_CONFIGFS_F_ACC
  1615		/*
  1616		 * accessory HID support can be active while the
  1617		 * accessory function is not actually enabled,
  1618		 * so we need to inform it when we are disconnected.
  1619		 */
> 1620		acc_disconnect();
  1621	#endif
  1622		gi = container_of(cdev, struct gadget_info, cdev);
  1623		spin_lock_irqsave(&gi->spinlock, flags);
  1624		cdev = get_gadget_data(gadget);
  1625		if (!cdev || gi->unbind) {
  1626			spin_unlock_irqrestore(&gi->spinlock, flags);
  1627			return;
  1628		}
  1629	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

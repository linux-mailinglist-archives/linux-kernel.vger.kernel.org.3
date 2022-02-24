Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7124C2327
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 05:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiBXEzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 23:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiBXEzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 23:55:36 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528F32325DD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 20:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645678506; x=1677214506;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yhbBBoX5KRf7nvHy++kI613H5nQHm9mQmQgb/uFvFKU=;
  b=RjeMa2GeU1aAtnhZ5aWuQG7UO80TnwkxG4zuZXatP1nV/VstdAOBHlH1
   Z6On8vrx0ht0GsKvZBrLx0K94ILjIJ+aioM64b+VYuM+nI35figCj/qJ/
   pymb4PlzK8UceIx23/Sj567P4Jpif76H7xttCHjANqnX02rBmhQ1SBe2M
   tbwFlpP7DmF282inqMhrRr6LJtPiKfxytvOpFSLJPjDiWIjjKLf+YdLZX
   5BR7WRreE5/JXduUP6WfJfZdOLJW1r65hjE6J5FJfkfL00bwSEVGKHoI4
   Ycvxo9oCzKeLFYs2qrhIAlr/UZEZl7N+Hd9l+F22vVKycPpWGhcyGaDm7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="235658572"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="235658572"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 20:55:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="506184848"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Feb 2022 20:55:03 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN69e-0002HM-NP; Thu, 24 Feb 2022 04:55:02 +0000
Date:   Thu, 24 Feb 2022 12:54:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ronak Vijay Raheja <rraheja@codeaurora.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Jack Pham <jackp@codeaurora.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 1001/9999] drivers/usb/gadget/configfs.c:1620:9: error: implicit declaration
 of function 'acc_disconnect'
Message-ID: <202202241230.Gv0at8F7-lkp@intel.com>
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

Hi Ronak,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   2b5b0c26e9234f1d328d9fe3d2da998d996db1ec
commit: 80fef39de7e9dbe706d0cbc820a09b5c05dc366f [1001/9999] ANDROID: usb: gadget: Resolve NULL pointer dereference in composite_disconnect
config: nios2-randconfig-r032-20220224 (https://download.01.org/0day-ci/archive/20220224/202202241230.Gv0at8F7-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/80fef39de7e9dbe706d0cbc820a09b5c05dc366f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
        git checkout 80fef39de7e9dbe706d0cbc820a09b5c05dc366f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/usb/gadget/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/usb/gadget/configfs.c: In function 'configfs_composite_disconnect':
>> drivers/usb/gadget/configfs.c:1620:9: error: implicit declaration of function 'acc_disconnect' [-Werror=implicit-function-declaration]
    1620 |         acc_disconnect();
         |         ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ASYNC_TX_ENABLE_CHANNEL_SWITCH
   Depends on DMADEVICES
   Selected by
   - GKI_HIDDEN_DMA_CONFIGS


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

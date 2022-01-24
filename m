Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBB549851B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243879AbiAXQpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:45:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:11191 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243859AbiAXQo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643042699; x=1674578699;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aM9YJcSBXC3yFsRIAO+XebEgJNs0dEaVhB0zbDtZ3xQ=;
  b=UYPkqkG9u4/rqZiFgWvnZQm7XYcbIOvIXwX1kS6+dH9n6tZ0VDWf7AcB
   EdWDBJvl3R8O4D4gYEuLYnfx1Xedvqbxh8MJmBRRiiv0BfP/uQxmlP/dC
   +4Nqm/Bt/nq+8jCT6bPM6e5V44e3bXhmvGxGfa7a6oUQRgndo974lnW71
   m6sFEit+JnjeY6Ok3jNlXon9gV7fFRoMOwWYWP+Fmf+r+S0xB1yO51PwC
   LEOkTb383oEsGpEI8/uCYJp0KVWwbvhPIBpaO859fpNuW0CQVeOLbbwQ9
   c1bXSUMX7+bZUCg/QHLoUhehnT+lKy9YR/97/Hpmetkz0mwfndxPE7ho+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="270525828"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="270525828"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 08:44:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627562188"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 08:44:56 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC2Sd-000Icf-Q6; Mon, 24 Jan 2022 16:44:55 +0000
Date:   Tue, 25 Jan 2022 00:44:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ronak Vijay Raheja <rraheja@codeaurora.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Jack Pham <jackp@codeaurora.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 2301/9999] drivers/usb/gadget/configfs.c:1620:2: error: implicit declaration
 of function 'acc_disconnect'
Message-ID: <202201250013.vOmQcvaI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ronak,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   eb69f26fe8e2177cfb7cbf859a23fc5ac59cacb7
commit: 80fef39de7e9dbe706d0cbc820a09b5c05dc366f [2301/9999] ANDROID: usb: gadget: Resolve NULL pointer dereference in composite_disconnect
config: arm64-randconfig-r021-20220120 (https://download.01.org/0day-ci/archive/20220125/202201250013.vOmQcvaI-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/80fef39de7e9dbe706d0cbc820a09b5c05dc366f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
        git checkout 80fef39de7e9dbe706d0cbc820a09b5c05dc366f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/usb/gadget/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/usb/gadget/configfs.c:1620:2: error: implicit declaration of function 'acc_disconnect' [-Werror,-Wimplicit-function-declaration]
           acc_disconnect();
           ^
   1 error generated.


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

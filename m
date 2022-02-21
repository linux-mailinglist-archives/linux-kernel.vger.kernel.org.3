Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DC34BE233
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358861AbiBUNTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:19:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbiBUNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:19:40 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515BA1EEDA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645449557; x=1676985557;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I79uwjS1z7JWGQEvjvtR53Cl64d3hoSo4uV5m4nZh5k=;
  b=YxkcLNMPBlxctV9ZJrmKxUUszcNdTUcGrpoce3BS9Q8n2Ac9iWZfLMNe
   zEdOapvmpGQZMN+9TAyz3iGR2YX7C8fgxaHHv1pCsN4A9Dn7SWB68VbuM
   Af40rCBbfBBrt5SGauzlYUARhA+/9biN4cQflSt3BC2V1Qte37cZEkm6E
   ipF0HNNL+alOlQlUDBicdJnUrsD04SOW+XT+4P8jEZQRv7MuATW09ADMG
   UayeyMI47xdljFQRnjnDYz/iXwTb4296FRzX+lCz2YK4/EypEYs41/FKA
   EY9mphcQNbszpiSZ6VXHTgGPJDM9yH3ce3senYh/zTKgndvKOvrMg5V+8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="276098869"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="276098869"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 05:19:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="683203057"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2022 05:19:16 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM8ax-0001dj-Ah; Mon, 21 Feb 2022 13:19:15 +0000
Date:   Mon, 21 Feb 2022 21:18:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/090-spi-hid 11/11]
 drivers/hid/spi-hid/spi-hid-apple-core.c:259:22: warning: no previous
 prototype for 'spihid_get_data'
Message-ID: <202202212138.tQW6fcMZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   6503ad96bc85209be90119188ff30d21612bbbf8
commit: 6503ad96bc85209be90119188ff30d21612bbbf8 [11/11] WIP: HID: transport: spi: add Apple SPI transport
config: csky-allyesconfig (https://download.01.org/0day-ci/archive/20220221/202202212138.tQW6fcMZ-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/6503ad96bc85209be90119188ff30d21612bbbf8
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout 6503ad96bc85209be90119188ff30d21612bbbf8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash drivers/hid/spi-hid/ drivers/platform/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hid/spi-hid/spi-hid-apple-core.c:259:22: warning: no previous prototype for 'spihid_get_data' [-Wmissing-prototypes]
     259 | struct spihid_apple *spihid_get_data(struct spihid_interface *idev)
         |                      ^~~~~~~~~~~~~~~
--
>> drivers/hid/spi-hid/spi-hid-apple-of.c:24:5: warning: no previous prototype for 'spihid_apple_of_power_on' [-Wmissing-prototypes]
      24 | int spihid_apple_of_power_on(struct spihid_apple_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hid/spi-hid/spi-hid-apple-of.c:40:5: warning: no previous prototype for 'spihid_apple_of_power_off' [-Wmissing-prototypes]
      40 | int spihid_apple_of_power_off(struct spihid_apple_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hid/spi-hid/spi-hid-apple-of.c:50:5: warning: no previous prototype for 'spihid_apple_of_enable_irq' [-Wmissing-prototypes]
      50 | int spihid_apple_of_enable_irq(struct spihid_apple_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hid/spi-hid/spi-hid-apple-of.c:59:5: warning: no previous prototype for 'spihid_apple_of_disable_irq' [-Wmissing-prototypes]
      59 | int spihid_apple_of_disable_irq(struct spihid_apple_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/spihid_get_data +259 drivers/hid/spi-hid/spi-hid-apple-core.c

   258	
 > 259	struct spihid_apple *spihid_get_data(struct spihid_interface *idev)
   260	{
   261		switch (idev->id) {
   262		case SPIHID_DEVICE_ID_KBD:
   263			return container_of(idev, struct spihid_apple, kbd);
   264		case SPIHID_DEVICE_ID_TP:
   265			return container_of(idev, struct spihid_apple, tp);
   266		default:
   267			return NULL;
   268		}
   269	}
   270	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

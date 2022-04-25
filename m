Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B9A50EBF1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbiDYW1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343692AbiDYWNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:13:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC1515FF8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650924637; x=1682460637;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E5/ldu6UrbcdaF8SLoOV8zocI5w41Xum+8+2cvuW2gk=;
  b=iysh/ndVYO25ZdT/VIXLMoQfOy2dp1btK35xl2wL7AUUPyXJwRQQK9TZ
   JGncSaavwqiFhqHHhlxgtCvtqDln/O0Fl1D2Ht8u0BvkdbndTVX7cHpDE
   r0mG14dEuhuE8++oJmwLVZBPjfIOkhkPqzsNl0aMGCaPk/RiSsgMOieYe
   CKpHsbQOSItC5ZQF0/5lbE6oZ+5/v4QXra0LqZmVUPKA7YSakvtv4P/bp
   H3WWJ99vOdYu/7POylFQHX4nn33bWTVwImsbi1ZofYCw3TVv9vQ7BiH3y
   84Ns8xR/PQe1W0X5aBsDKhLZH3TcJy/axfM6O8YBFI8tojBQzKAgQ9We0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="290516792"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="290516792"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 15:10:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="649885598"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Apr 2022 15:10:35 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nj6ug-0002vU-M1;
        Mon, 25 Apr 2022 22:10:34 +0000
Date:   Tue, 26 Apr 2022 06:09:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:pr/22 74/189]
 drivers/hid/spi-hid/spi-hid-apple-core.c:259:22: warning: no previous
 prototype for 'spihid_get_data'
Message-ID: <202204260603.NDqCgsMa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux pr/22
head:   7ee315306d1a3b0da8cf2a53e7f55889d0e7f034
commit: e1c721ad4fcedb51a74c3833f5ede7ae10e42e0f [74/189] WIP: HID: transport: spi: add Apple SPI transport
config: arm64-randconfig-r012-20220425 (https://download.01.org/0day-ci/archive/20220426/202204260603.NDqCgsMa-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/e1c721ad4fcedb51a74c3833f5ede7ae10e42e0f
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux pr/22
        git checkout e1c721ad4fcedb51a74c3833f5ede7ae10e42e0f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

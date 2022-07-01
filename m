Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E59B562EF6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiGAIwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbiGAIvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:51:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D8712A86
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656665436; x=1688201436;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OV5Yn5ppH27zc0dzk6AOKlbT4smjcFxlDqdU5nFht38=;
  b=ZdA2fkLLw91JuBbwiejxYRND9fQkfqC1pok95GsBncEgYYrEzlBwRg1n
   XHFiGcFrMsUi9+Oh8lYVMV7DzrKIgzYIA6HDQD4kqP4kYUx5+GPFch1lK
   Mv5YYVkQlkgiceQtJYDmZ5qeDksyAMi0xg/XgaSOYTMb7fePpq2mbrX7t
   NqCvB1rTKyUUiEjYK/ToUVlyC5e8mRUnon1kEgB3RHQELf83RU/hEus4J
   rUlKKOusaES7N6K/FAWHNQ01TqatUkO3NcSEpUJUg+MNbxtG27fVxB4Z4
   xVx6tLl8o67r2/p/D8Ce8dAcorKsiO2IzRmLez9AUc2zia3Ph0VnScWoy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="262998160"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="262998160"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 01:50:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="659357672"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 01 Jul 2022 01:50:34 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7CME-000DlA-40;
        Fri, 01 Jul 2022 08:50:34 +0000
Date:   Fri, 1 Jul 2022 16:49:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [char-misc:char-misc-linus 3/3]
 drivers/misc/cardreader/rtsx_usb.c:639:6: warning: variable 'ret' is used
 uninitialized whenever 'if' condition is true
Message-ID: <202207011658.rHJFVLWA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-linus
head:   3776c78559853fd151be7c41e369fd076fb679d5
commit: 3776c78559853fd151be7c41e369fd076fb679d5 [3/3] misc: rtsx_usb: use separate command and response buffers
config: arm-buildonly-randconfig-r006-20220629 (https://download.01.org/0day-ci/archive/20220701/202207011658.rHJFVLWA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a9119143a2d1f4d0d0bc1fe0d819e5351b4e0deb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?id=3776c78559853fd151be7c41e369fd076fb679d5
        git remote add char-misc https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
        git fetch --no-tags char-misc char-misc-linus
        git checkout 3776c78559853fd151be7c41e369fd076fb679d5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/misc/cardreader/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/cardreader/rtsx_usb.c:639:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!ucr->rsp_buf)
               ^~~~~~~~~~~~~
   drivers/misc/cardreader/rtsx_usb.c:678:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/misc/cardreader/rtsx_usb.c:639:2: note: remove the 'if' if its condition is always false
           if (!ucr->rsp_buf)
           ^~~~~~~~~~~~~~~~~~
   drivers/misc/cardreader/rtsx_usb.c:622:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +639 drivers/misc/cardreader/rtsx_usb.c

   616	
   617	static int rtsx_usb_probe(struct usb_interface *intf,
   618				 const struct usb_device_id *id)
   619	{
   620		struct usb_device *usb_dev = interface_to_usbdev(intf);
   621		struct rtsx_ucr *ucr;
   622		int ret;
   623	
   624		dev_dbg(&intf->dev,
   625			": Realtek USB Card Reader found at bus %03d address %03d\n",
   626			 usb_dev->bus->busnum, usb_dev->devnum);
   627	
   628		ucr = devm_kzalloc(&intf->dev, sizeof(*ucr), GFP_KERNEL);
   629		if (!ucr)
   630			return -ENOMEM;
   631	
   632		ucr->pusb_dev = usb_dev;
   633	
   634		ucr->cmd_buf = kmalloc(IOBUF_SIZE, GFP_KERNEL);
   635		if (!ucr->cmd_buf)
   636			return -ENOMEM;
   637	
   638		ucr->rsp_buf = kmalloc(IOBUF_SIZE, GFP_KERNEL);
 > 639		if (!ucr->rsp_buf)
   640			goto out_free_cmd_buf;
   641	
   642		usb_set_intfdata(intf, ucr);
   643	
   644		ucr->vendor_id = id->idVendor;
   645		ucr->product_id = id->idProduct;
   646	
   647		mutex_init(&ucr->dev_mutex);
   648	
   649		ucr->pusb_intf = intf;
   650	
   651		/* initialize */
   652		ret = rtsx_usb_init_chip(ucr);
   653		if (ret)
   654			goto out_init_fail;
   655	
   656		/* initialize USB SG transfer timer */
   657		timer_setup(&ucr->sg_timer, rtsx_usb_sg_timed_out, 0);
   658	
   659		ret = mfd_add_hotplug_devices(&intf->dev, rtsx_usb_cells,
   660					      ARRAY_SIZE(rtsx_usb_cells));
   661		if (ret)
   662			goto out_init_fail;
   663	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EE458B6DA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiHFQdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbiHFQdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:33:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE853FD22
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659803584; x=1691339584;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nDDFgsQSuZ6QBnUHbXm4VzzkeRn1Fpt+27ObtEcY8jk=;
  b=V53AzZz+GF8isVmSae+983vzQua8u08dKJ09bomBZx4VuvDOpDbBK38q
   7z05K11mybb75LWR4RmP9BDOtSSo5Nvl32XiZcSQWoYaE+Wb2ux/eHvFF
   yBR55uLy+QQNzJv+j35z+q3BOMZm8kl8TAbFNXPWDskJIr1v3koqkRyE7
   eSfx11WRLzjs7p0eFvaFiXGCKcZJGMrgCKdGvXlOcNsES2htEwZTrs9NA
   81rvo2ihOYrzE/RfiJWpo+iF/DFTi6eMTBcqtjRGXrQq8pFv7R8NBgzVP
   YyzQO3exe1ivngaQlax+OJ0y8So3Lu9cYN6uBusf8Y+o2XrvNt0N879Lo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="270152568"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="270152568"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 09:33:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="693309149"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Aug 2022 09:33:03 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKMjW-000KWZ-2c;
        Sat, 06 Aug 2022 16:33:02 +0000
Date:   Sun, 7 Aug 2022 00:32:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/090-spi-hid 17/21]
 drivers/hid/dockchannel-hid/dockchannel-hid.c:569:37: warning: format '%ld'
 expects argument of type 'long int', but argument 3 has type 'size_t' {aka
 'unsigned int'}
Message-ID: <202208070010.KglsBSww-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   740efddf69b264d6439f9cf124d36acab812dd39
commit: 55af457be82d0853857bab148c649a328aa58ffa [17/21] hid: Add Apple DockChannel HID transport driver
config: parisc64-allyesconfig (https://download.01.org/0day-ci/archive/20220807/202208070010.KglsBSww-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/55af457be82d0853857bab148c649a328aa58ffa
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout 55af457be82d0853857bab148c649a328aa58ffa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/hid/dockchannel-hid/ drivers/net/ethernet/aquantia/atlantic/ sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dchid_cmd':
   drivers/hid/dockchannel-hid/dockchannel-hid.c:303:28: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     303 |         iface->out_flags = FIELD_PREP(FLAGS_GROUP, type) | FIELD_PREP(FLAGS_REQ, req);
         |                            ^~~~~~~~~~
   In file included from include/linux/device.h:15,
                    from drivers/hid/dockchannel-hid/dockchannel-hid.c:10:
   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dchid_handle_ready':
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:569:37: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     569 |                 dev_err(dchid->dev, "Bad length for ready message: %ld\n", length);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:569:17: note: in expansion of macro 'dev_err'
     569 |                 dev_err(dchid->dev, "Bad length for ready message: %ld\n", length);
         |                 ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:569:70: note: format string is defined here
     569 |                 dev_err(dchid->dev, "Bad length for ready message: %ld\n", length);
         |                                                                    ~~^
         |                                                                      |
         |                                                                      long int
         |                                                                    %d
   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dchid_packet_work':
   drivers/hid/dockchannel-hid/dockchannel-hid.c:825:20: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     825 |         int type = FIELD_GET(FLAGS_GROUP, shdr->flags);
         |                    ^~~~~~~~~
         |                    FOLL_GET
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:829:37: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'unsigned int' [-Wformat=]
     829 |                 dev_err(dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:829:17: note: in expansion of macro 'dev_err'
     829 |                 dev_err(dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                 ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:829:68: note: format string is defined here
     829 |                 dev_err(dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                                                                  ~~^
         |                                                                    |
         |                                                                    long int
         |                                                                  %d
   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dchid_handle_ack':
   drivers/hid/dockchannel-hid/dockchannel-hid.c:855:44: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'unsigned int' [-Wformat=]
     855 |                 dev_err(iface->dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:855:17: note: in expansion of macro 'dev_err'
     855 |                 dev_err(iface->dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                 ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:855:75: note: format string is defined here
     855 |                 dev_err(iface->dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                                                                         ~~^
         |                                                                           |
         |                                                                           long int
         |                                                                         %d
   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dockchannel_hid_probe':
   drivers/hid/dockchannel-hid/dockchannel-hid.c:975:14: warning: variable 'defer' set but not used [-Wunused-but-set-variable]
     975 |         bool defer = false;
         |              ^~~~~
   cc1: some warnings being treated as errors


vim +569 drivers/hid/dockchannel-hid/dockchannel-hid.c

   558	
   559	static void dchid_handle_ready(struct dockchannel_hid *dchid, void *data, size_t length)
   560	{
   561		struct hid_device *hid;
   562		struct dchid_iface *iface;
   563		int ret;
   564		u8 *pkt = data;
   565		u8 index;
   566		int i;
   567	
   568		if (length < 2) {
 > 569			dev_err(dchid->dev, "Bad length for ready message: %ld\n", length);
   570			return;
   571		}
   572	
   573		index = pkt[1];
   574	
   575		if (index >= MAX_INTERFACES) {
   576			dev_err(dchid->dev, "Got ready notification for bad iface %d\n", index);
   577			return;
   578		}
   579	
   580		iface = dchid->ifaces[index];
   581		if (!iface) {
   582			dev_err(dchid->dev, "Got ready notification for unknown iface %d\n", index);
   583			return;
   584		}
   585	
   586		if (iface->hid) {
   587			dev_warn(iface->dchid->dev, "Interface %s already ready!\n",
   588				 iface->name);
   589			return;
   590		}
   591	
   592		/* When STM is ready, grab global device info */
   593		if (!strcmp(iface->name, "stm")) {
   594			ret = dchid_get_report_cmd(iface, STM_REPORT_ID, &dchid->device_id,
   595						   sizeof(dchid->device_id));
   596			if (ret < sizeof(dchid->device_id)) {
   597				dev_warn(iface->dchid->dev, "Failed to get device ID from STM!\n");
   598				/* Fake it and keep going. Things might still work... */
   599				memset(&dchid->device_id, 0, sizeof(dchid->device_id));
   600				dchid->device_id.vendor_id = HOST_VENDOR_ID_APPLE;
   601			}
   602			ret = dchid_get_report_cmd(iface, STM_REPORT_SERIAL, dchid->serial,
   603						   sizeof(dchid->serial) - 1);
   604			if (ret < 0) {
   605				dev_warn(iface->dchid->dev, "Failed to get serial from STM!\n");
   606				dchid->serial[0] = 0;
   607			}
   608	
   609			dchid->id_ready = true;
   610			for (i = 0; i < MAX_INTERFACES; i++)
   611				if (dchid->ifaces[i] && dchid->ifaces[i]->deferred)
   612					dchid_init_interface(dchid->ifaces[i]);
   613	
   614		}
   615	
   616		hid = hid_allocate_device();
   617		if (IS_ERR(hid))
   618			return;
   619	
   620		snprintf(hid->name, sizeof(hid->name), "Apple MTP %s", iface->name);
   621		snprintf(hid->phys, sizeof(hid->phys), "%s.%d (%s)",
   622			 dev_name(iface->dchid->dev), iface->index, iface->name);
   623		strscpy(hid->uniq, dchid->serial, sizeof(hid->uniq));
   624	
   625		hid->ll_driver = &dchid_ll;
   626		hid->bus = BUS_HOST;
   627		hid->vendor = dchid->device_id.vendor_id;
   628		hid->product = dchid->device_id.product_id;
   629		hid->version = dchid->device_id.version_number;
   630		hid->type = HID_TYPE_OTHER;
   631		if (!strcmp(iface->name, "multi-touch")) {
   632			hid->type = HID_TYPE_SPI_MOUSE;
   633		} else if (!strcmp(iface->name, "keyboard")) {
   634			hid->type = HID_TYPE_SPI_KEYBOARD;
   635	
   636			/* These country codes match what earlier Apple HID keyboards did */
   637			switch (dchid->device_id.keyboard_type) {
   638			case KEYBOARD_TYPE_ANSI:
   639				hid->country = 33; // US-English
   640				break;
   641	
   642			case KEYBOARD_TYPE_ISO:
   643				hid->country = 13; // ISO
   644				break;
   645	
   646			case KEYBOARD_TYPE_JIS:
   647				hid->country = 15; // Japan
   648				break;
   649			}
   650		}
   651	
   652		hid->dev.parent = iface->dchid->dev;
   653		hid->driver_data = iface;
   654	
   655		ret = hid_add_device(hid);
   656		if (ret < 0) {
   657			hid_destroy_device(hid);
   658			dev_warn(iface->dchid->dev, "Failed to register hid device %s", iface->name);
   659			return;
   660		}
   661	
   662		iface->hid = hid;
   663	}
   664	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

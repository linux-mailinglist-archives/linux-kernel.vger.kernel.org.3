Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5184349F13D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345530AbiA1Cry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:47:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:7805 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345463AbiA1Crx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643338073; x=1674874073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YtX0JdWggJb1I5bOI7l6NBvJz4MZCW05GklK9HFoiRg=;
  b=FJpLGdzr/T5XsZc+TumeQANMMooJTzqZkFG+aKwry4rELyMOAcuMYvxR
   Dh/WAT3E8Fa/ldb0icSAiZlLRJiZVIG2I+L0/PM/lROGusSdbELhJ2svk
   AjawwfC/745vEZrVabhpfLRmFkoqjJyY924N+1J9lJ3pmPkef3WHQa0VJ
   aHMrE7BvqFfycPKqLGB7WYAdy2PfujJcS/O13KfXDCbTd433UluCf9Y1U
   ZIloBXDSJRyLr8XUQnHbBINKNaW0dGTPOTtLeJxya7E7DZr6STGmUqux6
   cqGI5goM22pYYxbH0UOqPHXQMPXDQeDhB4ifyf3TlfwC8fvSFZZed0bYs
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="310341117"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="310341117"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 18:47:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="564036176"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2022 18:47:50 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDHIj-000NLI-OG; Fri, 28 Jan 2022 02:47:49 +0000
Date:   Fri, 28 Jan 2022 10:47:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     kbuild-all@lists.01.org, tomm.merciai@gmail.com,
        linuxfancy@googlegroups.com,
        Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: usb251xb: add boost-up property support
Message-ID: <202201281048.hNLcZLlz-lkp@intel.com>
References: <20220127231437.10893-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127231437.10893-1-tomm.merciai@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on v5.17-rc1 next-20220127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Tommaso-Merciai/usb-usb251xb-add-boost-up-property-support/20220128-071607
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220128/202201281048.hNLcZLlz-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/3a9e1d961fe56a5b7498208623910e72837b849e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Tommaso-Merciai/usb-usb251xb-add-boost-up-property-support/20220128-071607
        git checkout 3a9e1d961fe56a5b7498208623910e72837b849e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/usb/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/usb/misc/usb251xb.c: In function 'usb251xb_get_ofdata':
>> drivers/usb/misc/usb251xb.c:546:53: error: expected ';' before ')' token
     546 |  of_property_read_u8(np, "boost-up", &hub->boost_up))
         |                                                     ^
         |                                                     ;
>> drivers/usb/misc/usb251xb.c:546:53: error: expected statement before ')' token


vim +546 drivers/usb/misc/usb251xb.c

   397	
   398	static int usb251xb_get_ofdata(struct usb251xb *hub,
   399				       const struct usb251xb_data *data)
   400	{
   401		struct device *dev = hub->dev;
   402		struct device_node *np = dev->of_node;
   403		int len, err;
   404		u32 property_u32 = 0;
   405		const char *cproperty_char;
   406		char str[USB251XB_STRING_BUFSIZE / 2];
   407	
   408		if (!np) {
   409			dev_err(dev, "failed to get ofdata\n");
   410			return -ENODEV;
   411		}
   412	
   413		if (of_get_property(np, "skip-config", NULL))
   414			hub->skip_config = 1;
   415		else
   416			hub->skip_config = 0;
   417	
   418		hub->gpio_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
   419		if (PTR_ERR(hub->gpio_reset) == -EPROBE_DEFER) {
   420			return -EPROBE_DEFER;
   421		} else if (IS_ERR(hub->gpio_reset)) {
   422			err = PTR_ERR(hub->gpio_reset);
   423			dev_err(dev, "unable to request GPIO reset pin (%d)\n", err);
   424			return err;
   425		}
   426	
   427		if (of_property_read_u16_array(np, "vendor-id", &hub->vendor_id, 1))
   428			hub->vendor_id = USB251XB_DEF_VENDOR_ID;
   429	
   430		if (of_property_read_u16_array(np, "product-id",
   431					       &hub->product_id, 1))
   432			hub->product_id = data->product_id;
   433	
   434		if (of_property_read_u16_array(np, "device-id", &hub->device_id, 1))
   435			hub->device_id = USB251XB_DEF_DEVICE_ID;
   436	
   437		hub->conf_data1 = USB251XB_DEF_CONFIG_DATA_1;
   438		if (of_get_property(np, "self-powered", NULL)) {
   439			hub->conf_data1 |= BIT(7);
   440	
   441			/* Configure Over-Current sens when self-powered */
   442			hub->conf_data1 &= ~BIT(2);
   443			if (of_get_property(np, "ganged-sensing", NULL))
   444				hub->conf_data1 &= ~BIT(1);
   445			else if (of_get_property(np, "individual-sensing", NULL))
   446				hub->conf_data1 |= BIT(1);
   447		} else if (of_get_property(np, "bus-powered", NULL)) {
   448			hub->conf_data1 &= ~BIT(7);
   449	
   450			/* Disable Over-Current sense when bus-powered */
   451			hub->conf_data1 |= BIT(2);
   452		}
   453	
   454		if (of_get_property(np, "disable-hi-speed", NULL))
   455			hub->conf_data1 |= BIT(5);
   456	
   457		if (of_get_property(np, "multi-tt", NULL))
   458			hub->conf_data1 |= BIT(4);
   459		else if (of_get_property(np, "single-tt", NULL))
   460			hub->conf_data1 &= ~BIT(4);
   461	
   462		if (of_get_property(np, "disable-eop", NULL))
   463			hub->conf_data1 |= BIT(3);
   464	
   465		if (of_get_property(np, "individual-port-switching", NULL))
   466			hub->conf_data1 |= BIT(0);
   467		else if (of_get_property(np, "ganged-port-switching", NULL))
   468			hub->conf_data1 &= ~BIT(0);
   469	
   470		hub->conf_data2 = USB251XB_DEF_CONFIG_DATA_2;
   471		if (of_get_property(np, "dynamic-power-switching", NULL))
   472			hub->conf_data2 |= BIT(7);
   473	
   474		if (!of_property_read_u32(np, "oc-delay-us", &property_u32)) {
   475			if (property_u32 == 100) {
   476				/* 100 us*/
   477				hub->conf_data2 &= ~BIT(5);
   478				hub->conf_data2 &= ~BIT(4);
   479			} else if (property_u32 == 4000) {
   480				/* 4 ms */
   481				hub->conf_data2 &= ~BIT(5);
   482				hub->conf_data2 |= BIT(4);
   483			} else if (property_u32 == 16000) {
   484				/* 16 ms */
   485				hub->conf_data2 |= BIT(5);
   486				hub->conf_data2 |= BIT(4);
   487			} else {
   488				/* 8 ms (DEFAULT) */
   489				hub->conf_data2 |= BIT(5);
   490				hub->conf_data2 &= ~BIT(4);
   491			}
   492		}
   493	
   494		if (of_get_property(np, "compound-device", NULL))
   495			hub->conf_data2 |= BIT(3);
   496	
   497		hub->conf_data3 = USB251XB_DEF_CONFIG_DATA_3;
   498		if (of_get_property(np, "port-mapping-mode", NULL))
   499			hub->conf_data3 |= BIT(3);
   500	
   501		if (data->led_support && of_get_property(np, "led-usb-mode", NULL))
   502			hub->conf_data3 &= ~BIT(1);
   503	
   504		if (of_get_property(np, "string-support", NULL))
   505			hub->conf_data3 |= BIT(0);
   506	
   507		hub->non_rem_dev = USB251XB_DEF_NON_REMOVABLE_DEVICES;
   508		usb251xb_get_ports_field(hub, "non-removable-ports", data->port_cnt,
   509					 true, &hub->non_rem_dev);
   510	
   511		hub->port_disable_sp = USB251XB_DEF_PORT_DISABLE_SELF;
   512		usb251xb_get_ports_field(hub, "sp-disabled-ports", data->port_cnt,
   513					 true, &hub->port_disable_sp);
   514	
   515		hub->port_disable_bp = USB251XB_DEF_PORT_DISABLE_BUS;
   516		usb251xb_get_ports_field(hub, "bp-disabled-ports", data->port_cnt,
   517					 true, &hub->port_disable_bp);
   518	
   519		hub->max_power_sp = USB251XB_DEF_MAX_POWER_SELF;
   520		if (!of_property_read_u32(np, "sp-max-total-current-microamp",
   521		    &property_u32))
   522			hub->max_power_sp = min_t(u8, property_u32 / 2000, 50);
   523	
   524		hub->max_power_bp = USB251XB_DEF_MAX_POWER_BUS;
   525		if (!of_property_read_u32(np, "bp-max-total-current-microamp",
   526		    &property_u32))
   527			hub->max_power_bp = min_t(u8, property_u32 / 2000, 255);
   528	
   529		hub->max_current_sp = USB251XB_DEF_MAX_CURRENT_SELF;
   530		if (!of_property_read_u32(np, "sp-max-removable-current-microamp",
   531		    &property_u32))
   532			hub->max_current_sp = min_t(u8, property_u32 / 2000, 50);
   533	
   534		hub->max_current_bp = USB251XB_DEF_MAX_CURRENT_BUS;
   535		if (!of_property_read_u32(np, "bp-max-removable-current-microamp",
   536		    &property_u32))
   537			hub->max_current_bp = min_t(u8, property_u32 / 2000, 255);
   538	
   539		hub->power_on_time = USB251XB_DEF_POWER_ON_TIME;
   540		if (!of_property_read_u32(np, "power-on-time-ms", &property_u32))
   541			hub->power_on_time = min_t(u8, property_u32 / 2, 255);
   542	
   543		if (of_property_read_u16_array(np, "language-id", &hub->lang_id, 1))
   544			hub->lang_id = USB251XB_DEF_LANGUAGE_ID;
   545	
 > 546		of_property_read_u8(np, "boost-up", &hub->boost_up))
   547	
   548		cproperty_char = of_get_property(np, "manufacturer", NULL);
   549		strlcpy(str, cproperty_char ? : USB251XB_DEF_MANUFACTURER_STRING,
   550			sizeof(str));
   551		hub->manufacturer_len = strlen(str) & 0xFF;
   552		memset(hub->manufacturer, 0, USB251XB_STRING_BUFSIZE);
   553		len = min_t(size_t, USB251XB_STRING_BUFSIZE / 2, strlen(str));
   554		len = utf8s_to_utf16s(str, len, UTF16_LITTLE_ENDIAN,
   555				      (wchar_t *)hub->manufacturer,
   556				      USB251XB_STRING_BUFSIZE);
   557	
   558		cproperty_char = of_get_property(np, "product", NULL);
   559		strlcpy(str, cproperty_char ? : data->product_str, sizeof(str));
   560		hub->product_len = strlen(str) & 0xFF;
   561		memset(hub->product, 0, USB251XB_STRING_BUFSIZE);
   562		len = min_t(size_t, USB251XB_STRING_BUFSIZE / 2, strlen(str));
   563		len = utf8s_to_utf16s(str, len, UTF16_LITTLE_ENDIAN,
   564				      (wchar_t *)hub->product,
   565				      USB251XB_STRING_BUFSIZE);
   566	
   567		cproperty_char = of_get_property(np, "serial", NULL);
   568		strlcpy(str, cproperty_char ? : USB251XB_DEF_SERIAL_STRING,
   569			sizeof(str));
   570		hub->serial_len = strlen(str) & 0xFF;
   571		memset(hub->serial, 0, USB251XB_STRING_BUFSIZE);
   572		len = min_t(size_t, USB251XB_STRING_BUFSIZE / 2, strlen(str));
   573		len = utf8s_to_utf16s(str, len, UTF16_LITTLE_ENDIAN,
   574				      (wchar_t *)hub->serial,
   575				      USB251XB_STRING_BUFSIZE);
   576	
   577		/*
   578		 * The datasheet documents the register as 'Port Swap' but in real the
   579		 * register controls the USB DP/DM signal swapping for each port.
   580		 */
   581		hub->port_swap = USB251XB_DEF_PORT_SWAP;
   582		usb251xb_get_ports_field(hub, "swap-dx-lanes", data->port_cnt,
   583					 false, &hub->port_swap);
   584	
   585		/* The following parameters are currently not exposed to devicetree, but
   586		 * may be as soon as needed.
   587		 */
   588		hub->bat_charge_en = USB251XB_DEF_BATTERY_CHARGING_ENABLE;
   589		hub->boost_57 = USB251XB_DEF_BOOST_57;
   590		hub->boost_14 = USB251XB_DEF_BOOST_14;
   591		hub->port_map12 = USB251XB_DEF_PORT_MAP_12;
   592		hub->port_map34 = USB251XB_DEF_PORT_MAP_34;
   593		hub->port_map56 = USB251XB_DEF_PORT_MAP_56;
   594		hub->port_map7  = USB251XB_DEF_PORT_MAP_7;
   595	
   596		return 0;
   597	}
   598	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

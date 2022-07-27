Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3128958260C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiG0MD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiG0MDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:03:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AE44B0D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658923403; x=1690459403;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sHAEFwUNdqLL94P+x+Go4fSiTBbugqZ3K4sm5/rhvAg=;
  b=UUANL6YP4Zm+SlUcEocdvKPplZOwa0qokkYx7oj2QNtfY+cGXjygLwP1
   l6Ftp412cIn63yAu0m0OiUDznPJdUy2tKT43SmfZl6VdthCB8j6bIk2Gu
   Ub5e2JJU+EWBiBIrlapufC8C9RBIPm5MAkS5vCj3e2QqsAfq0NvC3L6kI
   GAKZLniMc4QNPF+ZC+V2PqWkWm1CqIRn5QTCS7UkCFIY5dZ982QYkoT9+
   QG+VkwlJvgb3Y3dTJHGD1qrNQzVg+rkF8+UtU5nNq83i3fr6MLjqWLqCg
   MWZX2FK+QjfZBurRZ5Bd+3TtBxigsPU347xhEoBwCnKMm/GxOlq5ATveb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="289409043"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="289409043"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 05:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="575956628"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Jul 2022 05:03:19 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGfl1-0008hE-0F;
        Wed, 27 Jul 2022 12:03:19 +0000
Date:   Wed, 27 Jul 2022 20:02:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hyeonki Hong <hhk7734@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>
Subject: [tobetter:odroid-5.19.y 53/99]
 drivers/input/touchscreen/dwav-usb-mt.c:40:35: sparse: sparse: symbol
 'DEV_INFO' was not declared. Should it be static?
Message-ID: <202207272044.tiVNkrQP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/tobetter/linux odroid-5.19.y
head:   c7c464300e75e7dc0e654a0550f885685d92a092
commit: 43b2780642d8ec14d8375ab9f5a3761d151ea5c6 [53/99] ODROID-COMMON: input/touchscreen: Add D-WAV Multitouch driver.
config: sparc-randconfig-s043-20220727 (https://download.01.org/0day-ci/archive/20220727/202207272044.tiVNkrQP-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/tobetter/linux/commit/43b2780642d8ec14d8375ab9f5a3761d151ea5c6
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.19.y
        git checkout 43b2780642d8ec14d8375ab9f5a3761d151ea5c6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash drivers/input/touchscreen/ drivers/pwm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/input/touchscreen/dwav-usb-mt.c:176:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int x @@     got restricted __be16 [usertype] @@
   drivers/input/touchscreen/dwav-usb-mt.c:176:41: sparse:     expected unsigned int x
   drivers/input/touchscreen/dwav-usb-mt.c:176:41: sparse:     got restricted __be16 [usertype]
>> drivers/input/touchscreen/dwav-usb-mt.c:178:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int y @@     got restricted __be16 [usertype] @@
   drivers/input/touchscreen/dwav-usb-mt.c:178:41: sparse:     expected unsigned int y
   drivers/input/touchscreen/dwav-usb-mt.c:178:41: sparse:     got restricted __be16 [usertype]
   drivers/input/touchscreen/dwav-usb-mt.c:182:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int x @@     got restricted __be16 [usertype] @@
   drivers/input/touchscreen/dwav-usb-mt.c:182:41: sparse:     expected unsigned int x
   drivers/input/touchscreen/dwav-usb-mt.c:182:41: sparse:     got restricted __be16 [usertype]
   drivers/input/touchscreen/dwav-usb-mt.c:184:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int y @@     got restricted __be16 [usertype] @@
   drivers/input/touchscreen/dwav-usb-mt.c:184:41: sparse:     expected unsigned int y
   drivers/input/touchscreen/dwav-usb-mt.c:184:41: sparse:     got restricted __be16 [usertype]
   drivers/input/touchscreen/dwav-usb-mt.c:188:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int x @@     got restricted __be16 [usertype] @@
   drivers/input/touchscreen/dwav-usb-mt.c:188:41: sparse:     expected unsigned int x
   drivers/input/touchscreen/dwav-usb-mt.c:188:41: sparse:     got restricted __be16 [usertype]
   drivers/input/touchscreen/dwav-usb-mt.c:190:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int y @@     got restricted __be16 [usertype] @@
   drivers/input/touchscreen/dwav-usb-mt.c:190:41: sparse:     expected unsigned int y
   drivers/input/touchscreen/dwav-usb-mt.c:190:41: sparse:     got restricted __be16 [usertype]
   drivers/input/touchscreen/dwav-usb-mt.c:194:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int x @@     got restricted __be16 [usertype] @@
   drivers/input/touchscreen/dwav-usb-mt.c:194:41: sparse:     expected unsigned int x
   drivers/input/touchscreen/dwav-usb-mt.c:194:41: sparse:     got restricted __be16 [usertype]
   drivers/input/touchscreen/dwav-usb-mt.c:196:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int y @@     got restricted __be16 [usertype] @@
   drivers/input/touchscreen/dwav-usb-mt.c:196:41: sparse:     expected unsigned int y
   drivers/input/touchscreen/dwav-usb-mt.c:196:41: sparse:     got restricted __be16 [usertype]
   drivers/input/touchscreen/dwav-usb-mt.c:200:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int x @@     got restricted __be16 [usertype] @@
   drivers/input/touchscreen/dwav-usb-mt.c:200:41: sparse:     expected unsigned int x
   drivers/input/touchscreen/dwav-usb-mt.c:200:41: sparse:     got restricted __be16 [usertype]
   drivers/input/touchscreen/dwav-usb-mt.c:202:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int y @@     got restricted __be16 [usertype] @@
   drivers/input/touchscreen/dwav-usb-mt.c:202:41: sparse:     expected unsigned int y
   drivers/input/touchscreen/dwav-usb-mt.c:202:41: sparse:     got restricted __be16 [usertype]

vim +/DEV_INFO +40 drivers/input/touchscreen/dwav-usb-mt.c

    39	
  > 40	const struct usbtouch_device_info DEV_INFO[] = {
    41		[ODROID_VU7] = {
    42			.name = "ODROID VU7 MultiTouch(800x480)",
    43			.max_x = 800,
    44			.max_y = 480,
    45			.max_press = 255,
    46			.max_finger = 5,
    47		},
    48		[ODROID_VU5] = {
    49			.name = "ODROID VU5 MultiTouch(800x480)",
    50			.max_x = 800,
    51			.max_y = 480,
    52			.max_press = 255,
    53			.max_finger = 5,
    54		},
    55		[ODROID_VU7PLUS] = {
    56			.name = "ODROID VU7 Plus MultiTouch(1024x600)",
    57			.max_x = 1024,
    58			.max_y = 600,
    59			.max_press = 255,
    60			.max_finger = 5,
    61		},
    62	};
    63	
    64	static const struct usb_device_id dwav_usb_mt_devices[] = {
    65		{USB_DEVICE(USB_VENDOR_ID_DWAV,   USB_DEVICE_ID_VU7),
    66			.driver_info = ODROID_VU7},
    67		{USB_DEVICE(USB_VENDOR_ID_ODROID, USB_DEVICE_ID_VU5),
    68			.driver_info = ODROID_VU5},
    69		{USB_DEVICE(USB_VENDOR_ID_ODROID, USB_DEVICE_ID_VU7PLUS),
    70			.driver_info = ODROID_VU7PLUS},
    71		{}
    72	};
    73	
    74	struct dwav_raw {                   /* Total 25 bytes */
    75		unsigned char   header;     /* frame header 0xAA*/
    76		unsigned char   press;
    77		/* Touch flag (1:valid touch data, 0:touch finished) */
    78		unsigned short  x1;         /* 1st x */
    79		unsigned short  y1;         /* 1st y */
    80		unsigned char   end;
    81		/* 1st touch finish flags 0xBB, RPI only uses the first 7 bytes */
    82		unsigned char   ids;        /* touch ID(bit field) */
    83		unsigned short  y2;
    84		unsigned short  x2;
    85		unsigned short  y3;
    86		unsigned short  x3;
    87		unsigned short  y4;
    88		unsigned short  x4;
    89		unsigned short  y5;
    90		unsigned short  x5;
    91		unsigned char   tail;       /* frame end 0xCC */
    92	};
    93	
    94	#define	TS_EVENT_UNKNOWN	0x00
    95	#define	TS_EVENT_PRESS		0x01
    96	#define	TS_EVENT_RELEASE	0x02
    97	
    98	struct	finger_t	{
    99		unsigned int	status;	/* ts event type */
   100		unsigned int	x;	/* ts data x */
   101		unsigned int	y;	/* ts data y */
   102	}	__packed;
   103	
   104	struct dwav_usb_mt  {
   105		char		name[128], phys[64];
   106	
   107		int		dev_id;
   108		/* for URB Data DMA */
   109		dma_addr_t	data_dma;
   110		unsigned char	*data;
   111		int		data_size;
   112	
   113		struct urb		*irq;
   114		struct usb_interface	*interface;
   115		struct input_dev	*input;
   116	
   117		struct finger_t		*finger;
   118	};
   119	
   120	static void dwav_usb_mt_report(struct dwav_usb_mt *dwav_usb_mt)
   121	{
   122		int	id, max_x, max_y, max_press, max_finger;
   123	
   124		max_x = DEV_INFO[dwav_usb_mt->dev_id].max_x;
   125		max_y = DEV_INFO[dwav_usb_mt->dev_id].max_y;
   126		max_press = DEV_INFO[dwav_usb_mt->dev_id].max_press;
   127		max_finger = DEV_INFO[dwav_usb_mt->dev_id].max_finger;
   128	
   129		for (id = 0; id < max_finger; id++)	{
   130	
   131			if (dwav_usb_mt->finger[id].status == TS_EVENT_UNKNOWN)
   132				continue;
   133	
   134			if (dwav_usb_mt->finger[id].x >= max_x ||
   135			    dwav_usb_mt->finger[id].y >= max_y)
   136				continue;
   137	
   138			input_mt_slot(dwav_usb_mt->input, id);
   139	
   140			if (dwav_usb_mt->finger[id].status != TS_EVENT_RELEASE) {
   141				input_mt_report_slot_state(dwav_usb_mt->input,
   142						MT_TOOL_FINGER, true);
   143				input_report_abs(dwav_usb_mt->input,
   144						ABS_MT_POSITION_X,
   145						dwav_usb_mt->finger[id].x);
   146				input_report_abs(dwav_usb_mt->input,
   147						ABS_MT_POSITION_Y,
   148						dwav_usb_mt->finger[id].y);
   149				input_report_abs(dwav_usb_mt->input,
   150						ABS_MT_PRESSURE,
   151						max_press);
   152			} else {
   153				input_mt_report_slot_state(dwav_usb_mt->input,
   154						MT_TOOL_FINGER, false);
   155				dwav_usb_mt->finger[id].status = TS_EVENT_UNKNOWN;
   156			}
   157			input_mt_report_pointer_emulation(dwav_usb_mt->input, true);
   158			input_sync(dwav_usb_mt->input);
   159		}
   160	}
   161	
   162	static void dwav_usb_mt_process(struct dwav_usb_mt *dwav_usb_mt,
   163			unsigned char *pkt, int len)
   164	{
   165		struct  dwav_raw *dwav_raw = (struct dwav_raw *)pkt;
   166		unsigned char bit_mask, cnt;
   167	
   168		for (cnt = 0, bit_mask = 0x01;
   169		     cnt < DEV_INFO[dwav_usb_mt->dev_id].max_finger;
   170		     cnt++, bit_mask <<= 1) {
   171			if ((dwav_raw->ids & bit_mask) && dwav_raw->press) {
   172				dwav_usb_mt->finger[cnt].status = TS_EVENT_PRESS;
   173				switch (cnt) {
   174				case	0:
   175					dwav_usb_mt->finger[cnt].x
 > 176						= cpu_to_be16(dwav_raw->x1);
   177					dwav_usb_mt->finger[cnt].y
 > 178						= cpu_to_be16(dwav_raw->y1);
   179					break;
   180				case	1:
   181					dwav_usb_mt->finger[cnt].x
   182						= cpu_to_be16(dwav_raw->x2);
   183					dwav_usb_mt->finger[cnt].y
   184						= cpu_to_be16(dwav_raw->y2);
   185					break;
   186				case	2:
   187					dwav_usb_mt->finger[cnt].x
   188						= cpu_to_be16(dwav_raw->x3);
   189					dwav_usb_mt->finger[cnt].y
   190						= cpu_to_be16(dwav_raw->y3);
   191					break;
   192				case	3:
   193					dwav_usb_mt->finger[cnt].x
   194						= cpu_to_be16(dwav_raw->x4);
   195					dwav_usb_mt->finger[cnt].y
   196						= cpu_to_be16(dwav_raw->y4);
   197					break;
   198				case	4:
   199					dwav_usb_mt->finger[cnt].x
   200						= cpu_to_be16(dwav_raw->x5);
   201					dwav_usb_mt->finger[cnt].y
   202						= cpu_to_be16(dwav_raw->y5);
   203					break;
   204				default:
   205					break;
   206				}
   207			} else {
   208				if (dwav_usb_mt->finger[cnt].status == TS_EVENT_PRESS)
   209					dwav_usb_mt->finger[cnt].status
   210						= TS_EVENT_RELEASE;
   211				else
   212					dwav_usb_mt->finger[cnt].status
   213						= TS_EVENT_UNKNOWN;
   214			}
   215		}
   216		dwav_usb_mt_report(dwav_usb_mt);
   217	}
   218	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

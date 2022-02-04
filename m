Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6A24A981F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349768AbiBDLCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:02:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:15386 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346009AbiBDLCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643972539; x=1675508539;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Wh2WOcgT3HJbG90dCX+tCwQaPBWYwZ+IbOo4EkM6IwA=;
  b=jSQ66YnjJ7uW/pOfqPYR4LIFp7nnb4kTs+xS8oebXpsgc2bvm6J6ZwVs
   zT1uPQEAODg1cm+NTabVFEiAN8o1hYZy0O5X2FTj1HErfbGNSb4aHXRc8
   gH6esgQI3IZL73MXTDpU2Xec+oAqbB15vowzrZwdvgIdzgAVT5BnQ+Vl1
   FDpnC/wnpxtEBFOZ+57r5sJH8C6tvwLfgGPW1X5NLCECKz6kqpGBWjas2
   xzwuFFl9lpUH7y79fHM6qoAgfqj+crkZiRdgZok2IsTyqZrpAz3zIfoB4
   6uXrhP5L2QYsrtyAZtwcjuc25qy+vXjexNYYQdPU9I1GlOrVIsWsM0wm4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="311651898"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="311651898"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 03:02:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="772067527"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Feb 2022 03:02:17 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFwM5-000XVE-4s; Fri, 04 Feb 2022 11:02:17 +0000
Date:   Fri, 4 Feb 2022 19:02:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/090-spi-hid 11/12]
 drivers/hid/hid-magicmouse.c:662:41: warning: format specifies type
 'unsigned short' but the argument has type 'int'
Message-ID: <202202041829.eLXWBfs9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   25070af6e6d0c750f307b019df19cc93a54b664c
commit: 193121bdba0a9e2be57fc6b4f1e53daf4164b1fa [11/12] HID: magicmouse: add support for Macbook trackpads
config: riscv-randconfig-r042-20220131 (https://download.01.org/0day-ci/archive/20220204/202202041829.eLXWBfs9-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a73e4ce6a59b01f0e37037761c1e6889d539d233)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/AsahiLinux/linux/commit/193121bdba0a9e2be57fc6b4f1e53daf4164b1fa
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout 193121bdba0a9e2be57fc6b4f1e53daf4164b1fa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hid/hid-magicmouse.c:662:41: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                   hid_dbg(hdev, "ev x:%04hx y:%04hx\n", le16_to_int(f->abs_x),
                                       ~~~~~             ^~~~~~~~~~~~~~~~~~~~~
                                       %04x
   include/linux/hid.h:1199:30: note: expanded from macro 'hid_dbg'
           dev_dbg(&(hid)->dev, fmt, ##__VA_ARGS__)
                                ~~~    ^~~~~~~~~~~
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                           ~~~    ^~~~~~~~~~~
   drivers/hid/hid-magicmouse.c:663:4: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                           le16_to_int(f->abs_y));
                           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/hid.h:1199:30: note: expanded from macro 'hid_dbg'
           dev_dbg(&(hid)->dev, fmt, ##__VA_ARGS__)
                                ~~~    ^~~~~~~~~~~
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                           ~~~    ^~~~~~~~~~~
   2 warnings generated.
--
   drivers/hid/hid-magicmouse.c:169: warning: Function parameter or member 'pos' not described in 'magicmouse_sc'
   drivers/hid/hid-magicmouse.c:169: warning: Function parameter or member 'hdev' not described in 'magicmouse_sc'
   drivers/hid/hid-magicmouse.c:169: warning: Function parameter or member 'work' not described in 'magicmouse_sc'
   drivers/hid/hid-magicmouse.c:169: warning: Function parameter or member 'battery_timer' not described in 'magicmouse_sc'
   drivers/hid/hid-magicmouse.c:169: warning: Function parameter or member 'input_ops' not described in 'magicmouse_sc'
>> drivers/hid/hid-magicmouse.c:592: warning: expecting prototype for struct trackpad. Prototype was for struct tp_header instead


vim +662 drivers/hid/hid-magicmouse.c

   571	
   572	/**
   573	 * struct trackpad report
   574	 *
   575	 * @report_id:		reportid
   576	 * @buttons:		HID Usage Buttons 3 1-bit reports
   577	 * @num_fingers:	the number of fingers being reported in @fingers
   578	 * @clicked:		same as @buttons
   579	 */
   580	struct tp_header {
   581		// HID mouse report
   582		u8 report_id;
   583		u8 buttons;
   584		u8 rel_x;
   585		u8 rel_y;
   586		u8 padding[4];
   587		// HID vendor part, up to 1751 bytes
   588		u8 unknown[22];
   589		u8 num_fingers;
   590		u8 clicked;
   591		u8 unknown3[14];
 > 592	};
   593	
   594	static inline int le16_to_int(__le16 x)
   595	{
   596		return (signed short)le16_to_cpu(x);
   597	}
   598	
   599	static void report_finger_data(struct input_dev *input, int slot,
   600				       const struct input_mt_pos *pos,
   601				       const struct tp_finger *f)
   602	{
   603		input_mt_slot(input, slot);
   604		input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
   605	
   606		input_report_abs(input, ABS_MT_TOUCH_MAJOR,
   607				 le16_to_int(f->touch_major) << 1);
   608		input_report_abs(input, ABS_MT_TOUCH_MINOR,
   609				 le16_to_int(f->touch_minor) << 1);
   610		input_report_abs(input, ABS_MT_WIDTH_MAJOR,
   611				 le16_to_int(f->tool_major) << 1);
   612		input_report_abs(input, ABS_MT_WIDTH_MINOR,
   613				 le16_to_int(f->tool_minor) << 1);
   614		input_report_abs(input, ABS_MT_ORIENTATION,
   615				 J314_TP_MAX_FINGER_ORIENTATION - le16_to_int(f->orientation));
   616		input_report_abs(input, ABS_MT_PRESSURE, le16_to_int(f->pressure));
   617		input_report_abs(input, ABS_MT_POSITION_X, pos->x);
   618		input_report_abs(input, ABS_MT_POSITION_Y, pos->y);
   619	}
   620	
   621	static int magicmouse_raw_event_spi(struct hid_device *hdev,
   622			struct hid_report *report, u8 *data, int size)
   623	{
   624		struct magicmouse_sc *msc = hid_get_drvdata(hdev);
   625		struct input_dev *input = msc->input;
   626		struct tp_header *tp_hdr;
   627		struct tp_finger *f;
   628		int i, n;
   629		u32 npoints;
   630		const size_t hdr_sz = sizeof(struct tp_header);
   631		const size_t touch_sz = sizeof(struct tp_finger);
   632		u8 map_contacs[MAX_CONTACTS];
   633	
   634		// hid_warn(hdev, "%s\n", __func__);
   635		// print_hex_dump_debug("appleft ev: ", DUMP_PREFIX_OFFSET, 16, 1, data,
   636		// 		     size, false);
   637	
   638		if (data[0] != TRACKPAD2_USB_REPORT_ID)
   639			return 0;
   640	
   641		/* Expect 46 bytes of prefix, and N * 30 bytes of touch data. */
   642		if (size < hdr_sz || ((size - hdr_sz) % touch_sz) != 0)
   643			return 0;
   644	
   645		tp_hdr = (struct tp_header *)data;
   646	
   647		npoints = (size - hdr_sz) / touch_sz;
   648		if (npoints < tp_hdr->num_fingers || npoints > MAX_CONTACTS) {
   649			hid_warn(hdev,
   650				 "unexpected number of touches (%u) for "
   651				 "report\n",
   652				 npoints);
   653			return 0;
   654		}
   655	
   656		n = 0;
   657		for (i = 0; i < tp_hdr->num_fingers; i++) {
   658			f = (struct tp_finger *)(data + hdr_sz + i * touch_sz);
   659			if (le16_to_int(f->touch_major) == 0)
   660				continue;
   661	
 > 662			hid_dbg(hdev, "ev x:%04hx y:%04hx\n", le16_to_int(f->abs_x),
   663				le16_to_int(f->abs_y));
   664			msc->pos[n].x = le16_to_int(f->abs_x);
   665			msc->pos[n].y = -le16_to_int(f->abs_y);
   666			map_contacs[n] = i;
   667			n++;
   668		}
   669	
   670		input_mt_assign_slots(input, msc->tracking_ids, msc->pos, n, 0);
   671	
   672		for (i = 0; i < n; i++) {
   673			int idx = map_contacs[i];
   674			f = (struct tp_finger *)(data + hdr_sz + idx * touch_sz);
   675			report_finger_data(input, msc->tracking_ids[i], &msc->pos[i], f);
   676		}
   677	
   678		input_mt_sync_frame(input);
   679		input_report_key(input, BTN_MOUSE, data[1] & 1);
   680	
   681		input_sync(input);
   682		return 1;
   683	}
   684	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

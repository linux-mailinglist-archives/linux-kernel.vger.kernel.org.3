Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62ED50EBFC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiDYWZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343645AbiDYWCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:02:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BB63298E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650923977; x=1682459977;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K37orOMojrXs5qDL8WyLkZCi+08bdVnSS7jsmHDoBsc=;
  b=XoYN+HJb31ugHdVs8F9xXo1yylc7ogr4zcJZsX0fNTrw6GHHU1meUkJj
   tkMsT/vmgnNzTYZZR3mFFpDOQIX5O9zDfF/b4qV6uZdoB55GiEhuKM1K6
   Vyj7LkD+P9SelVZGSbKOjccSNO3UUg0Hy9iBSnngVxdaMoJiV4phH3Cc3
   dYh4i6sR9FyMf/lArdrWZUftkSaQeZ6uWxhs69u5YdXgYCTmHESzchPaG
   T0vCZsKg31qwAhbOd8zwFlpUaL4QFyS2T9K4KxkGUhGRf+cKyI1WpJ/kM
   ShZY7VfN3EloZd97sD+T3iumj4CzEuK5xlZC8EfrxuNZhpDop4hrRm9zp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="328315383"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="328315383"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 14:59:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="512829792"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Apr 2022 14:59:34 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nj6k2-0002us-4m;
        Mon, 25 Apr 2022 21:59:34 +0000
Date:   Tue, 26 Apr 2022 05:59:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [asahilinux:pr/22 73/189] drivers/hid/hid-magicmouse.c:662:41:
 warning: format specifies type 'unsigned short' but the argument has type
 'int'
Message-ID: <202204260549.BK1ztC91-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux pr/22
head:   7ee315306d1a3b0da8cf2a53e7f55889d0e7f034
commit: 03f2bf13a1adfe8af74f01c14af0943adef72470 [73/189] HID: magicmouse: add support for Macbook trackpads
config: hexagon-randconfig-r041-20220425 (https://download.01.org/0day-ci/archive/20220426/202204260549.BK1ztC91-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/03f2bf13a1adfe8af74f01c14af0943adef72470
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux pr/22
        git checkout 03f2bf13a1adfe8af74f01c14af0943adef72470
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hid/hid-magicmouse.c:662:41: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                   hid_dbg(hdev, "ev x:%04hx y:%04hx\n", le16_to_int(f->abs_x),
                                       ~~~~~             ^~~~~~~~~~~~~~~~~~~~~
                                       %04x
   include/linux/hid.h:1218:30: note: expanded from macro 'hid_dbg'
           dev_dbg(&(hid)->dev, fmt, ##__VA_ARGS__)
                                ~~~    ^~~~~~~~~~~
   include/linux/dev_printk.h:155:39: note: expanded from macro 'dev_dbg'
           dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                        ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:167:19: note: expanded from macro 'dynamic_dev_dbg'
                              dev, fmt, ##__VA_ARGS__)
                                   ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                 ^~~~~~~~~~~
   include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                               ^~~~~~~~~~~
   drivers/hid/hid-magicmouse.c:663:4: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                           le16_to_int(f->abs_y));
                           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/hid.h:1218:30: note: expanded from macro 'hid_dbg'
           dev_dbg(&(hid)->dev, fmt, ##__VA_ARGS__)
                                ~~~    ^~~~~~~~~~~
   include/linux/dev_printk.h:155:39: note: expanded from macro 'dev_dbg'
           dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                        ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:167:19: note: expanded from macro 'dynamic_dev_dbg'
                              dev, fmt, ##__VA_ARGS__)
                                   ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                 ^~~~~~~~~~~
   include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                               ^~~~~~~~~~~
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2332D477D25
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbhLPUOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:14:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:50939 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241185AbhLPUOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639685663; x=1671221663;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Cgin81Vb3mZ1HNSQqud19uJhMNhDSYwo3xd/SsOyjcc=;
  b=E9mYdRPMF4xkvh8P/2kWGday+H6EVCoS2MLdKWWhc1rxrmLVBZHDB4bX
   XCro/2m/L6JG5BEY/qaclmkgLNq76N21OdyJ5fnmWHPPZumWiJ5tbcwWf
   cnKQANYpZZW0h1oFitmo8lrKfPeLtsh26gROefxJlfOatMmyJ2l4WuwAg
   5rXxcejpNtP4/MI4T1QZ4LFnpZwQpmMDv3jn4gfCUQsScY/ml40JIlY4c
   c0CTpjIYm7QIWuzi0AzVK3SvCs3PNsPH2gTSQaKR6qLfm6dB0bPd4/BrR
   wOOJVRG5tNPsWie/daOeIrqTbamajjDAx9M8gWPybe8EsXWu5tYnsObc3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="239810610"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="239810610"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 12:14:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="683091201"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2021 12:14:21 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxx8u-0003kw-Ue; Thu, 16 Dec 2021 20:14:20 +0000
Date:   Fri, 17 Dec 2021 04:14:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [asahilinux:asahi 63/63] drivers/hid/hid-appleft.c:196:41: warning:
 format specifies type 'unsigned short' but the argument has type 'int'
Message-ID: <202112170404.zf3tjug6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux asahi
head:   b63c1083b20eefa3b23180ae57e1919c723f7d86
commit: b63c1083b20eefa3b23180ae57e1919c723f7d86 [63/63] WIP: HID: Add hid-appleft for Apple Macbook Trackpads
config: hexagon-randconfig-r021-20211216 (https://download.01.org/0day-ci/archive/20211217/202112170404.zf3tjug6-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/b63c1083b20eefa3b23180ae57e1919c723f7d86
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux asahi
        git checkout b63c1083b20eefa3b23180ae57e1919c723f7d86
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hid/hid-appleft.c:196:41: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                   hid_dbg(hdev, "ev x:%04hx y:%04hx\n", le16_to_int(f->abs_x),
                                       ~~~~~             ^~~~~~~~~~~~~~~~~~~~~
                                       %04x
   include/linux/hid.h:1182:30: note: expanded from macro 'hid_dbg'
           dev_dbg(&(hid)->dev, fmt, ##__VA_ARGS__)
                                ~~~    ^~~~~~~~~~~
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                           ~~~    ^~~~~~~~~~~
   drivers/hid/hid-appleft.c:197:4: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                           le16_to_int(f->abs_y));
                           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/hid.h:1182:30: note: expanded from macro 'hid_dbg'
           dev_dbg(&(hid)->dev, fmt, ##__VA_ARGS__)
                                ~~~    ^~~~~~~~~~~
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                           ~~~    ^~~~~~~~~~~
   2 warnings generated.


vim +196 drivers/hid/hid-appleft.c

   155	
   156	static int appleft_raw_event(struct hid_device *hdev, struct hid_report *report,
   157				     u8 *data, int size)
   158	{
   159		struct appleft_sc *asc = hid_get_drvdata(hdev);
   160		struct input_dev *input = asc->input;
   161		struct tp_header *tp_hdr;
   162		struct tp_finger *f;
   163		int i, n;
   164		u32 npoints;
   165		const size_t hdr_sz = sizeof(struct tp_header);
   166		const size_t touch_sz = sizeof(struct tp_finger);
   167	
   168		// hid_warn(hdev, "%s\n", __func__);
   169		// print_hex_dump_debug("appleft ev: ", DUMP_PREFIX_OFFSET, 16, 1, data,
   170		// 		     size, false);
   171	
   172		if (data[0] != TRACKPAD_SPI_REPORT_ID)
   173			return 0;
   174	
   175		/* Expect 46 bytes of prefix, and N * 30 bytes of touch data. */
   176		if (size < hdr_sz || ((size - hdr_sz) % touch_sz) != 0)
   177			return 0;
   178	
   179		tp_hdr = (struct tp_header *)data;
   180	
   181		npoints = (size - hdr_sz) / touch_sz;
   182		if (npoints < tp_hdr->num_fingers || npoints > MAX_CONTACTS) {
   183			hid_warn(hdev,
   184				 "unexpected number of touches (%u) for "
   185				 "report\n",
   186				 npoints);
   187			return 0;
   188		}
   189	
   190		n = 0;
   191		for (i = 0; i < tp_hdr->num_fingers; i++) {
   192			f = (struct tp_finger *)(data + hdr_sz + i * touch_sz);
   193			if (le16_to_int(f->touch_major) == 0)
   194				continue;
   195	
 > 196			hid_dbg(hdev, "ev x:%04hx y:%04hx\n", le16_to_int(f->abs_x),
   197				le16_to_int(f->abs_y));
   198			asc->pos[n].x = le16_to_int(f->abs_x);
   199			asc->pos[n].y = asc->y_min + asc->y_max - le16_to_int(f->abs_y);
   200			asc->map_contacs[n] = i;
   201			n++;
   202		}
   203	
   204		input_mt_assign_slots(input, asc->slots, asc->pos, n, 0);
   205	
   206		for (i = 0; i < n; i++) {
   207			int idx = asc->map_contacs[i];
   208			f = (struct tp_finger *)(data + hdr_sz + idx * touch_sz);
   209			report_finger_data(input, asc->slots[i], &asc->pos[i], f);
   210		}
   211	
   212		input_mt_sync_frame(input);
   213		input_report_key(input, BTN_MOUSE, data[1] & 1);
   214	
   215		input_sync(input);
   216		return 1;
   217	}
   218	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6655B475C19
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244082AbhLOPqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:46:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:48704 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237960AbhLOPqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639583167; x=1671119167;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C9GDrVZ9XRV1Tyn15XIu1m+c1fHF/qYIGbNdxCRZAlY=;
  b=UbUKMzdTvt5olp+2vqUh2+NSiaoR2GqkgtucmWzkodagTKugCvnea4Lv
   7CizdOEM07sDyD5l+uTzgY1N96OSyshwu50MZ5wHPJnEwpnaRqFK7700P
   f9Rd8alGmHeHWYvC/m6lJRMUfM+W/9rlEz9S5MxxscL+sPCSb4RAK/kN3
   wVdX37ejhjyu2pFdAlNrR4xjHEzVx4nJ87SLA3u/m66v4zCQ92azzNmV1
   dz0qC4ncTFXUGYbPvq8sC0ct9MpxK2pC1LukKhRvZMbRFK3uXwwc49jiO
   SG41u8sY+uZO9Ibzsl95RW7WLmilEFTDacjqFlhtrOSIhhmdVPhCyCxaa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="325534020"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="325534020"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 07:46:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="614741780"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Dec 2021 07:46:05 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxWTk-0001ym-SJ; Wed, 15 Dec 2021 15:46:04 +0000
Date:   Wed, 15 Dec 2021 23:46:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:touchpad/wip 80/82] drivers/hid/hid-appleft.c:68:
 warning: expecting prototype for struct magicmouse_sc. Prototype was for
 struct appleft_sc instead
Message-ID: <202112152315.IFJ9Vy6H-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux touchpad/wip
head:   a2281d64fdbcbab0dae68c6ea75bd5b548332e06
commit: 23cee793a43b082dfa9c9a58a0fb9604c5825d7a [80/82] WIP: HID: Add hid-appleft for Apple Macbook Trackpads
config: nds32-allyesconfig (https://download.01.org/0day-ci/archive/20211215/202112152315.IFJ9Vy6H-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/23cee793a43b082dfa9c9a58a0fb9604c5825d7a
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux touchpad/wip
        git checkout 23cee793a43b082dfa9c9a58a0fb9604c5825d7a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hid/hid-appleft.c:68: warning: expecting prototype for struct magicmouse_sc. Prototype was for struct appleft_sc instead
   drivers/hid/hid-appleft.c:105: warning: Function parameter or member 'unknown_or_origin1' not described in 'tp_finger'
   drivers/hid/hid-appleft.c:105: warning: Function parameter or member 'unknown_or_origin2' not described in 'tp_finger'
>> drivers/hid/hid-appleft.c:127: warning: expecting prototype for struct trackpad. Prototype was for struct tp_header instead


vim +68 drivers/hid/hid-appleft.c

    43	
    44	/**
    45	 * struct magicmouse_sc - Tracks Magic Mouse-specific data.
    46	 * @input: Input device through which we report events.
    47	 * @quirks: Currently unused.
    48	 * @ntouches: Number of touches in most recent touch report.
    49	 * @scroll_accel: Number of consecutive scroll motions.
    50	 * @scroll_jiffies: Time of last scroll motion.
    51	 * @touches: Most recent data for a touch, indexed by tracking ID.
    52	 * @tracking_ids: Mapping of current touch input data to @touches.
    53	 */
    54	struct appleft_sc {
    55		struct input_dev *input;
    56		unsigned long quirks;
    57	
    58		int ntouches;
    59	
    60		struct input_mt_pos pos[MAX_CONTACTS];
    61		int slots[MAX_CONTACTS];
    62		u8 map_contacs[MAX_CONTACTS];
    63	
    64		struct hid_device *hdev;
    65		struct delayed_work work;
    66	
    67		int x_min, y_min, x_max, y_max;
  > 68	};
    69	
    70	/**
    71	 * struct tp_finger - single trackpad finger structure, le16-aligned
    72	 *
    73	 * @origin:		zero when switching track finger
    74	 * @abs_x:		absolute x coordinate
    75	 * @abs_y:		absolute y coordinate
    76	 * @rel_x:		relative x coordinate
    77	 * @rel_y:		relative y coordinate
    78	 * @tool_major:		tool area, major axis
    79	 * @tool_minor:		tool area, minor axis
    80	 * @orientation:	16384 when point, else 15 bit angle
    81	 * @touch_major:	touch area, major axis
    82	 * @touch_minor:	touch area, minor axis
    83	 * @unused:		zeros
    84	 * @pressure:		pressure on forcetouch touchpad
    85	 * @multi:		one finger: varies, more fingers: constant
    86	 * @crc16:		on last finger: crc over the whole message struct
    87	 *			(i.e. message header + this struct) minus the last
    88	 *			@crc16 field; unknown on all other fingers.
    89	 */
    90	struct tp_finger {
    91		__le16 unknown_or_origin1;
    92		__le16 unknown_or_origin2;
    93		__le16 abs_x;
    94		__le16 abs_y;
    95		__le16 rel_x;
    96		__le16 rel_y;
    97		__le16 tool_major;
    98		__le16 tool_minor;
    99		__le16 orientation;
   100		__le16 touch_major;
   101		__le16 touch_minor;
   102		__le16 unused[2];
   103		__le16 pressure;
   104		__le16 multi;
   105	} __attribute__((packed, aligned(2)));
   106	
   107	/**
   108	 * struct trackpad report
   109	 *
   110	 * @report_id:		reportid
   111	 * @buttons:		HID Usage Buttons 3 1-bit reports
   112	 * @num_fingers:	the number of fingers being reported in @fingers
   113	 * @clicked:		same as @buttons
   114	 */
   115	struct tp_header {
   116		// HID mouse report
   117		u8 report_id;
   118		u8 buttons;
   119		u8 rel_x;
   120		u8 rel_y;
   121		u8 padding[4];
   122		// HID vendor part, up to 1751 bytes
   123		u8 unknown[22];
   124		u8 num_fingers;
   125		u8 clicked;
   126		u8 unknown3[14];
 > 127	};
   128	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

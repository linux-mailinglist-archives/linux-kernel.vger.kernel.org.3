Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753A6488161
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 06:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiAHE4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 23:56:40 -0500
Received: from mga01.intel.com ([192.55.52.88]:12401 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbiAHE4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 23:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641617800; x=1673153800;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=amh0S41kviibyhBRS+hWko6HYQX7jqyUsf/G4yUOZSM=;
  b=fw2NFMiFBwGC8EIK7QpvQ4aLN/mZSAd8EHtb9tqYRH/NqSEmXW1T/Att
   ztHmkrDdaf8F0xZrsTy0gpknJoU4kvq3JHAAkvsIG8DyrN6m9bxWmXDCY
   a6eWgWfasiSB6VGATQnIzbgXfQi3qY+U7tdRNMSrb7FcfVYNq75nI+o+U
   MB0NOYM1FA4v6P2vVRzcfp0XcrrMcpGga4Pg3J4Q5StolvJ480DYVD3QR
   YMo3UX80vUFu6fJsumEjO2mSfkHNeqH/foKbLqOI55HYBTTWeedoz4547
   iZN93LvoPkpAoLDHfLcUTZBVt1+wJRI3MtUNiF3tkvq24op6habBmVl2Q
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="267292855"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="267292855"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 20:56:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="473561462"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Jan 2022 20:56:38 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n63mP-0000H1-HC; Sat, 08 Jan 2022 04:56:37 +0000
Date:   Sat, 8 Jan 2022 12:56:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steve Muckle <smuckle@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alistair Delva <adelva@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android11-kiwi-5.4
 754/9999] drivers/rtc/hctosys.c:24:5: warning: no previous prototype for
 'rtc_hctosys'
Message-ID: <202201081257.UmKmhhk7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android11-kiwi-5.4
head:   7d1d5848183bd1d9086d0572f9af431d3ded407f
commit: 5f378fd56aa3988be21e859254a2d72628d044c6 [754/9999] ANDROID: rtc: class: support hctosys from modular RTC drivers
config: i386-randconfig-a001-20220107 (https://download.01.org/0day-ci/archive/20220108/202201081257.UmKmhhk7-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/5f378fd56aa3988be21e859254a2d72628d044c6
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android11-kiwi-5.4
        git checkout 5f378fd56aa3988be21e859254a2d72628d044c6
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/rtc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/rtc/hctosys.c:24:5: warning: no previous prototype for 'rtc_hctosys' [-Wmissing-prototypes]
      24 | int rtc_hctosys(void)
         |     ^~~~~~~~~~~


vim +/rtc_hctosys +24 drivers/rtc/hctosys.c

    12	
    13	/* IMPORTANT: the RTC only stores whole seconds. It is arbitrary
    14	 * whether it stores the most close value or the value with partial
    15	 * seconds truncated. However, it is important that we use it to store
    16	 * the truncated value. This is because otherwise it is necessary,
    17	 * in an rtc sync function, to read both xtime.tv_sec and
    18	 * xtime.tv_nsec. On some processors (i.e. ARM), an atomic read
    19	 * of >32bits is not possible. So storing the most close value would
    20	 * slow down the sync API. So here we have the truncated value and
    21	 * the best guess is to add 0.5s.
    22	 */
    23	
  > 24	int rtc_hctosys(void)
    25	{
    26		int err = -ENODEV;
    27		struct rtc_time tm;
    28		struct timespec64 tv64 = {
    29			.tv_nsec = NSEC_PER_SEC >> 1,
    30		};
    31		struct rtc_device *rtc = rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
    32	
    33		if (!rtc) {
    34			pr_info("unable to open rtc device (%s)\n",
    35				CONFIG_RTC_HCTOSYS_DEVICE);
    36			goto err_open;
    37		}
    38	
    39		err = rtc_read_time(rtc, &tm);
    40		if (err) {
    41			dev_err(rtc->dev.parent,
    42				"hctosys: unable to read the hardware clock\n");
    43			goto err_read;
    44		}
    45	
    46		tv64.tv_sec = rtc_tm_to_time64(&tm);
    47	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

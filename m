Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864DC591AAC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 15:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbiHMNie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 09:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239514AbiHMNiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 09:38:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E020B7D2;
        Sat, 13 Aug 2022 06:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660397903; x=1691933903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uQN4KelHJ453Go4Tyzsr6QcdAi7V7e3WbNeyQTHa1Bg=;
  b=j5RkGmmR7YNJewoXIrGlPUKZHCkV/B4zJ5MfSWFLNPLkyh0/KjBPM+ju
   j9LbF5syWyzupfEEXXhJcLpuRsU15SNSOXOjBZKz8jJ27vJENvAwmXCwH
   5PIR4IGTh7dfpHX2GpqMvJuo6R7Og7HITC1kxzrfZ0oktCA+blpw3b8JK
   9cP7ntXpvKMCp+pPW7UjuauEDxYSYEqBk7PW/BPf/v5R/sjf+Gty9Db81
   nM7MYFCSvm6EOHdGkZG0/tS0gVn3ZWL8LGX/vw9B1OeuN7Ix2GRlx2sPe
   HqnsoCz3yOLPxQ1vEAIXlO4mUIyyQYWfbMvkWkgj4J4xsFjAVjaS2wiVf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="278708253"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="278708253"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 06:38:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="851836213"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2022 06:38:19 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMrLG-0001iM-2b;
        Sat, 13 Aug 2022 13:38:18 +0000
Date:   Sat, 13 Aug 2022 21:37:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Luke D. Jones" <luke@ljones.dev>, hdegoede@redhat.com
Cc:     kbuild-all@lists.01.org, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: Re: [PATCH] asus-wmi: Add support for TUF laptop keyboard RGB
Message-ID: <202208132140.7Y3f2Xhn-lkp@intel.com>
References: <20220803231631.49924-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803231631.49924-1-luke@ljones.dev>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Luke,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.19]
[cannot apply to next-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luke-D-Jones/asus-wmi-Add-support-for-TUF-laptop-keyboard-RGB/20220804-071716
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 526942b8134cc34d25d27f95dfff98b8ce2f6fcd
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220813/202208132140.7Y3f2Xhn-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/e25083de01260bb6c1b3070f7f3e6915de07c44c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Luke-D-Jones/asus-wmi-Add-support-for-TUF-laptop-keyboard-RGB/20220804-071716
        git checkout e25083de01260bb6c1b3070f7f3e6915de07c44c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/platform/x86/asus-wmi.c: In function 'tuf_krgb_mode_store':
>> drivers/platform/x86/asus-wmi.c:782:15: warning: variable 'data' set but not used [-Wunused-but-set-variable]
     782 |         char *data, *part, *end;
         |               ^~~~


vim +/data +782 drivers/platform/x86/asus-wmi.c

   777	
   778	static ssize_t tuf_krgb_mode_store(struct device *device,
   779					 struct device_attribute *attr,
   780					 const char *buf, size_t count)
   781	{
 > 782		char *data, *part, *end;
   783		u8 res, tmp, arg_num;
   784		int err;
   785	
   786		struct asus_wmi *asus = dev_get_drvdata(device);
   787		struct led_classdev *cdev = &asus->tuf_krgb_mode.dev.led_cdev;
   788	
   789		data = end = kstrdup(buf, GFP_KERNEL);
   790		arg_num = 0;
   791	
   792		while ((part = strsep(&end, " ")) != NULL) {
   793			if (part == NULL)
   794				return -1;
   795	
   796			res = kstrtou8(part, 10, &tmp);
   797			if (res)
   798				return -1;
   799	
   800			if (arg_num == 0)
   801				asus->tuf_krgb_mode.save = tmp;
   802			else if (arg_num == 1)
   803				/* These are the known usable modes across all TUF/ROG */
   804				asus->tuf_krgb_mode.mode = tmp < 12 && tmp != 9 ? tmp : 0x0a;
   805			else if (arg_num == 2) {
   806				if (tmp == 0)
   807					asus->tuf_krgb_mode.speed = 0xe1;
   808				else if (tmp == 1)
   809					asus->tuf_krgb_mode.speed = 0xeb;
   810				else if (tmp == 2)
   811					asus->tuf_krgb_mode.speed = 0xf5;
   812				else
   813					asus->tuf_krgb_mode.speed = 0xeb;
   814			}
   815	
   816			arg_num += 1;
   817		}
   818	
   819		err = tuf_rgb_brightness_set(cdev, cdev->brightness);
   820		if (err)
   821			return err;
   822		return 0;
   823	}
   824	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

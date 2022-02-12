Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3424B378C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 20:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiBLTJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 14:09:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiBLTJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 14:09:22 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B4A6007E;
        Sat, 12 Feb 2022 11:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644692958; x=1676228958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dvxw7XxUhAZ4S9b9hBQyw/9Mc1dtJ0mAojzM9ohu4SQ=;
  b=CRgy/2cOAkMVBlzUhNJeYhTGtnxw6BLdRrjsh3XNtdQPhV+18RcC/lLL
   p/EO7fRfweNcnzmY/0y7oqrm+XINgZ1vWBbpGOi6x7zQ+q62rB+zbdBVH
   phHrjoYJols2U83L1IVr+7VtS98hHm4R0IoWXdMuTtBW5mcKdMUU4omEc
   1F1xw3y+SSRNNYHyQXwxl1Dhv64Ybmv0oizH+Fbr+mZGiptwJa3eHS+Zr
   s6wSDVEl6fMDdA3PA0rCKaIBp/+PydSaWMl6zYezLWaiiL0W3smtD1Syg
   Po9T7GrG0ccfSvKMpUMn3vLXzz0qoH4wi90iZUa90e8Zuw2aeXgSaG1Jm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="249845288"
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="249845288"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 11:09:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="569366672"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2022 11:09:16 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIxlj-0006YQ-DA; Sat, 12 Feb 2022 19:09:15 +0000
Date:   Sun, 13 Feb 2022 03:08:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Abhijeet V <abhijeetviswa@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abhijeet V <abhijeetviswa@gmail.com>
Subject: Re: [PATCH 1/2] asus-wmi: Use led multicolor class for keyboard
 backlight
Message-ID: <202202130255.uwrbJQfB-lkp@intel.com>
References: <20220211200122.9821-2-abhijeetviswa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211200122.9821-2-abhijeetviswa@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhijeet,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.17-rc3 next-20220211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Abhijeet-V/asus-wmi-Keyboard-rgb-led-multicolor-support/20220212-040427
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f1baf68e1383f6ed93eb9cff2866d46562607a43
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220213/202202130255.uwrbJQfB-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f6685f774697c85d6a352dcea013f46a99f9fe31)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/860e9e7427b00b9dbd0c35851cecda00be1968f2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Abhijeet-V/asus-wmi-Keyboard-rgb-led-multicolor-support/20220212-040427
        git checkout 860e9e7427b00b9dbd0c35851cecda00be1968f2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/asus-wmi.c:958:5: warning: no previous prototype for function 'kbd_led_classdev_init' [-Wmissing-prototypes]
   int kbd_led_classdev_init(struct asus_wmi *asus, int brightness)
       ^
   drivers/platform/x86/asus-wmi.c:958:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int kbd_led_classdev_init(struct asus_wmi *asus, int brightness)
   ^
   static 
   1 warning generated.


vim +/kbd_led_classdev_init +958 drivers/platform/x86/asus-wmi.c

   957	
 > 958	int kbd_led_classdev_init(struct asus_wmi *asus, int brightness)
   959	{
   960		int rv;
   961	
   962		asus->kbd_led_wk = brightness;
   963		asus->kbd_led_mc.led_cdev.name = "asus::kbd_backlight";
   964		asus->kbd_led_mc.led_cdev.flags = LED_BRIGHT_HW_CHANGED;
   965		asus->kbd_led_mc.led_cdev.brightness_set = kbd_led_brightness_set;
   966		asus->kbd_led_mc.led_cdev.brightness_get = kbd_led_brightness_get;
   967		asus->kbd_led_mc.led_cdev.max_brightness = 3;
   968	
   969		asus->kbd_led_mc.num_colors = ASUS_KBD_SUBLED_COUNT;
   970	
   971		rv = led_classdev_multicolor_register(&asus->platform_device->dev,
   972						&asus->kbd_led_mc);
   973		return rv;
   974	}
   975	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

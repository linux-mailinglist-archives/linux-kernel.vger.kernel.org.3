Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC7355E205
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbiF0OcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbiF0Ob7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:31:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86891B53
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656340316; x=1687876316;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Nj7zc4Vf5DEwRG8+8FPf8Nj1+CasYZy9wQCWHjICcuY=;
  b=M4weTnujzAoZFx8dhFHjxvBD+R5jrXZZXr2JzThtPIp2FDIH5gqbt8Qe
   yoAVHsKLTwtbgDHD2huuQohw4A6jfDJQ5UaDErEGjEfyEEUnj3qfUWH6A
   Wcu2pGXglQXrv1NLDXlR2AqzK6sfcdkHCULo9BOfFPZBmMnQisOw7Wb3A
   WmR8eQc/xysBcWEtCwFDGcl2vTn0zJV5KPMZnfaWcHkUljFso2vzSLPl5
   1fJqD2HqfWxt+VhyBX3hlzIBWGBWEdHsMpSSvAZk0NzLZu2NHcBtywP9V
   6orp8R6gAAmeQL1eCVfprRwBNY7/9lJ6CHhAMPcimvZ31ajxPlx01U+2P
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="345460199"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="345460199"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 07:31:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="657696370"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jun 2022 07:31:53 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5pmK-0008e6-P2;
        Mon, 27 Jun 2022 14:31:52 +0000
Date:   Mon, 27 Jun 2022 22:31:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 5/8] fs/nilfs2/ioctl.c:165:16: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202206272224.EDBJ0RPP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   5d6223c9876bbed53ff2a2977d2c36868f50c050
commit: db9e8d09f277a3100ecc7c742eec642e874c4f54 [5/8] x86/uaccess: Provide untagged_addr() and remove tags before address check
config: x86_64-randconfig-s022-20220627 (https://download.01.org/0day-ci/archive/20220627/202206272224.EDBJ0RPP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=db9e8d09f277a3100ecc7c742eec642e874c4f54
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout db9e8d09f277a3100ecc7c742eec642e874c4f54
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/auxdisplay/ drivers/char/mwave/ drivers/input/misc/ drivers/rtc/ drivers/usb/class/ drivers/usb/image/ drivers/usb/misc/sisusbvga/ drivers/watchdog/ fs/nilfs2/ fs/verity/ sound/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/nilfs2/ioctl.c:165:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/nilfs2/ioctl.c:165:16: sparse:     expected int [noderef] __user *__ptr_clean
   fs/nilfs2/ioctl.c:165:16: sparse:     got int *
--
>> fs/verity/measure.c:42:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/verity/measure.c:42:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/verity/measure.c:42:13: sparse:     got unsigned short *
--
>> drivers/auxdisplay/panel.c:1041:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/auxdisplay/panel.c:1041:17: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/auxdisplay/panel.c:1041:17: sparse:     got char *
--
>> drivers/rtc/rtc-abx80x.c:527:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-abx80x.c:527:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-abx80x.c:527:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-pcf85063.c:304:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-pcf85063.c:304:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-pcf85063.c:304:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-pcf2127.c:231:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-pcf2127.c:231:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-pcf2127.c:231:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-rv3032.c:480:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-rv3032.c:480:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-rv3032.c:480:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-rx8010.c:350:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-rx8010.c:350:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-rx8010.c:350:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-rv3028.c:597:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-rv3028.c:597:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-rv3028.c:597:24: sparse:     got unsigned int *
--
>> drivers/char/mwave/3780i.c:499:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:499:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:499:20: sparse:     got unsigned short *
   drivers/char/mwave/3780i.c:541:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:541:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:541:20: sparse:     got unsigned short *
   drivers/char/mwave/3780i.c:580:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:580:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:580:20: sparse:     got unsigned short *
   drivers/char/mwave/3780i.c:629:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:629:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:629:20: sparse:     got unsigned short *
   drivers/char/mwave/3780i.c:631:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:631:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:631:20: sparse:     got unsigned short *
   drivers/char/mwave/3780i.c:674:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:674:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:674:20: sparse:     got unsigned short *
   drivers/char/mwave/3780i.c:676:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:676:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:676:20: sparse:     got unsigned short *
--
>> drivers/watchdog/pcwd_usb.c:375:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     got char const *
>> drivers/watchdog/pcwd_usb.c:407:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_usb.c:407:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_usb.c:407:24: sparse:     got int *
   drivers/watchdog/pcwd_usb.c:416:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_usb.c:416:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_usb.c:416:24: sparse:     got int *
   drivers/watchdog/pcwd_usb.c:423:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     got int *
   drivers/watchdog/pcwd_usb.c:447:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     got int *
   drivers/watchdog/pcwd_usb.c:458:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_usb.c:458:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_usb.c:458:24: sparse:     got int *
   drivers/watchdog/pcwd_usb.c:467:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_usb.c:467:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_usb.c:467:24: sparse:     got int *
--
>> drivers/watchdog/advantechwdt.c:120:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/advantechwdt.c:120:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/advantechwdt.c:120:37: sparse:     got char const *
>> drivers/watchdog/advantechwdt.c:152:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/advantechwdt.c:152:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/advantechwdt.c:152:24: sparse:     got int *
   drivers/watchdog/advantechwdt.c:158:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/advantechwdt.c:158:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/advantechwdt.c:158:21: sparse:     got int *
   drivers/watchdog/advantechwdt.c:175:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/advantechwdt.c:175:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/advantechwdt.c:175:21: sparse:     got int *
   drivers/watchdog/advantechwdt.c:182:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/advantechwdt.c:182:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/advantechwdt.c:182:24: sparse:     got int *
--
>> drivers/watchdog/kempld_wdt.c:349:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     got int *
   drivers/watchdog/kempld_wdt.c:357:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/kempld_wdt.c:357:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/kempld_wdt.c:357:23: sparse:     got int *
--
>> drivers/watchdog/sc1200wdt.c:200:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sc1200wdt.c:200:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sc1200wdt.c:200:24: sparse:     got int *
   drivers/watchdog/sc1200wdt.c:203:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sc1200wdt.c:203:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sc1200wdt.c:203:24: sparse:     got int *
   drivers/watchdog/sc1200wdt.c:209:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sc1200wdt.c:209:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sc1200wdt.c:209:21: sparse:     got int *
   drivers/watchdog/sc1200wdt.c:229:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sc1200wdt.c:229:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sc1200wdt.c:229:21: sparse:     got int *
   drivers/watchdog/sc1200wdt.c:240:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sc1200wdt.c:240:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sc1200wdt.c:240:24: sparse:     got int *
>> drivers/watchdog/sc1200wdt.c:276:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/sc1200wdt.c:276:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/sc1200wdt.c:276:37: sparse:     got char const *
--
>> drivers/watchdog/pc87413_wdt.c:354:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/pc87413_wdt.c:354:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/pc87413_wdt.c:354:37: sparse:     got char const *
>> drivers/watchdog/pc87413_wdt.c:403:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pc87413_wdt.c:403:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pc87413_wdt.c:403:24: sparse:     got int *
   drivers/watchdog/pc87413_wdt.c:405:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pc87413_wdt.c:405:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pc87413_wdt.c:405:24: sparse:     got int *
   drivers/watchdog/pc87413_wdt.c:409:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pc87413_wdt.c:409:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pc87413_wdt.c:409:21: sparse:     got int *
   drivers/watchdog/pc87413_wdt.c:428:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pc87413_wdt.c:428:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pc87413_wdt.c:428:21: sparse:     got int *
   drivers/watchdog/pc87413_wdt.c:439:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pc87413_wdt.c:439:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pc87413_wdt.c:439:24: sparse:     got int *
--
>> drivers/input/misc/uinput.c:835:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/input/misc/uinput.c:835:15: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/input/misc/uinput.c:835:15: sparse:     got char *
>> drivers/input/misc/uinput.c:865:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/input/misc/uinput.c:865:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/input/misc/uinput.c:865:21: sparse:     got unsigned int *
--
>> drivers/usb/class/usbtmc.c:568:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/usb/class/usbtmc.c:568:22: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:568:22: sparse:     got unsigned char *
   drivers/usb/class/usbtmc.c:589:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/usb/class/usbtmc.c:589:22: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:589:22: sparse:     got unsigned char *
>> drivers/usb/class/usbtmc.c:614:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/class/usbtmc.c:614:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:614:13: sparse:     got unsigned int *
   drivers/usb/class/usbtmc.c:1063:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/class/usbtmc.c:1063:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:1063:13: sparse:     got unsigned int *
   drivers/usb/class/usbtmc.c:1274:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/class/usbtmc.c:1274:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:1274:13: sparse:     got unsigned int *
   drivers/usb/class/usbtmc.c:1295:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/class/usbtmc.c:1295:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:1295:13: sparse:     got unsigned int *
   drivers/usb/class/usbtmc.c:1989:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/class/usbtmc.c:1989:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:1989:16: sparse:     got unsigned int *
   drivers/usb/class/usbtmc.c:2000:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/class/usbtmc.c:2000:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:2000:13: sparse:     got unsigned int *
   drivers/usb/class/usbtmc.c:2136:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/class/usbtmc.c:2136:26: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:2136:26: sparse:     got unsigned int *
   drivers/usb/class/usbtmc.c:2141:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/usb/class/usbtmc.c:2141:26: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:2141:26: sparse:     got unsigned char *
   drivers/usb/class/usbtmc.c:2175:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/usb/class/usbtmc.c:2175:26: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:2175:26: sparse:     got unsigned char *
   drivers/usb/class/usbtmc.c:2180:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/usb/class/usbtmc.c:2180:26: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:2180:26: sparse:     got unsigned char *
   drivers/usb/class/usbtmc.c:2188:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/usb/class/usbtmc.c:2188:34: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:2188:34: sparse:     got unsigned char *
--
   sound/core/control.c:815:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:815:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:816:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:816:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:835:48: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:1529:40: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:1638:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/control.c:1638:13: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/control.c:1638:13: sparse:     got int *
   sound/core/control.c:1642:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/control.c:1642:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/control.c:1642:21: sparse:     got int *
   sound/core/control.c:1779:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/control.c:1779:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/control.c:1779:24: sparse:     got int *
   sound/core/control.c:1820:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/control.c:1820:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/control.c:1820:24: sparse:     got int *
   sound/core/control.c: note: in included file:
>> sound/core/control_compat.c:33:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/control_compat.c:33:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/control_compat.c:33:13: sparse:     got unsigned int *
   sound/core/control_compat.c:96:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/control_compat.c:96:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/control_compat.c:96:13: sparse:     got unsigned int *
>> sound/core/control_compat.c:108:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/control_compat.c:108:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/control_compat.c:108:13: sparse:     got signed int *
   sound/core/control_compat.c:113:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/control_compat.c:113:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/control_compat.c:113:21: sparse:     got signed int *
   sound/core/control_compat.c:114:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/control_compat.c:114:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/control_compat.c:114:21: sparse:     got signed int *
   sound/core/control_compat.c:115:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/control_compat.c:115:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/control_compat.c:115:21: sparse:     got signed int *
   sound/core/control_compat.c:193:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [assigned] err @@     got restricted snd_ctl_elem_type_t [usertype] type @@
   sound/core/control_compat.c:193:21: sparse:     expected int [assigned] err
   sound/core/control_compat.c:193:21: sparse:     got restricted snd_ctl_elem_type_t [usertype] type
   sound/core/control_compat.c:203:14: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control_compat.c:205:14: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control_compat.c:207:14: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control_compat.c:209:14: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control_compat.c:229:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/control_compat.c:229:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/control_compat.c:229:13: sparse:     got unsigned int *
   sound/core/control_compat.c:237:21: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control_compat.c:238:21: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control_compat.c:242:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/control_compat.c:242:29: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/control_compat.c:242:29: sparse:     got signed int *
   sound/core/control_compat.c:270:21: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control_compat.c:271:21: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control_compat.c:276:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/control_compat.c:276:29: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/control_compat.c:276:29: sparse:     got signed int *
   sound/core/control_compat.c:381:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/control_compat.c:381:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/control_compat.c:381:13: sparse:     got signed int *
   sound/core/control_compat.c:386:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/control_compat.c:386:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/control_compat.c:386:21: sparse:     got signed int *
   sound/core/control_compat.c:387:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/control_compat.c:387:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/control_compat.c:387:21: sparse:     got signed int *
   sound/core/control_compat.c:388:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/control_compat.c:388:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/control_compat.c:388:21: sparse:     got signed int *
--
   sound/core/timer.c:2044:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/timer.c:2044:13: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/timer.c:2044:13: sparse:     got int *
   sound/core/timer.c:2083:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/timer.c:2083:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/timer.c:2083:24: sparse:     got int *
   sound/core/timer.c: note: in included file:
>> sound/core/timer_compat.c:40:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/timer_compat.c:40:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/timer_compat.c:40:13: sparse:     got unsigned int *
   sound/core/timer_compat.c:41:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/timer_compat.c:41:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/timer_compat.c:41:13: sparse:     got unsigned int *
   sound/core/timer.c:790:25: sparse: sparse: context imbalance in 'snd_timer_process_callbacks' - unexpected unlock
--
   sound/core/pcm_native.c:1082:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:1082:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:1082:20: sparse:     got unsigned int *
   sound/core/pcm_native.c:1108:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:1108:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:1108:20: sparse:     got unsigned int *
   sound/core/pcm_native.c:3039:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3039:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3039:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3134:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3134:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3134:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3135:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3135:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3135:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3136:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3136:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3136:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3171:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean @@     got restricted snd_pcm_state_t * @@
   sound/core/pcm_native.c:3171:13: sparse:     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3171:13: sparse:     got restricted snd_pcm_state_t *
   sound/core/pcm_native.c:3172:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3172:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3172:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3173:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_native.c:3173:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3173:13: sparse:     got signed int *
   sound/core/pcm_native.c:3174:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_native.c:3174:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3174:13: sparse:     got signed int *
   sound/core/pcm_native.c:3175:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean @@     got restricted snd_pcm_state_t * @@
   sound/core/pcm_native.c:3175:13: sparse:     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3175:13: sparse:     got restricted snd_pcm_state_t *
   sound/core/pcm_native.c:3176:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_native.c:3176:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3176:13: sparse:     got signed int *
   sound/core/pcm_native.c:3177:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_native.c:3177:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3177:13: sparse:     got signed int *
   sound/core/pcm_native.c:3178:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3178:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3178:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3179:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3179:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3179:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3191:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm_native.c:3191:13: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3191:13: sparse:     got int *
   sound/core/pcm_native.c:3208:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3208:13: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3208:13: sparse:     got signed long *
   sound/core/pcm_native.c:3216:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3216:13: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3216:13: sparse:     got signed long *
   sound/core/pcm_native.c:3233:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3233:13: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3233:13: sparse:     got signed long *
   sound/core/pcm_native.c:3246:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3246:13: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3246:13: sparse:     got signed long *
   sound/core/pcm_native.c:3257:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3257:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3257:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3259:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3259:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3259:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3262:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3262:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3262:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3273:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3273:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3273:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3275:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3275:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3275:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3278:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3278:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3278:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3302:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm_native.c:3302:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3302:24: sparse:     got int *
   sound/core/pcm_native.c:3310:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3310:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3310:21: sparse:     got unsigned int *
   sound/core/pcm_native.c:3357:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3357:21: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3357:21: sparse:     got signed long *
   sound/core/pcm_native.c: note: in included file:
>> sound/core/pcm_compat.c:21:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_compat.c:21:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:21:13: sparse:     got signed int *
>> sound/core/pcm_compat.c:32:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:32:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:32:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:35:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:35:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:35:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:46:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:46:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:46:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:49:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:49:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:49:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:94:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_compat.c:94:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:94:13: sparse:     got signed int *
   sound/core/pcm_compat.c:95:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:95:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:95:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:96:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:96:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:96:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:97:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:97:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:97:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:98:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:98:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:98:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:99:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:99:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:99:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:100:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:100:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:100:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:101:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:101:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:101:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:102:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:102:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:102:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:103:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:103:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:103:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:104:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:104:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:104:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:116:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:116:25: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:116:25: sparse:     got unsigned int *
   sound/core/pcm_compat.c:134:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:134:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:134:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:135:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:135:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:135:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:136:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:136:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:136:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:137:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:137:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:137:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:142:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:142:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:142:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:143:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:143:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:143:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:144:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:144:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:144:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:145:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:145:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:145:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:196:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:196:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:196:20: sparse:     got unsigned int *
   sound/core/pcm_compat.c:263:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:263:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:263:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:301:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:301:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:301:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:302:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:302:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:302:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:312:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_compat.c:312:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:312:13: sparse:     got signed int *
   sound/core/pcm_compat.c:350:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:350:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:350:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:351:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:351:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:351:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:359:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:359:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:359:21: sparse:     got unsigned int *
   sound/core/pcm_compat.c:371:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_compat.c:371:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:371:21: sparse:     got signed int *
   sound/core/pcm_compat.c:426:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:426:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:426:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:427:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:427:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:427:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:428:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:428:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:428:13: sparse:     got unsigned int *
>> sound/core/pcm_compat.c:458:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean @@     got restricted snd_pcm_state_t * @@
   sound/core/pcm_compat.c:458:13: sparse:     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:458:13: sparse:     got restricted snd_pcm_state_t *
   sound/core/pcm_compat.c:459:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:459:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:459:13: sparse:     got unsigned int *
>> sound/core/pcm_compat.c:460:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   sound/core/pcm_compat.c:460:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:460:13: sparse:     got signed long long *
   sound/core/pcm_compat.c:461:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   sound/core/pcm_compat.c:461:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:461:13: sparse:     got signed long long *
   sound/core/pcm_compat.c:462:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean @@     got restricted snd_pcm_state_t * @@
   sound/core/pcm_compat.c:462:13: sparse:     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:462:13: sparse:     got restricted snd_pcm_state_t *
   sound/core/pcm_compat.c:463:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   sound/core/pcm_compat.c:463:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:463:13: sparse:     got signed long long *
   sound/core/pcm_compat.c:464:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   sound/core/pcm_compat.c:464:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:464:13: sparse:     got signed long long *
   sound/core/pcm_compat.c:465:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:465:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:465:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:466:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:466:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:466:13: sparse:     got unsigned int *
   sound/core/pcm_compat.c:507:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_compat.c:507:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_compat.c:507:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:95:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock' - different lock contexts for basic block
   sound/core/pcm_native.c:96:1: sparse: sparse: context imbalance in 'snd_pcm_group_unlock' - unexpected unlock
   sound/core/pcm_native.c:97:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock_irq' - different lock contexts for basic block
   sound/core/pcm_native.c:98:1: sparse: sparse: context imbalance in 'snd_pcm_group_unlock_irq' - unexpected unlock
   sound/core/pcm_native.c:145:9: sparse: sparse: context imbalance in 'snd_pcm_stream_lock_nested' - different lock contexts for basic block
   sound/core/pcm_native.c:171:9: sparse: sparse: context imbalance in '_snd_pcm_stream_lock_irqsave' - different lock contexts for basic block
   sound/core/pcm_native.c:184:9: sparse: sparse: context imbalance in '_snd_pcm_stream_lock_irqsave_nested' - different lock contexts for basic block
   sound/core/pcm_native.c:201:39: sparse: sparse: context imbalance in 'snd_pcm_stream_unlock_irqrestore' - unexpected unlock
   sound/core/pcm_native.c:1261:44: sparse: sparse: context imbalance in 'snd_pcm_action_group' - unexpected unlock
   sound/core/pcm_native.c:1331:37: sparse: sparse: context imbalance in 'snd_pcm_stream_group_ref' - different lock contexts for basic block
--
>> sound/core/rawmidi.c:665:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/rawmidi.c:665:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:665:13: sparse:     got unsigned int *
>> sound/core/rawmidi.c:667:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:667:13: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:667:13: sparse:     got int *
   sound/core/rawmidi.c:669:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/rawmidi.c:669:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:669:13: sparse:     got unsigned int *
   sound/core/rawmidi.c:860:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:860:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:860:24: sparse:     got int *
   sound/core/rawmidi.c:866:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:866:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:866:21: sparse:     got int *
   sound/core/rawmidi.c:878:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/rawmidi.c:878:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:878:21: sparse:     got unsigned int *
   sound/core/rawmidi.c:913:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:913:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:913:21: sparse:     got int *
   sound/core/rawmidi.c:928:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:928:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:928:21: sparse:     got int *
   sound/core/rawmidi.c:962:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:962:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:962:21: sparse:     got int *
   sound/core/rawmidi.c:976:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:976:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:976:21: sparse:     got int *
   sound/core/rawmidi.c:984:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:984:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:984:21: sparse:     got int *
   sound/core/rawmidi.c: note: in included file:
>> sound/core/rawmidi_compat.c:26:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/rawmidi_compat.c:26:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/rawmidi_compat.c:26:13: sparse:     got signed int *
>> sound/core/rawmidi_compat.c:27:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/rawmidi_compat.c:27:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/rawmidi_compat.c:27:13: sparse:     got unsigned int *
   sound/core/rawmidi_compat.c:28:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/rawmidi_compat.c:28:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/rawmidi_compat.c:28:13: sparse:     got unsigned int *
   sound/core/rawmidi_compat.c:29:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/rawmidi_compat.c:29:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/rawmidi_compat.c:29:13: sparse:     got unsigned int *
   sound/core/rawmidi_compat.c:30:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/rawmidi_compat.c:30:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/rawmidi_compat.c:30:13: sparse:     got unsigned int *
   sound/core/rawmidi_compat.c:63:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/rawmidi_compat.c:63:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/rawmidi_compat.c:63:13: sparse:     got signed int *
--
   sound/core/seq/seq_clientmgr.c: note: in included file:
>> sound/core/seq/seq_compat.c:42:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/seq/seq_compat.c:42:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/seq/seq_compat.c:42:13: sparse:     got unsigned int *
>> sound/core/seq/seq_compat.c:43:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   sound/core/seq/seq_compat.c:43:13: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   sound/core/seq/seq_compat.c:43:13: sparse:     got unsigned char *
   sound/core/seq/seq_compat.c:52:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/seq/seq_compat.c:52:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/seq/seq_compat.c:52:13: sparse:     got unsigned int *
   sound/core/seq/seq_compat.c:53:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   sound/core/seq/seq_compat.c:53:13: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   sound/core/seq/seq_compat.c:53:13: sparse:     got unsigned char *
   sound/core/seq/seq_clientmgr.c:711:9: sparse: sparse: context imbalance in 'deliver_to_subscribers' - different lock contexts for basic block
--
>> drivers/usb/image/mdc800.c:806:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/usb/image/mdc800.c:806:20: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/usb/image/mdc800.c:806:20: sparse:     got char const *
--
>> drivers/usb/misc/sisusbvga/sisusb.c:780:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/usb/misc/sisusbvga/sisusb.c:780:37: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/usb/misc/sisusbvga/sisusb.c:780:37: sparse:     got unsigned char *
>> drivers/usb/misc/sisusbvga/sisusb.c:795:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/usb/misc/sisusbvga/sisusb.c:795:37: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/usb/misc/sisusbvga/sisusb.c:795:37: sparse:     got unsigned short *
>> drivers/usb/misc/sisusbvga/sisusb.c:842:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/misc/sisusbvga/sisusb.c:842:37: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/misc/sisusbvga/sisusb.c:842:37: sparse:     got unsigned int *
   drivers/usb/misc/sisusbvga/sisusb.c:1127:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/usb/misc/sisusbvga/sisusb.c:1127:45: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/usb/misc/sisusbvga/sisusb.c:1127:45: sparse:     got unsigned char *
   drivers/usb/misc/sisusbvga/sisusb.c:1140:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/usb/misc/sisusbvga/sisusb.c:1140:45: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/usb/misc/sisusbvga/sisusb.c:1140:45: sparse:     got unsigned short *
   drivers/usb/misc/sisusbvga/sisusb.c:1180:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/misc/sisusbvga/sisusb.c:1180:45: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/misc/sisusbvga/sisusb.c:1180:45: sparse:     got unsigned int *
   drivers/usb/misc/sisusbvga/sisusb.c:2520:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/usb/misc/sisusbvga/sisusb.c:2520:34: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/usb/misc/sisusbvga/sisusb.c:2520:34: sparse:     got unsigned char *
   drivers/usb/misc/sisusbvga/sisusb.c:2531:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/usb/misc/sisusbvga/sisusb.c:2531:34: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/usb/misc/sisusbvga/sisusb.c:2531:34: sparse:     got unsigned short *
   drivers/usb/misc/sisusbvga/sisusb.c:2542:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/misc/sisusbvga/sisusb.c:2542:34: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/misc/sisusbvga/sisusb.c:2542:34: sparse:     got unsigned int *
   drivers/usb/misc/sisusbvga/sisusb.c:2600:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/misc/sisusbvga/sisusb.c:2600:26: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/misc/sisusbvga/sisusb.c:2600:26: sparse:     got unsigned int *
   drivers/usb/misc/sisusbvga/sisusb.c:2653:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/usb/misc/sisusbvga/sisusb.c:2653:29: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/usb/misc/sisusbvga/sisusb.c:2653:29: sparse:     got unsigned char *
   drivers/usb/misc/sisusbvga/sisusb.c:2664:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/usb/misc/sisusbvga/sisusb.c:2664:29: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/usb/misc/sisusbvga/sisusb.c:2664:29: sparse:     got unsigned short *
   drivers/usb/misc/sisusbvga/sisusb.c:2675:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/misc/sisusbvga/sisusb.c:2675:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/misc/sisusbvga/sisusb.c:2675:29: sparse:     got unsigned int *
   drivers/usb/misc/sisusbvga/sisusb.c:2740:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/misc/sisusbvga/sisusb.c:2740:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/misc/sisusbvga/sisusb.c:2740:21: sparse:     got unsigned int *
   drivers/usb/misc/sisusbvga/sisusb.c:2926:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/misc/sisusbvga/sisusb.c:2926:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/misc/sisusbvga/sisusb.c:2926:21: sparse:     got unsigned int *

vim +165 fs/nilfs2/ioctl.c

cde98f0f84ccff Ryusuke Konishi    2011-01-20  159  
d623a9420c9ae2 Vyacheslav Dubeyko 2014-01-23  160  /**
d623a9420c9ae2 Vyacheslav Dubeyko 2014-01-23  161   * nilfs_ioctl_getversion - get info about a file's version (generation number)
d623a9420c9ae2 Vyacheslav Dubeyko 2014-01-23  162   */
cde98f0f84ccff Ryusuke Konishi    2011-01-20  163  static int nilfs_ioctl_getversion(struct inode *inode, void __user *argp)
cde98f0f84ccff Ryusuke Konishi    2011-01-20  164  {
cde98f0f84ccff Ryusuke Konishi    2011-01-20 @165  	return put_user(inode->i_generation, (int __user *)argp);
cde98f0f84ccff Ryusuke Konishi    2011-01-20  166  }
cde98f0f84ccff Ryusuke Konishi    2011-01-20  167  

:::::: The code at line 165 was first introduced by commit
:::::: cde98f0f84ccff78e87235cb7b551747d6ad00de nilfs2: implement FS_IOC_GETFLAGS/SETFLAGS/GETVERSION

:::::: TO: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
:::::: CC: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

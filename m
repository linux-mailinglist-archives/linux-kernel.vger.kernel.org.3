Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8ED57929D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbiGSFnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiGSFnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:43:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E709D286EB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658209420; x=1689745420;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fi0bRXbCmAFjjR3nuv6uOQZ/xW9CcI8T7lvTZRyZEDY=;
  b=SDDwQoQOBeLHdc2V/gFNk5z8yQhHdwnldkz8/7lndxAD2O3XHZaoAhD+
   fdt4lNfEBOqe8slmMrQorqBwES13x06LEoLnie+O3CxCICxsYUylfFc8I
   Vq37hMAPc0uQ7l1cXaeb9ROWuNeR8U5tWGNZefUJlp5tjlbMU1qa5LMYA
   XQ2gRHTMa9Ty+zoOjtNd++Q52pWr+GXYT2gOFT/sqUL/1+yjRMFD2JmyW
   au0K619ZxtOthCahgAgKXWJi4pfPJj7QmXwpzFMWzngR0BUi3mnmJsAlq
   seXeGrN2u/5JNAK7GYKmpqh7tjfkAkKa4WtHJBHIBWsqdODtNAsQDu5pA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="285154166"
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="285154166"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 22:43:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="597528503"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 18 Jul 2022 22:43:36 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDg19-0005KI-OS;
        Tue, 19 Jul 2022 05:43:35 +0000
Date:   Tue, 19 Jul 2022 13:43:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: gpio-mockup-cdev.c:24:37: warning: unused variable 'req'
Message-ID: <202207191305.jL0JzHsp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ca85855bdcae8f84f1512e88b4c75009ea17ea2f
commit: 4f4d0af7b2d997635b08fabd748673eff1bb12d6 selftests: gpio: restore CFLAGS options
date:   8 months ago
reproduce: make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   gpio-mockup-cdev.c: In function 'request_line_v2':
   gpio-mockup-cdev.c:24:37: error: storage size of 'req' isn't known
      24 |         struct gpio_v2_line_request req;
         |                                     ^~~
   gpio-mockup-cdev.c:32:21: error: 'GPIO_V2_LINE_FLAG_OUTPUT' undeclared (first use in this function); did you mean 'GPIOLINE_FLAG_IS_OUT'?
      32 |         if (flags & GPIO_V2_LINE_FLAG_OUTPUT) {
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~
         |                     GPIOLINE_FLAG_IS_OUT
   gpio-mockup-cdev.c:32:21: note: each undeclared identifier is reported only once for each function it appears in
   gpio-mockup-cdev.c:35:47: error: 'GPIO_V2_LINE_ATTR_ID_OUTPUT_VALUES' undeclared (first use in this function)
      35 |                 req.config.attrs[0].attr.id = GPIO_V2_LINE_ATTR_ID_OUTPUT_VALUES;
         |                                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   gpio-mockup-cdev.c:39:26: error: 'GPIO_V2_GET_LINE_IOCTL' undeclared (first use in this function); did you mean 'GPIO_GET_LINEINFO_IOCTL'?
      39 |         ret = ioctl(cfd, GPIO_V2_GET_LINE_IOCTL, &req);
         |                          ^~~~~~~~~~~~~~~~~~~~~~
         |                          GPIO_GET_LINEINFO_IOCTL
>> gpio-mockup-cdev.c:24:37: warning: unused variable 'req' [-Wunused-variable]
      24 |         struct gpio_v2_line_request req;
         |                                     ^~~
   gpio-mockup-cdev.c: In function 'get_value_v2':
   gpio-mockup-cdev.c:48:36: error: storage size of 'vals' isn't known
      48 |         struct gpio_v2_line_values vals;
         |                                    ^~~~
   gpio-mockup-cdev.c:53:26: error: 'GPIO_V2_LINE_GET_VALUES_IOCTL' undeclared (first use in this function); did you mean 'GPIOHANDLE_GET_LINE_VALUES_IOCTL'?
      53 |         ret = ioctl(lfd, GPIO_V2_LINE_GET_VALUES_IOCTL, &vals);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                          GPIOHANDLE_GET_LINE_VALUES_IOCTL
>> gpio-mockup-cdev.c:48:36: warning: unused variable 'vals' [-Wunused-variable]
      48 |         struct gpio_v2_line_values vals;
         |                                    ^~~~
   gpio-mockup-cdev.c: In function 'main':
   gpio-mockup-cdev.c:127:20: error: 'GPIO_V2_LINE_FLAG_INPUT' undeclared (first use in this function); did you mean 'GPIOLINE_FLAG_IS_OUT'?
     127 |         flags_v2 = GPIO_V2_LINE_FLAG_INPUT;
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
         |                    GPIOLINE_FLAG_IS_OUT
   gpio-mockup-cdev.c:133:37: error: 'GPIO_V2_LINE_FLAG_ACTIVE_LOW' undeclared (first use in this function); did you mean 'GPIOLINE_FLAG_ACTIVE_LOW'?
     133 |                         flags_v2 |= GPIO_V2_LINE_FLAG_ACTIVE_LOW;
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                     GPIOLINE_FLAG_ACTIVE_LOW
   gpio-mockup-cdev.c:137:45: error: 'GPIOHANDLE_REQUEST_BIAS_PULL_UP' undeclared (first use in this function); did you mean 'GPIOHANDLE_REQUEST_INPUT'?
     137 |                                 flags_v1 |= GPIOHANDLE_REQUEST_BIAS_PULL_UP;
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                             GPIOHANDLE_REQUEST_INPUT
   gpio-mockup-cdev.c:138:45: error: 'GPIO_V2_LINE_FLAG_BIAS_PULL_UP' undeclared (first use in this function)
     138 |                                 flags_v2 |= GPIO_V2_LINE_FLAG_BIAS_PULL_UP;
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   gpio-mockup-cdev.c:140:45: error: 'GPIOHANDLE_REQUEST_BIAS_PULL_DOWN' undeclared (first use in this function); did you mean 'GPIOHANDLE_REQUEST_ACTIVE_LOW'?
     140 |                                 flags_v1 |= GPIOHANDLE_REQUEST_BIAS_PULL_DOWN;
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                             GPIOHANDLE_REQUEST_ACTIVE_LOW
   gpio-mockup-cdev.c:141:45: error: 'GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN' undeclared (first use in this function)
     141 |                                 flags_v2 |= GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN;
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   gpio-mockup-cdev.c:143:45: error: 'GPIOHANDLE_REQUEST_BIAS_DISABLE' undeclared (first use in this function); did you mean 'GPIOHANDLE_REQUEST_OPEN_DRAIN'?
     143 |                                 flags_v1 |= GPIOHANDLE_REQUEST_BIAS_DISABLE;
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                             GPIOHANDLE_REQUEST_OPEN_DRAIN
   gpio-mockup-cdev.c:144:45: error: 'GPIO_V2_LINE_FLAG_BIAS_DISABLED' undeclared (first use in this function)
     144 |                                 flags_v2 |= GPIO_V2_LINE_FLAG_BIAS_DISABLED;
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   gpio-mockup-cdev.c:152:37: error: 'GPIO_V2_LINE_FLAG_OUTPUT' undeclared (first use in this function); did you mean 'GPIOLINE_FLAG_IS_OUT'?
     152 |                         flags_v2 |= GPIO_V2_LINE_FLAG_OUTPUT;
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~
         |                                     GPIOLINE_FLAG_IS_OUT
   gpio-mockup-cdev.c: In function 'request_line_v2':
>> gpio-mockup-cdev.c:43:1: warning: control reaches end of non-void function [-Wreturn-type]
      43 | }
         | ^

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

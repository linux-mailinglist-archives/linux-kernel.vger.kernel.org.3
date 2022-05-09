Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A17252063E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 22:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiEIU7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 16:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiEIU6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 16:58:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B5E230205
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 13:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652129699; x=1683665699;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/2ojvokHDpRo6MCeWVXJN3jfN6CgTzQZ9UNO9o0niZQ=;
  b=nAgbjKK9OwxyJswXM06AxdwnlZjjFNUZT+pfeJJsLTM/1JzwN+82BVP0
   H3IxR/4m8iYdzM5GFhqEITv7oLMBCdUz3W8o5RFYFQPum98zTAoDbmYej
   dzh8kIfvoSDFZKLWVD06jrpos3rCGAbqjJ+76PBAWZYN26mm5WLyISf5K
   nKKabqZa9ILu6VN3D3ekpgWGao2Md3coMzQoG8xs6efeoYZruvHHHhcG/
   4L0BFAJUbVM6828hLvfUjNpzELjAEbcq5Ehnf/ivwBbi6W8l6MFqUDHZM
   raqocfrQjcBRZEMKmbYMo0t5zJmwZAGMTDD/BsAoJexd+bm5ChM9Oo97j
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="256703602"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="256703602"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 13:54:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="623146938"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 May 2022 13:54:58 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noAPB-000Gu2-DN;
        Mon, 09 May 2022 20:54:57 +0000
Date:   Tue, 10 May 2022 04:54:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shiyan <shc_work@mail.ru>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: drivers/video/backlight/lp855x_bl.c:511:34: warning: 'lp855x_dt_ids'
 defined but not used
Message-ID: <202205100408.icb8X7jy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9be9ed2612b5aedb52a2c240edb1630b6b743cb6
commit: 8c5dc8d9f19c7992b5ed557b865127a80149041b video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel symbol
date:   3 years, 1 month ago
config: i386-randconfig-a016-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100408.icb8X7jy-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8c5dc8d9f19c7992b5ed557b865127a80149041b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8c5dc8d9f19c7992b5ed557b865127a80149041b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/video/backlight/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/video/backlight/lp855x_bl.c:511:34: warning: 'lp855x_dt_ids' defined but not used [-Wunused-const-variable=]
     511 | static const struct of_device_id lp855x_dt_ids[] = {
         |                                  ^~~~~~~~~~~~~


vim +/lp855x_dt_ids +511 drivers/video/backlight/lp855x_bl.c

7be865ab8634d4 Kim, Milo 2012-03-23  510  
4add06645a0be0 Kim, Milo 2013-04-29 @511  static const struct of_device_id lp855x_dt_ids[] = {
4add06645a0be0 Kim, Milo 2013-04-29  512  	{ .compatible = "ti,lp8550", },
4add06645a0be0 Kim, Milo 2013-04-29  513  	{ .compatible = "ti,lp8551", },
4add06645a0be0 Kim, Milo 2013-04-29  514  	{ .compatible = "ti,lp8552", },
4add06645a0be0 Kim, Milo 2013-04-29  515  	{ .compatible = "ti,lp8553", },
5812c13a4e636d Milo Kim  2013-11-12  516  	{ .compatible = "ti,lp8555", },
4add06645a0be0 Kim, Milo 2013-04-29  517  	{ .compatible = "ti,lp8556", },
4add06645a0be0 Kim, Milo 2013-04-29  518  	{ .compatible = "ti,lp8557", },
4add06645a0be0 Kim, Milo 2013-04-29  519  	{ }
4add06645a0be0 Kim, Milo 2013-04-29  520  };
4add06645a0be0 Kim, Milo 2013-04-29  521  MODULE_DEVICE_TABLE(of, lp855x_dt_ids);
4add06645a0be0 Kim, Milo 2013-04-29  522  

:::::: The code at line 511 was first introduced by commit
:::::: 4add06645a0be0519030705e3076e1a5ceba7477 backlight: lp855x: add a device tree structure

:::::: TO: Kim, Milo <Milo.Kim@ti.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

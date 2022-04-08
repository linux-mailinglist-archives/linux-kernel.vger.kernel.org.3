Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30F04F8FD2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiDHHwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiDHHwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:52:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F431E3E07
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649404209; x=1680940209;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JBQAEVa/AnHJozcy/j95b+u+r1Jbyr0Ue7e1qlYEap4=;
  b=RYIwnCSu+0uEo6WY0XBA1uZpGgCSkbowBThos9nfTHuqeJWtbyv90zNG
   TY2jLNMCtiJ0o6vr6DWczqcDu3ktcz7eg5crvmRqlzQ9C+YI6i5KYMoOT
   aS4IN2hP6fWrjjO00Xj6zJL5/u6UZUUOseOBo1JINHmYFWBcBG3K/pZw/
   y85jluKdNnZqXi2GlVQnYVLZwnVRq3yaz/ERjkQEZ8+u8YEN8SmbThCE8
   lYvvuZfXOPAf9d69FtnIzAf0YlaaRs8qPmUzqDDtA+482+eC0hm5/G5am
   GQZ2VBEkjBJa3DiYJsGxEWC3YfLl57dorUCsSB0sil9/CUh0vCUChvJTl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261714605"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="261714605"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 00:50:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="659398766"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Apr 2022 00:50:07 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncjNe-00001F-Rt;
        Fri, 08 Apr 2022 07:50:06 +0000
Date:   Fri, 8 Apr 2022 15:49:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>
Subject: [l1k:smsc95xx_5.17 344/887]
 drivers/staging/fbtft/fb_st7789v.c:418:5: warning: no previous prototype for
 'variant_minipitft13'
Message-ID: <202204081548.vMqZ6gXI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: 7997fb3ca8c6a8db601b0352840394c046bb179b [344/887] staging: fbtft: Add minipitft13 variant
config: xtensa-randconfig-r033-20220408 (https://download.01.org/0day-ci/archive/20220408/202204081548.vMqZ6gXI-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/7997fb3ca8c6a8db601b0352840394c046bb179b
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 7997fb3ca8c6a8db601b0352840394c046bb179b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/staging/fbtft/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/fbtft/fb_st7789v.c:418:5: warning: no previous prototype for 'variant_minipitft13' [-Wmissing-prototypes]
     418 | int variant_minipitft13(struct fbtft_display *display)
         |     ^~~~~~~~~~~~~~~~~~~


vim +/variant_minipitft13 +418 drivers/staging/fbtft/fb_st7789v.c

   417	
 > 418	int variant_minipitft13(struct fbtft_display *display)
   419	{
   420		display->fbtftops.set_addr_win = minipitft13_set_addr_win;
   421		return 0;
   422	}
   423	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

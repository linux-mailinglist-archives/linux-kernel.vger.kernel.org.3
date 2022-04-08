Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA7D4F8F0F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiDHG73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiDHG72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:59:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614031C1ED0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 23:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649401046; x=1680937046;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vv9NH8J3xtabiSJIAMlMbK85qkhOBLaU6uB5sigmv8s=;
  b=eP0fzWOUiczmy4RRNAYpTts0AHgTBiFBPlxEhqwI7kN0hdXM62BDl6L3
   nJrDITl48bMZDUWYxsMkY8ElfaStelZm5HQAEtj1/qHSqQBZJF71HhPle
   n0UwPjlGs84Ff/d60XmgBEYSh9iBKAw/4H4UD5dgpItmFWA2aUKOPNbC6
   Tq6uFEj8r2we4ItYR9yoMk70UJ/c2fI9ONkW8nqlww55btBdNvl4sLALI
   UWI6H6WWstByZSbGExwa4saJOMTzr3mZ8otfQ+DKjjpLtZKO4SOHBI+uo
   iIMLuiBGyQ9E4XocnIu9jZZnOtMfKkvyu8yBZadG1avLnuLQuX7Blm2AX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261520470"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="261520470"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 23:57:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="698082569"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 07 Apr 2022 23:57:24 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nciYd-000695-TS;
        Fri, 08 Apr 2022 06:57:23 +0000
Date:   Fri, 8 Apr 2022 14:57:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>
Subject: [l1k:smsc95xx_5.17 276/886]
 drivers/staging/fbtft/fb_st7735r.c:189:5: warning: no previous prototype for
 'variant_adafruit18'
Message-ID: <202204081457.WVlGdoRe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: a6418ad0878bd7646203a3b02164c20a162a8110 [276/886] staging/fbtft: Add support for display variants
config: xtensa-randconfig-r033-20220408 (https://download.01.org/0day-ci/archive/20220408/202204081457.WVlGdoRe-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/a6418ad0878bd7646203a3b02164c20a162a8110
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout a6418ad0878bd7646203a3b02164c20a162a8110
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/staging/fbtft/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/fbtft/fb_st7735r.c:189:5: warning: no previous prototype for 'variant_adafruit18' [-Wmissing-prototypes]
     189 | int variant_adafruit18(struct fbtft_display *display)
         |     ^~~~~~~~~~~~~~~~~~
>> drivers/staging/fbtft/fb_st7735r.c:195:5: warning: no previous prototype for 'variant_adafruit18_green' [-Wmissing-prototypes]
     195 | int variant_adafruit18_green(struct fbtft_display *display)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/variant_adafruit18 +189 drivers/staging/fbtft/fb_st7735r.c

   188	
 > 189	int variant_adafruit18(struct fbtft_display *display)
   190	{
   191		display->gamma = ADAFRUIT18_GAMMA;
   192		return 0;
   193	}
   194	
 > 195	int variant_adafruit18_green(struct fbtft_display *display)
   196	{
   197		display->gamma = ADAFRUIT18_GAMMA;
   198		display->fbtftops.set_addr_win = adafruit18_green_tab_set_addr_win;
   199		return 0;
   200	}
   201	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

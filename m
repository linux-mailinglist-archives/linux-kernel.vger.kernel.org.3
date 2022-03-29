Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF6A4EA6A6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 06:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiC2Ell (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 00:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiC2Elj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 00:41:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3320F76E38
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 21:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648528797; x=1680064797;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2ejbOjj87Foc8zOioqooV8OCloynScGgyi42rcyoCec=;
  b=neIrvDGACJgqUDAwQqmt8wDebQXkv1KrcYcbKZU0CBgkZYe/lqaOVp8N
   YiaWtmuJZBX7l8oMJi459Xw4nm/4ZFwC/B3eUm1esUejeGoKzZZUNdyIs
   mizxI6kOv0foxoCKn90QxrXkUm9JHqHuZva278gFLEOXEhm+BiC7C0ZCW
   lRLGTXnEfW0RFc3qk/H0/L242+IfAahNGmTJSA8w+EFdv3hagdu0e6vzl
   JuUHlmjYlLJ1YJOPMQdZpMLirDzmj7MV7WnONJWEhCFZGtCtqjE8W6ki1
   nuWkScv8hwQ6+VBTOCCQCJrYeDg7VWCGnntpFO6b88i1xCwQLtHTdS6db
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="239092069"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="239092069"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 21:39:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="502756124"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Mar 2022 21:39:55 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZ3e6-0002eM-H8; Tue, 29 Mar 2022 04:39:54 +0000
Date:   Tue, 29 Mar 2022 12:39:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qianggui Song <qianggui.song@amlogic.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/pinctrl/meson/pinctrl-meson-s4.c:178:27: warning: unused
 variable 'tdm_sclk1_c_pins'
Message-ID: <202203291224.XHa6U5lx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qianggui,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1930a6e739c4b4a654a69164dbe39e554d228915
commit: 775214d389c259c77ff2b4de50bdaab5c9bd5db3 pinctrl: meson: add pinctrl driver support for Meson-S4 Soc
date:   8 weeks ago
config: arm64-randconfig-r015-20220328 (https://download.01.org/0day-ci/archive/20220329/202203291224.XHa6U5lx-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=775214d389c259c77ff2b4de50bdaab5c9bd5db3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 775214d389c259c77ff2b4de50bdaab5c9bd5db3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/pinctrl/meson/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/meson/pinctrl-meson-s4.c:178:27: warning: unused variable 'tdm_sclk1_c_pins' [-Wunused-const-variable]
   static const unsigned int tdm_sclk1_c_pins[]            = { GPIOC_3 };
                             ^
   1 warning generated.


vim +/tdm_sclk1_c_pins +178 drivers/pinctrl/meson/pinctrl-meson-s4.c

   173	
   174	/* Bank C func4 */
   175	static const unsigned int tdm_d2_c_pins[]		= { GPIOC_0 };
   176	static const unsigned int tdm_d3_c_pins[]		= { GPIOC_1 };
   177	static const unsigned int tdm_fs1_c_pins[]		= { GPIOC_2 };
 > 178	static const unsigned int tdm_sclk1_c_pins[]		= { GPIOC_3 };
   179	static const unsigned int mclk_1_c_pins[]		= { GPIOC_4 };
   180	static const unsigned int tdm_d4_c_pins[]		= { GPIOC_5 };
   181	static const unsigned int tdm_d5_c_pins[]		= { GPIOC_6 };
   182	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

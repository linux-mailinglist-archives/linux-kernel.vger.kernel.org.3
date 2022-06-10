Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C54546FE2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348245AbiFJXPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343938AbiFJXO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:14:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5E518344
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654902897; x=1686438897;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RsqeCXqH+5B1saV90Gbx918B8s9eAPKiAy9H93CA0+s=;
  b=Qjk9yuxJtodBItQ0NPrJoscnjuiIgPW8157XSN/B1FyDeJfFu4ejNlG3
   qT55KI75uHMzo60PYiZkkUg27PSIAvouw/RgBrJsbVTDX9RIk/PkOM3Ky
   rVq4P9JA1Hu3Q/zcXS10dA49kKpK/cjQDLrGnfIWhropn5aEY6/2mxovq
   X/uH5sinmONU7U/Zzhc2Xy8D03XP60yZWfcvKkzE/APJPovc0eCKHm3ta
   Az11NNWtVt5oH/YGpPTP/AuO1RXNqOXL0/VhSq9GUl1J8f0eOWOuhGkG6
   +SrWOy5TIUI/wEO5xvhB39Hb6PbYdQmNwXb1hwgvELg6ct3X8AdTmNEwU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="364104282"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="364104282"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 16:14:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="650066990"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jun 2022 16:14:55 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nznqB-000IM5-34;
        Fri, 10 Jun 2022 23:14:55 +0000
Date:   Sat, 11 Jun 2022 07:14:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jarkko Sakkinen <jarkko@profian.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jarkko-tpmdd:kprobes 3/3] arch/arm/kernel/module_alloc.c:24:7:
 warning: no previous prototype for 'module_alloc'
Message-ID: <202206110736.sXofukqb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git kprobes
head:   8a45ec8f64f51131c2e98dcb9ee56edf0ca0a0b3
commit: 8a45ec8f64f51131c2e98dcb9ee56edf0ca0a0b3 [3/3] kprobes: Enable tracing for mololithic kernel images
config: arm-trizeps4_defconfig (https://download.01.org/0day-ci/archive/20220611/202206110736.sXofukqb-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=8a45ec8f64f51131c2e98dcb9ee56edf0ca0a0b3
        git remote add jarkko-tpmdd git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
        git fetch --no-tags jarkko-tpmdd kprobes
        git checkout 8a45ec8f64f51131c2e98dcb9ee56edf0ca0a0b3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/kernel/module_alloc.c:24:7: warning: no previous prototype for 'module_alloc' [-Wmissing-prototypes]
      24 | void *module_alloc(unsigned long size)
         |       ^~~~~~~~~~~~


vim +/module_alloc +24 arch/arm/kernel/module_alloc.c

    22	
    23	#ifdef CONFIG_MMU
  > 24	void *module_alloc(unsigned long size)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549794B0383
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiBJCn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:43:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiBJCn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:43:26 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B040424093
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 18:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644461008; x=1675997008;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OTibWnBAvqXW7RJ+mTY9ftdI1FSjxJZp+KtPXDys2q0=;
  b=DJeD66E20HQgNaUcVAh8Hz54grnio/G5K3SOXsTp2Nfp2HYBrptlp0sl
   q36m3poosdpW+eYSn9nxfvvtc0V65gWXy1ol4ocYkbAU2mbyE//ve+vyZ
   RnpjoRi9cO54v3zGGd10TtKqjOn26Q/WpPwvt0202LH0wmDJb5AopflMx
   ZJdxrlhot8iVRGTZvQg8/mN9N0MybnZqzX1BcpY9u77vXdNrRw/6GLf+H
   aaUjjjCBP3b+ZQTm2nWsQhpA8HZYHkkN41YPOYwJq/S29pvPTqRNaK/M3
   Ia+8THa5UlAE4qwQIPesNvpAN18e+JStaOex5k9ALcJwzgBQd0mJfMGk3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="232960576"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="232960576"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 18:43:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="585810556"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Feb 2022 18:43:22 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHzQX-0002bB-G6; Thu, 10 Feb 2022 02:43:21 +0000
Date:   Thu, 10 Feb 2022 10:43:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa-dev@sang-engineering.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: powerpc64-linux-ld: drivers/i2c/busses/i2c-pasemi-core.o:undefined
 reference to `__this_module'
Message-ID: <202202101008.EvUHrprq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f4bc5bbb5fef3cf421ba3485d6d383c27ec473ed
commit: d88ae2932df0e670610cb741fec442ad12466c03 i2c: pasemi: Add Apple platform driver
date:   4 months ago
config: powerpc64-randconfig-r012-20220210 (https://download.01.org/0day-ci/archive/20220210/202202101008.EvUHrprq-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d88ae2932df0e670610cb741fec442ad12466c03
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d88ae2932df0e670610cb741fec442ad12466c03
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> powerpc64-linux-ld: warning: orphan section `.stubs' from `drivers/i2c/busses/i2c-pasemi-core.o' being placed in section `.stubs'
>> powerpc64-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/i2c/busses/i2c-pasemi-core.o' being placed in section `.ftrace.tramp'
>> powerpc64-linux-ld: drivers/i2c/busses/i2c-pasemi-core.o:(.toc+0x0): undefined reference to `__this_module'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

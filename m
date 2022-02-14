Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0BD4B4BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 11:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348092AbiBNKeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:34:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347799AbiBNKct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:32:49 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540A42BCA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644832827; x=1676368827;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xkE7ZB+HG58Bb8iZcYin4WAJ58blIEp7ZEadKNZd9f0=;
  b=XI7vCoAwMIco7VhP3nsaqVnl93DK286cz01gMQmq7kVF0GT3xW2v0E/7
   +KOccBdCG/I3tfN3aMbnIYQz4VlwOrqskGSpb1ufp+tQq+tNW32EV26Mf
   mXWGNm3w9qCDAPA/rCCzfU0Rk+lP5lLVaQ5q2KAebYJWwGGIGLdfkqrxO
   +5cwO6OG9xJjMQ4T+6dK5QaGWhiBV9Wnhs+BnX7FfoKWgt32SYa9rHkLe
   KX58SeiK4Hyu867mFVDqZAwWsZdtNDqEd7PVx43u7vrdnWun/p9x6iymD
   psh2QfB0gn73XEY+ux2Z9xQG2BBUjUrxSsYJdJ4Vd9bLNu3MJEGHkRQST
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250263427"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="250263427"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 01:59:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="501680245"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Feb 2022 01:59:51 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJY98-0008N3-PV; Mon, 14 Feb 2022 09:59:50 +0000
Date:   Mon, 14 Feb 2022 17:58:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: sound/soc/samsung/aries_wm8994.c:525:34: warning: unused variable
 'samsung_wm8994_of_match'
Message-ID: <202202141756.kbtxAPyD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   754e0b0e35608ed5206d6a67a791563c631cec07
commit: 7a3a7671fa6c7e90aff5f4242add2a40587b85ef ASoC: samsung: Add driver for Aries boards
date:   1 year, 8 months ago
config: hexagon-randconfig-r035-20220213 (https://download.01.org/0day-ci/archive/20220214/202202141756.kbtxAPyD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7a3a7671fa6c7e90aff5f4242add2a40587b85ef
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7a3a7671fa6c7e90aff5f4242add2a40587b85ef
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash sound/soc/samsung/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/samsung/aries_wm8994.c:525:34: warning: unused variable 'samsung_wm8994_of_match' [-Wunused-const-variable]
   static const struct of_device_id samsung_wm8994_of_match[] = {
                                    ^
   1 warning generated.


vim +/samsung_wm8994_of_match +525 sound/soc/samsung/aries_wm8994.c

   524	
 > 525	static const struct of_device_id samsung_wm8994_of_match[] = {
   526		{
   527			.compatible = "samsung,fascinate4g-wm8994",
   528			.data = &fascinate4g_variant,
   529		},
   530		{
   531			.compatible = "samsung,aries-wm8994",
   532			.data = &aries_variant,
   533		},
   534		{ /* sentinel */ },
   535	};
   536	MODULE_DEVICE_TABLE(of, samsung_wm8994_of_match);
   537	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B65F5477F2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 01:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiFKXnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 19:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiFKXnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 19:43:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28EF5FED
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 16:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654991030; x=1686527030;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RT0p+2hDhajSJ1kH9e9JAI65ma613oxiWt/W9xAaIwU=;
  b=EbrM0hHbWT/Njcor0PZ8ly60kRyS5sG5P3Rb2Qkz7+/sQ6uzg5jDi27X
   zCZmanX+Fb9wPWyC7eMfRz+yOuLosr6hj3oNU8hTpaYAjoEvMjTKoLxLd
   HT3U8lEKDz0PO0LK/jdF5a1t0W+LLlNHxyj9wM2bt6NUvwRMfH8flceGK
   5IGquheUi/jqs798mQ8X/p6rNSU2SMOpeIVJhZqdhVK6Wdk8X+CwCEeNB
   a3AXWGlldqGxJ77JmlX0/FrKkd77X5kEGPzNxOL88jvCbK55j2daA5bUo
   ZNtv0gNMTdw09xIKixzjCXzOtRnZziGlw9suriHes3CranGxxvEI9QAzC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="276733999"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="276733999"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 16:43:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="685305514"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jun 2022 16:43:48 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0Alg-000JQH-7W;
        Sat, 11 Jun 2022 23:43:48 +0000
Date:   Sun, 12 Jun 2022 07:43:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: drivers/dma/dw/rzn1-dmamux.c:105:34: warning: unused variable
 'rzn1_dmac_match'
Message-ID: <202206120706.vHMLJjkz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0678afa6055d14799c1dc1eee47c8025eba56cab
commit: 134d9c52fca26d2d199516e915da00f0cc6adc73 dmaengine: dw: dmamux: Introduce RZN1 DMA router support
date:   3 weeks ago
config: hexagon-randconfig-r035-20220611 (https://download.01.org/0day-ci/archive/20220612/202206120706.vHMLJjkz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ff4abe755279a3a47cc416ef80dbc900d9a98a19)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=134d9c52fca26d2d199516e915da00f0cc6adc73
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 134d9c52fca26d2d199516e915da00f0cc6adc73
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/dma/dw/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/dma/dw/rzn1-dmamux.c:105:34: warning: unused variable 'rzn1_dmac_match' [-Wunused-const-variable]
   static const struct of_device_id rzn1_dmac_match[] = {
                                    ^
   1 warning generated.


vim +/rzn1_dmac_match +105 drivers/dma/dw/rzn1-dmamux.c

   104	
 > 105	static const struct of_device_id rzn1_dmac_match[] = {
   106		{ .compatible = "renesas,rzn1-dma" },
   107		{}
   108	};
   109	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

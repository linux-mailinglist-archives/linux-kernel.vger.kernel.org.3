Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF19D4B9999
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbiBQHHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:07:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbiBQHHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:07:19 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FD01B8FEE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 23:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645081625; x=1676617625;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aIAIHiSYFQs1OHO8vn3EML5N+RuWuBiMvLCuRRsbiQw=;
  b=hQyM+/2xXYSc4aVgo/1h2nXw2LYqIbRtCNTN61umgOUWm+Du4pvWmR5c
   F+DWfL/kIcUg22l7wvc1+yPpb368r63NBOuXhds37YiyGMJj0hlxygt5W
   TQSupe+fvZu62sNR+jDRkQ21u0+afslmljUTxEyREL7EHonObpdSnlt8X
   zIE+07eBbOji3ofbwsbeLN6ILqXZy5+M7xfXqCyLoU7ZQlmb2xKogf1ov
   eO9KRGTZ9F3LjBIVBEoQPdzh7Nux1VNHeBObmJDNSvJjsBNYs2eq9oyb8
   FK0H/NBRQyjCyfg6I67AQW2fLpPcIKWxtQJXU4xfwef98vnWHb3/7cCLJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="234341125"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="234341125"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 23:07:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="776955949"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 16 Feb 2022 23:07:03 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKasZ-000BYK-1x; Thu, 17 Feb 2022 07:07:03 +0000
Date:   Thu, 17 Feb 2022 15:06:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: drivers/fpga/microchip-spi.c:341:34: warning: unused variable
 'mpf_of_ids'
Message-ID: <202202171552.gFz6PXXK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220217-002021/Ivan-Bornyakov/fpga-microsemi-spi-add-Microsemi-FPGA-manager/20220214-222923
head:   6acf97cc27bd55298cb9d6a365b078b09e2b6acf
commit: 6acf97cc27bd55298cb9d6a365b078b09e2b6acf fpga: microchip-spi: add Microchip FPGA manager
date:   15 hours ago
config: mips-randconfig-r006-20220217 (https://download.01.org/0day-ci/archive/20220217/202202171552.gFz6PXXK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0bad7cb56526f2572c74449fcf97c1fcda42b41d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/0day-ci/linux/commit/6acf97cc27bd55298cb9d6a365b078b09e2b6acf
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220217-002021/Ivan-Bornyakov/fpga-microsemi-spi-add-Microsemi-FPGA-manager/20220214-222923
        git checkout 6acf97cc27bd55298cb9d6a365b078b09e2b6acf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/fpga/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/fpga/microchip-spi.c:341:34: warning: unused variable 'mpf_of_ids' [-Wunused-const-variable]
   static const struct of_device_id mpf_of_ids[] = {
                                    ^
   1 warning generated.


vim +/mpf_of_ids +341 drivers/fpga/microchip-spi.c

   340	
 > 341	static const struct of_device_id mpf_of_ids[] = {
   342		{ .compatible = "microchip,mpf-spi-fpga-mgr" },
   343		{},
   344	};
   345	MODULE_DEVICE_TABLE(of, mpf_of_ids);
   346	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

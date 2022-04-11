Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BB94FB28A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 06:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiDKEJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 00:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiDKEJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 00:09:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BBD1658C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 21:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649650017; x=1681186017;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7a5L5pHh2qS6ch6/EmFZOA1nOfyVhZlxe5zhAixrEQM=;
  b=FbwzDn+E1u5ED0OVEUi6nUlJ2L92lRmLYPLiDkTMwRvrbXX2v5/SHNot
   sywVRQUujk4PrHfRos9olVGVEPqnKFGzTDEXc5NJ3gh0peagYe7QkRdbV
   2EzeKRvam6RCyp+2zd4iIB8M+pMhp265Dl8wvGGOrkgJQdXzVJRz3tVOc
   /XpqxyXzfViAqQNGxkMyfGV18F/uncZzwvLqJq6T7p24hX1ulyifdooJx
   5snyAbgVR4qo71ZnZZgRn0zeOPX5K6DzYA0fMVHYPTC+iYHTZK8M3j6/A
   K5BQ/1EfwescNROUeYE13b051++L9WkmjafqqXPvkZyTj0NtN9spRa2oA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="261771899"
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="261771899"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 21:06:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="506950142"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Apr 2022 21:06:55 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndlKI-0001UF-EK;
        Mon, 11 Apr 2022 04:06:54 +0000
Date:   Mon, 11 Apr 2022 12:06:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Hughes <JamesH65@users.noreply.github.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Subject: [l1k:smsc95xx_5.17 85/888]
 drivers/perf/raspberrypi_axi_monitor.c:139:1: warning: 'static' is not at
 beginning of declaration
Message-ID: <202204111229.bejmJhO0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   240f56c27361c195cd502d95aba51c6b8e5b808c
commit: 7903ec0612d5f7d32ca61206d5e3cbe0262d3c00 [85/888] AXI performance monitor driver (#2222)
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220411/202204111229.bejmJhO0-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/7903ec0612d5f7d32ca61206d5e3cbe0262d3c00
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 7903ec0612d5f7d32ca61206d5e3cbe0262d3c00
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/char/broadcom/ drivers/perf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/perf/raspberrypi_axi_monitor.c:139:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
     139 | const static char *bus_filter_strings[] = {
         | ^~~~~
   drivers/perf/raspberrypi_axi_monitor.c:176:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
     176 | const static char *system_bus_string[] = {
         | ^~~~~
   drivers/perf/raspberrypi_axi_monitor.c:197:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
     197 | const static char *vpu_bus_string[] = {
         | ^~~~~
   drivers/perf/raspberrypi_axi_monitor.c:218:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
     218 | const static char *monitor_name[] = {
         | ^~~~~


vim +/static +139 drivers/perf/raspberrypi_axi_monitor.c

   138	
 > 139	const static char *bus_filter_strings[] = {
   140		"",
   141		"CORE0_V",
   142		"ICACHE0",
   143		"DCACHE0",
   144		"CORE1_V",
   145		"ICACHE1",
   146		"DCACHE1",
   147		"L2_MAIN",
   148		"HOST_PORT",
   149		"HOST_PORT2",
   150		"HVS",
   151		"ISP",
   152		"VIDEO_DCT",
   153		"VIDEO_SD2AXI",
   154		"CAM0",
   155		"CAM1",
   156		"DMA0",
   157		"DMA1",
   158		"DMA2_VPU",
   159		"JPEG",
   160		"VIDEO_CME",
   161		"TRANSPOSER",
   162		"VIDEO_FME",
   163		"CCP2TX",
   164		"USB",
   165		"V3D0",
   166		"V3D1",
   167		"V3D2",
   168		"AVE",
   169		"DEBUG",
   170		"CPU",
   171		"M30"
   172	};
   173	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

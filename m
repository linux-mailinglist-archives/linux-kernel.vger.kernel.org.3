Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119CA4B03FC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiBJDfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:35:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiBJDe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:34:59 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E009D23BE3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644464101; x=1676000101;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xJJPp6htCjKYKK9FKDEVJoJUEcaZy7OiWHicr2oJnIA=;
  b=g/jSj+Vugb63YiSMMfoaiTpcPpUpoUfTBCk+8rZRGWpQ2csVvfYC3Wdi
   iDnLtM5ITa+VBn98YKBammn5aoO8saV8UK/W8l8gN6ZtFuwO734BKo0Bz
   H3dcl96nry4JIJDscDM0Ib5gnVIcfkz85Dkjgk6fK+xT9FT+eLeFx4X+6
   /qh7v8o2A14AfVRwvt5/KdZntoYlENmBKxWKKidLw9Nzzyo1Nu0Dh7Wjk
   Hmtu2nSDXO7xS8/jG0TUF4KGKWEbDdiey+bPqte4bVHT7yznCQIcXjxes
   6/8lRi0dxSuViEN1o+XfgKht043b/EqDoxJZQoherI1Laa0lLVHdkPksX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="273949914"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="273949914"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 19:34:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="701525251"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 Feb 2022 19:34:23 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nI0Dv-0002ec-9I; Thu, 10 Feb 2022 03:34:23 +0000
Date:   Thu, 10 Feb 2022 11:34:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [saeed:net-next-mlx5 113/149] undefined reference to `ioread64_lo_hi'
Message-ID: <202202101152.IvkySQrT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git net-next-mlx5
head:   645c8116a15fb54da78658990992296831729f62
commit: 8664d49a815e34f8e88489efb72c23826167adbe [113/149] ptp_pch: Use ioread64_lo_hi() / iowrite64_lo_hi()
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220210/202202101152.IvkySQrT-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git/commit/?id=8664d49a815e34f8e88489efb72c23826167adbe
        git remote add saeed https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git
        git fetch --no-tags saeed net-next-mlx5
        git checkout 8664d49a815e34f8e88489efb72c23826167adbe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/ptp/ptp_pch.o: in function `pch_rx_snap_read':
>> (.text+0x36c): undefined reference to `ioread64_lo_hi'
   hppa-linux-ld: drivers/ptp/ptp_pch.o: in function `pch_tx_snap_read':
   (.text+0x3ec): undefined reference to `ioread64_lo_hi'
   hppa-linux-ld: drivers/ptp/ptp_pch.o: in function `pch_set_station_address':
>> (.text+0x4e0): undefined reference to `iowrite64_lo_hi'
   hppa-linux-ld: drivers/ptp/ptp_pch.o: in function `ptp_pch_settime':
>> ptp_pch.o:(.text+0x680): undefined reference to `iowrite64_lo_hi'
   hppa-linux-ld: drivers/ptp/ptp_pch.o: in function `ptp_pch_adjtime':
>> ptp_pch.o:(.text+0x758): undefined reference to `ioread64_lo_hi'
>> hppa-linux-ld: ptp_pch.o:(.text+0x77c): undefined reference to `iowrite64_lo_hi'
   hppa-linux-ld: drivers/ptp/ptp_pch.o: in function `ptp_pch_gettime':
   ptp_pch.o:(.text+0xb10): undefined reference to `ioread64_lo_hi'
   hppa-linux-ld: drivers/ptp/ptp_pch.o: in function `pch_probe':
   ptp_pch.o:(.text+0xe88): undefined reference to `iowrite64_lo_hi'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

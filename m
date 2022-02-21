Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9474BE06B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350423AbiBUJfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:35:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350044AbiBUJ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:27:07 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F4622513
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645434684; x=1676970684;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wOTmblO5+ELXVIIn1qHC/eijBtSFzcFQf/GVXdIIgMA=;
  b=gZXEemEt7IzEAXLfh46bJMYKhY35DmxfflFTAX3Lf8QBwgPylW2dbolQ
   V5QV3M94I4AQNASWj1lL4bwvEd7XKPovg9DGS/gyNqMKzB7QBCqRPAfUK
   wzXuAav6hWET/1VLhSTHC0A2O1bbUQWKhVl/KxlIn+kR5LUaWAnoiXCYh
   aiaDoWRcpUT8S3ww6Eo+GTx/K4mhloc5ZIlJNTPY5IWVYPQWKqTHC611t
   38YvtRTikiHS4HLa/zPhcQh/BQu/Ef69Mvlj+CJOXlAThvTvaZP8Pl8z8
   kRmqaKZXsYIFLzsRoVoMumlAcE9cqgBga3XYl4tiNar17CSIjYHAso5Wz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="238884566"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="238884566"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 01:11:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="627314918"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2022 01:11:10 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM4ir-0001S8-EN; Mon, 21 Feb 2022 09:11:09 +0000
Date:   Mon, 21 Feb 2022 17:11:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [ammarfaizi2-block:axboe/linux-block/m1/2022-02-19 434/552]
 include/linux/soc/apple/rtkit.h:223:5: warning: no previous prototype for
 'apple_rtkit_poll'
Message-ID: <202202211757.0kgIweOT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1/2022-02-19
head:   b781e0ccdc0c9a931571d15db09d45b7258b9905
commit: 493f6321556155242b30f79a6aa6afa58d5ff28d [434/552] WIP: nvme-apple: add initial Apple SoC NVMe driver
config: h8300-randconfig-r025-20220221 (https://download.01.org/0day-ci/archive/20220221/202202211757.0kgIweOT-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/493f6321556155242b30f79a6aa6afa58d5ff28d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1/2022-02-19
        git checkout 493f6321556155242b30f79a6aa6afa58d5ff28d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=h8300 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/nvme/host/apple.c:32:
>> include/linux/soc/apple/rtkit.h:223:5: warning: no previous prototype for 'apple_rtkit_poll' [-Wmissing-prototypes]
     223 | int apple_rtkit_poll(struct apple_rtkit *rtk)
         |     ^~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for NFSD_V2_ACL
   Depends on NETWORK_FILESYSTEMS && NFSD
   Selected by
   - NFSD_V3_ACL && NETWORK_FILESYSTEMS


vim +/apple_rtkit_poll +223 include/linux/soc/apple/rtkit.h

aee0bc1199b4a8 Hector Martin 2022-02-08  222  
d47d01d475b6a9 Hector Martin 2022-02-08 @223  int apple_rtkit_poll(struct apple_rtkit *rtk)
d47d01d475b6a9 Hector Martin 2022-02-08  224  {
d47d01d475b6a9 Hector Martin 2022-02-08  225  	return -ENODEV;
d47d01d475b6a9 Hector Martin 2022-02-08  226  }
d47d01d475b6a9 Hector Martin 2022-02-08  227  

:::::: The code at line 223 was first introduced by commit
:::::: d47d01d475b6a9678964a7bcd5566378902185f7 soc: apple: rtkit: Add recv_message_early callback and apple_rtkit_poll

:::::: TO: Hector Martin <marcan@marcan.st>
:::::: CC: Hector Martin <marcan@marcan.st>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

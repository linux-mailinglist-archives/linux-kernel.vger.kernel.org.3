Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D9D5307B4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352917AbiEWCaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352906AbiEWCak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:30:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6585037A3D
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 19:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653273032; x=1684809032;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4WK8aGbUDqaIUa1SiHIHoDVH53+ZD8ZQAWBCdkSvXdc=;
  b=Q7mz4n7o7HO73IBarfTgfMLmw2Z+GrPRazofSTxGHJbois2rsAsrpSK6
   uXsGAex263iOUSRxoH4p1kK6+GfBwNz3gZwtvcKp/ZVkx0QW6UCeT7Tct
   1B7Ff9exTmszRIv69olamQHVi50wlY4Ix2gzxMPAqJKuxUEx14RMs1vl+
   B0aQUWQIP6gY+oA4bNUS4d7SCN7I8tRAMfuTO5q61lPKWzcYdRSAUjHNI
   Q79fAnuPovOhLcnv/CgaxoPxYRgCF5+LdTT13haXoMjx1HOWIzcsaVbQG
   LBLEy6Uyh1u1F2xAUMck/1eTHKzCUa6eaN+VXbdduWK64weEcbYtnfuPr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="252955632"
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="252955632"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 19:30:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="716481815"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 May 2022 19:30:31 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsxq2-0000pG-Bf;
        Mon, 23 May 2022 02:30:30 +0000
Date:   Mon, 23 May 2022 10:30:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [tomoyo-tomoyo-test1:master 1/1]
 drivers/input/mouse/psmouse-smbus.c:320:2: warning: call to
 __warn_flushing_systemwide_wq declared with 'warning' attribute: Please
 avoid flushing system-wide workqueues.
Message-ID: <202205231050.yd4wTc2M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git master
head:   84baad17cb8286b6b53b675f8c3d7343ee6a990c
commit: 84baad17cb8286b6b53b675f8c3d7343ee6a990c [1/1] workqueue: Wrap flush_workqueue() using a macro
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220523/202205231050.yd4wTc2M-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 768a1ca5eccb678947f4155e38a5f5744dcefb56)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add tomoyo-tomoyo-test1 git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git
        git fetch --no-tags tomoyo-tomoyo-test1 master
        git checkout 84baad17cb8286b6b53b675f8c3d7343ee6a990c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/input/mouse/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/input/mouse/psmouse-smbus.c:320:2: warning: call to __warn_flushing_systemwide_wq declared with 'warning' attribute: Please avoid flushing system-wide workqueues. [-Wattribute-warning]
           flush_scheduled_work();
           ^
   include/linux/workqueue.h:705:32: note: expanded from macro 'flush_scheduled_work'
   #define flush_scheduled_work() flush_workqueue(system_wq)
                                  ^
   include/linux/workqueue.h:695:3: note: expanded from macro 'flush_workqueue'
                   __warn_flushing_systemwide_wq();                        \
                   ^
   1 warning generated.


vim +/warning +320 drivers/input/mouse/psmouse-smbus.c

8eb92e5c91338e Benjamin Tissoires 2017-03-02  316  
8eb92e5c91338e Benjamin Tissoires 2017-03-02  317  void psmouse_smbus_module_exit(void)
8eb92e5c91338e Benjamin Tissoires 2017-03-02  318  {
8eb92e5c91338e Benjamin Tissoires 2017-03-02  319  	bus_unregister_notifier(&i2c_bus_type, &psmouse_smbus_notifier);
8eb92e5c91338e Benjamin Tissoires 2017-03-02 @320  	flush_scheduled_work();

:::::: The code at line 320 was first introduced by commit
:::::: 8eb92e5c91338eb19f86ffb2232258337ebf905b Input: psmouse - add support for SMBus companions

:::::: TO: Benjamin Tissoires <benjamin.tissoires@redhat.com>
:::::: CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

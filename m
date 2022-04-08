Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7034F8B0E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiDHAdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 20:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiDHAd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 20:33:29 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC35C165E42
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 17:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649377884; x=1680913884;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K3ytg78E28TEeNjsGtSSj5v1hsWr7I04qg+hD1BnI1w=;
  b=IEG/wc8ekL7je7DVumS+Ouol+9+rYk0dT/tyVb2O7F27ukv5HoCDyU+m
   sT9VRE0ll9rcp9Gv6JoSqCN1SB29ONGFMpguFCnFUe2skur7p4CvMVxCq
   qfrzHRvbM2kDvo7/WauYqCJMWJmEMUNwra8QbEiMpuQNViyVkhFzLbeX0
   yK7T/t74QGE+rKFJbxa8t6jtaz9Okser6T44EZPNdkoX9yVvo0w/Viwx+
   i59AKl+IbQOZsBFdKrKXYhx3437gvyRJpBwTT8G3zlVHAk0pgeOnpevb4
   0R/W4fc8SeCiFeRCmj2u8LnAOd/H78rSqQH+HJZhCVeUkzOgOU/OWvsUk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="322164110"
X-IronPort-AV: E=Sophos;i="5.90,243,1643702400"; 
   d="scan'208";a="322164110"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 17:31:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,243,1643702400"; 
   d="scan'208";a="723185008"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 07 Apr 2022 17:31:23 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nccX4-0005u7-DN;
        Fri, 08 Apr 2022 00:31:22 +0000
Date:   Fri, 8 Apr 2022 08:30:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/wip.freezer 3/5]
 drivers/acpi/x86/s2idle.c:546:9: error: too few arguments to function
 'unlock_system_sleep'
Message-ID: <202204080853.ZTlryCwN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/wip.freezer
head:   ed5b8f90d21512ee2392f35dbb0ab867c66d243d
commit: 46038225e7df3d71cc3fc0d3df5bb79e7cf136ec [3/5] freezer: Have {,un}lock_system_sleep() save/restore flags
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220408/202204080853.ZTlryCwN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=46038225e7df3d71cc3fc0d3df5bb79e7cf136ec
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/wip.freezer
        git checkout 46038225e7df3d71cc3fc0d3df5bb79e7cf136ec
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/acpi/x86/s2idle.c: In function 'acpi_register_lps0_dev':
>> drivers/acpi/x86/s2idle.c:546:9: error: too few arguments to function 'unlock_system_sleep'
     546 |         unlock_system_sleep();
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/acpi/x86/s2idle.c:20:
   include/linux/suspend.h:514:13: note: declared here
     514 | extern void unlock_system_sleep(unsigned int);
         |             ^~~~~~~~~~~~~~~~~~~
   drivers/acpi/x86/s2idle.c: In function 'acpi_unregister_lps0_dev':
   drivers/acpi/x86/s2idle.c:559:9: error: too few arguments to function 'unlock_system_sleep'
     559 |         unlock_system_sleep();
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/acpi/x86/s2idle.c:20:
   include/linux/suspend.h:514:13: note: declared here
     514 | extern void unlock_system_sleep(unsigned int);
         |             ^~~~~~~~~~~~~~~~~~~


vim +/unlock_system_sleep +546 drivers/acpi/x86/s2idle.c

fef98671194be0 Rafael J. Wysocki 2020-12-17  538  
20e1d6402a71db Mario Limonciello 2022-03-17  539  int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg)
20e1d6402a71db Mario Limonciello 2022-03-17  540  {
20e1d6402a71db Mario Limonciello 2022-03-17  541  	if (!lps0_device_handle || sleep_no_lps0)
20e1d6402a71db Mario Limonciello 2022-03-17  542  		return -ENODEV;
20e1d6402a71db Mario Limonciello 2022-03-17  543  
20e1d6402a71db Mario Limonciello 2022-03-17  544  	lock_system_sleep();
20e1d6402a71db Mario Limonciello 2022-03-17  545  	list_add(&arg->list_node, &lps0_s2idle_devops_head);
20e1d6402a71db Mario Limonciello 2022-03-17 @546  	unlock_system_sleep();
20e1d6402a71db Mario Limonciello 2022-03-17  547  
20e1d6402a71db Mario Limonciello 2022-03-17  548  	return 0;
20e1d6402a71db Mario Limonciello 2022-03-17  549  }
20e1d6402a71db Mario Limonciello 2022-03-17  550  EXPORT_SYMBOL_GPL(acpi_register_lps0_dev);
20e1d6402a71db Mario Limonciello 2022-03-17  551  

:::::: The code at line 546 was first introduced by commit
:::::: 20e1d6402a71dba7ad2b81f332a3c14c7d3b939b ACPI / x86: Add support for LPS0 callback handler

:::::: TO: Mario Limonciello <mario.limonciello@amd.com>
:::::: CC: Hans de Goede <hdegoede@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8C04FA564
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 08:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiDIG0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 02:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiDIG0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 02:26:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6732DCE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 23:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649485441; x=1681021441;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o0Kidqq7ChtJB5LjNY72wCdecLyykNyGhxKhNN3+MPk=;
  b=ZCoaUFUf4YDaMANGsvZfixiZfdAxAAq3x3fyLuvDSVg2XQzMyElD0r0w
   1XCj4xOAi2qOClp2kW1wOzla2br3TNTe7M40vQZ7bkkWIPPiuyaSp0Kqm
   bLL3o4ZwalB1mVhuuDIG/VFiQs6GsWqSoWPoK1Po2TcbLsZSXzUHlseI7
   M4dXUshKjOeBcZFl/ONSvmPiW/MsnNhYYTUhLO1I8tM+Et1YLNMIfUpFM
   sgJIoPMrq4g0YrsANQYZD7sNF+ak5n3ySyc3fex7fbeg3HI/0zUBGtUAm
   dmrWrTgRv1VHH1SXMhDOSxZgNrbfTlGT6/o2bmY2tfoLon2o3eCIiweZs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="259363496"
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="259363496"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 23:24:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="643246205"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Apr 2022 23:23:58 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nd4Vp-0000xd-TJ;
        Sat, 09 Apr 2022 06:23:57 +0000
Date:   Sat, 9 Apr 2022 14:23:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:for-5.19/cxl-device-lock 2/12] include/linux/device.h:849:3:
 error: use of undeclared identifier 'DRV_NAME'
Message-ID: <202204091427.VqNnQI8Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-5.19/cxl-device-lock
head:   fd011b3bf6035eb145160f266fe0250e1e42b86e
commit: 69d523de7046a14555e4f4986c4682e8c1635740 [2/12] device-core: Add dev->lock_class to enable device_lock() lockdep validation
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220409/202204091427.VqNnQI8Y-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c29a51b3a257908aebc01cd7c4655665db317d66)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=69d523de7046a14555e4f4986c4682e8c1635740
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl for-5.19/cxl-device-lock
        git checkout 69d523de7046a14555e4f4986c4682e8c1635740
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/xen/xen-pciback/conf_space.c:17:
   In file included from include/linux/pci.h:37:
>> include/linux/device.h:849:3: error: use of undeclared identifier 'DRV_NAME'
                   dev_warn(dev,
                   ^
   include/linux/dev_printk.h:146:54: note: expanded from macro 'dev_warn'
           dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                               ^
   drivers/xen/xen-pciback/conf_space.c:13:22: note: expanded from macro 'dev_fmt'
   #define dev_fmt(fmt) DRV_NAME ": " fmt
                        ^
   In file included from drivers/xen/xen-pciback/conf_space.c:17:
   In file included from include/linux/pci.h:1522:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:700:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:97:11: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                           ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/xen/xen-pciback/conf_space.c:17:
   In file included from include/linux/pci.h:1522:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:700:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:97:25: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/xen/xen-pciback/conf_space.c:17:
   In file included from include/linux/pci.h:1522:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:700:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:4: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
                           set->sig[1] | set->sig[0]) == 0;
                           ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/xen/xen-pciback/conf_space.c:17:
   In file included from include/linux/pci.h:1522:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:700:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:100:11: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[1] | set->sig[0]) == 0;
                           ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/xen/xen-pciback/conf_space.c:17:
   In file included from include/linux/pci.h:1522:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:700:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:113:11: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/xen/xen-pciback/conf_space.c:17:
   In file included from include/linux/pci.h:1522:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:700:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:113:27: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&


vim +/DRV_NAME +849 include/linux/device.h

   826	
   827	/*
   828	 * Note: this routine expects that the state of @dev->mutex is stable
   829	 * from entry to exit. There is no support for changing lockdep
   830	 * validation classes, only enabling and disabling validation.
   831	 */
   832	static inline void device_set_lock_class(struct device *dev, int lock_class)
   833	{
   834		/*
   835		 * Allow for setting or clearing the lock class while the
   836		 * device_lock() is held, in which case the paired nested lock
   837		 * might need to be acquired or released now to accommodate the
   838		 * next device_unlock().
   839		 */
   840		if (dev->lock_class < 0 && lock_class >= 0) {
   841			/* Enabling lockdep validation... */
   842			if (mutex_is_locked(&dev->mutex))
   843				mutex_lock_nested(&dev->lockdep_mutex, lock_class);
   844		} else if (dev->lock_class >= 0 && lock_class < 0) {
   845			/* Disabling lockdep validation... */
   846			if (mutex_is_locked(&dev->mutex))
   847				mutex_unlock(&dev->lockdep_mutex);
   848		} else {
 > 849			dev_warn(dev,
   850				 "%s: failed to change lock_class from: %d to %d\n",
   851				 __func__, dev->lock_class, lock_class);
   852			return;
   853		}
   854		dev->lock_class = lock_class;
   855	}
   856	#else /* !CONFIG_PROVE_LOCKING */
   857	static inline void device_lockdep_init(struct device *dev)
   858	{
   859		lockdep_set_novalidate_class(&dev->mutex);
   860	}
   861	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

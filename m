Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183374DCF1F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiCQUJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiCQUJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:09:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB46154717
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647547686; x=1679083686;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YBoCQb7UmoOARchuRJI1sTlyMd0JMJDPlVJrDO2OlEg=;
  b=AG9LLVVoWunYG3PxH5u1xGjrr6wCkDjwfDWAwDM5hYCr8juMHfTALyuZ
   2w7F86reOovGl14AD322P7iIbl64LloOnFFjmTtsyBnHp3ozvNz4Hrltm
   HmLppJDTLwzlfKtBxwy39lr3dXRGWA+v55llYp0Lq5Cj8LRDccdAWs6op
   7G3SBZAm7KvOkH81WBSwyPh0OcySONMYXmEu1Z1EEG2pmwyIYqXNMwVgM
   /X965Zd1xYAO8dX8ZoDB5hhOTIV4YJwnE6rTmcKuLgJk80+pY3/pQLKGe
   WoRBGfcFoy2QdU63yZdMkdS9L24BsYGX8G4Wd/YFz3kCFVv5MHiCPQj76
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="281769420"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="281769420"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:08:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="516907953"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Mar 2022 13:08:04 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUwPj-000Dzg-Vv; Thu, 17 Mar 2022 20:08:03 +0000
Date:   Fri, 18 Mar 2022 04:06:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.17-rc6-wip 41/41]
 drivers/iommu/iommufd/device.c:136:77: warning: cast from pointer to integer
 of different size
Message-ID: <202203180421.pQJyHnCm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc6-wip
head:   d883a7e5a78fb9f4d6fc85a0845f95c6613aaade
commit: d883a7e5a78fb9f4d6fc85a0845f95c6613aaade [41/41] Check the below call trace
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220318/202203180421.pQJyHnCm-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/luxis1999/iommufd/commit/d883a7e5a78fb9f4d6fc85a0845f95c6613aaade
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc6-wip
        git checkout d883a7e5a78fb9f4d6fc85a0845f95c6613aaade
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/iommu/iommufd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/iommufd.h:12,
                    from drivers/iommu/iommufd/device.c:4:
   drivers/iommu/iommufd/device.c: In function 'iommufd_device_setup_msi':
>> drivers/iommu/iommufd/device.c:136:77: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     136 |  printk("%s, dev: %s, hwpt->domain: %llx\n", __func__, dev_name(idev->dev), (unsigned long long)hwpt->domain);
         |                                                                             ^
   include/linux/printk.h:418:19: note: in definition of macro 'printk_index_wrap'
     418 |   _p_func(_fmt, ##__VA_ARGS__);    \
         |                   ^~~~~~~~~~~
   drivers/iommu/iommufd/device.c:136:2: note: in expansion of macro 'printk'
     136 |  printk("%s, dev: %s, hwpt->domain: %llx\n", __func__, dev_name(idev->dev), (unsigned long long)hwpt->domain);
         |  ^~~~~~


vim +136 drivers/iommu/iommufd/device.c

   130	
   131	static int iommufd_device_setup_msi(struct iommufd_device *idev,
   132					    struct iommufd_hw_pagetable *hwpt,
   133					    phys_addr_t sw_msi_start,
   134					    unsigned int flags)
   135	{
 > 136		printk("%s, dev: %s, hwpt->domain: %llx\n", __func__, dev_name(idev->dev), (unsigned long long)hwpt->domain);
   137		/*
   138		 * IOMMU_CAP_INTR_REMAP means that the platform is isolating MSI,
   139		 * nothing further to do.
   140		 */
   141		if (iommu_capable(idev->dev->bus, IOMMU_CAP_INTR_REMAP))
   142			return 0;
   143	
   144		printk("%s %d\n", __func__, __LINE__);
   145		/*
   146		 * On ARM systems that set the global IRQ_DOMAIN_FLAG_MSI_REMAP every
   147		 * allocated iommu_domain will block interrupts by default and this
   148		 * special flow is needed to turn them back on.
   149		 */
   150		if (irq_domain_check_msi_remap()) {
   151			if (WARN_ON(!sw_msi_start))
   152				return -EPERM;
   153			return iommu_get_msi_cookie(hwpt->domain, sw_msi_start);
   154		}
   155	
   156		/*
   157		 * Otherwise the platform has a MSI window that is not isolated. For
   158		 * historical compat with VFIO allow a module parameter to ignore the
   159		 * insecurity.
   160		 */
   161		if (!(flags & IOMMUFD_ATTACH_FLAGS_ALLOW_UNSAFE_INTERRUPT))
   162			return -EPERM;
   163		return 0;
   164	}
   165	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

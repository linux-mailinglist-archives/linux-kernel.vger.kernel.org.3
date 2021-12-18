Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C80479A35
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 11:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhLRKVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 05:21:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:20723 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhLRKVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 05:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639822903; x=1671358903;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0MYmWjaeNtxHjdp/ZJ5oNCs0a9L3m5UGEcRQ+TVqY2E=;
  b=cqc2AxEqTdVLdIDsM3SQcTSrE0MZemRPPRyycAXwmM81l8ePVEUuifxN
   cdLUn5v44MFxr3UClBYgmziCUferkjgzjbOCCVE6/myENBLe+xBugtiWF
   22xCMVT5h4yaWvo5oL3jVH4CZ4GXv9zk4ItFlMsxrh1oYJ0gpuBoIHCsa
   YXEnBZ++HVlc1y/28V25xQdtLFvtSeLW/TUljDlWeUjO25oEyMEelFS8T
   V+s5CHzpH1xhCLev3SM8DaG+W97xwARyDIzSWxqLn2MAa9lRNBynm2fd3
   CHtEFKOhFSWDLB2pTX8ZHHpaEcIpIvgxsg6fO/RvfE53C5a81hVTyVDjt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="326201875"
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="326201875"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 02:21:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="465406124"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Dec 2021 02:21:41 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myWqS-0005s0-Jg; Sat, 18 Dec 2021 10:21:40 +0000
Date:   Sat, 18 Dec 2021 18:20:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [hyperv:hyperv-next 4/5] drivers/hv/vmbus_drv.c:2082:29: warning:
 shift count >= width of type
Message-ID: <202112181827.o3X7GmHz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next
head:   19fd7ca00201c0525452dcf5a490e4b01674ef4c
commit: 6327882f7b4a476ea902de4bee5657f1028d6859 [4/5] scsi: storvsc: Add Isolation VM support for storvsc driver
config: x86_64-randconfig-a013-20211216 (https://download.01.org/0day-ci/archive/20211218/202112181827.o3X7GmHz-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 4c9e31a4814592bbda7153833e46728dc7b21100)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?id=6327882f7b4a476ea902de4bee5657f1028d6859
        git remote add hyperv https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
        git fetch --no-tags hyperv hyperv-next
        git checkout 6327882f7b4a476ea902de4bee5657f1028d6859
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/hv/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hv/vmbus_drv.c:2082:29: warning: shift count >= width of type [-Wshift-count-overflow]
   static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
                               ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   1 warning generated.


vim +2082 drivers/hv/vmbus_drv.c

  2081	
> 2082	static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
  2083	/*
  2084	 * vmbus_device_register - Register the child device
  2085	 */
  2086	int vmbus_device_register(struct hv_device *child_device_obj)
  2087	{
  2088		struct kobject *kobj = &child_device_obj->device.kobj;
  2089		int ret;
  2090	
  2091		dev_set_name(&child_device_obj->device, "%pUl",
  2092			     &child_device_obj->channel->offermsg.offer.if_instance);
  2093	
  2094		child_device_obj->device.bus = &hv_bus;
  2095		child_device_obj->device.parent = &hv_acpi_dev->dev;
  2096		child_device_obj->device.release = vmbus_device_release;
  2097	
  2098		/*
  2099		 * Register with the LDM. This will kick off the driver/device
  2100		 * binding...which will eventually call vmbus_match() and vmbus_probe()
  2101		 */
  2102		ret = device_register(&child_device_obj->device);
  2103		if (ret) {
  2104			pr_err("Unable to register child device\n");
  2105			return ret;
  2106		}
  2107	
  2108		child_device_obj->channels_kset = kset_create_and_add("channels",
  2109								      NULL, kobj);
  2110		if (!child_device_obj->channels_kset) {
  2111			ret = -ENOMEM;
  2112			goto err_dev_unregister;
  2113		}
  2114	
  2115		ret = vmbus_add_channel_kobj(child_device_obj,
  2116					     child_device_obj->channel);
  2117		if (ret) {
  2118			pr_err("Unable to register primary channeln");
  2119			goto err_kset_unregister;
  2120		}
  2121		hv_debug_add_dev_dir(child_device_obj);
  2122	
  2123		child_device_obj->device.dma_mask = &vmbus_dma_mask;
  2124		child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
  2125		return 0;
  2126	
  2127	err_kset_unregister:
  2128		kset_unregister(child_device_obj->channels_kset);
  2129	
  2130	err_dev_unregister:
  2131		device_unregister(&child_device_obj->device);
  2132		return ret;
  2133	}
  2134	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

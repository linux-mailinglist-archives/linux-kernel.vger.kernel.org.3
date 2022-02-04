Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600EB4A9C30
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359822AbiBDPqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:46:34 -0500
Received: from mga07.intel.com ([134.134.136.100]:37832 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230391AbiBDPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643989593; x=1675525593;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=04krOM/xHlc6HK9Mk9Mxm4vXikFJwsBjtHm5I6m5L7g=;
  b=gxofPuN/qmruAnzmwHrOsmcHFdrqu+tZa644ULzqsQdLa3n1KLvnRIVl
   Ii1bD5ZfvjM1DoOC4IpUo+5JaMFe7B0yYSzBJNKgJ8modn/juh82y2JaK
   W7iMvP02nk9LBNvjmxBFmR7U0t4Q4xT79LHmDDehZ1lXzto4z7UHSdVqe
   reJktT6/rf5xF/vSC4Su1tNNrlJ+h8Hk+hNWoaWiaD0ujISyAss+1GE/j
   yfOTdaZioY58/Cdg8CBXbVBVviJYeN/n1MgbdlMhjLFEZPcq6jE247/Ss
   NqJQ1BntCMgGnz+oqNtlfCYRt6rKQm3RVjumXibGc6w+6vVT85S9Xq5RO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="311689521"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="311689521"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 07:46:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="769985996"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 04 Feb 2022 07:46:31 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nG0n9-000Xou-AV; Fri, 04 Feb 2022 15:46:31 +0000
Date:   Fri, 4 Feb 2022 23:46:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:smc/work 9/11] drivers/platform/apple/smc_core.c:135:1:
 error: expected ';' before 'struct'
Message-ID: <202202042319.XtC6P0wx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux smc/work
head:   fc848a39b71518ca1661de7057b87cb0e8cac9f9
commit: a429c9bbeba2b08856339793bd4a0d1a65a730a1 [9/11] platform/apple: Add new Apple Mac SMC driver
config: arm64-randconfig-r024-20220130 (https://download.01.org/0day-ci/archive/20220204/202202042319.XtC6P0wx-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/a429c9bbeba2b08856339793bd4a0d1a65a730a1
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux smc/work
        git checkout a429c9bbeba2b08856339793bd4a0d1a65a730a1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/platform/apple/smc_core.c:135:1: error: expected ';' before 'struct'
     135 | struct apple_smc *apple_smc_probe(struct device *dev, const struct apple_smc_backend_ops *ops, void *cookie)
         | ^~~~~~
   drivers/platform/apple/smc_core.c:25:30: warning: 'apple_smc_devs' defined but not used [-Wunused-const-variable=]
      25 | static const struct mfd_cell apple_smc_devs[] = {
         |                              ^~~~~~~~~~~~~~


vim +135 drivers/platform/apple/smc_core.c

   134	
 > 135	struct apple_smc *apple_smc_probe(struct device *dev, const struct apple_smc_backend_ops *ops, void *cookie)
   136	{
   137		struct apple_smc *smc;
   138		u32 count;
   139		int ret;
   140	
   141		smc = devm_kzalloc(dev, sizeof(*smc), GFP_KERNEL);
   142		if (!smc)
   143			return ERR_PTR(-ENOMEM);
   144	
   145		smc->dev = dev;
   146		smc->be_cookie = cookie;
   147		smc->be = ops;
   148		mutex_init(&smc->mutex);
   149	
   150		ret = apple_smc_read_u32(smc, SMC_KEY(#KEY), &count);
   151		if (ret)
   152			return ERR_PTR(dev_err_probe(dev, ret, "Failed to get key count"));
   153		smc->key_count = be32_to_cpu(count);
   154	
   155		ret = apple_smc_get_key_by_index(smc, 0, &smc->first_key);
   156		if (ret)
   157			return ERR_PTR(dev_err_probe(dev, ret, "Failed to get first key"));
   158	
   159		ret = apple_smc_get_key_by_index(smc, smc->key_count - 1, &smc->last_key);
   160		if (ret)
   161			return ERR_PTR(dev_err_probe(dev, ret, "Failed to get last key"));
   162	
   163		dev_info(dev, "Initialized (%d keys %p4ch..%p4ch)\n",
   164			 smc->key_count, &smc->first_key, &smc->last_key);
   165	
   166		dev_set_drvdata(dev, smc);
   167	
   168		ret = mfd_add_devices(dev, -1, apple_smc_devs, ARRAY_SIZE(apple_smc_devs), NULL, 0, NULL);
   169		if (ret)
   170			return ERR_PTR(dev_err_probe(dev, ret, "Subdevice initialization failed"));
   171	
   172		return smc;
   173	}
   174	EXPORT_SYMBOL(apple_smc_probe);
   175	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

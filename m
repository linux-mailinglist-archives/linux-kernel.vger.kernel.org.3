Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7447502D0E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355780AbiDOPji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355798AbiDOPhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:37:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548C09E9FF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650036855; x=1681572855;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qdg2petk+soq0HdicT5JUNfEl4DJ5673ftDQCa4sp94=;
  b=iDUd5qzAxzRD3kE9y7MdpJkYAU6et9XwdYWwLOIBr38+B8wljoeiHw7p
   EmXjFb6QD0+P2HVCAKpjwxfgDnVR7hI6XERhs4jqFn4WuBPBYfTn+tceH
   QyjDbLO+XekOW5vykpJpNHVhJj7oW5lwlUZOtAQdWekfGR+F50FQwRUSi
   xcdkWSS7/2xSSE1aBQfdTV/XnOJE75R4eMUKAI7WXMYKZzp+oQzjU/QmW
   WT+i/X9iATJgoNHSayXzS7ZCvC8GE3xHZgAm/dqq5ySV84D9VDe9bR6vW
   vA7gox0V4DxL8SE8bFlj3NHuJsrA2vCJ1wl9FEWmJnCJu/dTsv8BV2pIp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="245055714"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="245055714"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 08:34:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="508973300"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Apr 2022 08:34:13 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfNxd-000261-6V;
        Fri, 15 Apr 2022 15:34:13 +0000
Date:   Fri, 15 Apr 2022 23:33:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jgunthorpe:vfio_kvm_no_group 2/11]
 arch/x86/kvm/../../../virt/kvm/vfio.c:356:58: warning: cast to pointer from
 integer of different size
Message-ID: <202204152347.iVwF28RC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux vfio_kvm_no_group
head:   0a779a04652d97c98d71a1538a37f89145dba9ed
commit: c068aae365aaf0ecde7abf0842298c59d7ed0d9c [2/11] kvm/vfio: Reduce the scope of PPC #ifdefs
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220415/202204152347.iVwF28RC-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/jgunthorpe/linux/commit/c068aae365aaf0ecde7abf0842298c59d7ed0d9c
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe vfio_kvm_no_group
        git checkout c068aae365aaf0ecde7abf0842298c59d7ed0d9c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/kvm/../../../virt/kvm/vfio.c: In function 'kvm_vfio_set_group':
>> arch/x86/kvm/../../../virt/kvm/vfio.c:356:58: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     356 |                 return kvm_vfio_group_set_spapr_tce(dev, (void __user *)arg);
         |                                                          ^


vim +356 arch/x86/kvm/../../../virt/kvm/vfio.c

26d16e3ba7292b Jason Gunthorpe 2022-03-30  338  
26d16e3ba7292b Jason Gunthorpe 2022-03-30  339  static int kvm_vfio_set_group(struct kvm_device *dev, long attr, u64 arg)
26d16e3ba7292b Jason Gunthorpe 2022-03-30  340  {
26d16e3ba7292b Jason Gunthorpe 2022-03-30  341  	int32_t __user *argp = (int32_t __user *)(unsigned long)arg;
26d16e3ba7292b Jason Gunthorpe 2022-03-30  342  	int32_t fd;
26d16e3ba7292b Jason Gunthorpe 2022-03-30  343  
26d16e3ba7292b Jason Gunthorpe 2022-03-30  344  	switch (attr) {
26d16e3ba7292b Jason Gunthorpe 2022-03-30  345  	case KVM_DEV_VFIO_GROUP_ADD:
26d16e3ba7292b Jason Gunthorpe 2022-03-30  346  		if (get_user(fd, argp))
26d16e3ba7292b Jason Gunthorpe 2022-03-30  347  			return -EFAULT;
26d16e3ba7292b Jason Gunthorpe 2022-03-30  348  		return kvm_vfio_group_add(dev, fd);
26d16e3ba7292b Jason Gunthorpe 2022-03-30  349  
26d16e3ba7292b Jason Gunthorpe 2022-03-30  350  	case KVM_DEV_VFIO_GROUP_DEL:
26d16e3ba7292b Jason Gunthorpe 2022-03-30  351  		if (get_user(fd, argp))
26d16e3ba7292b Jason Gunthorpe 2022-03-30  352  			return -EFAULT;
26d16e3ba7292b Jason Gunthorpe 2022-03-30  353  		return kvm_vfio_group_del(dev, fd);
26d16e3ba7292b Jason Gunthorpe 2022-03-30  354  
26d16e3ba7292b Jason Gunthorpe 2022-03-30  355  	case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE:
26d16e3ba7292b Jason Gunthorpe 2022-03-30 @356  		return kvm_vfio_group_set_spapr_tce(dev, (void __user *)arg);
ec53500fae421e Alex Williamson 2013-10-30  357  	}
ec53500fae421e Alex Williamson 2013-10-30  358  
ec53500fae421e Alex Williamson 2013-10-30  359  	return -ENXIO;
ec53500fae421e Alex Williamson 2013-10-30  360  }
ec53500fae421e Alex Williamson 2013-10-30  361  

:::::: The code at line 356 was first introduced by commit
:::::: 26d16e3ba7292b7fce26d25a2ba8f44b8c28ffe3 kvm/vfio: Move KVM_DEV_VFIO_GROUP_* ioctls into functions

:::::: TO: Jason Gunthorpe <jgg@nvidia.com>
:::::: CC: Jason Gunthorpe <jgg@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

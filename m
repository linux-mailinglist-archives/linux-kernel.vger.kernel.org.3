Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FD2502F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 22:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351248AbiDOUMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 16:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351512AbiDOUMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 16:12:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C25E13D19
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 13:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650053373; x=1681589373;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0ttQiJt1wYBwYCOZIqR6JxxJqq6DPU7ZtHlhxqY2iRE=;
  b=looe6i9sbA/7FqETt+iBvF99Kk9LiHHh94JSOUIgcsOhlN0qYjZJGttl
   Onem4dvJzplFGKK9Il6tOQwnTumIl1le2BkrL20J5dInd+hv0NVldZg3J
   oZ1CIZn3Ww0CWkUjw3DCDTxPa6cLMSmp1Tv9AZwNnJDJEovP4mW6QtH0s
   VNmrIxnDGsQ32rSISSIDAecWb13erdhIPORCceoY6TZz39O4VsBKmrN0Y
   Xk/WKRMGKsz+qOPx4io7V6MCSOhYIPq7KqMG6q3YQ46qQQexrQJU14G0m
   d2JgrtqfpnlIVpL4tuPc2YGb5dTHC5X5m0kjtSSZP+C29+xRcinNM003t
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="262079163"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="262079163"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 13:09:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="803626787"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 15 Apr 2022 13:09:31 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfSG3-0002MU-9v;
        Fri, 15 Apr 2022 20:09:31 +0000
Date:   Sat, 16 Apr 2022 04:08:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jgunthorpe:vfio_kvm_no_group 2/11]
 arch/powerpc/kvm/../../../virt/kvm/vfio.c:356:58: error: cast to pointer
 from integer of different size
Message-ID: <202204160410.A4xlb0e3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux vfio_kvm_no_group
head:   0a779a04652d97c98d71a1538a37f89145dba9ed
commit: c068aae365aaf0ecde7abf0842298c59d7ed0d9c [2/11] kvm/vfio: Reduce the scope of PPC #ifdefs
config: powerpc-randconfig-c003-20220414 (https://download.01.org/0day-ci/archive/20220416/202204160410.A4xlb0e3-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jgunthorpe/linux/commit/c068aae365aaf0ecde7abf0842298c59d7ed0d9c
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe vfio_kvm_no_group
        git checkout c068aae365aaf0ecde7abf0842298c59d7ed0d9c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/powerpc/kvm/../../../virt/kvm/vfio.c: In function 'kvm_vfio_set_group':
>> arch/powerpc/kvm/../../../virt/kvm/vfio.c:356:58: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
     356 |                 return kvm_vfio_group_set_spapr_tce(dev, (void __user *)arg);
         |                                                          ^
   cc1: all warnings being treated as errors


vim +356 arch/powerpc/kvm/../../../virt/kvm/vfio.c

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

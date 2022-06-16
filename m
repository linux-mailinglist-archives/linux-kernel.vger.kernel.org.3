Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1FD54E585
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377548AbiFPPAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377533AbiFPPAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:00:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169EC3D1E1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655391606; x=1686927606;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8VFBWLEjdh2vm4DugxGzcZthkVfAhjug4/uks535WYE=;
  b=X8adP5MZ8RXB4pDEvd9uY605SHeUauuQQuW0RHwda0po6h3Zn0Yjr0VF
   s/N66F/Hbit7KX+k/gJiXd1NP8ZiiwL/rBNPsD/uMYByvnNZWNw9B+KW0
   gWo79wH8739/L2dgmE27xsO2BfmSq1uq58uWHrjQwZsgjQLYBNXjZ7dSM
   q0vh8v8HAWH5JrrqOiJPBoUXX4C+uktmta6vUtxUv362egI37VlkLTWdL
   KJvXaev3yQx1h7WyMVgA4zGp6v/TGG2zpgFP2dqy1Of++F50QpBkJNgg9
   FHyh5rtZkzCRfb6Qzs7kFJEoikHOtZzlGoW9C9Vp9eu//QAan/tPwNZgp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="278061784"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="278061784"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 08:00:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="713386547"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Jun 2022 08:00:03 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1qyZ-000OTh-4C;
        Thu, 16 Jun 2022 15:00:03 +0000
Date:   Thu, 16 Jun 2022 22:59:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: include/linux/intel-iommu.h:531:28: error: use of undeclared
 identifier 'CONFIG_DMAR_UNITS_SUPPORTED'
Message-ID: <202206162251.cVdwcud4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220616-024802/Steve-Wahl/iommu-vt-d-Increase-DMAR_UNITS_SUPPORTED/20220506-035321
head:   3e005e10e4d8627a55a987d047c19dba233ba66b
commit: 3e005e10e4d8627a55a987d047c19dba233ba66b iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
date:   20 hours ago
config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220616/202206162251.cVdwcud4-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f0e608de27b3d568000046eebf3712ab542979d6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3e005e10e4d8627a55a987d047c19dba233ba66b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220616-024802/Steve-Wahl/iommu-vt-d-Increase-DMAR_UNITS_SUPPORTED/20220506-035321
        git checkout 3e005e10e4d8627a55a987d047c19dba233ba66b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/kvm/x86.c:44:
>> include/linux/intel-iommu.h:531:28: error: use of undeclared identifier 'CONFIG_DMAR_UNITS_SUPPORTED'
           unsigned int iommu_refcnt[DMAR_UNITS_SUPPORTED];
                                     ^
   include/linux/dmar.h:21:30: note: expanded from macro 'DMAR_UNITS_SUPPORTED'
   #define DMAR_UNITS_SUPPORTED    CONFIG_DMAR_UNITS_SUPPORTED
                                   ^
   In file included from arch/x86/kvm/x86.c:44:
   include/linux/intel-iommu.h:535:17: error: use of undeclared identifier 'CONFIG_DMAR_UNITS_SUPPORTED'
           u16             iommu_did[DMAR_UNITS_SUPPORTED];
                                     ^
   include/linux/dmar.h:21:30: note: expanded from macro 'DMAR_UNITS_SUPPORTED'
   #define DMAR_UNITS_SUPPORTED    CONFIG_DMAR_UNITS_SUPPORTED
                                   ^
   2 errors generated.


vim +/CONFIG_DMAR_UNITS_SUPPORTED +531 include/linux/intel-iommu.h

b0d1f8741b8123 Jacob Pan       2020-05-16  527  
9ddbfb42138d84 Lu Baolu        2018-07-14  528  struct dmar_domain {
9ddbfb42138d84 Lu Baolu        2018-07-14  529  	int	nid;			/* node id */
9ddbfb42138d84 Lu Baolu        2018-07-14  530  
9739ba327c01e2 Parav Pandit    2021-06-10 @531  	unsigned int iommu_refcnt[DMAR_UNITS_SUPPORTED];
9ddbfb42138d84 Lu Baolu        2018-07-14  532  					/* Refcount of devices per iommu */
9ddbfb42138d84 Lu Baolu        2018-07-14  533  
9ddbfb42138d84 Lu Baolu        2018-07-14  534  
9ddbfb42138d84 Lu Baolu        2018-07-14  535  	u16		iommu_did[DMAR_UNITS_SUPPORTED];
9ddbfb42138d84 Lu Baolu        2018-07-14  536  					/* Domain ids per IOMMU. Use u16 since
9ddbfb42138d84 Lu Baolu        2018-07-14  537  					 * domain ids are 16 bit wide according
9ddbfb42138d84 Lu Baolu        2018-07-14  538  					 * to VT-d spec, section 9.3 */
9ddbfb42138d84 Lu Baolu        2018-07-14  539  
1f106ff0ea2782 Parav Pandit    2021-06-10  540  	u8 has_iotlb_device: 1;
1f106ff0ea2782 Parav Pandit    2021-06-10  541  	u8 iommu_coherency: 1;		/* indicate coherency of iommu access */
6043257b1de069 Jason Gunthorpe 2022-04-11  542  	u8 force_snooping : 1;		/* Create IOPTEs with snoop control */
1f106ff0ea2782 Parav Pandit    2021-06-10  543  
9ddbfb42138d84 Lu Baolu        2018-07-14  544  	struct list_head devices;	/* all devices' list */
9ddbfb42138d84 Lu Baolu        2018-07-14  545  	struct iova_domain iovad;	/* iova's that belong to this domain */
9ddbfb42138d84 Lu Baolu        2018-07-14  546  
9ddbfb42138d84 Lu Baolu        2018-07-14  547  	struct dma_pte	*pgd;		/* virtual address */
9ddbfb42138d84 Lu Baolu        2018-07-14  548  	int		gaw;		/* max guest address width */
9ddbfb42138d84 Lu Baolu        2018-07-14  549  
9ddbfb42138d84 Lu Baolu        2018-07-14  550  	/* adjusted guest address width, 0 is level 2 30-bit */
9ddbfb42138d84 Lu Baolu        2018-07-14  551  	int		agaw;
9ddbfb42138d84 Lu Baolu        2018-07-14  552  
9ddbfb42138d84 Lu Baolu        2018-07-14  553  	int		flags;		/* flags to find out type of domain */
9ddbfb42138d84 Lu Baolu        2018-07-14  554  	int		iommu_superpage;/* Level of superpages supported:
9ddbfb42138d84 Lu Baolu        2018-07-14  555  					   0 == 4KiB (no superpages), 1 == 2MiB,
9ddbfb42138d84 Lu Baolu        2018-07-14  556  					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
9ddbfb42138d84 Lu Baolu        2018-07-14  557  	u64		max_addr;	/* maximum mapped address */
9ddbfb42138d84 Lu Baolu        2018-07-14  558  
9ddbfb42138d84 Lu Baolu        2018-07-14  559  	struct iommu_domain domain;	/* generic domain data structure for
9ddbfb42138d84 Lu Baolu        2018-07-14  560  					   iommu core */
9ddbfb42138d84 Lu Baolu        2018-07-14  561  };
9ddbfb42138d84 Lu Baolu        2018-07-14  562  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

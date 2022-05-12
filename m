Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE1252568C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358458AbiELUvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348349AbiELUu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:50:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D3524950
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652388652; x=1683924652;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ir3jumVTPsEtVAlCCzru3GvFR8Ccn6TVtNrXTCoC+2M=;
  b=J/4M+Gvm+V04f8tD9UeVkI9p0/KdrNvlrTFn+fdOUwXxbd9bs2d32sTT
   6xR9yWZcEaqYPZicrWvoKPKI7JcZb8h5phDV+AdN+3V/fILWHFnA/E1yO
   q5NRPNmPKQA1qTii3nYOFgfIueSDyknVi3h23+4Ipcbx3DTSCSlgerHUQ
   Rbmbtm/sMRasP5fKE1VLyiRe2Ef5aX8hNYOUET54lQIvhLW6MN8SM3t1O
   8uz1R1bluLRKlJzJDk74DmS2RmDir71mPPKhwqV0Bjr8O8K7Sfnrw9phV
   0ewK2+yej1a9EFAqhoOTZKlXi1VI6rbK8QgP0ROB4w14NsCPEs8YJZ7km
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="268969463"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="268969463"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 13:50:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="603546303"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 May 2022 13:50:50 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npFlp-000Kue-Kb;
        Thu, 12 May 2022 20:50:49 +0000
Date:   Fri, 13 May 2022 04:50:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: include/linux/intel-iommu.h:531:28: error: use of undeclared
 identifier 'CONFIG_DMAR_UNITS_SUPPORTED'
Message-ID: <202205130438.4S9ZxIkJ-lkp@intel.com>
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

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220512-231415/Steve-Wahl/iommu-vt-d-Increase-DMAR_UNITS_SUPPORTED/20220506-035321
head:   70fc6f8ca45b69a710b82d38ef61ac43a73fef24
commit: 70fc6f8ca45b69a710b82d38ef61ac43a73fef24 iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
date:   5 hours ago
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220513/202205130438.4S9ZxIkJ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9519dacab7b8afd537811fc2abaceb4d14f4e16a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/70fc6f8ca45b69a710b82d38ef61ac43a73fef24
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220512-231415/Steve-Wahl/iommu-vt-d-Increase-DMAR_UNITS_SUPPORTED/20220506-035321
        git checkout 70fc6f8ca45b69a710b82d38ef61ac43a73fef24
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/char/agp/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/char/agp/intel-gtt.c:23:
>> include/linux/intel-iommu.h:531:28: error: use of undeclared identifier 'CONFIG_DMAR_UNITS_SUPPORTED'
           unsigned int iommu_refcnt[DMAR_UNITS_SUPPORTED];
                                     ^
   include/linux/dmar.h:21:30: note: expanded from macro 'DMAR_UNITS_SUPPORTED'
   #define DMAR_UNITS_SUPPORTED    CONFIG_DMAR_UNITS_SUPPORTED
                                   ^
   In file included from drivers/char/agp/intel-gtt.c:23:
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

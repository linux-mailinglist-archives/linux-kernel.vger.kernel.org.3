Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6905256DD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358637AbiELVK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbiELVK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:10:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBA33B01C
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652389855; x=1683925855;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ngM5MW6Uypp14d3Hp2UmVsui82daPLdUFpkqWIqZkMM=;
  b=b8r8stqlES+PQ2KZQ2O3v8r/GbaNpeDjUT+2l/c9htYMtV6t5oDD7vav
   Zu1oxbzTeULGwEhIvtL1yWDcyggTgxfC3UX4KBsunKKM8ZJ0Uk+EwDPEu
   FSKan+t6yqtO8XYZgEUs2Qmf3hOFVERaYrg8yMF//LgKB/3T+KXyhGJg6
   QmmsjcxeuF+e4PFleG5vJFpUsYG4TplkUs5y54D2CS2JtlAwm73nTFSWq
   2MDo9rxp6+pIu2wSkkcA3qF48ET5lhirSXExVl2MJwtLYgu74NiO7fNbH
   Ww7SfCZKtiX46JZ8X7lB3VvZQI7UZaj4YtpBqUSjFfNVRzJ+KDeFIyTkq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="250039282"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="250039282"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 14:10:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="572695003"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 May 2022 14:10:52 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npG5D-000Kwa-V9;
        Thu, 12 May 2022 21:10:51 +0000
Date:   Fri, 13 May 2022 05:10:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: include/linux/dmar.h:21:33: error: 'CONFIG_DMAR_UNITS_SUPPORTED'
 undeclared here (not in a function); did you mean 'DMAR_UNITS_SUPPORTED'?
Message-ID: <202205130506.HnFWEJtK-lkp@intel.com>
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

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220512-231415/Steve-Wahl/iommu-vt-d-Increase-DMAR_UNITS_SUPPORTED/20220506-035321
head:   70fc6f8ca45b69a710b82d38ef61ac43a73fef24
commit: 70fc6f8ca45b69a710b82d38ef61ac43a73fef24 iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
date:   6 hours ago
config: x86_64-randconfig-a002 (https://download.01.org/0day-ci/archive/20220513/202205130506.HnFWEJtK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/70fc6f8ca45b69a710b82d38ef61ac43a73fef24
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220512-231415/Steve-Wahl/iommu-vt-d-Increase-DMAR_UNITS_SUPPORTED/20220506-035321
        git checkout 70fc6f8ca45b69a710b82d38ef61ac43a73fef24
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/intel-iommu.h:21,
                    from arch/x86/kvm/x86.c:44:
>> include/linux/dmar.h:21:33: error: 'CONFIG_DMAR_UNITS_SUPPORTED' undeclared here (not in a function); did you mean 'DMAR_UNITS_SUPPORTED'?
      21 | #define DMAR_UNITS_SUPPORTED    CONFIG_DMAR_UNITS_SUPPORTED
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/intel-iommu.h:531:35: note: in expansion of macro 'DMAR_UNITS_SUPPORTED'
     531 |         unsigned int iommu_refcnt[DMAR_UNITS_SUPPORTED];
         |                                   ^~~~~~~~~~~~~~~~~~~~


vim +21 include/linux/dmar.h

    20	
  > 21	#define	DMAR_UNITS_SUPPORTED	CONFIG_DMAR_UNITS_SUPPORTED
    22	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

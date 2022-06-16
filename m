Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC3654E635
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377977AbiFPPlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiFPPlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:41:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF9637030
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655394066; x=1686930066;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PKdrXrAzjIvDU1Ic1yRpuUEl06zvIKU558SCZYtshoI=;
  b=YeyRJMiHMMWJFKYS9T8hcPLDib4rAZeoxYsFHpvCXeIlTLgY1P5FwcaM
   NGiE1yRIWUJSmms7HnUEKkJX1f1TTwlZpl6PK/EZyG5LVxHQiZ+5sQrjI
   v77LUkGak63TUFq9JAlTD0cw9hLsafKB0C9FfaDeaKnT0AggGZA4uf4Rh
   asJR7oq7oamxACr5mVBTpx62KhsSMvzEf4dkgVxK9qJFfe8AWXfwZoSv3
   KBlxY8RhQCPrX3SFaYhMLlxNZ3VUYY3kvJedn3WqW0DummhF3L9R6WAoN
   cjTXltWlAhha5gUpviE9tHYEIqLie1a90cmEW3k/xE1Jofv0TcWf9DJ+a
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="276852103"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="276852103"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 08:41:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="589696319"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2022 08:41:04 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1rcG-000OVN-7l;
        Thu, 16 Jun 2022 15:41:04 +0000
Date:   Thu, 16 Jun 2022 23:40:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>, Kevin Tian <kevin.tian@intel.com>
Subject: include/linux/dmar.h:21:33: error: 'CONFIG_DMAR_UNITS_SUPPORTED'
 undeclared here (not in a function); did you mean 'DMAR_UNITS_SUPPORTED'?
Message-ID: <202206162309.0IdGIck1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220616-024802/Steve-Wahl/iommu-vt-d-Increase-DMAR_UNITS_SUPPORTED/20220506-035321
head:   3e005e10e4d8627a55a987d047c19dba233ba66b
commit: 3e005e10e4d8627a55a987d047c19dba233ba66b iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
date:   21 hours ago
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220616/202206162309.0IdGIck1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/3e005e10e4d8627a55a987d047c19dba233ba66b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220616-024802/Steve-Wahl/iommu-vt-d-Increase-DMAR_UNITS_SUPPORTED/20220506-035321
        git checkout 3e005e10e4d8627a55a987d047c19dba233ba66b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/intel-iommu.h:21,
                    from drivers/char/agp/intel-gtt.c:23:
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0523A4DD252
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiCRBQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiCRBQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:16:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A102976D2;
        Thu, 17 Mar 2022 18:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647566112; x=1679102112;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r4mko7k/AH0w7KPMrUblI0WhnZhFqX+FTI9+xnVZOhU=;
  b=WE3CBC/pVAuEceMZUnC+56vh8kVjnIyfitObrZY2qj8B17l46Y99hKGK
   AbKDiHX0wsiR+229Ag0+FFl9KLRgTg4IPb16jcQ7l3jtMcXe/AhXrE3cr
   g+DSB/0K1V6XgzXsnP9fZpbVp5IpPjgqh/LFbLnvdOSncohA/jy8sSL7q
   nMRL/imT7vuEWDOo0+BiMtT65o/R35sLy8CrOIYRYIsKgW30oyoMx0mKt
   49U7aBFHAA3EDIHC5qwIrIH89DwL4wrBw0RfhcBcfpybWC19HO6RiQby8
   1Bn0DxQPwUpOJ+pE6D091/yma2aVRPq7HCmWyL0E8J8RfvoIQvQylQNK/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="281823266"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="281823266"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 18:15:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="715255613"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Mar 2022 18:15:10 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nV1Cv-000EIn-Sy; Fri, 18 Mar 2022 01:15:09 +0000
Date:   Fri, 18 Mar 2022 09:14:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>, linux-doc@vger.kernel.org
Subject: [jgunthorpe:iommufd 2/13] htmldocs:
 Documentation/userspace-api/iommufd.rst:55: (SEVERE/4) Unexpected section
 title or transition.
Message-ID: <202203180943.vNNAWkZa-lkp@intel.com>
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

tree:   https://github.com/jgunthorpe/linux iommufd
head:   0ecea195175b25f110f9e0c66c94c5d00751a6ec
commit: a33afc78a9c19bc4e34f21acc8b521f125a0825f [2/13] iommufd: Overview documentation
reproduce: make htmldocs

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Documentation/userspace-api/iommufd.rst:55: (SEVERE/4) Unexpected section title or transition.

vim +55 Documentation/userspace-api/iommufd.rst

    54	
  > 55	  _________________________________________________________
    56	 |                         iommufd                         |
    57	 |       [1]                                               |
    58	 |  _________________                                      |
    59	 | |                 |                                     |
    60	 | |                 |                                     |
    61	 | |                 |                                     |
    62	 | |                 |                                     |
    63	 | |                 |                                     |
    64	 | |                 |                                     |
    65	 | |                 |        [3]                 [2]      |
    66	 | |                 |    ____________         __________  |
    67	 | |      IOAS       |<--|            |<------|          | |
    68	 | |                 |   |HW_PAGETABLE|       |  DEVICE  | |
    69	 | |                 |   |____________|       |__________| |
    70	 | |                 |         |                   |       |
    71	 | |                 |         |                   |       |
    72	 | |                 |         |                   |       |
    73	 | |                 |         |                   |       |
    74	 | |                 |         |                   |       |
    75	 | |_________________|         |                   |       |
    76	 |         |                   |                   |       |
    77	 |_________|___________________|___________________|_______|
    78	           |                   |                   |
    79	           |              _____v______      _______v_____
    80	           | PFN storage |            |    |             |
    81	           |------------>|iommu_domain|    |struct device|
    82	                         |____________|    |_____________|
    83	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

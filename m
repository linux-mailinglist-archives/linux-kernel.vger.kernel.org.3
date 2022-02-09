Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022624AF70A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbiBIQl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiBIQl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:41:56 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC42C05CB82
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644424918; x=1675960918;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YOISPTTlwEqXpujhvpjUN0jt6et1qe7wYrQ9UFNFp/M=;
  b=OIc46HZiQQUeIXAxY+Y0Y+RDijsIapBm4BrmDxS4J3/mLNsIayyk/pl+
   DTPOP6yykAPFLTweB+K/TLh+gpIZnN5SdhisyGw6Pd1385tHobjgTOZ/s
   3w52hl9E+2EhgMNBQxDHFAghNJyhm5aIjGyNOND0qzMRP2inUx0msamCN
   QfdXuI+tKu9et71KYhJSnWMxT1rlhLxRYlBMAs/xuGQcPZYZ+9aK99R07
   Cc0MPufwOhSPrdADJUehXwfxzngHLNZPMUx/ync04EYN//x+S136pixlN
   9kUMM15GaKtV1ASuMJj0dN+angqztwQOkjZnaBW2dIpdmkd0iifXLdEMZ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229215540"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="229215540"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 08:41:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="633275722"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Feb 2022 08:41:56 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHq2V-00023L-Rp; Wed, 09 Feb 2022 16:41:55 +0000
Date:   Thu, 10 Feb 2022 00:41:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.17-rc1 23/28]
 include/linux/iommufd.h:30:1: error: expected identifier or '(' before '{'
 token
Message-ID: <202202100016.xxWqSxcW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc1
head:   ebf68af0385d0d5c209e63e8065d31db938275d8
commit: 68a771c26362267465beafd67fabe1e751604493 [23/28] vfio/pci: Add VFIO_DEVICE_ATTACH_IOASPT
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220210/202202100016.xxWqSxcW-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/luxis1999/iommufd/commit/68a771c26362267465beafd67fabe1e751604493
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc1
        git checkout 68a771c26362267465beafd67fabe1e751604493
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/vfio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/vfio/vfio.c:35:
>> include/linux/iommufd.h:30:1: error: expected identifier or '(' before '{' token
      30 | {
         | ^
   include/linux/iommufd.h:29:1: warning: 'iommufd_bind_pci_device' declared 'static' but never defined [-Wunused-function]
      29 | iommufd_bind_pci_device(int fd, struct pci_dev *pdev, u32 *id);
         | ^~~~~~~~~~~~~~~~~~~~~~~


vim +30 include/linux/iommufd.h

faffab36f0032f0 Jason Gunthorpe 2021-11-11  26  
faffab36f0032f0 Jason Gunthorpe 2021-11-11  27  #else /* !CONFIG_IOMMUFD */
faffab36f0032f0 Jason Gunthorpe 2021-11-11  28  static inline struct iommufd_device *
faffab36f0032f0 Jason Gunthorpe 2021-11-11  29  iommufd_bind_pci_device(int fd, struct pci_dev *pdev, u32 *id);
faffab36f0032f0 Jason Gunthorpe 2021-11-11 @30  {
faffab36f0032f0 Jason Gunthorpe 2021-11-11  31  	return ERR_PTR(-EOPNOTSUPP);
faffab36f0032f0 Jason Gunthorpe 2021-11-11  32  }
faffab36f0032f0 Jason Gunthorpe 2021-11-11  33  

:::::: The code at line 30 was first introduced by commit
:::::: faffab36f0032f06ff2478067840ead66e38b543 iommufd: Add kAPI toward external drivers

:::::: TO: Jason Gunthorpe <jgg@nvidia.com>
:::::: CC: Jason Gunthorpe <jgg@nvidia.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

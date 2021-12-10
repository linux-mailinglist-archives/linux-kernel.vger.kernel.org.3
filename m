Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C94D470A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242378AbhLJTjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:39:54 -0500
Received: from mga09.intel.com ([134.134.136.24]:49038 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242268AbhLJTjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639164978; x=1670700978;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YMVjjPxE6ZNOSlhpmtJyudPFTyzfXcrqNcNMyIhXu98=;
  b=f8jaYoTSWJXAGwfFAX7b7hY2mB85qqSl0xfb7TW9O8kXcqOvmTjP1OYb
   6t+d04xQGGfLhgQf8c/OB8fe1rd11iRGI2YjOx6aObagm/XHkD1KiKTgx
   1sN8OK7e4UficNazByI/BH02mzZyvBNwIMmTWCydPWE0haiul2vsFzaPX
   /mgJL/aAXWAsndXWqnVi49VjU8uxu+SiY3rhnd0RTUf9GEHDq+Zjqe2D0
   U5hB9MKbvxkHmPNQ7eCHCWT/Js9Kn+YVOtnPT6cXXL9XzCGti4fmAUofH
   64JZjZnIYJaC4sHqPYkFtp4bZzhi76sKd77knmfrIWKptXGSjp8D/xbGt
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="238229272"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="238229272"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 11:36:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="463782854"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Dec 2021 11:36:16 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvlgm-0003cA-2l; Fri, 10 Dec 2021 19:36:16 +0000
Date:   Sat, 11 Dec 2021 03:35:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.16-rc3 31/33] ERROR: modpost:
 "interval_tree_remove" [drivers/iommu/iommufd/iommufd.ko] undefined!
Message-ID: <202112110341.e23ozuyj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.16-rc3
head:   44f89b130eec28760e6b655facd4be49c5bcc3f9
commit: 74814fdbefe2fb370111a0ce00641c64376447cb [31/33] vfio/pci: Add bind_iommufd() support
config: x86_64-randconfig-a001-20211210 (https://download.01.org/0day-ci/archive/20211211/202112110341.e23ozuyj-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/luxis1999/iommufd/commit/74814fdbefe2fb370111a0ce00641c64376447cb
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.16-rc3
        git checkout 74814fdbefe2fb370111a0ce00641c64376447cb
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "interval_tree_remove" [drivers/iommu/iommufd/iommufd.ko] undefined!
>> ERROR: modpost: "interval_tree_insert" [drivers/iommu/iommufd/iommufd.ko] undefined!
>> ERROR: modpost: "interval_tree_span_iter_first" [drivers/iommu/iommufd/iommufd.ko] undefined!
>> ERROR: modpost: "interval_tree_iter_next" [drivers/iommu/iommufd/iommufd.ko] undefined!
>> ERROR: modpost: "interval_tree_span_iter_next" [drivers/iommu/iommufd/iommufd.ko] undefined!
>> ERROR: modpost: "interval_tree_iter_first" [drivers/iommu/iommufd/iommufd.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMUFD
   Depends on IOMMU_SUPPORT
   Selected by
   - VFIO_PCI_CORE && VFIO && PCI && MMU

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

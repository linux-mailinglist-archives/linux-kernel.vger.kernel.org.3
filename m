Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF66473A39
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244665AbhLNBdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:33:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:21975 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237640AbhLNBdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639445583; x=1670981583;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E8vOL7jWoPtXylL0YcuoLKefuvb/SdvUSnxoD7m8IE0=;
  b=V4SBH5OTeahRpfGSvEa6QJQbbctb3e0oQx1cX/ohlQm/0OQD44m5d22h
   o4Gp8oqCcNAdikKs/SllmSOdjp9O2bNy2SvWjzssPf+rLe7eYlYjlDx9M
   1DVs3THczgtat0pEekdq1mQQwpwDXtbexn7lAK9C+BI+fdHTzyoVn1For
   s00a8+aR+CyaDqi8F9/77owmj/JX04MRD3fHuwwtih9UVzfHgLXetLS2P
   uvzxuXKCw/Dhl0cm7Q7S6rcsUoUV3vhdPDsfXdzT0CyeUJbdPIEZULJTR
   SDvQQofrf3wXPAkoJv5eopcLTTgThH4TryL5rvr1cS19Myc7gZzD/42FJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="299652252"
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="299652252"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 17:33:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="464871441"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Dec 2021 17:33:01 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwwge-0007Gw-Tk; Tue, 14 Dec 2021 01:33:00 +0000
Date:   Tue, 14 Dec 2021 09:32:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.16-rc3 31/37] undefined reference to
 `interval_tree_iter_first'
Message-ID: <202112140915.8XQn8g07-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.16-rc3
head:   39eca2be15451cc145f912190c4e5637362f6122
commit: 74814fdbefe2fb370111a0ce00641c64376447cb [31/37] vfio/pci: Add bind_iommufd() support
config: parisc-randconfig-r036-20211213 (https://download.01.org/0day-ci/archive/20211214/202112140915.8XQn8g07-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/74814fdbefe2fb370111a0ce00641c64376447cb
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.16-rc3
        git checkout 74814fdbefe2fb370111a0ce00641c64376447cb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
>> (.text+0x2e0): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_pages_get_exact_user':
   (.text+0x4d4): undefined reference to `interval_tree_iter_first'
>> hppa-linux-ld: (.text+0x528): undefined reference to `interval_tree_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_next':
>> (.text+0x544): undefined reference to `interval_tree_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_remove_reserved_iova':
   (.text+0x5ac): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: (.text+0x600): undefined reference to `interval_tree_iter_next'
>> hppa-linux-ld: (.text+0x618): undefined reference to `interval_tree_remove'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_pages_clean_xarray':
>> (.text+0x674): undefined reference to `interval_tree_span_iter_first'
>> hppa-linux-ld: (.text+0x71c): undefined reference to `interval_tree_span_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_area':
   (.text+0xf88): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `__iopt_area_unpin_domain':
   (.text+0x1340): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x13d4): undefined reference to `interval_tree_span_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `__iopt_unpopulate_domain':
   (.text+0x1654): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x16d0): undefined reference to `interval_tree_span_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `__iopt_unmap_iova':
>> (.text+0x189c): undefined reference to `interval_tree_remove'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_pages_unpin_xarray':
   (.text+0x1a88): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x1aec): undefined reference to `interval_tree_span_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_pin_domain':
   (.text+0x1c1c): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x1d44): undefined reference to `interval_tree_span_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_pages_fill_pinned_pfns':
   (.text+0x2198): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x2234): undefined reference to `interval_tree_span_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_finalize':
>> (.text+0x253c): undefined reference to `interval_tree_insert'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_iova':
   (.text+0x28f8): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x2930): undefined reference to `interval_tree_span_iter_next'
>> hppa-linux-ld: (.text+0x2948): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x2974): undefined reference to `interval_tree_span_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_access_pages':
   (.text+0x3220): undefined reference to `interval_tree_span_iter_first'
>> hppa-linux-ld: (.text+0x3248): undefined reference to `interval_tree_insert'
   hppa-linux-ld: (.text+0x3274): undefined reference to `interval_tree_span_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_reserve_iova':
   (.text+0x3420): undefined reference to `interval_tree_insert'
   hppa-linux-ld: drivers/iommu/iommufd/ioas_pt.o: in function `iommufd_ioas_pagetable_iova_ranges':
   (.text+0x388): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x3c4): undefined reference to `interval_tree_span_iter_next'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMUFD
   Depends on IOMMU_SUPPORT
   Selected by
   - VFIO_PCI_CORE && VFIO && PCI && MMU

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

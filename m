Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEF94C9708
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238312AbiCAUea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237975AbiCAUeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:34:23 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C9E46B1A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646166817; x=1677702817;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iCNIPVkX2GyKP5ILGD+3Dhc3XAWw9XSqvoVhaNIDTro=;
  b=W64Emnm2MtGG2WKEyoj6HvA+TarHDHVfBFtFVMzxRg+5yhdULlD1wSm1
   td5rZfDxr3KAuOQ2XoqvKfpXX8EJiezj/mKSg2682+LrFRlJOYR4vV74M
   4bf6xcD4HUUE0FYOE84l3HuyJT6fzCjb5SDkMCk0CqD0Z8fWXEaSBgI9D
   EV6KaKKKrHInQjDRcxYV/kf+O0LDb8IqJwdopsj9WOwj2s/A49ndNqYhm
   sxnSQnIOZ/dDu++wNiH6MvYpbcIWN3SX28YpGZu/Xl4SaO0q27nhCCZGJ
   tEx/D1noLpAANSEYZ9VTSaLTUSxKWUDxLDsYFz76ZNtwGSQgfX3EH/j08
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="250814862"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="250814862"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 12:33:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="535052110"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 Mar 2022 12:33:14 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP9BJ-0000yu-0Z; Tue, 01 Mar 2022 20:33:13 +0000
Date:   Wed, 2 Mar 2022 04:32:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.17-rc4 26/30] ld.lld: error: undefined
 symbol: interval_tree_iter_first
Message-ID: <202203020423.iVetVOKB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc4
head:   2bca5fa75dad57f41002a93861a950d35d55e568
commit: 9cf512778a76b8a63b429c0cf0c34b534f5577b9 [26/30] vfio: Select iommufd
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220302/202203020423.iVetVOKB-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/9cf512778a76b8a63b429c0cf0c34b534f5577b9
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc4
        git checkout 9cf512778a76b8a63b429c0cf0c34b534f5577b9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: interval_tree_iter_first
   >>> referenced by io_pagetable.c:537 (drivers/iommu/iommufd/io_pagetable.c:537)
   >>> vmlinux.o:(iommufd_device_detach)
   >>> referenced by io_pagetable.c:537 (drivers/iommu/iommufd/io_pagetable.c:537)
   >>> vmlinux.o:(iommufd_device_attach)
   >>> referenced by io_pagetable.c:161 (drivers/iommu/iommufd/io_pagetable.c:161)
   >>> vmlinux.o:(iopt_map_pages)
   >>> referenced 22 more times
--
>> ld.lld: error: undefined symbol: interval_tree_iter_next
   >>> referenced by io_pagetable.c:543 (drivers/iommu/iommufd/io_pagetable.c:543)
   >>> vmlinux.o:(iommufd_device_detach)
   >>> referenced by io_pagetable.c:543 (drivers/iommu/iommufd/io_pagetable.c:543)
   >>> vmlinux.o:(iommufd_device_attach)
   >>> referenced by io_pagetable.h:99 (drivers/iommu/iommufd/io_pagetable.h:99)
   >>> vmlinux.o:(iopt_access_pages)
   >>> referenced 12 more times
--
>> ld.lld: error: undefined symbol: interval_tree_remove
   >>> referenced by io_pagetable.c:546 (drivers/iommu/iommufd/io_pagetable.c:546)
   >>> vmlinux.o:(iommufd_device_detach)
   >>> referenced by io_pagetable.c:546 (drivers/iommu/iommufd/io_pagetable.c:546)
   >>> vmlinux.o:(iommufd_device_attach)
   >>> referenced by io_pagetable.c:192 (drivers/iommu/iommufd/io_pagetable.c:192)
   >>> vmlinux.o:(iopt_map_pages)
   >>> referenced 9 more times
--
>> ld.lld: error: undefined symbol: interval_tree_span_iter_first
   >>> referenced by io_pagetable.c:89 (drivers/iommu/iommufd/io_pagetable.c:89)
   >>> vmlinux.o:(iopt_map_pages)
   >>> referenced by io_pagetable.c:97 (drivers/iommu/iommufd/io_pagetable.c:97)
   >>> vmlinux.o:(iopt_map_pages)
   >>> referenced by ioas.c:93 (drivers/iommu/iommufd/ioas.c:93)
   >>> vmlinux.o:(iommufd_ioas_iova_ranges)
   >>> referenced 8 more times
--
>> ld.lld: error: undefined symbol: interval_tree_span_iter_next
   >>> referenced by io_pagetable.c:92 (drivers/iommu/iommufd/io_pagetable.c:92)
   >>> vmlinux.o:(iopt_map_pages)
   >>> referenced by io_pagetable.c:101 (drivers/iommu/iommufd/io_pagetable.c:101)
   >>> vmlinux.o:(iopt_map_pages)
   >>> referenced by ioas.c:96 (drivers/iommu/iommufd/ioas.c:96)
   >>> vmlinux.o:(iommufd_ioas_iova_ranges)
   >>> referenced 8 more times
--
>> ld.lld: error: undefined symbol: interval_tree_insert
   >>> referenced by io_pagetable.c:179 (drivers/iommu/iommufd/io_pagetable.c:179)
   >>> vmlinux.o:(iopt_map_pages)
   >>> referenced by io_pagetable.c:528 (drivers/iommu/iommufd/io_pagetable.c:528)
   >>> vmlinux.o:(iopt_reserve_iova)
   >>> referenced by io_pagetable.c:678 (drivers/iommu/iommufd/io_pagetable.c:678)
   >>> vmlinux.o:(iopt_table_add_domain)
   >>> referenced 2 more times

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMUFD
   Depends on IOMMU_SUPPORT
   Selected by
   - VFIO && MMU && (X86 || S390 || ARM || ARM64)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

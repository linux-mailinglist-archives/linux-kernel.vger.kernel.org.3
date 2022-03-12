Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E024D7136
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 22:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiCLV5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 16:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiCLV5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 16:57:49 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E952A70F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 13:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647122203; x=1678658203;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XSJjHBp+LyUwaRZ7wRbHiYl2tBHPKJ6xV6R6R0QDBVY=;
  b=mR+0zy+CL3+lfzhb3KytCp/b1CRjkwo3QquGPhdkFGsHiTJYxP/GJ3YI
   Js7zjH2AJo1N2ykfzI0utgjxBr74SzKDjL5xgmOu4p8eYGaeYBhGXR7I8
   HLrs4BoEYMEFNmril3HEGbfMOWBNKnfuxnNjpYzd/rXQguaeCJwo4zokc
   XJUP2TJck+6uw6B/Y2S5VT7FNKSOzyfjSIlerNX6rbgWnHkUEz7u8X5WI
   nY75HSoLRWAOoONxZdkBQdJ6wANEGxV3DhcXa8qnjuDOmaCT7VIpsu1D9
   GA7WXbmF5OERvIpNxc1aqEtu5GcW7cZ7ba8dyTUzf2++T1HH88bwR3r0Q
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="237994502"
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="237994502"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 13:56:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="645341713"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2022 13:56:42 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nT9j7-0008JL-FC; Sat, 12 Mar 2022 21:56:41 +0000
Date:   Sun, 13 Mar 2022 05:56:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.17-rc4 29/31] vfio.c:undefined
 reference to `iommufd_vfio_check_extension'
Message-ID: <202203130530.K8aEny7T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc4
head:   d0e769d6ae11d7abe38d2f0598926ba499bf3ec1
commit: d1878386aaf2b9c574b6ceafc7437ddd2152f926 [29/31] vfio: Fix kernel panic in vfio_external_check_extension()
config: arc-randconfig-r043-20220313 (https://download.01.org/0day-ci/archive/20220313/202203130530.K8aEny7T-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/d1878386aaf2b9c574b6ceafc7437ddd2152f926
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc4
        git checkout d1878386aaf2b9c574b6ceafc7437ddd2152f926
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: drivers/vfio/vfio.o: in function `vfio_external_check_extension':
>> vfio.c:(.text+0x7c8): undefined reference to `iommufd_vfio_check_extension'
>> arc-elf-ld: vfio.c:(.text+0x7c8): undefined reference to `iommufd_vfio_check_extension'
   arc-elf-ld: drivers/vfio/vfio.o: in function `__vfio_group_unset_container':
   vfio.c:(.text+0x8fa): undefined reference to `vfio_group_unset_iommufd'
   arc-elf-ld: vfio.c:(.text+0x8fa): undefined reference to `vfio_group_unset_iommufd'
   arc-elf-ld: drivers/vfio/vfio.o: in function `vfio_group_set_container':
   vfio.c:(.text+0x1180): undefined reference to `vfio_group_set_iommufd'
   arc-elf-ld: vfio.c:(.text+0x1180): undefined reference to `vfio_group_set_iommufd'

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

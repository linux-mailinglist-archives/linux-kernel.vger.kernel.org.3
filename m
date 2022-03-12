Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC24D70D4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 21:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiCLU0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 15:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiCLU0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 15:26:48 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A897820D51D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 12:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647116742; x=1678652742;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mtIYlnMi0Kl1kCrxo6c2DXSW7BmyRb7PReoq3xNTmfA=;
  b=Zqb7MbaHCY2Hhwtb2XTXtjbDYmRzn+Fsnf8hFfNnyke0LQ/MnJtH0bw1
   d88bIx52cWngDh4cWKP8TrmkLA7epmE7nonxxAAipaYR9eoy8nmf2J7y1
   PIe7di6Wnp7eqIHdIhclPi7DP9FHyzdMNpag3P/WN8vmHpGtRib1Dlm0K
   sXfh5MbCDWEDhprjKBwGBVbxxHH2b5oOOphFrZctYsFR2B0WzWw9k2aCk
   PR0ZQ+ioL1d7Hx8oq95pVozG78skXtAqWV9obPDC9j/61UnnMQxFepwHp
   xUuNot3HPGkS32z1CW5J+SLy5lCMtNz6pflYtO7MxugCmVCG3zRmghk2s
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="236421167"
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="236421167"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 12:25:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="645329305"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2022 12:25:40 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nT8J2-0008Fg-0t; Sat, 12 Mar 2022 20:25:40 +0000
Date:   Sun, 13 Mar 2022 04:25:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Liu Yi L <yi.l.liu@intel.com>
Subject: [luxis1999-iommufd:iommufd-v5.17-rc4 25/31] vfio.c:undefined
 reference to `vfio_group_unset_iommufd'
Message-ID: <202203130417.G9Mdfrna-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc4
head:   d0e769d6ae11d7abe38d2f0598926ba499bf3ec1
commit: 32bd602a155904c029c1514c6d0bb2aa2fd863c5 [25/31] vfio: Add iommufd VFIO compat support to group_fd
config: arc-randconfig-r043-20220313 (https://download.01.org/0day-ci/archive/20220313/202203130417.G9Mdfrna-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/32bd602a155904c029c1514c6d0bb2aa2fd863c5
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc4
        git checkout 32bd602a155904c029c1514c6d0bb2aa2fd863c5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: drivers/vfio/vfio.o: in function `__vfio_group_unset_container':
>> vfio.c:(.text+0x8d8): undefined reference to `vfio_group_unset_iommufd'
>> arc-elf-ld: vfio.c:(.text+0x8d8): undefined reference to `vfio_group_unset_iommufd'
   arc-elf-ld: drivers/vfio/vfio.o: in function `vfio_group_set_container':
>> vfio.c:(.text+0x113c): undefined reference to `vfio_group_set_iommufd'
>> arc-elf-ld: vfio.c:(.text+0x113c): undefined reference to `vfio_group_set_iommufd'

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

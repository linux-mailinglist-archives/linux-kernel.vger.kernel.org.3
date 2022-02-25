Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0AB4C4E22
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiBYSz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiBYSz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:55:56 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EDF1CABCE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645815323; x=1677351323;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y60gl5XzQCq+fmeyaGBJHZqpd2XBH6eJ043j+RfHgT8=;
  b=BxlYXkxl3nbeyExHXjDsBi8DoJXwRu3VeFtPuvsn5x8NgcMeAGUG7ibx
   1lunJHEkhmEPESUdHqdqUlcpuAMAU9uDS3/HIn39SksjfeLrlZYwf2A7A
   Cbsh8JXOkW0wwQmE5byb8mOKfUBA022BCc9Qwoi2A4+ub7vq7KS+fwilg
   m+QLrhdhNY72QItCnSmCyvd4J35cEYYhlxnNnmX7zOMsAbDf/uxRGNcJy
   W0jaJBhsA8iWM4HKykjgrZcGtY65r1yI5ubl7kdi96HMuSW/EZrwnSde8
   AehLGyt+8dM+hmoSoAKLY3SPawS04Aizzfq2ZTu0DP+nTuTA0vfKddwR1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="313277864"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="313277864"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 10:55:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="574686174"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2022 10:55:22 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNfkP-0004cr-SQ; Fri, 25 Feb 2022 18:55:21 +0000
Date:   Sat, 26 Feb 2022 02:54:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.17-rc4 14/25] ERROR: modpost:
 "vfio_platform_ops" [drivers/vfio/platform/vfio-platform.ko] undefined!
Message-ID: <202202260238.ppsRDcTe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc4
head:   034a4f5bce51691aff0f8104f3e0b1f376c4f50d
commit: 6c62a443fb8c1a82c6337b96e1d73949f616eef9 [14/25] vifo_platform: Use vfio_alloc/put_device()
config: arc-randconfig-r003-20220225 (https://download.01.org/0day-ci/archive/20220226/202202260238.ppsRDcTe-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/6c62a443fb8c1a82c6337b96e1d73949f616eef9
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc4
        git checkout 6c62a443fb8c1a82c6337b96e1d73949f616eef9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "vfio_platform_ops" [drivers/vfio/platform/vfio-platform.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

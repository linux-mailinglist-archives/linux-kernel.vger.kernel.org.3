Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5984AFF6A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiBIVsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:48:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbiBIVsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:48:10 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C6AC03BFF4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 13:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644443293; x=1675979293;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V5OdOIqmi/bDeET25hsIIG70BcxGdiVQ/wOGG3RvjWs=;
  b=RxsgkOfkh3nWUispqOb1gdzUi6dIyn2IZHnitLvq/Quy8VjliuthUBCY
   33KPZs3FuO4quwjnKcC/SCyChce43IRHpdAf5v99LpeWKSi+kG7aGRY5i
   3LR+zBNYKbIlTRYMULL0irUTep90q40HaKELFNZulC/QZA8kxPhqzZuVb
   GZpDxK8kEoXSFqF7ta/0ISUgGkxVAzWmYB4SEHnyXxPky+sNT0Zuyg9AS
   ug0QWHtXjxi7v/dLtlD4CvIzA0p27Ad7NTvpE61aGE1XDLg6vtncXc0K0
   wPbx2hKidQk0FZXqW3lzGBddkGJS4Gn1cCh9Ho5Gznj5K0M9RM2OqTmuX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="246928718"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="246928718"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 13:48:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="629443306"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 Feb 2022 13:48:11 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHuot-0002JE-7I; Wed, 09 Feb 2022 21:48:11 +0000
Date:   Thu, 10 Feb 2022 05:47:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.17-rc1 14/28] ERROR: modpost:
 "vfio_platform_ops" [drivers/vfio/platform/vfio-amba.ko] undefined!
Message-ID: <202202100548.m45ZFnHj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc1
head:   ebf68af0385d0d5c209e63e8065d31db938275d8
commit: 92b20d75d7b30d1c70dd13b1be97a7bb00d5910b [14/28] vifo_platform: Use vfio_alloc/put_device()
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220210/202202100548.m45ZFnHj-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/92b20d75d7b30d1c70dd13b1be97a7bb00d5910b
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc1
        git checkout 92b20d75d7b30d1c70dd13b1be97a7bb00d5910b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "vfio_platform_ops" [drivers/vfio/platform/vfio-amba.ko] undefined!
ERROR: modpost: "vfio_platform_ops" [drivers/vfio/platform/vfio-platform.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

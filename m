Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCCB4AFEB1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiBIUrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:47:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiBIUrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:47:09 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82973C001914
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644439631; x=1675975631;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BgI5Um2PzH6L3s4IASwJrQqFgjbsdXPkj4Z0ObGc2wU=;
  b=CzLfGx9FFGDzrBctPRSvCyVGy+fpFcBRGw/h9qAEGmH5qGlvTfNE/r/F
   ajoBtsOihEzpjxR61uFq8V7bLuZSronVev8DN55sw99mfvkDxNUWL1vQx
   ITCqaaoRout4BGJ4MbUtQqLRJBZv3Mj7sUJOzG9fK5aQNGRKTWlvqRvH4
   GjmfqJPJTf386n//NUUEDaO5yNVI2FGrpV5HtMaLajWgsiBJituW+xbzU
   M3EZTfyU2nMm/F07X6Glmf84mu9IGRaQvnIAmI1/Xc2hbvBGXM0fONO9j
   APItjAnFVu6nlmvUS068wXplmFVo5FaU6QipAkqz0qsl2bktmk9pzgpKQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="246912047"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="246912047"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 12:47:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="485408624"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 09 Feb 2022 12:47:10 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHtrp-0002G8-EM; Wed, 09 Feb 2022 20:47:09 +0000
Date:   Thu, 10 Feb 2022 04:46:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.17-rc1 14/28] ERROR: modpost:
 "vfio_platform_ops" [drivers/vfio/platform/vfio-platform.ko] undefined!
Message-ID: <202202100425.9NPIA1zc-lkp@intel.com>
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
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220210/202202100425.9NPIA1zc-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/92b20d75d7b30d1c70dd13b1be97a7bb00d5910b
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc1
        git checkout 92b20d75d7b30d1c70dd13b1be97a7bb00d5910b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "vfio_platform_ops" [drivers/vfio/platform/vfio-platform.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

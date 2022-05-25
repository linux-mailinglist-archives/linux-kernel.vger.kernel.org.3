Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E48534265
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbiEYRs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245754AbiEYRsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:48:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A6322285
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653500932; x=1685036932;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZiIT7udcNT8M512D+GC+EBX7lAzUqW1nxd2x6iQxp44=;
  b=OjCq26bW9IC2qL46wBDH++2MpZAC0E/EM45mk/wZvK9Fy1nEtTNlslxR
   5QUi8dm/2QUrZrZzSeZtDSO/y7GZuaDi1dnu/OUwGJBvxxhxHNNfAJll0
   tDd110SHkPWNxdm1gAdG406Fo/gx03dR2vlmtVdB+10npLmHXmt7c3z3F
   n3JcnnLz5Vvxhx+dJpAWftxw7yGx5oaKKeE8y8PBafo30dqSvig+qY39I
   FWXlLzdIv8x5PZf8nhog+yA1nPy37hLaCyZvYBYDTPC/e4EzVtb2FgKO+
   sDbNvWQMKjivabtXCRlGgLdjYe6va4pQgPQ9g+FqCF7C0K7/+8Rl6TGVC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="273997789"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273997789"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="549123097"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 May 2022 10:43:03 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntv2E-0003CW-U8;
        Wed, 25 May 2022 17:43:02 +0000
Date:   Thu, 26 May 2022 01:42:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [tzungbi-chrome-platform:dev 25/25] cros_kunit_util.c:undefined
 reference to `kunit_kmalloc_array'
Message-ID: <202205260106.u6TwOLMB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tzungbi/chrome-platform.git dev
head:   c8065f6d478990cfc385d1d579972a75fc29605b
commit: c8065f6d478990cfc385d1d579972a75fc29605b [25/25] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_query_all()
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220526/202205260106.u6TwOLMB-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tzungbi/chrome-platform.git/commit/?id=c8065f6d478990cfc385d1d579972a75fc29605b
        git remote add tzungbi-chrome-platform https://git.kernel.org/pub/scm/linux/kernel/git/tzungbi/chrome-platform.git
        git fetch --no-tags tzungbi-chrome-platform dev
        git checkout c8065f6d478990cfc385d1d579972a75fc29605b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/platform/chrome/cros_kunit_util.o: in function `cros_kunit_ec_xfer_mock':
>> cros_kunit_util.c:(.text+0x7c): undefined reference to `kunit_kmalloc_array'
   m68k-linux-ld: drivers/platform/chrome/cros_kunit_util.o: in function `cros_kunit_ec_xfer_mock_addx':
   cros_kunit_util.c:(.text+0x12e): undefined reference to `kunit_kmalloc_array'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

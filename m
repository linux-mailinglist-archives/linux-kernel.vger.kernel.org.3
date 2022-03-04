Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC8C4CCD49
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbiCDFce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiCDFcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:32:31 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2FF13195C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646371904; x=1677907904;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1Q6UfnwuiNskt5tIpY3SbJb6yLLCorI9f/4Na17BTgE=;
  b=Knr/xEYIF8evwi3eLF6phenJsy8ZIR0BhUwfl3Am/pwo6J8wog0xvKIv
   HcxsmgIhWcUhjy9+3RIyv4/i9ETVhEVqxcSiSRpxudIROvs0m+JyFqAUe
   qe8NmuCGzeroemwii9HgLwcQZMmYp19fL8MV7vhMlehBOw2Ap7rqR343Y
   7VWyRW4ERo9SvTSQyCV2ALfOd/D9Q3n/946Qw/zFkmTZW3rhP4pxNjY5D
   CK3YyW4UU0f34AbR7RemBzJFhaB9d4jfPfplPoTKm0OWsdgPu2AeIArQr
   jwxTjmgx03EZBpdA303cmW4NI8dPh2FN0zcljZueApewHw5S5Dl5MBoXa
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="253630447"
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="253630447"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 21:31:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="631060698"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Mar 2022 21:31:42 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nQ0XV-0001KU-O1; Fri, 04 Mar 2022 05:31:41 +0000
Date:   Fri, 4 Mar 2022 13:31:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/060-spi 13/18] ERROR: modpost:
 "apple_rtkit_shutdown" [drivers/nvme/host/nvme-apple.ko] undefined!
Message-ID: <202203041347.JoNxX2tN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/060-spi
head:   487ac6fe3387b5f859f743a5d585b3c7a9b297ae
commit: 0493627694b1aa30414492819003dfde6e9306c7 [13/18] fixup! WIP: soc: apple: rtkit: Add RTKit library
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220304/202203041347.JoNxX2tN-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/0493627694b1aa30414492819003dfde6e9306c7
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/060-spi
        git checkout 0493627694b1aa30414492819003dfde6e9306c7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "apple_rtkit_shutdown" [drivers/nvme/host/nvme-apple.ko] undefined!
>> ERROR: modpost: "apple_rtkit_is_crashed" [drivers/nvme/host/nvme-apple.ko] undefined!
>> ERROR: modpost: "apple_rtkit_is_running" [drivers/nvme/host/nvme-apple.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

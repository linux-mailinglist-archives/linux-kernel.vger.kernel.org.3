Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2D44CBB29
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiCCKVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiCCKVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:21:38 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC02488A8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 02:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646302853; x=1677838853;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DPYlkViuv6KB8OjsuQ1l0IzYXO0cMfstDabaYqO7S0o=;
  b=XI4ZFrgKv1/EDRN9QoLTpNZadCV/u/O1uWbG6pcV6dYXWPdYogPaRPDb
   7OSD93umHQWWMscsHFEtOK6yAD7czgt/Q7i2qutty5oLytuOr5dXL04hI
   VXteSIgvqLHjRQ+PDgCJp9lq1NUsJoTx7FCFHPHOyIkeQx8N465OHzD+y
   J5MGkbHcKy7BXH8xzMtArWOX7Bb6Z20e/M4XKWm5h8dVx1XTBbe0fSE29
   dQEMgonhoTM90jbVCpat9Fu0fs0RcQIZuhoeNLHGwwNaHgajrWg/C56+w
   Lgk2mw3f0otBHPDnfGPJsjNgL72onNhYYrpU4JvxB0CGUfujvcc2ws3J4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="340068830"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="340068830"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 02:20:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="709872419"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 Mar 2022 02:20:50 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPiZl-0000Nw-P3; Thu, 03 Mar 2022 10:20:49 +0000
Date:   Thu, 3 Mar 2022 18:20:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/050-nvme 9/15] undefined reference to
 `apple_sart_remove_allowed_region'
Message-ID: <202203031806.f1pqGvO7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/050-nvme
head:   fa98fe78deae80c3ca00451876f72fd38b2b3ee9
commit: 27dce760587c8c88aef9a2ef877a92df348075a6 [9/15] WIP: nvme-apple: add initial Apple SoC NVMe driver
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220303/202203031806.f1pqGvO7-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/27dce760587c8c88aef9a2ef877a92df348075a6
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/050-nvme
        git checkout 27dce760587c8c88aef9a2ef877a92df348075a6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_destroy':
>> (.text+0x3fc): undefined reference to `apple_sart_remove_allowed_region'
   hppa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_setup':
>> (.text+0x4f0): undefined reference to `apple_sart_add_allowed_region'
   hppa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_probe':
>> (.text+0x10fc): undefined reference to `apple_sart_get'
>> hppa-linux-ld: (.text+0x1310): undefined reference to `devm_apple_rtkit_init'
   hppa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_disable':
>> (.text+0x23e0): undefined reference to `apple_rtkit_is_crashed'
   hppa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_shutdown':
>> (.text+0x2678): undefined reference to `apple_rtkit_is_running'
>> hppa-linux-ld: (.text+0x2688): undefined reference to `apple_rtkit_shutdown'
   hppa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_remove':
   (.text+0x272c): undefined reference to `apple_rtkit_is_running'
   hppa-linux-ld: (.text+0x273c): undefined reference to `apple_rtkit_shutdown'
   hppa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_timeout':
   (.text+0x286c): undefined reference to `apple_rtkit_is_crashed'
   hppa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_reset_work':
   (.text+0x2a38): undefined reference to `apple_rtkit_is_crashed'
>> hppa-linux-ld: (.text+0x2a78): undefined reference to `apple_rtkit_is_running'
   hppa-linux-ld: (.text+0x2ad4): undefined reference to `apple_rtkit_shutdown'
>> hppa-linux-ld: (.text+0x2aec): undefined reference to `apple_rtkit_reinit'
>> hppa-linux-ld: (.text+0x2b28): undefined reference to `apple_rtkit_boot'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

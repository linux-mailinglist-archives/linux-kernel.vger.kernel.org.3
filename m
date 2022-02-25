Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484F64C3BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 03:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbiBYCuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 21:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiBYCuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:50:16 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D8D2692CA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 18:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645757384; x=1677293384;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GWCQnLticRYqKCcDbwJYpfrpHlXdGUq7jI/GXTVA6yU=;
  b=CeBHq3tzRyWamMS3xuUmlzJvVFHY0mDro3wpV4O/2mLYGlioQ8HcIGlV
   51yA+FGRUwX22do9lbrWc03axMBKw/hhKFG0eijLF4TxGqmBmaxYEHCOx
   pjunyKHjZesHd3MsXExKh2oehMN2WOOvbtGZfv8Y0ED+NpoF/jTJ8EStM
   HWDHnN8icULK44JamVgEgmlLTj+bVuOAUl8eiLWH07fos0i1osrUCWh/Q
   MIcBA8xW9K0Ix5uP1sALCmuJUtHAWRQkThBln3ZD5ogQkvwSg+RGdAAjI
   JiSN4hRYOVp3lmPObI9ZMg2OgarB2jLoUfXobuyttDixtoOkaU5UZcr1z
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252598743"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="252598743"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 18:49:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="592314381"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Feb 2022 18:49:42 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNQfu-0003l0-39; Fri, 25 Feb 2022 02:49:42 +0000
Date:   Fri, 25 Feb 2022 10:49:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [at91:at91-dt 6/12] Error: arch/arm/boot/dts/sama7g5.dtsi:102.21-22
 syntax error
Message-ID: <202202251004.qEq5gCtc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git at91-dt
head:   85aa52c46d5e8461eb2b87f8558e89cb83e4ab29
commit: 91b2007aba2e00f0cb9e0f9fa0a2db92cfeb70ff [6/12] ARM: dts: at91: sama7g5: Add NAND support
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220225/202202251004.qEq5gCtc-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git/commit/?id=91b2007aba2e00f0cb9e0f9fa0a2db92cfeb70ff
        git remote add at91 https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
        git fetch --no-tags at91 at91-dt
        git checkout 91b2007aba2e00f0cb9e0f9fa0a2db92cfeb70ff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/sama7g5.dtsi:102.21-22 syntax error
>> FATAL ERROR: Unable to parse input tree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

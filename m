Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B184C4F70
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbiBYUSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiBYUR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:17:59 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D88192B3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645820245; x=1677356245;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IXZgevlMhgT/BuHMLe37co58F8OyfmDgE9AWiUWJPO0=;
  b=B1XLDY8TyCF1DawpZSywOYXenCpJpIikZLABedSB29qkLNpbgPb8/s1H
   u/s93+7yr9TSKIR1m0RhaIN+O3yoRmSR5q5T2pS51b7bAZOUdCSIOphh4
   Xd9Ze9IIeBzI+u343Ki3JAsspLpN+ODLizvnJx0IVqeJYyrLbuLFAvY1p
   ogaxMeCyoIM1bqPyXqyggHflMbJpe2nwwZJLfwyUkLtyfwghiJxy6n6NQ
   4BNKlzg2uaBjzll7LpIWYtFBxPXETYkZvJm+8XWltyyv2FeVIEBQR+itY
   0GAqQnETkKQAUFAqpWKElSc9u0lEosvrzsVMg/Uj7dUhMo6COyxrkaYIr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="251403679"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="251403679"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 12:17:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="549406516"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 Feb 2022 12:17:23 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNh1n-0004fh-7r; Fri, 25 Feb 2022 20:17:23 +0000
Date:   Sat, 26 Feb 2022 04:16:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [at91:at91-dt-next 12/12] FATAL ERROR: Unable to parse input tree
Message-ID: <202202260434.MSueBSc1-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git at91-dt-next
head:   2e7f2c599a614ea47067ec9d32354a56785bb460
commit: 2e7f2c599a614ea47067ec9d32354a56785bb460 [12/12] ARM: dts: at91: sama7g5: Add NAND support
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220226/202202260434.MSueBSc1-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git/commit/?id=2e7f2c599a614ea47067ec9d32354a56785bb460
        git remote add at91 https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
        git fetch --no-tags at91 at91-dt-next
        git checkout 2e7f2c599a614ea47067ec9d32354a56785bb460
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   Error: arch/arm/boot/dts/sama7g5.dtsi:140.21-22 syntax error
>> FATAL ERROR: Unable to parse input tree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

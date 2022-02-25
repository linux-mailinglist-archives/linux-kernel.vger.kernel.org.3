Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457C24C42B1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbiBYKqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiBYKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:46:38 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F6E1F637B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645785966; x=1677321966;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YY/AcURvP12XZxRgKmG9oqCWrzRVApNCi7dEIAoNcOw=;
  b=EEIaoFHLN7YmaVFmI3J4hlcPxULJiAgD7U7jcWAfco365iXWBnNJlZuj
   yHBL3EZDZ0U42mRaU5Kbancgbwuxv6x36+lYOAL23qOJ5lSTjWquEKVOZ
   LyF0ZmV4t0LfsFSHjEfk2M0kkHoqqEvq0f1ucrJqPHpwKcVPEapHT7nq2
   6Rmccqj91egndLXjd6quXUKvLIF2OyLUM/YAFmMut5G9eFCrmm2tegcJM
   VtqyAdNUf5bYw8ya2iqZnuaFtSNLLLnYueLM61UptxfqK2Vem89bk9owd
   QTSZxNUGtTFWkQ/1vGEsMSo79H8RhSj6MgQ20Ipd0d94FMDTODjI1bn+D
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252204190"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="252204190"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 02:46:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="777382408"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 25 Feb 2022 02:46:00 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNY6q-0004Ch-39; Fri, 25 Feb 2022 10:46:00 +0000
Date:   Fri, 25 Feb 2022 18:45:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: omap-gpmc.c:undefined reference to `devm_gpiochip_add_data_with_key'
Message-ID: <202202251829.XLcsRg9D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   53ab78cd6d5aba25575a7cfb95729336ba9497d8
commit: 4cd335dae3cf25412427938d8abbaf04d46e63b5 mtd: rawnand: omap2: Prevent invalid configuration and build error
date:   4 weeks ago
config: ia64-randconfig-r024-20220225 (https://download.01.org/0day-ci/archive/20220225/202202251829.XLcsRg9D-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4cd335dae3cf25412427938d8abbaf04d46e63b5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4cd335dae3cf25412427938d8abbaf04d46e63b5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ia64-linux-ld: drivers/memory/omap-gpmc.o: in function `gpmc_probe':
>> omap-gpmc.c:(.text+0x15f2): undefined reference to `devm_gpiochip_add_data_with_key'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OMAP_GPMC
   Depends on MEMORY && OF_ADDRESS
   Selected by
   - MTD_NAND_OMAP2 && MTD && MTD_RAW_NAND && (ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST && HAS_IOMEM

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

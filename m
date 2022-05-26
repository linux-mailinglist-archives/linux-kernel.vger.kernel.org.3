Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F0553474E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 02:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347883AbiEZAIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 20:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347861AbiEZAI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 20:08:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11DEA7769
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 17:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653523703; x=1685059703;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=chY8ZtMyrJwsC/V5yz3eoodsBGtY+oChL0hlaavYh80=;
  b=GC6czQ12xqoQgUB3tJGSY0U/Fn7Y42nxf0uq5g586DJxHJIWXIw2oXrQ
   WcKOqywetZJaGdzC0LF2HAuelqMf3FFopLzeEeDPq33a1kNXKmQQu3pwO
   +kymA8uIFv3GvP+T4JZufs/i76nQRewNGw5c7TGPs48BqbfFcLmsgcPtA
   sOCHwuWMXWtfDjUs14vAcYOcFvi0cNcQA1BcRZbgXkP4g/TWz1UuS8Qcb
   zAt1WinVg1BzW16i9LIrXsa8NSlgyZNEb0JaqMriur/B3jQcVVpV4zpGA
   TcSy3krtgjsmRznovqLdtZyCVOjjdCXod2+6Ly8xhXU3iJGhQH8Da9hG3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="360362056"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="360362056"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 17:08:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="704229727"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 May 2022 17:08:22 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nu137-0003R4-On;
        Thu, 26 May 2022 00:08:21 +0000
Date:   Thu, 26 May 2022 08:08:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [tzungbi-chrome-platform:dev 25/25]
 cros_kunit_util.c:(.text.cros_kunit_ec_xfer_mock+0x100): undefined reference
 to `kunit_kmalloc_array'
Message-ID: <202205260852.vS1QoL3B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220526/202205260852.vS1QoL3B-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tzungbi/chrome-platform.git/commit/?id=c8065f6d478990cfc385d1d579972a75fc29605b
        git remote add tzungbi-chrome-platform https://git.kernel.org/pub/scm/linux/kernel/git/tzungbi/chrome-platform.git
        git fetch --no-tags tzungbi-chrome-platform dev
        git checkout c8065f6d478990cfc385d1d579972a75fc29605b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/platform/chrome/cros_kunit_util.o: in function `cros_kunit_ec_xfer_mock':
>> cros_kunit_util.c:(.text.cros_kunit_ec_xfer_mock+0x100): undefined reference to `kunit_kmalloc_array'
   powerpc-linux-ld: drivers/platform/chrome/cros_kunit_util.o: in function `cros_kunit_ec_xfer_mock_addx':
>> cros_kunit_util.c:(.text.cros_kunit_ec_xfer_mock_addx+0x50): undefined reference to `kunit_kmalloc_array'
>> powerpc-linux-ld: cros_kunit_util.c:(.text.cros_kunit_ec_xfer_mock_addx+0xec): undefined reference to `kunit_kmalloc_array'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

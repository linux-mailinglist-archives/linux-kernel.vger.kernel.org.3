Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE96050A1F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389094AbiDUOTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389085AbiDUOTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:19:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B90727FFC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650550585; x=1682086585;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/OvkHy0FqzI3Ls2KxWiBMDwEOS1YF5ERwMOn5Hz904I=;
  b=kDAN5+DRCcfqDID/9YYGVFo7FJnzKypaaY30QNtHsAuwmpeb3rFwExe8
   z82xWh73a2E8lNauUM+5RMh7n+xlC33AAQAORe8czdfa4iHa/xmRep+OU
   A6JjrbsjqlGZfrbCV/F2Tugs32KiXKXXKKy95KB21ygLjBxcGe5SppJse
   rU93Efnh8Ez//Nsvqbv95jipa97hapCDUrGTsZ3hrYlhluUaZG0aCncuQ
   aFQban7q/IJhl34h/ptHLsR8knYG3XppKPolgoAn5J0Ss5mas67X/YB2a
   eaC8YcAP9qAX3snLBKde4aSs0AA+sbmuTWc2XWauIgML4a+h1GXyDPLfi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="261960321"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="261960321"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 07:16:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="562591115"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Apr 2022 07:16:19 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhXbX-0008Sv-4l;
        Thu, 21 Apr 2022 14:16:19 +0000
Date:   Thu, 21 Apr 2022 22:15:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Subject: drivers/mfd/atc260x-i2c.c:45:34: warning: unused variable
 'atc260x_i2c_of_match'
Message-ID: <202204212213.zQ5mP49k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b253435746d9a4a701b5f09211b9c14d3370d0da
commit: c0d46b89ddeae419ee3ee8679fe6836119a83e14 mfd: Make symbol 'atc260x_i2c_of_match' static
date:   1 year ago
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220421/202204212213.zQ5mP49k-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c0d46b89ddeae419ee3ee8679fe6836119a83e14
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c0d46b89ddeae419ee3ee8679fe6836119a83e14
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/i915/gvt/ drivers/mfd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mfd/atc260x-i2c.c:45:34: warning: unused variable 'atc260x_i2c_of_match' [-Wunused-const-variable]
   static const struct of_device_id atc260x_i2c_of_match[] = {
                                    ^
   1 warning generated.


vim +/atc260x_i2c_of_match +45 drivers/mfd/atc260x-i2c.c

    44	
  > 45	static const struct of_device_id atc260x_i2c_of_match[] = {
    46		{ .compatible = "actions,atc2603c", .data = (void *)ATC2603C },
    47		{ .compatible = "actions,atc2609a", .data = (void *)ATC2609A },
    48		{ }
    49	};
    50	MODULE_DEVICE_TABLE(of, atc260x_i2c_of_match);
    51	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

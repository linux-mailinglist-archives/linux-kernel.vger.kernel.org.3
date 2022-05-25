Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E771C534640
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbiEYWMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiEYWMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:12:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9328E0DE
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653516752; x=1685052752;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+Wo76B/Eqk9nONCDhyVIm2GFOyBcbcBMDqB65FrTTl0=;
  b=SZ4Ie1yJ/iRFXZrKEnHkx1S+hQV83ud5xM7g2k9zOhCJz9EWb1EZ6oq4
   hAqKyqGJdZyATrJ+rlfnEVa2obOEWbZVxcMBWQ7Y5MPQh8ROpvleLID2L
   /hN7MK0ztLYoTG7Qewvmj5CyK5f9MLKm95gjQl8F1ksjfbAXBqMddMAZP
   VdGXBO+LVeCbnH76x45hofftIHJKPnjysx8dFWYvkzJUzBpB4aLbeu9Qe
   30pcMIS7OVBZqdmTflw7DWAXgKrOtVY4eij/vwXE9SNpQwI7iTpZlI+/m
   eL6PBEsNQsVQgmrxjQFijVgjIMvcMlYVyFg8pVzVj6uXsu2+h6EGgnKe+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="254445417"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="254445417"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 15:12:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="602502105"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 May 2022 15:12:19 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntzEo-0003Lx-GK;
        Wed, 25 May 2022 22:12:18 +0000
Date:   Thu, 26 May 2022 06:11:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/050-nvme 8/9] drivers/soc/apple/rtkit.c:665:9:
 error: call to undeclared function 'mbox_client_poll_data'; ISO C99 and
 later do not support implicit function declarations
Message-ID: <202205260646.kktYCjXu-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux bits/050-nvme
head:   54dfe8ce63a23f4a11e9aa0481a09a6ec2267b2f
commit: ecb1172a9cbf4c3ad18fa5c259380a116c2f00e6 [8/9] soc: apple: rtkit: Add apple_rtkit_poll
config: arm64-buildonly-randconfig-r005-20220524 (https://download.01.org/0day-ci/archive/20220526/202205260646.kktYCjXu-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d52a6e75b0c402c7f3b42a2b1b2873f151220947)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/AsahiLinux/linux/commit/ecb1172a9cbf4c3ad18fa5c259380a116c2f00e6
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/050-nvme
        git checkout ecb1172a9cbf4c3ad18fa5c259380a116c2f00e6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/soc/apple/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/soc/apple/rtkit.c:665:9: error: call to undeclared function 'mbox_client_poll_data'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return mbox_client_poll_data(rtk->mbox_chan);
                  ^
   drivers/soc/apple/rtkit.c:665:9: note: did you mean 'mbox_client_peek_data'?
   include/linux/mailbox_client.h:46:6: note: 'mbox_client_peek_data' declared here
   bool mbox_client_peek_data(struct mbox_chan *chan); /* atomic */
        ^
   1 error generated.


vim +/mbox_client_poll_data +665 drivers/soc/apple/rtkit.c

   662	
   663	int apple_rtkit_poll(struct apple_rtkit *rtk)
   664	{
 > 665		return mbox_client_poll_data(rtk->mbox_chan);
   666	}
   667	EXPORT_SYMBOL_GPL(apple_rtkit_poll);
   668	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

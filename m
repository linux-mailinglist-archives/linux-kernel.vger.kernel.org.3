Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133B75332A2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241752AbiEXUvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240133AbiEXUvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:51:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3275767C
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653425472; x=1684961472;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8uY9v8L0DfiF0Jwd61cD0HETvxNK3ecWxD2SCbuXr/o=;
  b=K8EIVhvJ8jGV4Ebpon8lrVC6QXE6GM/CHHB6X3FfzbZGa5Z1d18tnN/h
   Q+ubxP972TK0gw5vUFwGycld7h659N+yCHkVdrBQHCbMdIWLuPRYaFq0K
   m9PlAIDybJMXV/PM80zCtYhcauz/w6536Uwk7XhPLjn4ymGZlWF/C2CFs
   wv9HTj2ZUN5lW0FDn42s1OotonrwXlYwixxQ8vTIh4pGYe7Y487WKPJVi
   JJFvua/pbTDfWyhSKTpDef4zkjV+WY71aqrtHaDksd2zyUUyipo/es58t
   LgC2CxHRLb3ZyOZ5n5y0lh0r5TQiK4NIebZauapAjTyixg4oMpmD1IWJI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="254148289"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="254148289"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 13:51:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="559286224"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2022 13:51:10 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntbUj-0002Qk-Qz;
        Tue, 24 May 2022 20:51:09 +0000
Date:   Wed, 25 May 2022 04:50:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/050-nvme 8/9] drivers/soc/apple/rtkit.c:665:16:
 error: implicit declaration of function 'mbox_client_poll_data'; did you
 mean 'mbox_client_peek_data'?
Message-ID: <202205250417.A3XFu2wp-lkp@intel.com>
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
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220525/202205250417.A3XFu2wp-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/ecb1172a9cbf4c3ad18fa5c259380a116c2f00e6
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/050-nvme
        git checkout ecb1172a9cbf4c3ad18fa5c259380a116c2f00e6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/soc/apple/rtkit.c: In function 'apple_rtkit_poll':
>> drivers/soc/apple/rtkit.c:665:16: error: implicit declaration of function 'mbox_client_poll_data'; did you mean 'mbox_client_peek_data'? [-Werror=implicit-function-declaration]
     665 |         return mbox_client_poll_data(rtk->mbox_chan);
         |                ^~~~~~~~~~~~~~~~~~~~~
         |                mbox_client_peek_data
   cc1: some warnings being treated as errors


vim +665 drivers/soc/apple/rtkit.c

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

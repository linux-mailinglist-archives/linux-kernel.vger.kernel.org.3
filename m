Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A73E516EDE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384716AbiEBLbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384768AbiEBLbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:31:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AD513D57
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 04:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651490833; x=1683026833;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tGLAhKA7DkYEU1xQ/syou3n0tNkVpNRC4oxoekTP+fE=;
  b=eHbI56snPabSuniQ72XOoEw4yoSrU4I3138STYxBnaqXqGqAXfg/8IaR
   U1Pu+JyoaCc7+D1foM/4DBBwcsqeW3majDfN298WUbf7+Zy41F2tK1Zcr
   Iu05FEjLNoEnfwWcdUMle/0dw0F45OVapq+oiFa2SNbox0od+iogIPE2W
   6ABnYALC/0TVOJBJSBWXYScPAGTk0OIxrPykv53ryB+okrkQDk3dxct8t
   jR1xgA41Co/wi8IMRy9bTzw5xj3f9aIQlxctAPAQKtVRDmBTq24dGyQxT
   SRr/Yn4TIycgpLlTIeqNHupEtFPiESdGs3+c3JujudeAM7db8R+1CWGkN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="266035645"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="266035645"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 04:27:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="733393896"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 May 2022 04:27:09 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlUCr-0009WV-Ad;
        Mon, 02 May 2022 11:27:09 +0000
Date:   Mon, 2 May 2022 19:26:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/050-nvme 8/8] drivers/soc/apple/rtkit.c:665:16:
 error: implicit declaration of function 'mbox_client_poll_data'; did you
 mean 'mbox_client_peek_data'?
Message-ID: <202205021935.AfIGcsfD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/050-nvme
head:   222ee5def638142f93bf1fae4f1d714c993c843e
commit: 222ee5def638142f93bf1fae4f1d714c993c843e [8/8] soc: apple: rtkit: Add apple_rtkit_poll
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220502/202205021935.AfIGcsfD-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/222ee5def638142f93bf1fae4f1d714c993c843e
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/050-nvme
        git checkout 222ee5def638142f93bf1fae4f1d714c993c843e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
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

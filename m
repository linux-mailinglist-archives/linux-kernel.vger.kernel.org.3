Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18644562948
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiGACvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiGACva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:51:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F676050E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656643887; x=1688179887;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AopVrWGXnsJRIEhmOzSujbJkr+GZyNYqp6XggxtijZg=;
  b=esNY1dQO0Njv1ul0lTQs56nE5PJwW7KriFl7UOA31r7T07J+gbnF/mv0
   qHUjjqhFSKRgjskcCFPsGT6S1Vh/CyN0cA0FxK6MrcP31DViB1pAlI7ps
   p98EhVGKyq4eJNhU1e7QkfA84lUtBRsMrH8pCwoe2XwmA2wOsoxc/BMeK
   ZW5pGksu8pOEgJdz3mbHaPIh8e8Qo+nRRjVf6ARBfZt+2ZVZOPeGO+pog
   x1G9twliwwqng4sfB5ne0KsHb/DOzOcfn4bPZbw/3ZHvsAl+yn0JWVfwj
   /tC1Vm9w1y9DGD0vEY5cN1H+TqpOk59YLcGCHdre9pg1VXXt99YAc5oUe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="280085577"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="280085577"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 19:51:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="596070246"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2022 19:51:21 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o76kb-000DSM-5G;
        Fri, 01 Jul 2022 02:51:21 +0000
Date:   Fri, 1 Jul 2022 10:51:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/050-nvme 8/10] drivers/soc/apple/rtkit.c:665:16:
 error: implicit declaration of function 'mbox_client_poll_data'; did you
 mean 'mbox_client_peek_data'?
Message-ID: <202207011043.6SO82QmX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hector,

FYI, the error/warning still remains.

tree:   https://github.com/AsahiLinux/linux bits/050-nvme
head:   5b3910635863df45900af347c932d5468e7541fc
commit: ecb1172a9cbf4c3ad18fa5c259380a116c2f00e6 [8/10] soc: apple: rtkit: Add apple_rtkit_poll
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220701/202207011043.6SO82QmX-lkp@intel.com/config)
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

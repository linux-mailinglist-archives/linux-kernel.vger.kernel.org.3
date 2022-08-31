Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50875A7324
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiHaBDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiHaBDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:03:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5040FA6C53
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661907824; x=1693443824;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tX+TjnyXqVXPvOR4/+iT9qIqdeghblNu2RDoEAGKR20=;
  b=I/6g/4ksRZsn2y7nclABqXa5h4Pe/0Cs3BAXpU+cTWDUjKZMkrA9NhdQ
   32LTgscWijCIxh+m/trMnu/9Vi9s3xTxX4JAW+8IVDw13C1wnDB4SCy16
   Rfm7vz/ajgHPwzFAXeWlOlsKDNDjVsgNfkmlrfBwQY7/74HSMaB3uTHpb
   ZejCq+hotTn2ZeE4xk8HNylfYMr637Tg9LnPYWSPBRhpfNDs6KMg0wz0U
   ygmj3Va+EMY8Ql5kV8voaYUMxHWXnMWYFw5AF3NyxRNYrG1N4+xiF+WsV
   2Kb3gqYaPXddiDCCGflOC18Ec/GsxKIibgbhSShBRsvcPLjZzkBoigHUk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="321479038"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="321479038"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 18:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="645055741"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2022 18:03:42 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTC8r-0000p0-2Y;
        Wed, 31 Aug 2022 01:03:41 +0000
Date:   Wed, 31 Aug 2022 09:03:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [rmk-arm:for-next 5/7] init.c:undefined reference to
 `phys_initrd_start'
Message-ID: <202208310849.IBlVCgFP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm for-next
head:   a72b4b3ba681398a3ac1c1384efb949bef3ac846
commit: b35b2736b43d7124e7da6a8050b8fd9e02f9f734 [5/7] ARM: 9230/1: Support initrd with address in boot alias region
config: arm-eseries_pxa_defconfig (https://download.01.org/0day-ci/archive/20220831/202208310849.IBlVCgFP-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm for-next
        git checkout b35b2736b43d7124e7da6a8050b8fd9e02f9f734
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/mm/init.o: in function `arm_memblock_init':
>> init.c:(.init.text+0x1bc): undefined reference to `phys_initrd_start'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

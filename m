Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B540E5A70EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiH3Wko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiH3Wkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:40:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE126112B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661899237; x=1693435237;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ssOen9gMwWszYXe8Aqt0EdnvPZbxdbBLQnTCjQyphh8=;
  b=c/o/wCYx1Gr5CL/mLGPKRIAirwDbOO2pHnIHrE0L/9CejEh2H6Dtqf6J
   VVb+P21I/M51HyZTRmCP/ZBJld9rVgzMcnvTQUYhnaUulMq9WX0RGZACm
   uFfb2Xjq6G9IAHoKmMCq+7nSoBQ8gV7689EiwFr1kQUS+nkQvFMCrv8dh
   GFbOoo+hnyL7m1/ZlujWG1nnzLl9Z+pR65qKbGLf9+WGKms9SQDcyafxq
   WIKazRxyogEQkT4p1POopQ1njVircrzt+s4rB2lFgwNi0RzbS82NeREpu
   kG5AarS+pP9FQLrE+QyL0mM97UQO/jrpszR/CsxUOG7BTlayS2MliI2xW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="275723914"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="275723914"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 15:40:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="754223688"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 30 Aug 2022 15:40:35 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oT9uM-0000hR-33;
        Tue, 30 Aug 2022 22:40:34 +0000
Date:   Wed, 31 Aug 2022 06:39:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [rmk-arm:for-next 5/7] ld.lld: error: undefined symbol:
 phys_initrd_start
Message-ID: <202208310617.FHNEaNba-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm for-next
head:   a72b4b3ba681398a3ac1c1384efb949bef3ac846
commit: b35b2736b43d7124e7da6a8050b8fd9e02f9f734 [5/7] ARM: 9230/1: Support initrd with address in boot alias region
config: arm-pcm027_defconfig (https://download.01.org/0day-ci/archive/20220831/202208310617.FHNEaNba-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c7df82e4693c19e3fd2e25c83eb04d9deb7b7b59)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm for-next
        git checkout b35b2736b43d7124e7da6a8050b8fd9e02f9f734
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: phys_initrd_start
   >>> referenced by init.c
   >>>               mm/init.o:(arm_memblock_init) in archive arch/arm/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

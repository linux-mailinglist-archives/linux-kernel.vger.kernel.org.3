Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AD9568772
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiGFL4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiGFL4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:56:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3617528E13
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657108562; x=1688644562;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rrVUGL1hQFrMMOx+bu7YIMhdntBvJVEMHDlL9uzKXHk=;
  b=lorHlT/qltpZNR2VY5dwdWmMGAUsxg95V8Gmq0PuXTf3l9abspuEVIdC
   iWY6GR+HV6VaG3kU2yZCr6sREXp+W/ZcyiFfPMJ6YUHY7Zt0/O1hiKDy5
   Sdj/6U4i7JjsbbdfS8hkXVIvkatAaseY5RnMS/FRAybNJeONLChqsP9hy
   9/Igtv8S+HK8uBmDXxLQ9qos5mI2x90Hdlurlka/EbSo5GBWD1gIk8AC1
   8z0/Hg2RcmqPKQD/lw8STfxwcRtSJih00PNfRBs/V/6UR8tBeaFBwHAsU
   judHQI6aw3iCS6NbwqpOu/Cxk/INfPZ/gLuNO4XB3feRDDYArumBIlL5+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284461820"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="284461820"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 04:56:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="660941304"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2022 04:56:01 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o93dQ-000KXp-Tv;
        Wed, 06 Jul 2022 11:56:00 +0000
Date:   Wed, 6 Jul 2022 19:55:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/master 1/1]
 include/linux/random.h:109:10: fatal error: asm/archrandom.h: No such file
 or directory
Message-ID: <202207061910.VG60q3Ln-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/master
head:   b06ae5cc5acfc776074b6fa7580a3e33fd999734
commit: b06ae5cc5acfc776074b6fa7580a3e33fd999734 [1/1] random: remove CONFIG_ARCH_RANDOM
config: riscv-randconfig-r042-20220703 (https://download.01.org/0day-ci/archive/20220706/202207061910.VG60q3Ln-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/b06ae5cc5acfc776074b6fa7580a3e33fd999734
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/master
        git checkout b06ae5cc5acfc776074b6fa7580a3e33fd999734
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/net.h:18,
                    from include/linux/skbuff.h:26,
                    from include/linux/if_ether.h:19,
                    from include/media/tveeprom.h:8,
                    from drivers/media/usb/cx231xx/cx231xx-cards.c:18:
>> include/linux/random.h:109:10: fatal error: asm/archrandom.h: No such file or directory
     109 | #include <asm/archrandom.h>
         |          ^~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +109 include/linux/random.h

5960164fde9bc2 Joe Eykholt        2010-05-26  108  
63d77173266c17 H. Peter Anvin     2011-07-31 @109  #include <asm/archrandom.h>
b06ae5cc5acfc7 Jason A. Donenfeld 2022-07-05  110  

:::::: The code at line 109 was first introduced by commit
:::::: 63d77173266c1791f1553e9e8ccea65dc87c4485 random: Add support for architectural random hooks

:::::: TO: H. Peter Anvin <hpa@zytor.com>
:::::: CC: H. Peter Anvin <hpa@zytor.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

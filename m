Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5525045C3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 01:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiDPXaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 19:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiDPX36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 19:29:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70ED81DF
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 16:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650151645; x=1681687645;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JxMqWf/KQpqO9i4AJkYitosT7mAUrEoZbX3zEv00y+M=;
  b=mCFxAW+kqq92pxU6EIz7xpy1hfnEuhsyAf1CpEsWVsp6ybnrIjwuQxdr
   A5uOYNkjP8HjFs+WAlTWh+CYrj42qS8dmRj/BBVaM0PnwqkFPnVgUJH4w
   XSKLWagkRTqBAkVTqT1UXCB0Nt+c6pcgRqlfZdHr7kT3S4fbwis/his1f
   p4gMHzwZPYLPauucifdnFl0x2J4SWaxxBq3rRnuIXS1DNMnIcYOuc1nUf
   3A7oYUToaMEBtrbvKFH3z7SgDlL5FsTV74q/39Kjw6b3h6REHx6nNNxYT
   W4cIsZUYfF8w3jJdjmTbfKlmOIVjjjveDjT8WH3aCPTOtI4V3R+P9q14L
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="349795087"
X-IronPort-AV: E=Sophos;i="5.90,266,1643702400"; 
   d="scan'208";a="349795087"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 16:27:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,266,1643702400"; 
   d="scan'208";a="663653512"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Apr 2022 16:27:21 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfrp2-0003Yt-Ud;
        Sat, 16 Apr 2022 23:27:20 +0000
Date:   Sun, 17 Apr 2022 07:26:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dan Li <ashimida@linux.alibaba.com>
Subject: [kees:for-next/lkdtm 6/6] drivers/misc/lkdtm/cfi.c:62:37: warning:
 cast from pointer to integer of different size
Message-ID: <202204170710.LwCV5Ec0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/lkdtm
head:   2e53b877dc1258d4ac3de98f496bb88ec3bf5e25
commit: 2e53b877dc1258d4ac3de98f496bb88ec3bf5e25 [6/6] lkdtm: Add CFI_BACKWARD to test ROP mitigations
config: sparc-randconfig-r026-20220417 (https://download.01.org/0day-ci/archive/20220417/202204170710.LwCV5Ec0-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=2e53b877dc1258d4ac3de98f496bb88ec3bf5e25
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees for-next/lkdtm
        git checkout 2e53b877dc1258d4ac3de98f496bb88ec3bf5e25
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash drivers/misc/lkdtm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/misc/lkdtm/cfi.c: In function 'set_return_addr_unchecked':
>> drivers/misc/lkdtm/cfi.c:62:37: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      62 |         ((__force __typeof__(addr))((__force u64)(addr) | PAGE_OFFSET))
         |                                     ^
   drivers/misc/lkdtm/cfi.c:72:13: note: in expansion of macro 'no_pac_addr'
      72 |         if (no_pac_addr(*ret_addr) == expected)
         |             ^~~~~~~~~~~
>> drivers/misc/lkdtm/cfi.c:62:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      62 |         ((__force __typeof__(addr))((__force u64)(addr) | PAGE_OFFSET))
         |          ^
   drivers/misc/lkdtm/cfi.c:72:13: note: in expansion of macro 'no_pac_addr'
      72 |         if (no_pac_addr(*ret_addr) == expected)
         |             ^~~~~~~~~~~
   drivers/misc/lkdtm/cfi.c: In function 'set_return_addr':
>> drivers/misc/lkdtm/cfi.c:62:37: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      62 |         ((__force __typeof__(addr))((__force u64)(addr) | PAGE_OFFSET))
         |                                     ^
   drivers/misc/lkdtm/cfi.c:87:13: note: in expansion of macro 'no_pac_addr'
      87 |         if (no_pac_addr(*ret_addr) == expected)
         |             ^~~~~~~~~~~
>> drivers/misc/lkdtm/cfi.c:62:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      62 |         ((__force __typeof__(addr))((__force u64)(addr) | PAGE_OFFSET))
         |          ^
   drivers/misc/lkdtm/cfi.c:87:13: note: in expansion of macro 'no_pac_addr'
      87 |         if (no_pac_addr(*ret_addr) == expected)
         |             ^~~~~~~~~~~


vim +62 drivers/misc/lkdtm/cfi.c

    60	
    61	#define no_pac_addr(addr)      \
  > 62		((__force __typeof__(addr))((__force u64)(addr) | PAGE_OFFSET))
    63	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

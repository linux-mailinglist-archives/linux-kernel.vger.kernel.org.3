Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD7050600C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbiDRXBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiDRXBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:01:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9752D1F4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 15:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650322747; x=1681858747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qb24R7mKiVGUdMVc7ONgEkmnK/atyRN5jqb3qYtPfig=;
  b=Ftd53XdM506ufa/F6uWwdt+xR7/ORgUXrHKlQYGkIMhBrXlXlvba0wc+
   4XtXtTlOoZxnv9+NBvQl1UjuO9XiRLZdQ+JpEpZxYcV5WFZLNovc5k8JS
   8Nfvc9rNC9gnIrCmg9rSEXDWI0QBcyzOpz+qZCdZz+YCWF50qVzWco83E
   Xa0Z90LdRUdPssbqpCsA4oHC+6tPCtOxjB54nFvr/kRilwQBpCA3okXDz
   IQqqL2yNm3cxeURjwRsm0NC6AENM/8fvTiArgtjqSSvhorc51633JWRz5
   ps1bjNNadAp9kS7N6ikw0ZpDXukJUhgPv0IG2ycfNLeBgF5sdxtX8zMnh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="243560840"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="243560840"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 15:59:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="647033809"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Apr 2022 15:59:04 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngaKl-00054C-98;
        Mon, 18 Apr 2022 22:59:03 +0000
Date:   Tue, 19 Apr 2022 06:58:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom Rix <trix@redhat.com>, nsaenz@kernel.org,
        bcm-kernel-feedback-list@broadcom.com, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, gascoar@gmail.com, ojaswin98@gmail.com
Cc:     kbuild-all@lists.01.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] staging: vchiq_arm: change vchiq_platform_init from
 global to static
Message-ID: <202204190650.yy0x0YCl-lkp@intel.com>
References: <20220418164356.3532969-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418164356.3532969-1-trix@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

I love your patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Tom-Rix/staging-vchiq_arm-change-vchiq_platform_init-from-global-to-static/20220419-004611
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git bed6d200f8ca38e1ecbdd8fb7e0564884002abd1
config: sparc-randconfig-c004-20220417 (https://download.01.org/0day-ci/archive/20220419/202204190650.yy0x0YCl-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/192ca8cdfd692f17162557c64e8d533c816eccff
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tom-Rix/staging-vchiq_arm-change-vchiq_platform_init-from-global-to-static/20220419-004611
        git checkout 192ca8cdfd692f17162557c64e8d533c816eccff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash drivers/staging/vc04_services/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:20,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:8:
   In function 'memcpy_to_page',
       inlined from 'free_pagelist' at drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:434:4:
>> arch/sparc/include/asm/string.h:15:25: warning: argument 2 null where non-null expected [-Wnonnull]
      15 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/highmem.h:353:9: note: in expansion of macro 'memcpy'
     353 |         memcpy(to + offset, from, len);
         |         ^~~~~~
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: In function 'free_pagelist':
   arch/sparc/include/asm/string.h:15:25: note: in a call to built-in function '__builtin_memcpy'
      15 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/highmem.h:353:9: note: in expansion of macro 'memcpy'
     353 |         memcpy(to + offset, from, len);
         |         ^~~~~~
   In function 'memcpy_to_page',
       inlined from 'free_pagelist' at drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:441:4:
   arch/sparc/include/asm/string.h:15:25: warning: '__builtin_memcpy' offset 0 is out of the bounds [0, 0] [-Warray-bounds]
      15 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/highmem.h:353:9: note: in expansion of macro 'memcpy'
     353 |         memcpy(to + offset, from, len);
         |         ^~~~~~


vim +15 arch/sparc/include/asm/string.h

70a6fcf3283a0a Al Viro 2016-01-17  13  
70a6fcf3283a0a Al Viro 2016-01-17  14  #define __HAVE_ARCH_MEMCPY
70a6fcf3283a0a Al Viro 2016-01-17 @15  #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
70a6fcf3283a0a Al Viro 2016-01-17  16  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7E05338BD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbiEYIpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiEYIpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:45:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120C054688
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653468350; x=1685004350;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TPB4podfpj//Jo+j3unxVqcfYk3T0hs24iEtDSYrG+s=;
  b=BGc3+qu5v2LoESciVLGG4Q4tp2qF9yCubbgsNZ/3jkQ170vDZTZlcf5e
   NySCiBeKH17hhjuIY/TVs0ju1s2axuD7afxc83mpDV1AlnARKOmz5+Rov
   czGx3g66ROK5W7nbj0daMRrjRUNVXd1vGlMmlB6+4LE7lUDG2nRWTJhyw
   ZPDco2/1ztPTouH8gNzPgUu6uUDW7Rmk35O7ziSrPRgMs8xV6qvSaDVhK
   CX6XK2x0GwaD4twt2qP0glSBsoZmOOzvLUDFE42w85ZMeJ7gwtVDe0BVW
   zAoNsp0xYBibj5U31bUZhhkbI3/CVnwV4+k224K7pUmf3RjsLifvXBydj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="261368475"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="261368475"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 01:45:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="630258703"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 25 May 2022 01:45:48 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntmeJ-0002sk-OQ;
        Wed, 25 May 2022 08:45:47 +0000
Date:   Wed, 25 May 2022 16:45:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [krzk-github:n/dt-bindings-dts-samsung-pinctrl-cleanup 7/10]
 include/dt-bindings/pinctrl/samsung.h:13:2: warning: #warning "These
 bindings were deprecated, because they do not match" "the actual bindings
 but register values." "Instead include the header in the DTS source
 directory."
Message-ID: <202205251614.hoErFzuj-lkp@intel.com>
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

tree:   https://github.com/krzk/linux n/dt-bindings-dts-samsung-pinctrl-cleanup
head:   4b2c064cabc3a8c762322ec4fa48ccbc92d178cb
commit: 344a48ef864729dc234712c413a8157ca7f73b5f [7/10] dt-bindings: pinctrl: deprecate header with register constants
config: csky-randconfig-r013-20220524 (https://download.01.org/0day-ci/archive/20220525/202205251614.hoErFzuj-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/krzk/linux/commit/344a48ef864729dc234712c413a8157ca7f73b5f
        git remote add krzk-github https://github.com/krzk/linux
        git fetch --no-tags krzk-github n/dt-bindings-dts-samsung-pinctrl-cleanup
        git checkout 344a48ef864729dc234712c413a8157ca7f73b5f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/pinctrl/samsung/pinctrl-samsung.c:29:
>> include/dt-bindings/pinctrl/samsung.h:13:2: warning: #warning "These bindings were deprecated, because they do not match" "the actual bindings but register values." "Instead include the header in the DTS source directory." [-Wcpp]
      13 | #warning "These bindings were deprecated, because they do not match" \
         |  ^~~~~~~


vim +13 include/dt-bindings/pinctrl/samsung.h

    12	
  > 13	#warning "These bindings were deprecated, because they do not match" \
    14		  "the actual bindings but register values." \
    15		  "Instead include the header in the DTS source directory."
    16	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

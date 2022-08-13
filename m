Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFB45919F7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 13:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiHMLFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 07:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMLFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 07:05:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605DB6367
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 04:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660388718; x=1691924718;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8z5KIT6xVQZNvg5HTl9xBw8GPnHDC1QRBkka0y0uBHU=;
  b=Hlno+qD9OtMhmnKh4UGarn/VWC8N+tOvgDF9AxM1oh2l7qI0xt0NwuhX
   b/fglCLrQJ+Y9NLxOR+ajbEj7BhUQDXX62sZLTYTMu4VAHz0sZvNjZN2a
   G5zLN2ACxxEERMxZjiVyBTpmyAWHBvBVHQh2pfhxxsqcY4VUG1tpWVuXZ
   iJVCZvP8pKnhiKqQJKXiyDUhqWvZqFZlSVK2jon4MzrtOMwwcxA+YOCYg
   f2NxVAueX/qs0ijT4fT0Ru3ySAx8Fue7eC28xELskTIzCEFipJJx70ULD
   M2Js+M6jpkiLwMW1uUN8bGtz/bbsM1A6kI5QIGGQoCiL+Lh9yTLxsrdoO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="289314654"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="289314654"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 04:05:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="606182246"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2022 04:05:16 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMox9-0001bR-2A;
        Sat, 13 Aug 2022 11:05:15 +0000
Date:   Sat, 13 Aug 2022 19:04:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [rmk-arm:zii 79/88] drivers/net/dsa/ocelot/felix.c:952:30: error:
 use of undeclared identifier 'state'
Message-ID: <202208131936.OLjzZFs7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm zii
head:   62e6058fe979d92f54ea23e9a25dea2ab56880c8
commit: a89c8c1532e643454f4e463813183b5087b014f1 [79/88] net: dsa: ocelot: alternative
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220813/202208131936.OLjzZFs7-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm zii
        git checkout a89c8c1532e643454f4e463813183b5087b014f1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/dsa/ocelot/felix.c:952:30: error: use of undeclared identifier 'state'
                           felix->info->phylink_caps(state->interface);
                                                     ^
   1 error generated.


vim +/state +952 drivers/net/dsa/ocelot/felix.c

   938	
   939	static void felix_phylink_get_caps(struct dsa_switch *ds, int port,
   940					   struct phylink_config *config,
   941					   phy_interface_t *default_interface)
   942	{
   943		struct ocelot *ocelot = ds->priv;
   944		struct felix *felix;
   945	
   946		__set_bit(ocelot->ports[port]->phy_mode,
   947			  config->supported_interfaces);
   948	
   949		felix = ocelot_to_felix(ocelot);
   950		if (felix->info->phylink_caps)
   951			config->mac_capabilities =
 > 952				felix->info->phylink_caps(state->interface);
   953	}
   954	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

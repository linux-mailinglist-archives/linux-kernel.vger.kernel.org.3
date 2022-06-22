Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2897C553F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 02:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355045AbiFVAan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 20:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiFVAal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 20:30:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE732F3BD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 17:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655857840; x=1687393840;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PT8n3HVw02awrOvWFMR1O5kCUH7Bdkykhe2oBPlaVfE=;
  b=CXib6Cp/WoBLAs4hseu/s5AeYzwgUst19Me6HMFgCey99ggc5Kx1tCeM
   Hm0zzrALjxvs97ETxwW4LXLfry3gwKBHzjjg8PDx+61iztp/BfieBaLJI
   Q9h1lselzpdxMK/XPbdgV5bm8Z3Yv5JDppgRpwJik7bPC1p6F/HygSERd
   MfjJLuJNReu0AbcjVMFKumjyPfEkYDQVd583TEGN++B0W6kpbKYgsU1RJ
   S+k+6BYTYejW9UHxVGFSWVGj51pstgi/itTKA5HvubPZzsPGy+UYewAFU
   b+nfJV7WIkqubuhkrrZIG5pjcpWCvMYKpxVHzSJVHhlcb2mA8rZtVUPYj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="277822808"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="277822808"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 17:30:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="690205579"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2022 17:30:21 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3oGC-0000bx-DU;
        Wed, 22 Jun 2022 00:30:20 +0000
Date:   Wed, 22 Jun 2022 08:29:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:zii 35/107] drivers/net/phy/phylink.c:1328: warning:
 expecting prototype for phylink_set_fixe_linkd(). Prototype was for
 phylink_set_fixed_link() instead
Message-ID: <202206220816.cnquFKGD-lkp@intel.com>
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
head:   aedc75cf78fca1c8b7052c5d59981354f47e2e48
commit: 5c17680ea9fcb1a7cf664279fe1bcf51934dcdaa [35/107] net: phylink: add phylink_set_fixed_link()
config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20220622/202206220816.cnquFKGD-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm zii
        git checkout 5c17680ea9fcb1a7cf664279fe1bcf51934dcdaa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/net/phy/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/phy/phylink.c:1328: warning: expecting prototype for phylink_set_fixe_linkd(). Prototype was for phylink_set_fixed_link() instead


vim +1328 drivers/net/phy/phylink.c

  1317	
  1318	/**
  1319	 * phylink_set_fixe_linkd() - set a fixed link configuration for phylink
  1320	 * @pl: a pointer to a &struct phylink returned from phylink_create()
  1321	 * @speed: a SPEED_xx constant
  1322	 * @duplex: DUPLEX_FULL or DUPLEX_HALF
  1323	 *
  1324	 * Set a fixed-link configuration for the phylink instance immediately
  1325	 * after creation. Must not be used at any other time.
  1326	 */
  1327	int phylink_set_fixed_link(struct phylink *pl, int speed, int duplex)
> 1328	{
  1329		if (pl->cfg_link_an_mode != MLO_AN_PHY || pl->phydev || pl->sfp_bus)
  1330			return -EINVAL;
  1331	
  1332		pl->link_config.speed = speed;
  1333		pl->link_config.duplex = duplex;
  1334		pl->link_config.link = 1;
  1335		pl->cfg_link_an_mode = MLO_AN_FIXED;
  1336		pl->cur_link_an_mode = MLO_AN_FIXED;
  1337	
  1338		return 0;
  1339	}
  1340	EXPORT_SYMBOL_GPL(phylink_set_fixed_link);
  1341	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78830535724
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 02:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiE0AhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 20:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiE0AhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 20:37:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20BB30540
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 17:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653611823; x=1685147823;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DVAKz+z7unl2ZeUfJywVPkHBwMKOYVaMFgQfUcfVF08=;
  b=mtFFSw2zZYg9cmLisoa+tK8P21cVHmogJTFumblXNZRPlAHuLha6VEjM
   KXJXvoiRV+q+eYnAxZeXy1BIzRDpAdeBouXNrix5uNpfhkWMzzGaVMemc
   Sp3PdCI5vIOWLAqI/g2SDs7qrLck0IzjDGHmOGpRf1Lv+ksKajl6cZxT3
   WoWH4gjeKKBPOjstYN7sQkmOpKm9yj5kKXfRToywAE7jxuggczYCpaWcI
   RcBVKG7TPy36/wWChI5BehnkjQkys+NC09N1zS+mUVMBCYHf67s3zqAGe
   sxWOfVhe/ESv1e2HcjNaGBzsz/7p2XZD0sQ+XTBFq2DYgLQQxKGJKlLR5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="337384121"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="337384121"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 17:37:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="549867791"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 May 2022 17:37:02 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuNyP-0004HW-B2;
        Fri, 27 May 2022 00:37:01 +0000
Date:   Fri, 27 May 2022 08:36:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:zii 46/96] drivers/net/dsa/bcm_sf2.c:744:30: warning:
 unused variable 'priv'
Message-ID: <202205270808.9IZEVfpD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm zii
head:   c753f621782532ea52e3fc51d84128421e546ee6
commit: 18d04811ce6c67fcd6a047f4323216e153590ba1 [46/96] net: dsa: bcm_sf2: fix pause mode validation
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220527/202205270808.9IZEVfpD-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm zii
        git checkout 18d04811ce6c67fcd6a047f4323216e153590ba1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/dsa/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/dsa/bcm_sf2.c: In function 'bcm_sf2_sw_validate':
>> drivers/net/dsa/bcm_sf2.c:744:30: warning: unused variable 'priv' [-Wunused-variable]
     744 |         struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
         |                              ^~~~


vim +/priv +744 drivers/net/dsa/bcm_sf2.c

   739	
   740	static void bcm_sf2_sw_validate(struct dsa_switch *ds, int port,
   741					unsigned long *supported,
   742					struct phylink_link_state *state)
   743	{
 > 744		struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
   745		__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
   746		u32 caps;
   747	
   748		caps = dsa_to_port(ds, port)->pl_config.mac_capabilities;
   749	
   750		/* Pause modes are only programmed for these modes - see FIXME 3.
   751		 * So, as pause modes are not configured for other modes, disable
   752		 * support for them.
   753		 */
   754		if (!(state->interface == PHY_INTERFACE_MODE_RGMII ||
   755		      state->interface == PHY_INTERFACE_MODE_RGMII_TXID ||
   756		      state->interface == PHY_INTERFACE_MODE_MII ||
   757		      state->interface == PHY_INTERFACE_MODE_REVMII))
   758			caps &= ~(MAC_ASYM_PAUSE | MAC_SYM_PAUSE);
   759	
   760		/* Allow all the expected bits */
   761		phylink_set(mask, Autoneg);
   762		phylink_set_port_modes(mask);
   763		phylink_get_linkmodes(mask, state->interface, caps);
   764	
   765		linkmode_and(supported, supported, mask);
   766		linkmode_and(state->advertising, state->advertising, mask);
   767	}
   768	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

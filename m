Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482E1554474
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352797AbiFVHen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349994AbiFVHej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:34:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE5637019
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655883279; x=1687419279;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IWwa5IGnJiVpfEr6VWGmLAjNqADqem50Vc30yOX/3QM=;
  b=Tz2HBSNAbqsNkniZ4ZqBFBLPtbuQizsArQL5RbpMzSI9oa47C3uBqTcp
   yM03j+26pDY4d3YaotZOSq2cp58GSW7qF7l5kYtRxn8CUlsEaqES4TpB/
   vvSo6YvEyyVKMtaipxmASM3SMe/I4FYLVetJrYQqSekFqaQjpBiuVM7+N
   U15hi2jpRsXF9JxVRZ2r5lcUhOGvOQ4MsuDgcVg+xiQ8zvd0e+9uQvwTA
   7hDbdhDrwZMobqmTaLFPztYftUB1ORN8N78w/wQZJt3gslAsZ5SNPD3te
   QN459sSeWo4FD185cPm/i0+JeJXko70/UhRqiwwQ/XMnP5na87OI7bvqp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="260773211"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="260773211"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 00:34:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="690355885"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jun 2022 00:34:38 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3usn-000104-FF;
        Wed, 22 Jun 2022 07:34:37 +0000
Date:   Wed, 22 Jun 2022 15:34:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:zii 65/107] drivers/net/dsa/bcm_sf2.c:745:30: warning:
 unused variable 'priv'
Message-ID: <202206221528.TbeRpvmI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm zii
head:   aedc75cf78fca1c8b7052c5d59981354f47e2e48
commit: 78353a06b7aa098b1dc5bad04970b02cbcf312df [65/107] net: dsa: bcm_sf2: fix pause mode validation
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220622/202206221528.TbeRpvmI-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm zii
        git checkout 78353a06b7aa098b1dc5bad04970b02cbcf312df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/dsa/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/dsa/bcm_sf2.c: In function 'bcm_sf2_sw_validate':
>> drivers/net/dsa/bcm_sf2.c:745:30: warning: unused variable 'priv' [-Wunused-variable]
     745 |         struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
         |                              ^~~~


vim +/priv +745 drivers/net/dsa/bcm_sf2.c

   740	
   741	static void bcm_sf2_sw_validate(struct dsa_switch *ds, int port,
   742					unsigned long *supported,
   743					struct phylink_link_state *state)
   744	{
 > 745		struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
   746		__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
   747		u32 caps;
   748	
   749		caps = dsa_to_port(ds, port)->pl_config.mac_capabilities;
   750	
   751		/* Pause modes are only programmed for these modes - see FIXME 3.
   752		 * So, as pause modes are not configured for other modes, disable
   753		 * support for them.
   754		 */
   755		if (!(state->interface == PHY_INTERFACE_MODE_RGMII ||
   756		      state->interface == PHY_INTERFACE_MODE_RGMII_TXID ||
   757		      state->interface == PHY_INTERFACE_MODE_MII ||
   758		      state->interface == PHY_INTERFACE_MODE_REVMII))
   759			caps &= ~(MAC_ASYM_PAUSE | MAC_SYM_PAUSE);
   760	
   761		/* Allow all the expected bits */
   762		phylink_set(mask, Autoneg);
   763		phylink_set_port_modes(mask);
   764		phylink_get_linkmodes(mask, state->interface, caps);
   765	
   766		linkmode_and(supported, supported, mask);
   767		linkmode_and(state->advertising, state->advertising, mask);
   768	}
   769	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

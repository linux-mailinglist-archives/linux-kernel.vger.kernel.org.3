Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE73591889
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 06:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbiHMELQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 00:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiHMELM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 00:11:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7735F639A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 21:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660363870; x=1691899870;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0EGI9s0bBVNXb5z0Rkb7cK5cz+KhXiWCzGcHQOEcA+s=;
  b=mSELckSWs1kdhgF9EnOQ+2gG9I6lQqQ+kyfo/oIhprW0P6YnjZQrfoRu
   ENYUVWDtNkvOeNCOcKw4TfkpTygHnHFmO0TxULgM4wotlR5e0wPsE4jsX
   +AQVKQ3aBTIIyCHJpEkAmXkqlWXUy2qjNMB34PvgvzpN+Dipb+6vDRMiy
   fccS4ilJX16QFCli4jXzQqUtIQ+gvFuTQrK7v/FNtcA97pRfPwx6xyBQT
   1ZEIYFCiyXI5+BweeiZxrv6Z9+SO+MrrOQHe5+2g5emZV/O4yg3hgDfP7
   0kisXeV49evD1gFFdKZHjhAtmgAgwg3xZDCUeGVuEiktyn3IMDWL8zfsN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="278680016"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="278680016"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 21:11:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="732431431"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Aug 2022 21:11:07 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMiUN-0001I7-0U;
        Sat, 13 Aug 2022 04:11:07 +0000
Date:   Sat, 13 Aug 2022 12:10:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:zii 79/88] drivers/net/dsa/ocelot/felix.c:952:51: error:
 'state' undeclared; did you mean 'statx'?
Message-ID: <202208131225.U1oc7xRz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm zii
head:   62e6058fe979d92f54ea23e9a25dea2ab56880c8
commit: a89c8c1532e643454f4e463813183b5087b014f1 [79/88] net: dsa: ocelot: alternative
config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20220813/202208131225.U1oc7xRz-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm zii
        git checkout a89c8c1532e643454f4e463813183b5087b014f1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/net/dsa/ocelot/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/dsa/ocelot/felix.c: In function 'felix_phylink_get_caps':
>> drivers/net/dsa/ocelot/felix.c:952:51: error: 'state' undeclared (first use in this function); did you mean 'statx'?
     952 |                         felix->info->phylink_caps(state->interface);
         |                                                   ^~~~~
         |                                                   statx
   drivers/net/dsa/ocelot/felix.c:952:51: note: each undeclared identifier is reported only once for each function it appears in


vim +952 drivers/net/dsa/ocelot/felix.c

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

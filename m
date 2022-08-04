Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1807658A1FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 22:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbiHDUhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 16:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiHDUhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:37:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9707D27B0B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659645456; x=1691181456;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4uv49xID9uNYP2M7Joe9MR3cY2BuJ9sDe9MmLTYJSsM=;
  b=cxrxTUZe/sJwSsRA/Q4ZL2/Gz+E+mRLoCRj+bAXsJwORCBYjBC33Py5S
   T9JeIN8S5MGp1yYnmKdZIRfReZZYHyjHGTmaVKgCrfoWmJ527CyfxitAl
   /dfaQwvM8kPFdQPpZwVEBh6d46QmApuJK6wn99mhRQsYauwj3bQwGWAwk
   5XWVEiJK9+Kt642UgxzdhYM/ge/l+K5faVk5Eb+uLm0Z0sUOMnQI1WfYE
   KrpaCRJnIY5V8gEp2zk7CdDCcNwyaxxFqKXKg4c1rfohqH4yDyUS+HQIn
   7uHl9zddBhc5iKaeD8LHkzpZtSr8Effl4ddCAhTr/qlR+H6H2snSN8cCB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="276959980"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="276959980"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 13:37:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="579223065"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Aug 2022 13:37:35 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJhb4-000Ipt-1h;
        Thu, 04 Aug 2022 20:37:34 +0000
Date:   Fri, 5 Aug 2022 04:37:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:zii 78/87] drivers/net/dsa/ocelot/felix.c:952:51: error:
 'state' undeclared; did you mean 'statx'?
Message-ID: <202208050438.TH4My4lR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm zii
head:   315d00812d1f8ed8bbbce4e4fd8d32fc883900a0
commit: f8d2148d3f86d7253a86ccbf0e9af7071457218a [78/87] net: dsa: ocelot: alternative
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220805/202208050438.TH4My4lR-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm zii
        git checkout f8d2148d3f86d7253a86ccbf0e9af7071457218a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash

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

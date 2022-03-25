Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274C74E6F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 09:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354207AbiCYI0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 04:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241127AbiCYI0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 04:26:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78065B7157
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 01:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648196695; x=1679732695;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0Wx1h6e8sHp5XGHZUVFBH1EF/fnkJWCy6zP38gcfjUY=;
  b=Ax6TqUryWBUWe6N2BfLnDitO3uqVofmBj5WWFfYjUtxkQoeysV6m8wTV
   fZBNpBCGs1Yod1TmZRC3asIEDCLevp9a3KhaQ+uYch4Wi2MI1jzSaH64+
   DjouVIjoaZIXhfYnAy7oocg2YI4XYFyf1qHnyiPq1lXwov0jW3SbkN1PY
   zg0Y1Md3PDn7dspHXSHzoYOx+K53j9ssCI/UzhscJsUtQTJK+G3Bt6ZBX
   bzikxdEhP0/cCVU1JHIfFPO70RBm4NiTIDUyysRzvtAFFsYYn2WXMGiLj
   7w48/DN0RYmVw7OO0HV7HzAbuVJivE7iX7Nb9anIPFzupQEMyj9DhTSZ2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="240741638"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="240741638"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 01:24:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="584396422"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Mar 2022 01:24:52 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXfFb-000Ly0-UJ; Fri, 25 Mar 2022 08:24:51 +0000
Date:   Fri, 25 Mar 2022 16:24:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/net/ethernet/smsc/smc91c92_cs.c:447: undefined reference to
 `ioremap'
Message-ID: <202203251649.NgVhssp8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   34af78c4e616c359ed428d79fe4758a35d2c5473
commit: f9b3cd24578401e7a392974b3353277286e49cee Kconfig.debug: make DEBUG_INFO selectable from a choice
date:   30 hours ago
config: s390-randconfig-r022-20220325 (https://download.01.org/0day-ci/archive/20220325/202203251649.NgVhssp8-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9b3cd24578401e7a392974b3353277286e49cee
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f9b3cd24578401e7a392974b3353277286e49cee
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/net/ethernet/altera/altera_tse_main.o: in function `request_and_map':
   drivers/net/ethernet/altera/altera_tse_main.c:1335: undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/net/ethernet/smsc/smc91c92_cs.o: in function `mhz_mfc_config':
>> drivers/net/ethernet/smsc/smc91c92_cs.c:447: undefined reference to `ioremap'
   s390-linux-ld: drivers/net/ethernet/smsc/smc91c92_cs.o: in function `smc91c92_release':
>> drivers/net/ethernet/smsc/smc91c92_cs.c:962: undefined reference to `iounmap'
>> s390-linux-ld: drivers/net/ethernet/smsc/smc91c92_cs.c:962: undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/xircom/xirc2ps_cs.o: in function `xirc2ps_release':
>> drivers/net/ethernet/xircom/xirc2ps_cs.c:929: undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/xircom/xirc2ps_cs.o: in function `xirc2ps_config':
>> drivers/net/ethernet/xircom/xirc2ps_cs.c:838: undefined reference to `ioremap'
   s390-linux-ld: drivers/net/ethernet/xircom/xirc2ps_cs.o: in function `xirc2ps_release':
>> drivers/net/ethernet/xircom/xirc2ps_cs.c:929: undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   drivers/pcmcia/cistpl.c:103: undefined reference to `ioremap'
   s390-linux-ld: drivers/pcmcia/cistpl.c:110: undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.c:117: undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.c:118: undefined reference to `ioremap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   drivers/pcmcia/cistpl.c:72: undefined reference to `iounmap'


vim +447 drivers/net/ethernet/smsc/smc91c92_cs.c

b54bf94bf91e4c drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2008-08-02  422  
fba395eee7d3f3 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2006-03-31  423  static int mhz_mfc_config(struct pcmcia_device *link)
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  424  {
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  425      struct net_device *dev = link->priv;
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  426      struct smc_private *smc = netdev_priv(dev);
b5cb259e7fac55 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-24  427      unsigned int offset;
b54bf94bf91e4c drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2008-08-02  428      int i;
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  429  
00990e7ce0b0e5 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-30  430      link->config_flags |= CONF_ENABLE_SPKR | CONF_ENABLE_IRQ |
00990e7ce0b0e5 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-30  431  	    CONF_AUTO_SET_IO;
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  432  
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  433      /* The Megahertz combo cards have modem-like CIS entries, so
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  434         we have to explicitly try a bunch of port combinations. */
b54bf94bf91e4c drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2008-08-02  435      if (pcmcia_loop_config(link, mhz_mfc_config_check, NULL))
dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  436  	    return -ENODEV;
dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  437  
9a017a910346af drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-24  438      dev->base_addr = link->resource[0]->start;
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  439  
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  440      /* Allocate a memory window, for accessing the ISR */
cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  441      link->resource[2]->flags = WIN_DATA_WIDTH_8|WIN_MEMORY_TYPE_AM|WIN_ENABLE;
cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  442      link->resource[2]->start = link->resource[2]->end = 0;
cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  443      i = pcmcia_request_window(link, link->resource[2], 0);
4c89e88bfde6a3 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2008-08-03  444      if (i != 0)
dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  445  	    return -ENODEV;
dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  446  
cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28 @447      smc->base = ioremap(link->resource[2]->start,
cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  448  		    resource_size(link->resource[2]));
7feabb6412ea23 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-29  449      offset = (smc->manfid == MANFID_MOTOROLA) ? link->config_base : 0;
cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  450      i = pcmcia_map_mem_page(link, link->resource[2], offset);
8e95a2026f3b43 drivers/net/pcmcia/smc91c92_cs.c Joe Perches       2009-12-03  451      if ((i == 0) &&
8e95a2026f3b43 drivers/net/pcmcia/smc91c92_cs.c Joe Perches       2009-12-03  452  	(smc->manfid == MANFID_MEGAHERTZ) &&
8e95a2026f3b43 drivers/net/pcmcia/smc91c92_cs.c Joe Perches       2009-12-03  453  	(smc->cardid == PRODID_MEGAHERTZ_EM3288))
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  454  	    mhz_3288_power(link);
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  455  
dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  456      return 0;
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  457  }
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  458  

:::::: The code at line 447 was first introduced by commit
:::::: cdb138080b78146d1cdadba9f5dadbeb97445b91 pcmcia: do not use win_req_t when calling pcmcia_request_window()

:::::: TO: Dominik Brodowski <linux@dominikbrodowski.net>
:::::: CC: Dominik Brodowski <linux@dominikbrodowski.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

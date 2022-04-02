Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CF34F06A9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 01:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiDBXXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 19:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiDBXXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 19:23:04 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504F222BCC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 16:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648941671; x=1680477671;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9bAMqXpF1SQCOLUP/s6o++cHeCunNqb7YmV/wXSB7Fs=;
  b=Ttdm5gs0YZo/GYICSNYlEx4bJp+VQFHJTI/EEyUymnK6X39dJ7p8seXO
   tQVgi2ati4CGL98NcWyUzju5vvsWwVr6RkiKbmESM0Pkl/AA+w++YqbDJ
   fP/C2s+t74pSWE9aGRoV9KP9wsPDWmufg0AUjOvuNffZmZmI12o4LarU+
   Y1qJJF438FawpWKZjjzeMYjg609efxfwPlxGf69k76neei6f7NKaOX9Ej
   49QIUtrhc+WSnBVM1CC9DTyC69xzNY6SVgekl8AerCpBQTM0rZhM8pDbs
   1CAa5DYN6xyKLVHGz7x98/ZlrCFdo+Rz6A/FZnYFuPLU58gY+ZNZ2RLdZ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10305"; a="321039666"
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="321039666"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 16:21:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="656714220"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 02 Apr 2022 16:21:09 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nan3M-0000Wc-Cr;
        Sat, 02 Apr 2022 23:21:08 +0000
Date:   Sun, 3 Apr 2022 07:20:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [lunn:v5.17-rc8-mdio-c45 1/12] drivers/net/phy/mdio_bus.c:904:5:
 warning: no previous prototype for '__mdiobus_c45_modify_changed'
Message-ID: <202204030746.rsVzhrNr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/lunn/linux.git v5.17-rc8-mdio-c45
head:   21ffc4381ec731f5e9521dec8925c0089b14920b
commit: 0e5fe1025245189f58a0321314592b6c8a9090e9 [1/12] net: mdio: Add dedicates C45 API to MDIO bus drivers
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20220403/202204030746.rsVzhrNr-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/lunn/linux/commit/0e5fe1025245189f58a0321314592b6c8a9090e9
        git remote add lunn https://github.com/lunn/linux.git
        git fetch --no-tags lunn v5.17-rc8-mdio-c45
        git checkout 0e5fe1025245189f58a0321314592b6c8a9090e9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/net/phy/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/phy/mdio_bus.c:904:5: warning: no previous prototype for '__mdiobus_c45_modify_changed' [-Wmissing-prototypes]
     904 | int __mdiobus_c45_modify_changed(struct mii_bus *bus, int addr, int devad,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/__mdiobus_c45_modify_changed +904 drivers/net/phy/mdio_bus.c

   889	
   890	/**
   891	 * __mdiobus_c45_modify_changed - Unlocked version of the mdiobus_modify function
   892	 * @bus: the mii_bus struct
   893	 * @addr: the phy address
   894	 * @devad: device address to read
   895	 * @regnum: register number to modify
   896	 * @mask: bit mask of bits to clear
   897	 * @set: bit mask of bits to set
   898	 *
   899	 * Read, modify, and if any change, write the register value back to the
   900	 * device. Any error returns a negative number.
   901	 *
   902	 * NOTE: MUST NOT be called from interrupt context.
   903	 */
 > 904	int __mdiobus_c45_modify_changed(struct mii_bus *bus, int addr, int devad,
   905					 u32 regnum, u16 mask, u16 set)
   906	{
   907		int new, ret;
   908	
   909		ret = __mdiobus_c45_read(bus, addr, devad, regnum);
   910		if (ret < 0)
   911			return ret;
   912	
   913		new = (ret & ~mask) | set;
   914		if (new == ret)
   915			return 0;
   916	
   917		ret = __mdiobus_c45_write(bus, addr, devad, regnum, new);
   918	
   919		return ret < 0 ? ret : 1;
   920	}
   921	EXPORT_SYMBOL_GPL(__mdiobus_c45_modify_changed);
   922	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

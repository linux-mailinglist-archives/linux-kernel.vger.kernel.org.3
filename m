Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4129A4F06BA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 03:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiDCBQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 21:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiDCBQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 21:16:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE37B5F94
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 18:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648948454; x=1680484454;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kZjM5ldBS7N+jhE5VCwJ1ScRSkIHyKbMMnm5sFOSJTc=;
  b=fL6E1nhnIaYQTfxQodxk9VnST/Dd+3k4sTTzujuDjv8Ek73kfMAfaRcu
   n9VrzwOQjBSvHX5YVevcsKtAGCBU7fmKWPx1+h5DGAb8JNVgwqdr/4syW
   f8mESXjQ9Ng6A9G0em6dcwz+8hqshLEgybquAslFmT89avYaNw829YyUn
   rda5krnI8n7oIrXgK/ZXyKNxpFAhGvqZE+okK9aUKBfadnoVdaa3hmAAS
   4+qdG13UdInJom4Dc2xdGjebKhnEo3JWuxEEvW0T2ZNAyR3FhQm/27hk0
   DMGjNkKszXE5RTdkQRvylMpeOPvtU2C2rSIyy7vPKsFwU2JQM08rdmvUY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10305"; a="257929507"
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="257929507"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 18:14:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="656770040"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 02 Apr 2022 18:14:12 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naoom-0000be-0f;
        Sun, 03 Apr 2022 01:14:12 +0000
Date:   Sun, 3 Apr 2022 09:14:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [lunn:v5.17-rc8-mdio-c45 1/12] drivers/net/phy/mdio_bus.c:904:5:
 warning: no previous prototype for function '__mdiobus_c45_modify_changed'
Message-ID: <202204030949.IjI3mpYp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: i386-randconfig-a004 (https://download.01.org/0day-ci/archive/20220403/202204030949.IjI3mpYp-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/lunn/linux/commit/0e5fe1025245189f58a0321314592b6c8a9090e9
        git remote add lunn https://github.com/lunn/linux.git
        git fetch --no-tags lunn v5.17-rc8-mdio-c45
        git checkout 0e5fe1025245189f58a0321314592b6c8a9090e9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/phy/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/phy/mdio_bus.c:904:5: warning: no previous prototype for function '__mdiobus_c45_modify_changed' [-Wmissing-prototypes]
   int __mdiobus_c45_modify_changed(struct mii_bus *bus, int addr, int devad,
       ^
   drivers/net/phy/mdio_bus.c:904:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __mdiobus_c45_modify_changed(struct mii_bus *bus, int addr, int devad,
   ^
   static 
   1 warning generated.


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

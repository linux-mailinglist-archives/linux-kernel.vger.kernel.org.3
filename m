Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FAF5045B2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 00:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiDPWi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 18:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiDPWiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 18:38:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727D437031
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 15:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650148582; x=1681684582;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EvB/DZ5vH4mKbhMj8E9XI5tRXkv/uBKrhCIDsrfx7cs=;
  b=nMOs9907KCn5GlPNm83sw+f5UQ8kNGDLZmlEaMqCqw/5+pxwBrAjIsLl
   1x+Kg2ckmAbmkia0Zj/ziWxkoXH2U56OJMVxIr5Qbs8C5eOJ/VC3CYq3f
   i0rsBv+AIGFmFyQtHbmc+Kmb+S4hefFpGKQxpoc3G1g8d+OB7Q9H6OPOM
   8YOzcuK0hFS+JjydLjAUmg6mzEVjrxsCQXJzbVy4hp6eDqqJs739PN8l7
   L6uAV2yy1dRJYqy1UBL6Hq5RzJiD/bD9JD5QyIen8bLuxVNyupxsp0JIS
   si5d3exTX79/HJ9Zqb1GYmMC8MKSbGDOdVHXAuPszigsu/U9oE+4KQyYz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="326244991"
X-IronPort-AV: E=Sophos;i="5.90,266,1643702400"; 
   d="scan'208";a="326244991"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 15:36:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,266,1643702400"; 
   d="scan'208";a="726196454"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Apr 2022 15:36:20 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfr1f-0003XR-T8;
        Sat, 16 Apr 2022 22:36:19 +0000
Date:   Sun, 17 Apr 2022 06:35:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [lunn:v5.18-rc1-net-next-c45 30/44]
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:725: warning: expecting
 prototype for ixgbe_mii_bus_read_generic_45(). Prototype was for
 ixgbe_mii_bus_read_generic_c45() instead
Message-ID: <202204170653.yXcEwhTK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/lunn/linux.git v5.18-rc1-net-next-c45
head:   a6ca6875280b5cf6ee1d8466840b71bf6ffb7bfd
commit: 3667548ba293c93e5a8ca7be2778b460c40ade4f [30/44] net: ethernet: intel: ixgdb: Separate C22 and C45 transactions for xgmac
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220417/202204170653.yXcEwhTK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 64c045e25b8471bbb572bd29159c294a82a86a25)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/lunn/linux/commit/3667548ba293c93e5a8ca7be2778b460c40ade4f
        git remote add lunn https://github.com/lunn/linux.git
        git fetch --no-tags lunn v5.18-rc1-net-next-c45
        git checkout 3667548ba293c93e5a8ca7be2778b460c40ade4f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/dsa/sja1105/ drivers/net/ethernet/intel/ixgbe/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:725: warning: expecting prototype for ixgbe_mii_bus_read_generic_45(). Prototype was for ixgbe_mii_bus_read_generic_c45() instead
>> drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:795: warning: expecting prototype for ixgbe_mii_bus_write_generic_45(). Prototype was for ixgbe_mii_bus_write_generic_c45() instead


vim +725 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c

   714	
   715	/**
   716	 *  ixgbe_mii_bus_read_generic_45 - Read a clause 45 register with gssr flags
   717	 *  @hw: pointer to hardware structure
   718	 *  @addr: address
   719	 *  @devad: device address to read
   720	 *  @regnum: register number
   721	 *  @gssr: semaphore flags to acquire
   722	 **/
   723	static s32 ixgbe_mii_bus_read_generic_c45(struct ixgbe_hw *hw, int addr,
   724						  int devad, int regnum, u32 gssr)
 > 725	{
   726		u32 hwaddr, cmd;
   727		s32 data;
   728	
   729		if (hw->mac.ops.acquire_swfw_sync(hw, gssr))
   730			return -EBUSY;
   731	
   732		hwaddr = addr << IXGBE_MSCA_PHY_ADDR_SHIFT;
   733		hwaddr |= devad << 16 | regnum;
   734		cmd = hwaddr | IXGBE_MSCA_ADDR_CYCLE | IXGBE_MSCA_MDI_COMMAND;
   735	
   736		data = ixgbe_msca_cmd(hw, cmd);
   737		if (data < 0)
   738			goto mii_bus_read_done;
   739	
   740		cmd = hwaddr | IXGBE_MSCA_READ | IXGBE_MSCA_MDI_COMMAND;
   741		data = ixgbe_msca_cmd(hw, cmd);
   742		if (data < 0)
   743			goto mii_bus_read_done;
   744	
   745		data = IXGBE_READ_REG(hw, IXGBE_MSRWD);
   746		data = (data >> IXGBE_MSRWD_READ_DATA_SHIFT) & GENMASK(16, 0);
   747	
   748	mii_bus_read_done:
   749		hw->mac.ops.release_swfw_sync(hw, gssr);
   750		return data;
   751	}
   752	
   753	/**
   754	 *  ixgbe_mii_bus_write_generic_c22 - Write a clause 22 register with gssr flags
   755	 *  @hw: pointer to hardware structure
   756	 *  @addr: address
   757	 *  @regnum: register number
   758	 *  @val: value to write
   759	 *  @gssr: semaphore flags to acquire
   760	 **/
   761	static s32 ixgbe_mii_bus_write_generic_c22(struct ixgbe_hw *hw, int addr,
   762						   int regnum, u16 val, u32 gssr)
   763	{
   764		u32 hwaddr, cmd;
   765		s32 err;
   766	
   767		if (hw->mac.ops.acquire_swfw_sync(hw, gssr))
   768			return -EBUSY;
   769	
   770		IXGBE_WRITE_REG(hw, IXGBE_MSRWD, (u32)val);
   771	
   772		hwaddr = addr << IXGBE_MSCA_PHY_ADDR_SHIFT;
   773		hwaddr |= (regnum & GENMASK(5, 0)) << IXGBE_MSCA_DEV_TYPE_SHIFT;
   774		cmd = hwaddr | IXGBE_MSCA_OLD_PROTOCOL | IXGBE_MSCA_WRITE |
   775			IXGBE_MSCA_MDI_COMMAND;
   776	
   777		err = ixgbe_msca_cmd(hw, cmd);
   778	
   779		hw->mac.ops.release_swfw_sync(hw, gssr);
   780		return err;
   781	}
   782	
   783	/**
   784	 *  ixgbe_mii_bus_write_generic_45 - Write a clause 45 register with gssr flags
   785	 *  @hw: pointer to hardware structure
   786	 *  @addr: address
   787	 *  @devad: device address to read
   788	 *  @regnum: register number
   789	 *  @val: value to write
   790	 *  @gssr: semaphore flags to acquire
   791	 **/
   792	static s32 ixgbe_mii_bus_write_generic_c45(struct ixgbe_hw *hw, int addr,
   793						   int devad, int regnum, u16 val,
   794						   u32 gssr)
 > 795	{
   796		u32 hwaddr, cmd;
   797		s32 err;
   798	
   799		if (hw->mac.ops.acquire_swfw_sync(hw, gssr))
   800			return -EBUSY;
   801	
   802		IXGBE_WRITE_REG(hw, IXGBE_MSRWD, (u32)val);
   803	
   804		hwaddr = addr << IXGBE_MSCA_PHY_ADDR_SHIFT;
   805		hwaddr |= devad << 16 | regnum;
   806		cmd = hwaddr | IXGBE_MSCA_ADDR_CYCLE | IXGBE_MSCA_MDI_COMMAND;
   807	
   808		err = ixgbe_msca_cmd(hw, cmd);
   809		if (err < 0)
   810			goto mii_bus_write_done;
   811	
   812		cmd = hwaddr | IXGBE_MSCA_WRITE | IXGBE_MSCA_MDI_COMMAND;
   813		err = ixgbe_msca_cmd(hw, cmd);
   814	
   815	mii_bus_write_done:
   816		hw->mac.ops.release_swfw_sync(hw, gssr);
   817		return err;
   818	}
   819	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

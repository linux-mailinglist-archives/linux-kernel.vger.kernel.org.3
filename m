Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A995045C0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 01:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiDPXJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 19:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiDPXI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 19:08:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3CF2C131
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 16:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650150383; x=1681686383;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wELl+SyaLPB/ly7xW2SzJaUB89/IRsuP9PxBJjpL30Y=;
  b=TUFNkBqNi5Mn81CWUtiYaqxKKyiYhHcsYda/S07viXufvVRJxIZuLQ6h
   hreA8G7n/jVxIF/4j1Z37FINnBLY3lbU4vHh3i6DoZ8oM0ofh3lXoxqKG
   h/fme30DGR12H39WbmDJQYeXyBNdX2ncFBudpfykIwIDYbBuvfd5a+IsQ
   jVEfMTSQNO6HfnAIFlOpb4ZifK9IMvAiQo4KM9/RyMce0fkZ9+xn2Ywt9
   m75BiFTrFhJOTilsDihkdygbiJSY2HR435TOIV7J9ElGGe/qFgjUmJE8L
   ueKnNoIDzmua0ckCygh+Qg0dbQa0p5jS1TYlSrCSWvRSmPAzX4IY8NdtE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="323787433"
X-IronPort-AV: E=Sophos;i="5.90,266,1643702400"; 
   d="scan'208";a="323787433"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 16:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,266,1643702400"; 
   d="scan'208";a="509341458"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 16 Apr 2022 16:06:21 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfrUi-0003YH-L6;
        Sat, 16 Apr 2022 23:06:20 +0000
Date:   Sun, 17 Apr 2022 07:06:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [lunn:v5.18-rc1-net-next-c45 38/44]
 drivers/net/dsa/sja1105/sja1105_mdio.c:190:9: warning: variable 'tmp' is
 uninitialized when used here
Message-ID: <202204170750.Ftg38eOr-lkp@intel.com>
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

tree:   https://github.com/lunn/linux.git v5.18-rc1-net-next-c45
head:   a6ca6875280b5cf6ee1d8466840b71bf6ffb7bfd
commit: 47aade045321c64f7486052fb1cee153d0f6cbdc [38/44] net: dsa: sja1105: Separate C22 and C45 transactions for T1 MDIO bus
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220417/202204170750.Ftg38eOr-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 64c045e25b8471bbb572bd29159c294a82a86a25)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/lunn/linux/commit/47aade045321c64f7486052fb1cee153d0f6cbdc
        git remote add lunn https://github.com/lunn/linux.git
        git fetch --no-tags lunn v5.18-rc1-net-next-c45
        git checkout 47aade045321c64f7486052fb1cee153d0f6cbdc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/dsa/sja1105/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/sja1105/sja1105_mdio.c:190:9: warning: variable 'tmp' is uninitialized when used here [-Wuninitialized]
           return tmp & 0xffff;
                  ^~~
   drivers/net/dsa/sja1105/sja1105_mdio.c:175:9: note: initialize the variable 'tmp' to silence this warning
           u32 tmp;
                  ^
                   = 0
   1 warning generated.


vim +/tmp +190 drivers/net/dsa/sja1105/sja1105_mdio.c

5a8f09748ee79f Vladimir Oltean 2021-06-08  168  
47aade045321c6 Andrew Lunn     2022-04-01  169  static int sja1105_base_t1_mdio_read_c45(struct mii_bus *bus, int phy,
47aade045321c6 Andrew Lunn     2022-04-01  170  					 int mmd, int reg)
47aade045321c6 Andrew Lunn     2022-04-01  171  {
47aade045321c6 Andrew Lunn     2022-04-01  172  	struct sja1105_mdio_private *mdio_priv = bus->priv;
47aade045321c6 Andrew Lunn     2022-04-01  173  	struct sja1105_private *priv = mdio_priv->priv;
47aade045321c6 Andrew Lunn     2022-04-01  174  	u64 addr;
47aade045321c6 Andrew Lunn     2022-04-01  175  	u32 tmp;
47aade045321c6 Andrew Lunn     2022-04-01  176  	int rc;
5a8f09748ee79f Vladimir Oltean 2021-06-08  177  
47aade045321c6 Andrew Lunn     2022-04-01  178  	addr = sja1105_base_t1_encode_addr(priv, phy, SJA1105_C45_ADDR, mmd);
47aade045321c6 Andrew Lunn     2022-04-01  179  
47aade045321c6 Andrew Lunn     2022-04-01  180  	rc = sja1105_xfer_u32(priv, SPI_WRITE, addr, &reg, NULL);
47aade045321c6 Andrew Lunn     2022-04-01  181  	if (rc < 0)
47aade045321c6 Andrew Lunn     2022-04-01  182  		return rc;
47aade045321c6 Andrew Lunn     2022-04-01  183  
47aade045321c6 Andrew Lunn     2022-04-01  184  	addr = sja1105_base_t1_encode_addr(priv, phy, SJA1105_C45_DATA, mmd);
47aade045321c6 Andrew Lunn     2022-04-01  185  
47aade045321c6 Andrew Lunn     2022-04-01  186  	rc = sja1105_xfer_u32(priv, SPI_READ, addr, &reg, NULL);
5a8f09748ee79f Vladimir Oltean 2021-06-08  187  	if (rc < 0)
5a8f09748ee79f Vladimir Oltean 2021-06-08  188  		return rc;
5a8f09748ee79f Vladimir Oltean 2021-06-08  189  
5a8f09748ee79f Vladimir Oltean 2021-06-08 @190  	return tmp & 0xffff;
5a8f09748ee79f Vladimir Oltean 2021-06-08  191  }
5a8f09748ee79f Vladimir Oltean 2021-06-08  192  

:::::: The code at line 190 was first introduced by commit
:::::: 5a8f09748ee79f2ef28e560bd095587a0e204b3d net: dsa: sja1105: register the MDIO buses for 100base-T1 and 100base-TX

:::::: TO: Vladimir Oltean <vladimir.oltean@nxp.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

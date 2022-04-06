Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E634F580B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344526AbiDFIqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 04:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384256AbiDFInx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:43:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C7F488BE0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 22:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649224669; x=1680760669;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p4KTYD1cbHmpuXeM6O/b0bKuIQXYEEKGc1VZKUXra3E=;
  b=E+XpaqYp3MLZTsXBopD5Wai0o6wnEcm6nyKjBos145nRWMyCq3XeKiK4
   56JjBX/DaoM/Fvz0OG/ZseMGz6WpIg2HP4j60lI66Sylhqtj944CIIk+5
   /T1TphwkeN6Gti3dbXos8vfxcyXph9eutYBNhuVt3Na1vZONKBDxFeAuH
   VgIhu2nHL8n48v+7NKxg5RUP+SJEml/d9+160wSOzVY+ahHfEz+65u9q2
   nGx3GHX3bWIV4hJlb8yckbXL9hs4ehbwJt9QyyPCTiZGucnmTA5LkJzvS
   A+i51SdH0yhC7Bv4pWiUCXWPpP/DSGWSg/ycJmVaVpGMKsx1kATnWkAd0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="347400666"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="347400666"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 22:56:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="549394922"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 05 Apr 2022 22:56:50 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbyev-00047h-I9;
        Wed, 06 Apr 2022 05:56:49 +0000
Date:   Wed, 6 Apr 2022 13:56:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:robh/linux/dt/pop-pci-nodes 2/2]
 drivers/pci/of.c:29:6: warning: no previous prototype for 'add_bus_props'
Message-ID: <202204061333.cVi47HBi-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block robh/linux/dt/pop-pci-nodes
head:   b9198a9525a97d05b0bb2a7282fede92d7d2d93d
commit: b9198a9525a97d05b0bb2a7282fede92d7d2d93d [2/2] PCI: Create DT nodes if they don't exist
config: ia64-buildonly-randconfig-r006-20220405 (https://download.01.org/0day-ci/archive/20220406/202204061333.cVi47HBi-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/b9198a9525a97d05b0bb2a7282fede92d7d2d93d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block robh/linux/dt/pop-pci-nodes
        git checkout b9198a9525a97d05b0bb2a7282fede92d7d2d93d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from arch/ia64/include/asm/uaccess.h:40,
                    from include/linux/uaccess.h:11,
                    from arch/ia64/include/asm/sections.h:11,
                    from include/linux/interrupt.h:21,
                    from include/linux/pci.h:38,
                    from drivers/pci/of.c:11:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   drivers/pci/of.c: At top level:
   drivers/pci/of.c:18:21: warning: no previous prototype for 'make_node' [-Wmissing-prototypes]
      18 | struct device_node *make_node(void)
         |                     ^~~~~~~~~
>> drivers/pci/of.c:29:6: warning: no previous prototype for 'add_bus_props' [-Wmissing-prototypes]
      29 | void add_bus_props(struct device_node *node)
         |      ^~~~~~~~~~~~~
   drivers/pci/of.c:60:6: warning: no previous prototype for 'make_dev_node' [-Wmissing-prototypes]
      60 | void make_dev_node(struct pci_dev *dev)
         |      ^~~~~~~~~~~~~
   drivers/pci/of.c:88:21: warning: no previous prototype for 'make_bus_node' [-Wmissing-prototypes]
      88 | struct device_node *make_bus_node(struct pci_bus *bus)
         |                     ^~~~~~~~~~~~~


vim +/add_bus_props +29 drivers/pci/of.c

    28	
  > 29	void add_bus_props(struct device_node *node)
    30	{
    31		struct property *prop;
    32		__be32 *val;
    33	
    34		prop = kzalloc(sizeof(*prop), GFP_KERNEL);
    35		prop->name = "ranges";
    36		prop->value = prop + 1;
    37		prop->next = node->properties;
    38		node->properties = prop;
    39	
    40		prop = kzalloc(sizeof(*prop) + sizeof(__be32), GFP_KERNEL);
    41		prop->name = "#address-cells";
    42		prop->value = prop + 1;
    43		prop->length = sizeof(__be32);
    44		val = prop->value;
    45		val[0] = __cpu_to_be32(3);
    46		prop->next = node->properties;
    47		node->properties = prop;
    48	
    49		prop = kzalloc(sizeof(*prop) + sizeof(__be32), GFP_KERNEL);
    50		prop->name = "#size-cells";
    51		prop->value = prop + 1;
    52		prop->length = sizeof(__be32);
    53		val = prop->value;
    54		val[0] = __cpu_to_be32(2);
    55		prop->next = node->properties;
    56		node->properties = prop;
    57	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

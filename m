Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF404F57AC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiDFINN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 04:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445649AbiDFILu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:11:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41192BD7ED
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 19:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649210567; x=1680746567;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q9HJ/wMoqCq/bvozt3SgFYGtUgCsUPN2Y8mufFhHYxg=;
  b=fS/37ow91/wRlVvtYeosAM+jHpFDMittLfAqCcsAwAPNlYyvjZfyl5SR
   AkmyzL2jCU6wHrx8Ud0K8FwRs683nMZHxbZzFF2tOdgzUYyEU2fvG8+AN
   0vv+pleFZdHnG5cMWsu5UNZO8FZ732z+9ygce5OLygpDpro0rXnCkxAEe
   qU9aky5mYfhx44t/mffsk2gxXpOQw98eZG005oO09BEpAIJsEcZ+UyXFK
   ol5gGzPRyNBbKSXb1G1MZRxSH9PAvun3tiDhaDN4qAMY3P/ySGnCsur1r
   v68rR5G9oDIS+8Mac976qye8SukWAssHGtrkP/PXNz7372a0J07pvHQtK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260918486"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="260918486"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 19:02:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="608701778"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2022 19:02:45 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbv0O-0003yv-GN;
        Wed, 06 Apr 2022 02:02:44 +0000
Date:   Wed, 6 Apr 2022 10:01:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:robh/linux/dt/pop-pci-nodes 2/2]
 drivers/pci/of.c:29:6: warning: no previous prototype for function
 'add_bus_props'
Message-ID: <202204060919.ixlG0hLi-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block robh/linux/dt/pop-pci-nodes
head:   b9198a9525a97d05b0bb2a7282fede92d7d2d93d
commit: b9198a9525a97d05b0bb2a7282fede92d7d2d93d [2/2] PCI: Create DT nodes if they don't exist
config: mips-buildonly-randconfig-r002-20220405 (https://download.01.org/0day-ci/archive/20220406/202204060919.ixlG0hLi-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/b9198a9525a97d05b0bb2a7282fede92d7d2d93d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block robh/linux/dt/pop-pci-nodes
        git checkout b9198a9525a97d05b0bb2a7282fede92d7d2d93d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/pci/of.c:18:21: warning: no previous prototype for function 'make_node' [-Wmissing-prototypes]
   struct device_node *make_node(void)
                       ^
   drivers/pci/of.c:18:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct device_node *make_node(void)
   ^
   static 
>> drivers/pci/of.c:29:6: warning: no previous prototype for function 'add_bus_props' [-Wmissing-prototypes]
   void add_bus_props(struct device_node *node)
        ^
   drivers/pci/of.c:29:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void add_bus_props(struct device_node *node)
   ^
   static 
   drivers/pci/of.c:60:6: warning: no previous prototype for function 'make_dev_node' [-Wmissing-prototypes]
   void make_dev_node(struct pci_dev *dev)
        ^
   drivers/pci/of.c:60:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void make_dev_node(struct pci_dev *dev)
   ^
   static 
   drivers/pci/of.c:88:21: warning: no previous prototype for function 'make_bus_node' [-Wmissing-prototypes]
   struct device_node *make_bus_node(struct pci_bus *bus)
                       ^
   drivers/pci/of.c:88:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct device_node *make_bus_node(struct pci_bus *bus)
   ^
   static 
   4 warnings generated.


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

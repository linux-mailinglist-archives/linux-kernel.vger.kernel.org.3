Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF074F6A07
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiDFTf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiDFTfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:35:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9E3229CA7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 11:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649269395; x=1680805395;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=92yacfNwebATUCEf+W25F15FIBUvP6Pv62+QEoq9dhg=;
  b=FaTYtkJxhqEnvKn2CLQ2H39EHH7AsZIi8yphWZ71OQb95qvKWK7qpYSa
   lj/24B6kVLZeRW2+3zh2FhqgWquiYdqRqGgfOCAFo5jSfKhUL9MgzwClE
   DNvbd8hpzxSHMqUW520ZLnBHCQm6gAj9U+OJEdExcIK1ywLSKoOcw2Osf
   Aa1aqO+Db3XQQqhju7g7AidhBt1qvvF7U5YmxvCJPuDLM5NSIyHgXqg2o
   u06cSwGep1oOcJlegUbRuBzAphMNpNRM4IFwgtzhyFFH/3kRONiRBwUt9
   bQLSIBH64hYJPXVGs9XrRtUvQ/TujQu2Klbj1AfSBaekH412DH1LIf7K4
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="248648179"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="248648179"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 11:23:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="524589359"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Apr 2022 11:23:14 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncAJF-0004eN-Ee;
        Wed, 06 Apr 2022 18:23:13 +0000
Date:   Thu, 7 Apr 2022 02:22:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:robh/linux/dt/pop-pci-nodes 2/2]
 drivers/pci/of.c:84: undefined reference to `.of_attach_node'
Message-ID: <202204070238.tRrrzyyE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block robh/linux/dt/pop-pci-nodes
head:   b9198a9525a97d05b0bb2a7282fede92d7d2d93d
commit: b9198a9525a97d05b0bb2a7282fede92d7d2d93d [2/2] PCI: Create DT nodes if they don't exist
config: powerpc64-buildonly-randconfig-r001-20220405 (https://download.01.org/0day-ci/archive/20220407/202204070238.tRrrzyyE-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/b9198a9525a97d05b0bb2a7282fede92d7d2d93d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block robh/linux/dt/pop-pci-nodes
        git checkout b9198a9525a97d05b0bb2a7282fede92d7d2d93d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> powerpc64-linux-ld: warning: discarding dynamic section .glink
>> powerpc64-linux-ld: warning: discarding dynamic section .plt
   powerpc64-linux-ld: linkage table error against `of_attach_node'
   powerpc64-linux-ld: stubs don't match calculated size
   powerpc64-linux-ld: can not build stubs: bad value
   powerpc64-linux-ld: drivers/pci/of.o: in function `make_dev_node':
>> drivers/pci/of.c:84: undefined reference to `.of_attach_node'
>> powerpc64-linux-ld: drivers/pci/of.c:84: undefined reference to `.of_attach_node'
   powerpc64-linux-ld: drivers/pci/of.o: in function `make_bus_node':
   drivers/pci/of.c:97: undefined reference to `.of_attach_node'
   powerpc64-linux-ld: drivers/pci/of.c:97: undefined reference to `.of_attach_node'


vim +84 drivers/pci/of.c

    59	
    60	void make_dev_node(struct pci_dev *dev)
    61	{
    62		struct device_node *node;
    63		struct property *prop;
    64		__be32 *val;
    65	
    66		node = make_node();
    67	
    68		prop = kzalloc(sizeof(*prop) + sizeof(__be32) * 5, GFP_KERNEL);
    69		prop->name = "reg";
    70		prop->value = prop + 1;
    71		prop->length = sizeof(__be32) * 5;
    72		val = prop->value;
    73		val[0] = __cpu_to_be32(dev->devfn << 8);
    74		val[4] = __cpu_to_be32(SZ_4K);
    75		node->properties = prop;
    76	
    77		if (pci_is_bridge(dev)) {
    78			add_bus_props(node);
    79			node->full_name = kasprintf(GFP_KERNEL, "pci@%x,%x", PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
    80		} else
    81			node->full_name = kasprintf(GFP_KERNEL, "dev@%x,%x", PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
    82	
    83		node->parent = dev->bus->dev.of_node;
  > 84		of_attach_node(node);
    85		dev->dev.of_node = node;
    86	}
    87	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

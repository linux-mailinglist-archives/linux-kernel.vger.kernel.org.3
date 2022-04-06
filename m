Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529154F639B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbiDFPlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbiDFPkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:40:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C92626A0B5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649249764; x=1680785764;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i4Z8WedwVdvezLTFVD9PQEY/BenOcNbiAfsHFxkmaZw=;
  b=XDWekrp0yxcxR+Cuyx+10TQa6m667hiQBJyIrUiIrpbOCIQB6TnVJuRA
   pkKoGzfMQJGbnLiEqcO4DJ5zNd6CrCocSIKqUCr7weA1TS9a9rO3SR66f
   EDa7KZmlTRmTXnmMzyGNlh32ibBZ+bDNB3hgDttI+3m7q83/p75JtK/iW
   BJx9x2osZoKXsIBGVqj66MrrD+OguQ3PN68b08KEWyoTN7O63kf/uTqDq
   FiPR7MF9S8YWcpYcnTnEJOxGJb5MS8mRX9hQ7caFqwLuB5U+49bMpb+Cj
   jYKtkIodLumMOPFsU+nc7bS6cku80Uym7LJTJfb7I47vQBBN00r62Fiht
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="240968187"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="240968187"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 05:56:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="505717737"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2022 05:56:02 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nc5Cb-0004QC-HG;
        Wed, 06 Apr 2022 12:56:01 +0000
Date:   Wed, 6 Apr 2022 20:55:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:robh/linux/dt/pop-pci-nodes 2/2] ia64-linux-ld:
 of.c:undefined reference to `of_attach_node'
Message-ID: <202204062042.zlTRFO9x-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block robh/linux/dt/pop-pci-nodes
head:   b9198a9525a97d05b0bb2a7282fede92d7d2d93d
commit: b9198a9525a97d05b0bb2a7282fede92d7d2d93d [2/2] PCI: Create DT nodes if they don't exist
config: ia64-randconfig-r025-20220406 (https://download.01.org/0day-ci/archive/20220406/202204062042.zlTRFO9x-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ia64-linux-ld: drivers/pci/of.o: in function `make_dev_node':
   of.c:(.text+0x1a72): undefined reference to `of_attach_node'
>> ia64-linux-ld: of.c:(.text+0x1b62): undefined reference to `of_attach_node'
   ia64-linux-ld: drivers/pci/of.o: in function `make_bus_node':
   of.c:(.text+0x1c62): undefined reference to `of_attach_node'
   ia64-linux-ld: drivers/pci/of.o: in function `pci_set_bus_of_node':
   of.c:(.text+0x1ff2): undefined reference to `of_attach_node'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

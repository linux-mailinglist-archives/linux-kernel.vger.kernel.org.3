Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A39758B8C3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 02:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiHGAfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 20:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiHGAfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 20:35:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0481D1104
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 17:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659832519; x=1691368519;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=STCbwZNb5UGm90udlfBYFsCDdSn9eb84CgNg/J+DXRs=;
  b=ArYPYT1mmUlk8yvJ0zXZP5VgpqDMQxqVnVZm13vChGIRaxH1Jd6mylQ2
   VolI4m12olCG1Na4dh7RR64vbREc2H3gr5y2yXMObotwXizuaU3KrSTwn
   IM7Fe9PnDXEJeKQiZlwvZufek8agP1qswvvCOj4HlpyFlAqPDfcZgEk8u
   5s2GRt90+pQnPFe3jL20p8vv3cjEJ7jYxKK8jI2ToaxF7d/DvnawzK5+B
   Py4bvx3Qn7RnntC0Cwjc7G0NZIvWLcsvD4hgvpKhXCJ5nxbd6X7S/vWzf
   xPfdIE6mT7rJAwFQ4ndhfD5p1qO1FITnlpeXJOEfGW9gdQAi79pl+Bf+f
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="291174894"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="291174894"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 17:35:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="579907700"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Aug 2022 17:35:16 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKUGA-000Ko5-0E;
        Sun, 07 Aug 2022 00:35:14 +0000
Date:   Sun, 7 Aug 2022 08:35:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Matthew Auld <matthew.auld@intel.com>,
        =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
        Priyanka Dandamudi <priyanka.dandamudi@intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>
Subject: drivers/gpu/drm/i915/gt/intel_region_lmem.c:70:23: error: result of
 comparison of constant 4294967296 with expression of type 'resource_size_t'
 (aka 'unsigned int') is always false
Message-ID: <202208070818.09hru8ga-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akeem,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4d1044fcb996e8de9b9ab392f4a767890e45202d
commit: a91d1a17cd341548fd9535e33c331a2756acdfae drm/i915: Add support for LMEM PCIe resizable bar
date:   3 weeks ago
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220807/202208070818.09hru8ga-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 26dd42705c2af0b8f6e5d6cdb32c9bd5ed9524eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a91d1a17cd341548fd9535e33c331a2756acdfae
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a91d1a17cd341548fd9535e33c331a2756acdfae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/gt/intel_region_lmem.c:70:23: error: result of comparison of constant 4294967296 with expression of type 'resource_size_t' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
                       root_res->start > 0x100000000ull)
                       ~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   1 error generated.


vim +70 drivers/gpu/drm/i915/gt/intel_region_lmem.c

    46	
    47	#define LMEM_BAR_NUM 2
    48	static void i915_resize_lmem_bar(struct drm_i915_private *i915, resource_size_t lmem_size)
    49	{
    50		struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
    51		struct pci_bus *root = pdev->bus;
    52		struct resource *root_res;
    53		resource_size_t rebar_size;
    54		u32 pci_cmd;
    55		int i;
    56	
    57		rebar_size = roundup_pow_of_two(pci_resource_len(pdev, LMEM_BAR_NUM));
    58	
    59		if (rebar_size != roundup_pow_of_two(lmem_size))
    60			rebar_size = lmem_size;
    61		else
    62			return;
    63	
    64		/* Find out if root bus contains 64bit memory addressing */
    65		while (root->parent)
    66			root = root->parent;
    67	
    68		pci_bus_for_each_resource(root, root_res, i) {
    69			if (root_res && root_res->flags & (IORESOURCE_MEM | IORESOURCE_MEM_64) &&
  > 70			    root_res->start > 0x100000000ull)
    71				break;
    72		}
    73	
    74		/* pci_resize_resource will fail anyways */
    75		if (!root_res) {
    76			drm_info(&i915->drm, "Can't resize LMEM BAR - platform support is missing\n");
    77			return;
    78		}
    79	
    80		/* First disable PCI memory decoding references */
    81		pci_read_config_dword(pdev, PCI_COMMAND, &pci_cmd);
    82		pci_write_config_dword(pdev, PCI_COMMAND,
    83				       pci_cmd & ~PCI_COMMAND_MEMORY);
    84	
    85		_resize_bar(i915, LMEM_BAR_NUM, rebar_size);
    86	
    87		pci_assign_unassigned_bus_resources(pdev->bus);
    88		pci_write_config_dword(pdev, PCI_COMMAND, pci_cmd);
    89	}
    90	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

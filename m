Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30CC5953B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiHPH0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiHPH0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:26:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FD53A4AF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 20:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660621787; x=1692157787;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rReBDJAZM7TFgTZc50mkmdaZLYcK5V5lmTp/SADnq3I=;
  b=RcdBpCbvGalncVmqUfzfyVVnVmDNkE3ZdN6lGAtjOFHSNBOul8dGvsrF
   NsyBv6beSX/OrE4s+QJqnUnNW/QmYBCeu8NYJD3XLl1g2CtX0XSSK8PVh
   Gr0JqkgefzFFqF+nIRNO2wmJUQoghYCFWjUGRbJGms9rBZEPH8mQMZa3b
   nY8C+6Gx7GJ4J8l5xG6Y4IJtDgNJLLnrS4U9k1ZkCdbdGHJ5zI/q0Bwia
   5F3GJBsUDEKCHZKY8D3dXaOQvUXYkZjnIMk+WnGPO4PrE7v3Sx76aDJFH
   0KTgvMQ5S6wakbokzHe+zIeWuMEkc/B4DvckYLQ6O2f0TbOeH3jkmQJXo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="289686567"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="289686567"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 20:49:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="934727860"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 15 Aug 2022 20:49:45 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNnaK-0001QQ-1j;
        Tue, 16 Aug 2022 03:49:44 +0000
Date:   Tue, 16 Aug 2022 11:49:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bo Jiao <Bo.Jiao@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: drivers/net/wireless/mediatek/mt76/mt7915/mmio.c:341
 __mt7915_reg_addr() warn: always true condition '(addr <= 4294967295) =>
 (0-u32max <= u32max)'
Message-ID: <202208161128.vhPmbgKV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   568035b01cfb107af8d2e4bd2fb9aea22cf5b868
commit: cd4c314a65d3cce6486f8303e42aca04fd9f9011 mt76: mt7915: refine register definition
date:   6 months ago
config: ia64-randconfig-m031-20220814 (https://download.01.org/0day-ci/archive/20220816/202208161128.vhPmbgKV-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/net/wireless/mediatek/mt76/mt7915/mmio.c:341 __mt7915_reg_addr() warn: always true condition '(addr <= 4294967295) => (0-u32max <= u32max)'

vim +341 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c

   311	
   312	static u32 __mt7915_reg_addr(struct mt7915_dev *dev, u32 addr)
   313	{
   314		int i;
   315	
   316		if (addr < 0x100000)
   317			return addr;
   318	
   319		if (!dev->reg.map) {
   320			dev_err(dev->mt76.dev, "err: reg_map is null\n");
   321			return addr;
   322		}
   323	
   324		for (i = 0; i < dev->reg.map_size; i++) {
   325			u32 ofs;
   326	
   327			if (addr < dev->reg.map[i].phys)
   328				continue;
   329	
   330			ofs = addr - dev->reg.map[i].phys;
   331			if (ofs > dev->reg.map[i].size)
   332				continue;
   333	
   334			return dev->reg.map[i].maps + ofs;
   335		}
   336	
   337		if ((addr >= MT_INFRA_BASE && addr < MT_WFSYS0_PHY_START) ||
   338		    (addr >= MT_WFSYS0_PHY_START && addr < MT_WFSYS1_PHY_START) ||
   339		    (addr >= MT_WFSYS1_PHY_START && addr <= MT_WFSYS1_PHY_END) ||
   340		    (addr >= MT_CBTOP1_PHY_START && addr <= MT_CBTOP1_PHY_END) ||
 > 341		    (addr >= MT_CBTOP2_PHY_START && addr <= MT_CBTOP2_PHY_END))
   342			return mt7915_reg_map_l1(dev, addr);
   343	
   344		return mt7915_reg_map_l2(dev, addr);
   345	}
   346	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BF8597B79
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242750AbiHRCU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242744AbiHRCU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:20:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2384490C50
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660789256; x=1692325256;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RW94JfL1RSFVdNhd7XTObyaK9QdzniX0J+xar8BEqWI=;
  b=MtKjMNkpgcjfq6abKhSn+euqiBQjay6S1Ict00a3APHnObBQntrgTTqG
   E/tUD1zjpvI06WT2FSSLrhwJwBOPpOByJEG0oQ8SRm9Kwfk/jt7oFMTt7
   f/kIXQ7Dauco+Dk6pgX5dEz8mxaQ4tjXW5Of6VJpISFnHl6zrKkvhyfKz
   P34fJbjJcXRKfld4tU3/KOz/eKSSl2vW9IZShsjEt/eVAt/2tUB/hKmeo
   L3LEq3CsCG0qAj5EgSM2w2fTa7PdKltWPLEWRmOnlzMQoyoL8VbR2atGZ
   0577pFko456nghQx7c+wTTapNtsK1oP91mrYGr2q1ufYcNFs50y1u7ISU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="356640434"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="356640434"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 19:20:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="640683882"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Aug 2022 19:20:54 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOV9R-0001cD-1M;
        Thu, 18 Aug 2022 02:20:53 +0000
Date:   Thu, 18 Aug 2022 10:20:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bo Jiao <Bo.Jiao@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: drivers/net/wireless/mediatek/mt76/mt7915/mmio.c:341
 __mt7915_reg_addr() warn: always true condition '(addr <= 4294967295) =>
 (0-u32max <= u32max)'
Message-ID: <202208181013.Jmha89rK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b06a2755758937add738545ba4a544fc5a1c56d
commit: cd4c314a65d3cce6486f8303e42aca04fd9f9011 mt76: mt7915: refine register definition
date:   7 months ago
config: ia64-randconfig-m031-20220814 (https://download.01.org/0day-ci/archive/20220818/202208181013.Jmha89rK-lkp@intel.com/config)
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

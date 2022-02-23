Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E1E4C1C54
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244325AbiBWThV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiBWThQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:37:16 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766E6344C6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645645007; x=1677181007;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pGhsZBvXembgX/5xDXly0q/niwt9o53sW1vN3DE093E=;
  b=fpN+XrB7BO13n1j5K5sz3t4T0eQ9D7jM1xP/DpahTaylIyB9u6EPQrTv
   Cz2nRsE+eHLvOgUaAYeVO6BpbLSD0jwJspoHkX3ChqK5qxVyFc7ERtzpQ
   ZFEBsYO2F0VbDHRHiVR9tl3ydkuYpJX54EUq6IB6JC/Bq/mF6Np4XdTTs
   Q+swLmcx1y5UcofVnFUu/2ILc/EHfK2nV/2GwFto1Y1SKCgOKi41VB6VN
   9v/Gfr8kjQyX/QePxUgCPNapcxNU8Z6bqw/iBIyQ4k/1Jfm5i8LWX7fNc
   4P6cxpbdo+4Zws3MJmiTEKrFAplbYGsKAbCqticS9krLmtQ8EM6HOoIbO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="235573908"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="235573908"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 11:36:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="573951642"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Feb 2022 11:36:45 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMxRM-0001k8-JI; Wed, 23 Feb 2022 19:36:44 +0000
Date:   Thu, 24 Feb 2022 03:36:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [nbd168-wireless:mtk-flow-offload 15/15]
 drivers/net/ethernet/mediatek/mtk_ppe.c:446:28: warning: variable 'head' set
 but not used
Message-ID: <202202240359.nIypTA36-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/nbd168/wireless mtk-flow-offload
head:   4dded169141416b3248146f545378f36cca6bd03
commit: 4dded169141416b3248146f545378f36cca6bd03 [15/15] net: ethernet: mtk_eth_soc: support creating mac address based offload entries
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220224/202202240359.nIypTA36-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/nbd168/wireless/commit/4dded169141416b3248146f545378f36cca6bd03
        git remote add nbd168-wireless https://github.com/nbd168/wireless
        git fetch --no-tags nbd168-wireless mtk-flow-offload
        git checkout 4dded169141416b3248146f545378f36cca6bd03
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/ethernet/mediatek/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/mediatek/mtk_ppe.c: In function 'mtk_flow_entry_update_l2':
>> drivers/net/ethernet/mediatek/mtk_ppe.c:446:28: warning: variable 'head' set but not used [-Wunused-but-set-variable]
     446 |         struct hlist_head *head;
         |                            ^~~~


vim +/head +446 drivers/net/ethernet/mediatek/mtk_ppe.c

   440	
   441	static void
   442	mtk_flow_entry_update_l2(struct mtk_ppe *ppe, struct mtk_flow_entry *entry)
   443	{
   444		struct mtk_flow_entry *cur;
   445		struct mtk_foe_entry *hwe;
 > 446		struct hlist_head *head;
   447		struct hlist_node *tmp;
   448		int idle;
   449	
   450		idle = __mtk_foe_entry_idle_time(ppe, entry->data.ib1);
   451		head = &entry->l2_flows;
   452		hlist_for_each_entry_safe(cur, tmp, &entry->l2_flows, l2_data.list) {
   453			int cur_idle;
   454			u32 ib1;
   455	
   456			hwe = &ppe->foe_table[cur->hash];
   457			ib1 = READ_ONCE(hwe->ib1);
   458	
   459			if (FIELD_GET(MTK_FOE_IB1_STATE, ib1) != MTK_FOE_STATE_BIND) {
   460				cur->hash = 0xffff;
   461				__mtk_foe_entry_clear(ppe, cur);
   462				continue;
   463			}
   464	
   465			cur_idle = __mtk_foe_entry_idle_time(ppe, ib1);
   466			if (cur_idle >= idle)
   467				continue;
   468	
   469			idle = cur_idle;
   470			entry->data.ib1 &= ~MTK_FOE_IB1_BIND_TIMESTAMP;
   471			entry->data.ib1 |= hwe->ib1 & MTK_FOE_IB1_BIND_TIMESTAMP;
   472		}
   473	}
   474	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

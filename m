Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393F35479DE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 13:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbiFLLFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 07:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiFLLFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 07:05:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110B136E0D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 04:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655031907; x=1686567907;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VqnilqKc2DQHoSUV8vrS9SIsZS3bjUnnR/OEL95a+yE=;
  b=NAeQvowHynF1HAep+MoBtS5XwePFtkbFHvcSq3mYrtX0sZREepT0B7nR
   OthgXwlDKA0DtQXoBF+0FgDp9/PT0kM4tFajr7O02yvsJDkLKnMYpaAmX
   CZwSsRgNEHTO4G0D/dCe6BNwRuOjEb0UzSavnXunGDKmffBipbcbIWHca
   cfAtv3B6Q/HB9fTgVTT2rnVcqKHDIQqnrtZeU/hNbwy4agkJ8ZpgmCf48
   IYTYjUIbkz08VXSL6DdpMw8TXpBv/X2nntpw4vT/9wQZ9e1ahSom1yMbY
   yVl7BDdt13LlMrgrNLUEN3nr3wabSbW68D4k1DpNO6y2nJL7avJbYVyRO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="364356540"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="364356540"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 04:05:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="672751441"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2022 04:05:05 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0LOy-000Jrf-Ri;
        Sun, 12 Jun 2022 11:05:04 +0000
Date:   Sun, 12 Jun 2022 19:04:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/mediatek/mtk_ppe.c:572:18: warning: array
 subscript 'struct mtk_flow_entry[0]' is partly outside array bounds of
 'unsigned char[24]'
Message-ID: <202206121811.nCGepk59-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7a68065eb9cd194cf03f135c9211eeb2d5c4c0a0
commit: 33fc42de33278b2b3ec6f3390512987bc29a62b7 net: ethernet: mtk_eth_soc: support creating mac address based offload entries
date:   10 weeks ago
config: mips-randconfig-r024-20220612 (https://download.01.org/0day-ci/archive/20220612/202206121811.nCGepk59-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=33fc42de33278b2b3ec6f3390512987bc29a62b7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 33fc42de33278b2b3ec6f3390512987bc29a62b7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   {standard input}: Assembler messages:
   {standard input}:25: Error: found '(', expected: ')'
   {standard input}:25: Error: found '(', expected: ')'
   {standard input}:25: Error: non-constant expression in ".if" statement
   {standard input}:25: Error: junk at end of line, first unrecognized character is `('
   {standard input}:49: Error: found '(', expected: ')'
   {standard input}:49: Error: found '(', expected: ')'
   {standard input}:49: Error: non-constant expression in ".if" statement
   {standard input}:49: Error: junk at end of line, first unrecognized character is `('
   {standard input}:73: Error: found '(', expected: ')'
   {standard input}:73: Error: found '(', expected: ')'
   {standard input}:73: Error: non-constant expression in ".if" statement
   {standard input}:73: Error: junk at end of line, first unrecognized character is `('
   drivers/net/ethernet/mediatek/mtk_ppe.c: In function 'mtk_foe_entry_commit_subflow':
>> drivers/net/ethernet/mediatek/mtk_ppe.c:572:18: warning: array subscript 'struct mtk_flow_entry[0]' is partly outside array bounds of 'unsigned char[24]' [-Warray-bounds]
     572 |         flow_info->l2_data.base_flow = entry;
         |                  ^~
   drivers/net/ethernet/mediatek/mtk_ppe.c:567:21: note: referencing an object of size 24 allocated by 'kzalloc.constprop'
     567 |         flow_info = kzalloc(offsetof(struct mtk_flow_entry, l2_data.end),
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     568 |                             GFP_ATOMIC);
         |                             ~~~~~~~~~~~
   drivers/net/ethernet/mediatek/mtk_ppe.c:573:18: warning: array subscript 'struct mtk_flow_entry[0]' is partly outside array bounds of 'unsigned char[24]' [-Warray-bounds]
     573 |         flow_info->type = MTK_FLOW_TYPE_L2_SUBFLOW;
         |                  ^~
   drivers/net/ethernet/mediatek/mtk_ppe.c:567:21: note: referencing an object of size 24 allocated by 'kzalloc.constprop'
     567 |         flow_info = kzalloc(offsetof(struct mtk_flow_entry, l2_data.end),
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     568 |                             GFP_ATOMIC);
         |                             ~~~~~~~~~~~
   drivers/net/ethernet/mediatek/mtk_ppe.c:574:18: warning: array subscript 'struct mtk_flow_entry[0]' is partly outside array bounds of 'unsigned char[24]' [-Warray-bounds]
     574 |         flow_info->hash = hash;
         |                  ^~
   drivers/net/ethernet/mediatek/mtk_ppe.c:567:21: note: referencing an object of size 24 allocated by 'kzalloc.constprop'
     567 |         flow_info = kzalloc(offsetof(struct mtk_flow_entry, l2_data.end),
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     568 |                             GFP_ATOMIC);
         |                             ~~~~~~~~~~~
   {standard input}:2572: Error: found '(', expected: ')'
   {standard input}:2572: Error: found '(', expected: ')'
   {standard input}:2572: Error: non-constant expression in ".if" statement
   {standard input}:2572: Error: junk at end of line, first unrecognized character is `('
   {standard input}:5006: Error: found '(', expected: ')'
   {standard input}:5006: Error: found '(', expected: ')'
   {standard input}:5006: Error: non-constant expression in ".if" statement
   {standard input}:5006: Error: junk at end of line, first unrecognized character is `('
   {standard input}:5567: Error: found '(', expected: ')'
   {standard input}:5567: Error: found '(', expected: ')'
   {standard input}:5567: Error: non-constant expression in ".if" statement
   {standard input}:5567: Error: junk at end of line, first unrecognized character is `('
   {standard input}:7090: Error: found '(', expected: ')'
   {standard input}:7090: Error: found '(', expected: ')'
   {standard input}:7090: Error: non-constant expression in ".if" statement
   {standard input}:7090: Error: junk at end of line, first unrecognized character is `('


vim +572 drivers/net/ethernet/mediatek/mtk_ppe.c

   556	
   557	static void
   558	mtk_foe_entry_commit_subflow(struct mtk_ppe *ppe, struct mtk_flow_entry *entry,
   559				     u16 hash)
   560	{
   561		struct mtk_flow_entry *flow_info;
   562		struct mtk_foe_entry foe, *hwe;
   563		struct mtk_foe_mac_info *l2;
   564		u32 ib1_mask = MTK_FOE_IB1_PACKET_TYPE | MTK_FOE_IB1_UDP;
   565		int type;
   566	
   567		flow_info = kzalloc(offsetof(struct mtk_flow_entry, l2_data.end),
   568				    GFP_ATOMIC);
   569		if (!flow_info)
   570			return;
   571	
 > 572		flow_info->l2_data.base_flow = entry;
   573		flow_info->type = MTK_FLOW_TYPE_L2_SUBFLOW;
   574		flow_info->hash = hash;
   575		hlist_add_head(&flow_info->list, &ppe->foe_flow[hash / 2]);
   576		hlist_add_head(&flow_info->l2_data.list, &entry->l2_flows);
   577	
   578		hwe = &ppe->foe_table[hash];
   579		memcpy(&foe, hwe, sizeof(foe));
   580		foe.ib1 &= ib1_mask;
   581		foe.ib1 |= entry->data.ib1 & ~ib1_mask;
   582	
   583		l2 = mtk_foe_entry_l2(&foe);
   584		memcpy(l2, &entry->data.bridge.l2, sizeof(*l2));
   585	
   586		type = FIELD_GET(MTK_FOE_IB1_PACKET_TYPE, foe.ib1);
   587		if (type == MTK_PPE_PKT_TYPE_IPV4_HNAPT)
   588			memcpy(&foe.ipv4.new, &foe.ipv4.orig, sizeof(foe.ipv4.new));
   589		else if (type >= MTK_PPE_PKT_TYPE_IPV6_ROUTE_3T && l2->etype == ETH_P_IP)
   590			l2->etype = ETH_P_IPV6;
   591	
   592		*mtk_foe_entry_ib2(&foe) = entry->data.bridge.ib2;
   593	
   594		__mtk_foe_entry_commit(ppe, &foe, hash);
   595	}
   596	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

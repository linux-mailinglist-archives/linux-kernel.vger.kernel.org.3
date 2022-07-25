Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE4757FDFC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiGYLBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiGYLBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:01:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C880E5FDB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658746860; x=1690282860;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mo9chgy0bi5uG+EZ6kmOhhKH/zG+YyE1Qh3F/VVxZYk=;
  b=RaBW85fvCGiY/36kkxl0ZIgLwXov1+26FuA7087TOIdYxzNqTo/ZqWC2
   RSEOkW+nW6xiITcDD7RerYkIJwhyRw8u+sMU71DrPhEIL2PYB7Xk6oSLS
   b4nL/cPW8Vx2MKXcVIjIV6P+TX2xXmHoQGnO/Xf7QBl9DnESUuFDh1Ei7
   FTkUIwfJnaEWZXa26RWKCvgo5uhDdNwg7FtsU1ujQXELTS8sDbQwdt2rq
   IXnNirqOBPhx04B58cecoQnRXzn+vRoMySYikbXs6F3T2aLKUoil48P7R
   E5UzaDxlS4OmFIOLdeXIwmeVDzk0yzXabf1gvF9MaaZAfp4lsK7ey9R79
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="288429245"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="288429245"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 04:00:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="549949151"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Jul 2022 04:00:16 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFvot-0004yf-34;
        Mon, 25 Jul 2022 11:00:15 +0000
Date:   Mon, 25 Jul 2022 18:59:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c:262:17:
 warning: taking address of packed member 'len' of class or structure 'tlv'
 may result in an unaligned pointer value
Message-ID: <202207251801.hLXIP9Rh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e0dccc3b76fb35bb257b4118367a883073d7390e
commit: 25702d9c55dc5fda2ad9ad8de115e50dc7394ef9 mt76: connac: rely on le16_add_cpu in mt76_connac_mcu_add_nested_tlv
date:   7 months ago
config: arm-buildonly-randconfig-r003-20220724 (https://download.01.org/0day-ci/archive/20220725/202207251801.hLXIP9Rh-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9e88cbcc403bdf82f29259ad60ff60a8fc4434a1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=25702d9c55dc5fda2ad9ad8de115e50dc7394ef9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 25702d9c55dc5fda2ad9ad8de115e50dc7394ef9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/wireless/mediatek/mt76/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c:262:17: warning: taking address of packed member 'len' of class or structure 'tlv' may result in an unaligned pointer value [-Waddress-of-packed-member]
                   le16_add_cpu(&sta_hdr->len, len);
                                 ^~~~~~~~~~~~
   1 warning generated.


vim +262 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c

   242	
   243	struct tlv *
   244	mt76_connac_mcu_add_nested_tlv(struct sk_buff *skb, int tag, int len,
   245				       void *sta_ntlv, void *sta_wtbl)
   246	{
   247		struct sta_ntlv_hdr *ntlv_hdr = sta_ntlv;
   248		struct tlv *sta_hdr = sta_wtbl;
   249		struct tlv *ptlv, tlv = {
   250			.tag = cpu_to_le16(tag),
   251			.len = cpu_to_le16(len),
   252		};
   253		u16 ntlv;
   254	
   255		ptlv = skb_put(skb, len);
   256		memcpy(ptlv, &tlv, sizeof(tlv));
   257	
   258		ntlv = le16_to_cpu(ntlv_hdr->tlv_num);
   259		ntlv_hdr->tlv_num = cpu_to_le16(ntlv + 1);
   260	
   261		if (sta_hdr)
 > 262			le16_add_cpu(&sta_hdr->len, len);
   263	
   264		return ptlv;
   265	}
   266	EXPORT_SYMBOL_GPL(mt76_connac_mcu_add_nested_tlv);
   267	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

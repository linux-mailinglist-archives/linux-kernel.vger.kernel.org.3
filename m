Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE165174AB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbiEBQqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiEBQqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:46:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD036369
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651509765; x=1683045765;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D3wMZFZpe2ZlYEhjuVFF/JE9SxqxI1IK1rZxLLvrtns=;
  b=ca3tgYFtr6g5b9I0JwszflTwdTa5KvLb6eMMJ5wIGpR7nVPdMuKzNAuQ
   uSJXA2NqLQXPpo6BDtkHSV6yjELRSCT3FjowPrbx9Z0J7u4728Qyj2+zz
   E3zp0oU/yKNXW33H1nYRIOAHsXd1aoF2HzrCaUlq4TV01htkReLyqXsVO
   wL+dN+87dluKobO1tGFFppgbGVqeI2iIY1BZDIUQ28RUBhmDSyf36D7Ts
   qoWy4uToGLoLmdp19QF8HrK+0AHqW7zlFrVDduV3FbIHbQeQE+zR+O0XS
   NqCE4pg+SxLmPtT3d1YT86HQD18hgGmRgWIrBH7k92BT3cMZZNLaZFUTX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="327803555"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="327803555"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 09:42:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="516177017"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 May 2022 09:42:43 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlZ8F-0009hD-7Q;
        Mon, 02 May 2022 16:42:43 +0000
Date:   Tue, 3 May 2022 00:42:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/070-audio 2/20] drivers/dma/apple-admac.c:203:11:
 warning: format specifies type 'unsigned long long' but the argument has
 type 'dma_addr_t' (aka 'unsigned int')
Message-ID: <202205030024.ZdYFyB3P-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/070-audio
head:   91b81123719d8b742da188f01ee3d897e0fac92b
commit: 428ea35bca43fe213456fa57640c57deeadc4204 [2/20] dmaengine: apple-admac: Add Apple ADMAC driver
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220503/202205030024.ZdYFyB3P-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/428ea35bca43fe213456fa57640c57deeadc4204
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/070-audio
        git checkout 428ea35bca43fe213456fa57640c57deeadc4204
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/dma/ drivers/platform/ sound/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/dma/apple-admac.c:203:11: warning: format specifies type 'unsigned long long' but the argument has type 'dma_addr_t' (aka 'unsigned int') [-Wformat]
                   channo, addr, (u32) tx->period_len, FLAG_DESC_NOTIFY);
                           ^~~~
   include/linux/dev_printk.h:155:39: note: expanded from macro 'dev_dbg'
           dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                        ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:167:19: note: expanded from macro 'dynamic_dev_dbg'
                              dev, fmt, ##__VA_ARGS__)
                                   ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                 ^~~~~~~~~~~
   include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                               ^~~~~~~~~~~
>> drivers/dma/apple-admac.c:206:46: warning: shift count >= width of type [-Wshift-count-overflow]
           admac_poke(ad, REG_DESC_WRITE(channo), addr >> 32);
                                                       ^  ~~
>> drivers/dma/apple-admac.c:260:5: warning: no previous prototype for function 'admac_cyclic_read_residue' [-Wmissing-prototypes]
   u32 admac_cyclic_read_residue(struct admac_data *ad, int channo, struct admac_tx *adtx)
       ^
   drivers/dma/apple-admac.c:260:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u32 admac_cyclic_read_residue(struct admac_data *ad, int channo, struct admac_tx *adtx)
   ^
   static 
   3 warnings generated.


vim +203 drivers/dma/apple-admac.c

   187	
   188	/*
   189	 * Write one hardware descriptor for a dmaegine cyclic transaction.
   190	 */
   191	static void admac_cyclic_write_one_desc(struct admac_data *ad, int channo,
   192						struct admac_tx *tx)
   193	{
   194		dma_addr_t addr;
   195	
   196		if (WARN_ON(!tx->cyclic))
   197			return;
   198	
   199		addr = tx->buf_addr + (tx->submitted_pos % tx->buf_len);
   200		WARN_ON(addr + tx->period_len > tx->buf_end);
   201	
   202		dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
 > 203			channo, addr, (u32) tx->period_len, FLAG_DESC_NOTIFY);
   204	
   205		admac_poke(ad, REG_DESC_WRITE(channo), addr);
 > 206		admac_poke(ad, REG_DESC_WRITE(channo), addr >> 32);
   207		admac_poke(ad, REG_DESC_WRITE(channo), tx->period_len);
   208		admac_poke(ad, REG_DESC_WRITE(channo), FLAG_DESC_NOTIFY);
   209	
   210		tx->submitted_pos += tx->period_len;
   211		tx->submitted_pos %= 2 * tx->buf_len;
   212	}
   213	
   214	/*
   215	 * Write all the hardware descriptors for a cyclic transaction
   216	 * there is space for.
   217	 */
   218	static void admac_cyclic_write_desc(struct admac_data *ad, int channo,
   219						struct admac_tx *tx)
   220	{
   221		int i;
   222	
   223		for (i = 0; i < 4; i++) {
   224			if (admac_peek(ad, REG_DESC_RING(channo)) & RING_FULL)
   225				break;
   226			admac_cyclic_write_one_desc(ad, channo, tx);
   227		}
   228	}
   229	
   230	static int admac_alloc_chan_resources(struct dma_chan *chan)
   231	{
   232		return 0;
   233	}
   234	
   235	static void admac_free_chan_resources(struct dma_chan *chan)
   236	{
   237		// TODO
   238	}
   239	
   240	static int admac_ring_noccupied_slots(int ringval)
   241	{
   242		int wrslot = FIELD_GET(RING_WRITE_SLOT, ringval);
   243		int rdslot = FIELD_GET(RING_READ_SLOT, ringval);
   244	
   245		if (wrslot != rdslot) {
   246			return (wrslot + 4 - rdslot) % 4;
   247		} else {
   248			WARN_ON((ringval & (RING_FULL | RING_EMPTY)) == 0);
   249	
   250			if (ringval & RING_FULL)
   251				return 4;
   252			else
   253				return 0;
   254		}
   255	}
   256	
   257	/*
   258	 * Read from hardware the residue of a cyclic dmaengine transaction.
   259	 */
 > 260	u32 admac_cyclic_read_residue(struct admac_data *ad, int channo, struct admac_tx *adtx)
   261	{
   262		u32 ring1, ring2;
   263		u32 residue1, residue2;
   264		int nreports;
   265		size_t pos;
   266	
   267		ring1 =    admac_peek(ad, REG_REPORT_RING(channo));
   268		residue1 = admac_peek(ad, REG_RESIDUE(channo));
   269		ring2 =    admac_peek(ad, REG_REPORT_RING(channo));
   270		residue2 = admac_peek(ad, REG_RESIDUE(channo));
   271	
   272		if (residue2 > residue1) {
   273			// engine must have loaded next descriptor between the two residue reads
   274			nreports = admac_ring_noccupied_slots(ring1) + 1;
   275		} else {
   276			// no descriptor load between the two reads, ring2 is safe to use
   277			nreports = admac_ring_noccupied_slots(ring2);
   278		}
   279	
   280		pos = adtx->reclaimed_pos + adtx->period_len * (nreports + 1) \
   281							 - residue2;
   282	
   283		return adtx->buf_len - pos % adtx->buf_len;
   284	}
   285	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

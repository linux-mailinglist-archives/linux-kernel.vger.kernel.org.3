Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1249F5473E1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 12:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiFKKnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 06:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiFKKnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 06:43:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD21E91
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654944193; x=1686480193;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rSlk7VwOPh9kjavTqEPW04bXeJeRBAoDMQr6OFPwQSI=;
  b=Nh0dcejqsS56GCXbIfQY/B42RtR1YhNwJ7KM+dbtYgYhjh+KdHLj/PmY
   fvO0A/8gXSMavPqmvyUrAFFhT1tf+qfMMcTfpshL4zZbV7ZKNKrQ4988G
   iyWxxwhfDRigtaMAwZOvC4E25UXbxU6DKa78UfjajOm4eVlaoDsPsBuD6
   tX7L8/iRwL/11NPZ0J0qOnUWiR8fslP6ki4b+muepBgJjO9WxDj1HE2G5
   9CrYkQT4aFoqjJQHbSDSnC4IJwebN5E0iMuNn0kUPxerjtATQpN/U3pYW
   P7mmtbxwgrCyqQ23EB8D5TyNlQFm2vdWi8tuoPQfd5Vnh280Pht3pSefp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="266619439"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="266619439"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 03:43:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="828726615"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jun 2022 03:43:11 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzyaE-000IoL-Fa;
        Sat, 11 Jun 2022 10:43:10 +0000
Date:   Sat, 11 Jun 2022 18:42:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [vkoul-dmaengine:next 6/11] drivers/dma/apple-admac.c:210:34:
 warning: format specifies type 'unsigned int' but the argument has type
 'unsigned long'
Message-ID: <202206111824.f7xWW0VG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
head:   c9357195c5770029f0c65a5b76756dea5b767ff0
commit: b127315d9a78c011c011b88b92f650510edcfbd2 [6/11] dmaengine: apple-admac: Add Apple ADMAC driver
config: riscv-randconfig-r035-20220611 (https://download.01.org/0day-ci/archive/20220611/202206111824.f7xWW0VG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ff4abe755279a3a47cc416ef80dbc900d9a98a19)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?id=b127315d9a78c011c011b88b92f650510edcfbd2
        git remote add vkoul-dmaengine https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
        git fetch --no-tags vkoul-dmaengine next
        git checkout b127315d9a78c011c011b88b92f650510edcfbd2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/dma/apple-admac.c:210:34: warning: format specifies type 'unsigned int' but the argument has type 'unsigned long' [-Wformat]
                   channo, &addr, tx->period_len, FLAG_DESC_NOTIFY);
                                                  ^~~~~~~~~~~~~~~~
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
   drivers/dma/apple-admac.c:32:26: note: expanded from macro 'FLAG_DESC_NOTIFY'
   #define FLAG_DESC_NOTIFY        BIT(16)
                                   ^~~~~~~
   include/vdso/bits.h:7:19: note: expanded from macro 'BIT'
   #define BIT(nr)                 (UL(1) << (nr))
                                   ^~~~~~~~~~~~~~~
>> drivers/dma/apple-admac.c:213:22: warning: shift count >= width of type [-Wshift-count-overflow]
           writel_relaxed(addr >> 32,       ad->base + REG_DESC_WRITE(channo));
                               ^  ~~
   arch/riscv/include/asm/mmio.h:120:57: note: expanded from macro 'writel_relaxed'
   #define writel_relaxed(v, c)    ({ __io_rbw(); writel_cpu((v), (c)); __io_raw(); })
                                                              ^
   arch/riscv/include/asm/mmio.h:93:71: note: expanded from macro 'writel_cpu'
   #define writel_cpu(v, c)        ((void)__raw_writel((__force u32)cpu_to_le32(v), (c)))
                                                                                ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   2 warnings generated.


vim +210 drivers/dma/apple-admac.c

   195	
   196	/*
   197	 * Write one hardware descriptor for a dmaengine cyclic transaction.
   198	 */
   199	static void admac_cyclic_write_one_desc(struct admac_data *ad, int channo,
   200						struct admac_tx *tx)
   201	{
   202		dma_addr_t addr;
   203	
   204		addr = tx->buf_addr + (tx->submitted_pos % tx->buf_len);
   205	
   206		/* If happens means we have buggy code */
   207		WARN_ON_ONCE(addr + tx->period_len > tx->buf_end);
   208	
   209		dev_dbg(ad->dev, "ch%d descriptor: addr=0x%pad len=0x%zx flags=0x%x\n",
 > 210			channo, &addr, tx->period_len, FLAG_DESC_NOTIFY);
   211	
   212		writel_relaxed(addr,             ad->base + REG_DESC_WRITE(channo));
 > 213		writel_relaxed(addr >> 32,       ad->base + REG_DESC_WRITE(channo));
   214		writel_relaxed(tx->period_len,   ad->base + REG_DESC_WRITE(channo));
   215		writel_relaxed(FLAG_DESC_NOTIFY, ad->base + REG_DESC_WRITE(channo));
   216	
   217		tx->submitted_pos += tx->period_len;
   218		tx->submitted_pos %= 2 * tx->buf_len;
   219	}
   220	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA835675B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiGER2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiGER1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:27:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745A6205F7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657042069; x=1688578069;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zybgc9bSkn/aCSOb4a3jN3PrFsxboVpHXDzSFUMtco4=;
  b=UYluno192eH2VAxGuNIACdcT4snDPvdHWgUZvmnvioTHwTpe3Dn0Zhjw
   5wkClK9ELOB5R2X8AagtHUcR4SXSqpwsYOxqyBAHWAn85SNF/wQiJoBEO
   PJ4CveIhgzcber/5y8nRu30yCkdkRbZsjcIFGs2YzD14sWCEMLZ5Zqk/q
   U3axaF926YPUXLUx9IG5T0SomSiD9C7RC3bV56700LsHCf35RRbMphr5a
   TcWeWJOg/W6hqG7AfOJ0tXU0eDBJOQkjK0wVFdY1CWe2FBdMXMN50L6CJ
   RHkjYcjSvSzQF9itslKwYXWmA1BF2Jhl612PCfeQEzhdmUGjEnAsmju5c
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="345094491"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="345094491"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 10:27:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="650258696"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jul 2022 10:27:47 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8mKx-000JQH-7I;
        Tue, 05 Jul 2022 17:27:47 +0000
Date:   Wed, 6 Jul 2022 01:26:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Coly Li <colyli@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [colyli-bcache:nvdimm-meta 16/16] drivers/md/bcache/alloc.c:488:9:
 warning: argument 1 null where non-null expected
Message-ID: <202207060104.rBjNku9y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git nvdimm-meta
head:   5c8259ab2129816fc49fd6d060206ba61b0594d1
commit: 5c8259ab2129816fc49fd6d060206ba61b0594d1 [16/16] bcache: support storing bcache btree nodes into NVDIMM meta device
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220706/202207060104.rBjNku9y-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git/commit/?id=5c8259ab2129816fc49fd6d060206ba61b0594d1
        git remote add colyli-bcache https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git
        git fetch --no-tags colyli-bcache nvdimm-meta
        git checkout 5c8259ab2129816fc49fd6d060206ba61b0594d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/md/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/md/bcache/nvmpg.h:8,
                    from drivers/md/bcache/alloc.c:66:
   drivers/md/bcache/nvmpg_format.h:132:19: warning: 'bch_nvmpg_recs_magic' defined but not used [-Wunused-const-variable=]
     132 | static const __u8 bch_nvmpg_recs_magic[] = {
         |                   ^~~~~~~~~~~~~~~~~~~~
   drivers/md/bcache/nvmpg_format.h:129:19: warning: 'bch_nvmpg_magic' defined but not used [-Wunused-const-variable=]
     129 | static const __u8 bch_nvmpg_magic[] = {
         |                   ^~~~~~~~~~~~~~~
   In function '__bch_nvmpg_bucket_free',
       inlined from 'bch_bucket_free' at drivers/md/bcache/alloc.c:497:3:
>> drivers/md/bcache/alloc.c:488:9: warning: argument 1 null where non-null expected [-Wnonnull]
     488 |         memset(bch_nvmpg_offset_to_ptr(nvmpg_offset), 0, 1<<order);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/string.h:20,
                    from include/linux/uuid.h:12,
                    from include/linux/mod_devicetable.h:13,
                    from arch/parisc/include/asm/hardware.h:5,
                    from arch/parisc/include/asm/processor.h:17,
                    from arch/parisc/include/asm/spinlock.h:7,
                    from arch/parisc/include/asm/atomic.h:22,
                    from include/linux/atomic.h:7,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/parisc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/wait.h:9,
                    from include/linux/mempool.h:8,
                    from include/linux/bio.h:8,
                    from drivers/md/bcache/bcache.h:181,
                    from drivers/md/bcache/alloc.c:64:
   drivers/md/bcache/alloc.c: In function 'bch_bucket_free':
   arch/parisc/include/asm/string.h:6:15: note: in a call to function 'memset' declared 'nonnull'
       6 | extern void * memset(void *, int, size_t);
         |               ^~~~~~
--
   In file included from drivers/md/bcache/nvmpg.h:8,
                    from drivers/md/bcache/btree.c:29:
   drivers/md/bcache/nvmpg_format.h:132:19: warning: 'bch_nvmpg_recs_magic' defined but not used [-Wunused-const-variable=]
     132 | static const __u8 bch_nvmpg_recs_magic[] = {
         |                   ^~~~~~~~~~~~~~~~~~~~
   drivers/md/bcache/nvmpg_format.h:129:19: warning: 'bch_nvmpg_magic' defined but not used [-Wunused-const-variable=]
     129 | static const __u8 bch_nvmpg_magic[] = {
         |                   ^~~~~~~~~~~~~~~
   In function '__bch_nvmpg_btree_node_read',
       inlined from 'bch_btree_node_read' at drivers/md/bcache/btree.c:308:3:
>> drivers/md/bcache/btree.c:295:9: warning: argument 2 null where non-null expected [-Wnonnull]
     295 |         memcpy(b->keys.set[0].data, ptr, KEY_SIZE(&b->key) << 9);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/string.h:20,
                    from include/linux/uuid.h:12,
                    from include/linux/mod_devicetable.h:13,
                    from arch/parisc/include/asm/hardware.h:5,
                    from arch/parisc/include/asm/processor.h:17,
                    from arch/parisc/include/asm/spinlock.h:7,
                    from arch/parisc/include/asm/atomic.h:22,
                    from include/linux/atomic.h:7,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/parisc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/wait.h:9,
                    from include/linux/mempool.h:8,
                    from include/linux/bio.h:8,
                    from drivers/md/bcache/bcache.h:181,
                    from drivers/md/bcache/btree.c:24:
   drivers/md/bcache/btree.c: In function 'bch_btree_node_read':
   arch/parisc/include/asm/string.h:9:8: note: in a call to function 'memcpy' declared 'nonnull'
       9 | void * memcpy(void * dest,const void *src,size_t count);
         |        ^~~~~~


vim +488 drivers/md/bcache/alloc.c

   480	
   481	static void __bch_nvmpg_bucket_free(struct cache_set *c, struct bkey *k)
   482	{
   483		int order;
   484		unsigned long nvmpg_offset;
   485	
   486		order = ilog2(c->cache->sb.bucket_size / PAGE_SECTORS);
   487		nvmpg_offset = bkey_offset_to_nvmpg_offset(PTR_OFFSET(k, 0));
 > 488		memset(bch_nvmpg_offset_to_ptr(nvmpg_offset), 0, 1<<order);
   489		bch_nvmpg_free_pages(nvmpg_offset, order, c->set_uuid);
   490	}
   491	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB14959D274
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241116AbiHWHlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241079AbiHWHl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:41:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F78647CB
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661240486; x=1692776486;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gQQ7pWqHvPCyb/9Uo8rFSGnpiq55qOBowxqjLdnZDmM=;
  b=LI+JipQ7unbTWkgLG1CSZtOI/wWffFQv+n4LtLodL+1uNvKwQHvjBkq6
   mtAh5t0zjz56mjNXR3JLahKunyjQXiQr6F1r9ablt/2bF81sPASLeOp9P
   F1uQO9o/4hM/y7EzwOpPDDpSwe1TjN+uvXsPcSa7dgPZzXsuTUQ3ycPbk
   kH+oMXN7bJJw+nA1ucNlSAEifR/8GSZaj3f+HuyGxxzt+rzWY0znODXuL
   HftHQyWud1nkdK68i7UMWifRo8BFVlViKm1PmQynBuCwdwQJbPu0QTfEa
   jaz0LWI9FWSnMKCKJm9l2gFPH2Cil/NO+B7Xmyf5+ESF8wiWafrJYL2gl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="357596862"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="357596862"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:41:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="854773975"
Received: from lkp-server01.sh.intel.com (HELO 5b31f6010e99) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Aug 2022 00:41:19 -0700
Received: from kbuild by 5b31f6010e99 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQOXG-0000Bs-2i;
        Tue, 23 Aug 2022 07:41:18 +0000
Date:   Tue, 23 Aug 2022 15:41:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [mkp-scsi:for-next 26/50] include/linux/find.h:40:23: warning: array
 subscript 'long unsigned int[0]' is partly outside array bounds of 'u32[1]'
 {aka 'unsigned int[1]'}
Message-ID: <202208231557.N1l7dulw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
head:   8750aa54da43c0b50ea22f2f294dc834035b2146
commit: 434726c4b89ca25a278e548cf1034e6e22241723 [26/50] scsi: mpi3mr: Refresh SAS ports during soft reset
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220823/202208231557.N1l7dulw-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?id=434726c4b89ca25a278e548cf1034e6e22241723
        git remote add mkp-scsi https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
        git fetch --no-tags mkp-scsi for-next
        git checkout 434726c4b89ca25a278e548cf1034e6e22241723
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/scsi/mpi3mr/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from drivers/scsi/mpi3mr/mpi3mr.h:13,
                    from drivers/scsi/mpi3mr/mpi3mr_transport.c:10:
   drivers/scsi/mpi3mr/mpi3mr_transport.c: In function 'mpi3mr_update_mr_sas_port':
>> include/linux/find.h:40:23: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
      40 |                 val = *addr & GENMASK(size - 1, offset);
         |                       ^~~~~
   drivers/scsi/mpi3mr/mpi3mr_transport.c:1610:27: note: while referencing 'phys_to_be_added'
    1610 |         u32 phy_mask_xor, phys_to_be_added, phys_to_be_removed;
         |                           ^~~~~~~~~~~~~~~~
   In file included from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from drivers/scsi/mpi3mr/mpi3mr.h:13,
                    from drivers/scsi/mpi3mr/mpi3mr_transport.c:10:
>> include/linux/find.h:40:23: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
      40 |                 val = *addr & GENMASK(size - 1, offset);
         |                       ^~~~~
   drivers/scsi/mpi3mr/mpi3mr_transport.c:1610:45: note: while referencing 'phys_to_be_removed'
    1610 |         u32 phy_mask_xor, phys_to_be_added, phys_to_be_removed;
         |                                             ^~~~~~~~~~~~~~~~~~


vim +40 include/linux/find.h

5c88af59f9abc20 include/asm-generic/bitops/find.h Yury Norov         2021-05-06  19  
19de85ef574c3a2 include/asm-generic/bitops/find.h Akinobu Mita       2011-05-26  20  #ifndef find_next_bit
d852a6afd91fc92 include/asm-generic/bitops/find.h Akinobu Mita       2010-09-29  21  /**
d852a6afd91fc92 include/asm-generic/bitops/find.h Akinobu Mita       2010-09-29  22   * find_next_bit - find the next set bit in a memory region
d852a6afd91fc92 include/asm-generic/bitops/find.h Akinobu Mita       2010-09-29  23   * @addr: The address to base the search on
d852a6afd91fc92 include/asm-generic/bitops/find.h Akinobu Mita       2010-09-29  24   * @size: The bitmap size in bits
6d7131bd52b3e0d include/linux/find.h              Anna-Maria Behnsen 2022-04-11  25   * @offset: The bitnumber to start searching at
ec778edf97dcaa5 include/asm-generic/bitops/find.h Cody P Schafer     2013-11-12  26   *
ec778edf97dcaa5 include/asm-generic/bitops/find.h Cody P Schafer     2013-11-12  27   * Returns the bit number for the next set bit
ec778edf97dcaa5 include/asm-generic/bitops/find.h Cody P Schafer     2013-11-12  28   * If no bits are set, returns @size.
d852a6afd91fc92 include/asm-generic/bitops/find.h Akinobu Mita       2010-09-29  29   */
5c88af59f9abc20 include/asm-generic/bitops/find.h Yury Norov         2021-05-06  30  static inline
5c88af59f9abc20 include/asm-generic/bitops/find.h Yury Norov         2021-05-06  31  unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
5c88af59f9abc20 include/asm-generic/bitops/find.h Yury Norov         2021-05-06  32  			    unsigned long offset)
5c88af59f9abc20 include/asm-generic/bitops/find.h Yury Norov         2021-05-06  33  {
277a20a498d3075 include/asm-generic/bitops/find.h Yury Norov         2021-05-06  34  	if (small_const_nbits(size)) {
277a20a498d3075 include/asm-generic/bitops/find.h Yury Norov         2021-05-06  35  		unsigned long val;
277a20a498d3075 include/asm-generic/bitops/find.h Yury Norov         2021-05-06  36  
277a20a498d3075 include/asm-generic/bitops/find.h Yury Norov         2021-05-06  37  		if (unlikely(offset >= size))
277a20a498d3075 include/asm-generic/bitops/find.h Yury Norov         2021-05-06  38  			return size;
277a20a498d3075 include/asm-generic/bitops/find.h Yury Norov         2021-05-06  39  
277a20a498d3075 include/asm-generic/bitops/find.h Yury Norov         2021-05-06 @40  		val = *addr & GENMASK(size - 1, offset);
277a20a498d3075 include/asm-generic/bitops/find.h Yury Norov         2021-05-06  41  		return val ? __ffs(val) : size;
277a20a498d3075 include/asm-generic/bitops/find.h Yury Norov         2021-05-06  42  	}
277a20a498d3075 include/asm-generic/bitops/find.h Yury Norov         2021-05-06  43  
5c88af59f9abc20 include/asm-generic/bitops/find.h Yury Norov         2021-05-06  44  	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
5c88af59f9abc20 include/asm-generic/bitops/find.h Yury Norov         2021-05-06  45  }
19de85ef574c3a2 include/asm-generic/bitops/find.h Akinobu Mita       2011-05-26  46  #endif
c7f612cdf091def include/asm-generic/bitops/find.h Akinobu Mita       2006-03-26  47  

:::::: The code at line 40 was first introduced by commit
:::::: 277a20a498d30753f5d8a607dbf967bc163552c1 lib: add fast path for find_next_*_bit()

:::::: TO: Yury Norov <yury.norov@gmail.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

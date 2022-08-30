Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045905A704B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiH3WCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiH3WCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:02:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A189080D
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661896718; x=1693432718;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UWNhfGM4o48/RHMrCxXlv99aKPtZmUSaLxKD1tQ+80U=;
  b=BsHoz8GWGZZLaZjQxiVlOC7qzOoBbBWeWJ6zZFjZrYeVcSuo4Bmb6LCb
   vt1DbdlHzxd6H6TH3HHRUGgVS5ZxhtfWoFyVYj3gbGeyVSdK5tgATqibu
   UlzQ483LRQUPIbs93djdnvXB2XZGNSIKv8M7s7kvh8ghL+9XUKKDAWMzy
   +b9+bp8EHWCP09jepRboxhZkI3EkJo+zJBzrdG8juqFSLRq5JYy6/crj6
   TVA9QmWmavQxAo9BAGqlUGcR+yWtw509uunbmLJUYmwrgAi9FMvhmAdEE
   Sk4lCSg/g5+h81red8C5urANcEFQrhSGmU8NDyoqzoVh/aBPui/cg49xh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="294049033"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="294049033"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 14:58:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="588794460"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 30 Aug 2022 14:58:35 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oT9Fh-0000fD-1L;
        Tue, 30 Aug 2022 21:58:33 +0000
Date:   Wed, 31 Aug 2022 05:58:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:virt-to-pfn-v6.0-rc1 10/24]
 fs/iomap/direct-io.c:195:29: sparse: sparse: Using plain integer as NULL
 pointer
Message-ID: <202208310538.aeMiqjUq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git virt-to-pfn-v6.0-rc1
head:   fd7709c9f1119794e96665ae423d79d93bfe43fc
commit: cb1bcb8486737f0d37b3ee9522ee44106d9875ae [10/24] ARM: mm: Make virt_to_pfn() a static inline
config: arm-randconfig-s042-20220830 (https://download.01.org/0day-ci/archive/20220831/202208310538.aeMiqjUq-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=cb1bcb8486737f0d37b3ee9522ee44106d9875ae
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator virt-to-pfn-v6.0-rc1
        git checkout cb1bcb8486737f0d37b3ee9522ee44106d9875ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash block/ fs/cifs/ fs/iomap/ lib/crypto/ net/ceph/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> fs/iomap/direct-io.c:195:29: sparse: sparse: Using plain integer as NULL pointer
--
>> block/blk-lib.c:186:53: sparse: sparse: Using plain integer as NULL pointer
--
>> net/ceph/messenger.c:247:26: sparse: sparse: Using plain integer as NULL pointer
--
>> lib/crypto/chacha20poly1305.c:60:26: sparse: sparse: Using plain integer as NULL pointer
   lib/crypto/chacha20poly1305.c:128:26: sparse: sparse: Using plain integer as NULL pointer
   lib/crypto/chacha20poly1305.c:215:26: sparse: sparse: Using plain integer as NULL pointer
--
>> lib/crypto/chacha20poly1305-selftest.c:8833:26: sparse: sparse: Using plain integer as NULL pointer

vim +195 fs/iomap/direct-io.c

db074436f42196 Darrick J. Wong   2019-07-15  190  
a6d3d49587d10d Christoph Hellwig 2021-08-10  191  static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
a6d3d49587d10d Christoph Hellwig 2021-08-10  192  		loff_t pos, unsigned len)
db074436f42196 Darrick J. Wong   2019-07-15  193  {
489734ef94f4f7 Eric Biggers      2022-01-28  194  	struct inode *inode = file_inode(dio->iocb->ki_filp);
db074436f42196 Darrick J. Wong   2019-07-15 @195  	struct page *page = ZERO_PAGE(0);
db074436f42196 Darrick J. Wong   2019-07-15  196  	struct bio *bio;
db074436f42196 Darrick J. Wong   2019-07-15  197  
908c54909ae72d Christoph Hellwig 2022-05-05  198  	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
489734ef94f4f7 Eric Biggers      2022-01-28  199  	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
489734ef94f4f7 Eric Biggers      2022-01-28  200  				  GFP_KERNEL);
a6d3d49587d10d Christoph Hellwig 2021-08-10  201  	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
db074436f42196 Darrick J. Wong   2019-07-15  202  	bio->bi_private = dio;
db074436f42196 Darrick J. Wong   2019-07-15  203  	bio->bi_end_io = iomap_dio_bio_end_io;
db074436f42196 Darrick J. Wong   2019-07-15  204  
db074436f42196 Darrick J. Wong   2019-07-15  205  	get_page(page);
db074436f42196 Darrick J. Wong   2019-07-15  206  	__bio_add_page(bio, page, len, 0);
a6d3d49587d10d Christoph Hellwig 2021-08-10  207  	iomap_dio_submit_bio(iter, dio, bio, pos);
db074436f42196 Darrick J. Wong   2019-07-15  208  }
db074436f42196 Darrick J. Wong   2019-07-15  209  

:::::: The code at line 195 was first introduced by commit
:::::: db074436f421967f4f30cfbb6fbc2a728f3e62b3 iomap: move the direct IO code into a separate file

:::::: TO: Darrick J. Wong <darrick.wong@oracle.com>
:::::: CC: Darrick J. Wong <darrick.wong@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

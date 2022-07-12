Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2AA5721B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiGLRZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiGLRZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:25:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081FCBF565
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657646747; x=1689182747;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T6maC0lqsZWzeBJc6rVxdic9bCPQE1UdgmVmHOJsEEM=;
  b=ZBHct5OKFQOkzK9Op9j1lChwE+fujUwdheOTUMrMpyBipgC2CtkCZXfR
   Fh27/e6QgqnKNi6eFyl3tVBue4yuihVxy80j4miiHGoObNo3Blpms9Avq
   cxhKd8ClfvCKGpyuhcKCZe1kxZD+bILRkpcxyl49nlXSY0zJGkeWPy3fL
   98PKOOKBU9K+yLN9BPwaL3T6ud96UHxuLRgOhchgCrig9GfLpMUfgrGPY
   r6avcyu1K3Q/VdnQmaXmQwrfSyBXarTqUfDRAQVO6sB1PpYg48roKJZ1G
   PtXR7RDroOwInfPav87BpHz7juvNXA2WUM0y86w+eATzDpa26mRyBAC1p
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="346679747"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="346679747"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 10:25:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="545508105"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Jul 2022 10:25:28 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBJdX-0002Wv-DY;
        Tue, 12 Jul 2022 17:25:27 +0000
Date:   Wed, 13 Jul 2022 01:25:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bixuan Cui <cuibixuan@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/mtd/nand/onenand/onenand_base.c:779:34: sparse: sparse:
 incorrect type in argument 2 (different address spaces)
Message-ID: <202207130130.3Cd4bdQA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   72a8e05d4f66b5af7854df4490e3135168694b6b
commit: 9294523e3768030ae8afb84110bcecc66425a647 module: add printk formats to add module build ID to stacktraces
date:   1 year ago
config: csky-randconfig-s032-20220712 (https://download.01.org/0day-ci/archive/20220713/202207130130.3Cd4bdQA-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9294523e3768030ae8afb84110bcecc66425a647
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9294523e3768030ae8afb84110bcecc66425a647
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash drivers/mtd/nand/onenand/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/mtd/nand/onenand/onenand_base.c:779:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_base.c:779:34: sparse:     expected void const *from
   drivers/mtd/nand/onenand/onenand_base.c:779:34: sparse:     got void [noderef] __iomem *
   drivers/mtd/nand/onenand/onenand_base.c:817:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_base.c:817:34: sparse:     expected void const *from
   drivers/mtd/nand/onenand/onenand_base.c:817:34: sparse:     got void [noderef] __iomem *
>> drivers/mtd/nand/onenand/onenand_base.c:860:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_base.c:860:26: sparse:     expected void *to
   drivers/mtd/nand/onenand/onenand_base.c:860:26: sparse:     got void [noderef] __iomem *
   drivers/mtd/nand/onenand/onenand_base.c: note: in included file (through arch/csky/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:259:16: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:291:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:291:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:291:22: sparse:     got restricted __le16 [usertype]

vim +779 drivers/mtd/nand/onenand/onenand_base.c

cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  747  
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  748  /**
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  749   * onenand_read_bufferram - [OneNAND Interface] Read the bufferram area
720ae74ddf0aa409 drivers/mtd/nand/onenand/onenand_base.c Lee Jones     2020-11-09  750   * @mtd:		MTD data structure
720ae74ddf0aa409 drivers/mtd/nand/onenand/onenand_base.c Lee Jones     2020-11-09  751   * @area:		BufferRAM area
720ae74ddf0aa409 drivers/mtd/nand/onenand/onenand_base.c Lee Jones     2020-11-09  752   * @buffer:	the databuffer to put/get data
720ae74ddf0aa409 drivers/mtd/nand/onenand/onenand_base.c Lee Jones     2020-11-09  753   * @offset:	offset to read from or write to
720ae74ddf0aa409 drivers/mtd/nand/onenand/onenand_base.c Lee Jones     2020-11-09  754   * @count:		number of bytes to read/write
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  755   *
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  756   * Read the BufferRAM area
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  757   */
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  758  static int onenand_read_bufferram(struct mtd_info *mtd, int area,
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  759  		unsigned char *buffer, int offset, size_t count)
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  760  {
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  761  	struct onenand_chip *this = mtd->priv;
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  762  	void __iomem *bufferram;
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  763  
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  764  	bufferram = this->base + area;
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  765  
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  766  	bufferram += onenand_bufferram_offset(mtd, area);
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  767  
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  768  	if (ONENAND_CHECK_BYTE_ACCESS(count)) {
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  769  		unsigned short word;
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  770  
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  771  		/* Align with word(16-bit) size */
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  772  		count--;
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  773  
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  774  		/* Read word and save byte */
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  775  		word = this->read_word(bufferram + offset + count);
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  776  		buffer[count] = (word & 0xff);
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  777  	}
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  778  
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11 @779  	memcpy(buffer, bufferram + offset, count);
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  780  
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  781  	return 0;
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  782  }
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  783  
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  784  /**
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  785   * onenand_sync_read_bufferram - [OneNAND Interface] Read the bufferram area with Sync. Burst mode
720ae74ddf0aa409 drivers/mtd/nand/onenand/onenand_base.c Lee Jones     2020-11-09  786   * @mtd:		MTD data structure
720ae74ddf0aa409 drivers/mtd/nand/onenand/onenand_base.c Lee Jones     2020-11-09  787   * @area:		BufferRAM area
720ae74ddf0aa409 drivers/mtd/nand/onenand/onenand_base.c Lee Jones     2020-11-09  788   * @buffer:	the databuffer to put/get data
720ae74ddf0aa409 drivers/mtd/nand/onenand/onenand_base.c Lee Jones     2020-11-09  789   * @offset:	offset to read from or write to
720ae74ddf0aa409 drivers/mtd/nand/onenand/onenand_base.c Lee Jones     2020-11-09  790   * @count:		number of bytes to read/write
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  791   *
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  792   * Read the BufferRAM area with Sync. Burst Mode
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  793   */
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  794  static int onenand_sync_read_bufferram(struct mtd_info *mtd, int area,
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  795  		unsigned char *buffer, int offset, size_t count)
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  796  {
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  797  	struct onenand_chip *this = mtd->priv;
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  798  	void __iomem *bufferram;
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  799  
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  800  	bufferram = this->base + area;
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  801  
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  802  	bufferram += onenand_bufferram_offset(mtd, area);
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  803  
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  804  	this->mmcontrol(mtd, ONENAND_SYS_CFG1_SYNC_READ);
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  805  
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  806  	if (ONENAND_CHECK_BYTE_ACCESS(count)) {
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  807  		unsigned short word;
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  808  
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  809  		/* Align with word(16-bit) size */
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  810  		count--;
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  811  
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  812  		/* Read word and save byte */
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  813  		word = this->read_word(bufferram + offset + count);
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  814  		buffer[count] = (word & 0xff);
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  815  	}
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  816  
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  817  	memcpy(buffer, bufferram + offset, count);
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  818  
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  819  	this->mmcontrol(mtd, 0);
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  820  
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  821  	return 0;
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  822  }
52b0eea73de05df3 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-09-03  823  
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  824  /**
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  825   * onenand_write_bufferram - [OneNAND Interface] Write the bufferram area
720ae74ddf0aa409 drivers/mtd/nand/onenand/onenand_base.c Lee Jones     2020-11-09  826   * @mtd:		MTD data structure
720ae74ddf0aa409 drivers/mtd/nand/onenand/onenand_base.c Lee Jones     2020-11-09  827   * @area:		BufferRAM area
720ae74ddf0aa409 drivers/mtd/nand/onenand/onenand_base.c Lee Jones     2020-11-09  828   * @buffer:	the databuffer to put/get data
720ae74ddf0aa409 drivers/mtd/nand/onenand/onenand_base.c Lee Jones     2020-11-09  829   * @offset:	offset to read from or write to
720ae74ddf0aa409 drivers/mtd/nand/onenand/onenand_base.c Lee Jones     2020-11-09  830   * @count:		number of bytes to read/write
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  831   *
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  832   * Write the BufferRAM area
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  833   */
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  834  static int onenand_write_bufferram(struct mtd_info *mtd, int area,
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  835  		const unsigned char *buffer, int offset, size_t count)
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  836  {
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  837  	struct onenand_chip *this = mtd->priv;
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  838  	void __iomem *bufferram;
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  839  
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  840  	bufferram = this->base + area;
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  841  
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  842  	bufferram += onenand_bufferram_offset(mtd, area);
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  843  
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  844  	if (ONENAND_CHECK_BYTE_ACCESS(count)) {
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  845  		unsigned short word;
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  846  		int byte_offset;
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  847  
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  848  		/* Align with word(16-bit) size */
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  849  		count--;
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  850  
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  851  		/* Calculate byte access offset */
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  852  		byte_offset = offset + count;
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  853  
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  854  		/* Read word and save byte */
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  855  		word = this->read_word(bufferram + byte_offset);
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  856  		word = (word & ~0xff) | buffer[count];
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  857  		this->write_word(word, bufferram + byte_offset);
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  858  	}
9c01f87db183403a drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2006-05-12  859  
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11 @860  	memcpy(bufferram + offset, buffer, count);
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  861  
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  862  	return 0;
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  863  }
cd5f6346bc28a413 drivers/mtd/onenand/onenand_base.c      Kyungmin Park 2005-07-11  864  

:::::: The code at line 779 was first introduced by commit
:::::: cd5f6346bc28a41375412b49b290d22ee4e4bbe8 [MTD] Add initial support for OneNAND flash chips

:::::: TO: Kyungmin Park <kyungmin.park@samsung.com>
:::::: CC: Thomas Gleixner <tglx@mtd.linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

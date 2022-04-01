Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B114EE768
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 06:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244890AbiDAEjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 00:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiDAEjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 00:39:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38B825CBB4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 21:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648787837; x=1680323837;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h5i5fthEhUv3TerCM063y5oBoq9S1I6QZnJ7/7t94CA=;
  b=As07QLmTSt056P2ho2M2wj61AtbLEbjbDbQDt7rc979zJWseyTEgTYgQ
   PE3fkNV1yxnavpMlxICuG79WlbXJ7RJ71GlrJBFIKa3dpHOVbH8hNVNJQ
   BDZ4qHYjSPWoFb2j15ypK4XYzuRQMMQPWgzBge54WFQ4AAgdOYeto703+
   fYTQhWighLe7i9EXR4dmin8Z8Gxr2hcH5vqObsgMtlTjZFJjYSo20tH1S
   Fxu9OB/9E65fITYQxmhhDCZVe01KpXY8e0WBXg5njVl5SAWBX4oMEZf03
   OVtv1xUf+o1cu/ZGoZgUBGfJhmdtPbZHDLDgivg3M5oGsvghwzJKP3L1M
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="346480858"
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="346480858"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 21:37:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="547643455"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 31 Mar 2022 21:37:15 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1na92A-0000we-BJ;
        Fri, 01 Apr 2022 04:37:14 +0000
Date:   Fri, 1 Apr 2022 12:36:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [sbates130272-p2pmem:raid5_fixups 3/6]
 drivers/md/raid5-ppl.c:895:30: sparse: sparse: incorrect type in assignment
 (different address spaces)
Message-ID: <202204011224.U5aqrW6q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/sbates130272/linux-p2pmem.git raid5_fixups
head:   37cb73889e93d24459385229b6925da10648225d
commit: 93ecde7add0ce4b4464e98700e39da53458c2d46 [3/6] md/raid5: Add __rcu annotation to struct disk_info
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220401/202204011224.U5aqrW6q-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/sbates130272/linux-p2pmem/commit/93ecde7add0ce4b4464e98700e39da53458c2d46
        git remote add sbates130272-p2pmem https://github.com/sbates130272/linux-p2pmem.git
        git fetch --no-tags sbates130272-p2pmem raid5_fixups
        git checkout 93ecde7add0ce4b4464e98700e39da53458c2d46
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/md/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/md/raid5-ppl.c: note: in included file:
   drivers/md/raid5.h:271:14: sparse: sparse: array of flexible structures
>> drivers/md/raid5-ppl.c:895:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct md_rdev *rdev @@     got struct md_rdev [noderef] __rcu *rdev @@
   drivers/md/raid5-ppl.c:895:30: sparse:     expected struct md_rdev *rdev
   drivers/md/raid5-ppl.c:895:30: sparse:     got struct md_rdev [noderef] __rcu *rdev
>> drivers/md/raid5-ppl.c:946:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct md_rdev *parity_rdev @@     got struct md_rdev [noderef] __rcu *rdev @@
   drivers/md/raid5-ppl.c:946:29: sparse:     expected struct md_rdev *parity_rdev
   drivers/md/raid5-ppl.c:946:29: sparse:     got struct md_rdev [noderef] __rcu *rdev
>> drivers/md/raid5-ppl.c:1417:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct md_rdev *rdev @@     got struct md_rdev [noderef] __rcu *rdev @@
   drivers/md/raid5-ppl.c:1417:54: sparse:     expected struct md_rdev *rdev
   drivers/md/raid5-ppl.c:1417:54: sparse:     got struct md_rdev [noderef] __rcu *rdev

vim +895 drivers/md/raid5-ppl.c

4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  728  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  729  /*
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  730   * PPL recovery strategy: xor partial parity and data from all modified data
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  731   * disks within a stripe and write the result as the new stripe parity. If all
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  732   * stripe data disks are modified (full stripe write), no partial parity is
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  733   * available, so just xor the data disks.
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  734   *
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  735   * Recovery of a PPL entry shall occur only if all modified data disks are
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  736   * available and read from all of them succeeds.
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  737   *
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  738   * A PPL entry applies to a stripe, partial parity size for an entry is at most
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  739   * the size of the chunk. Examples of possible cases for a single entry:
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  740   *
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  741   * case 0: single data disk write:
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  742   *   data0    data1    data2     ppl        parity
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  743   * +--------+--------+--------+           +--------------------+
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  744   * | ------ | ------ | ------ | +----+    | (no change)        |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  745   * | ------ | -data- | ------ | | pp | -> | data1 ^ pp         |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  746   * | ------ | -data- | ------ | | pp | -> | data1 ^ pp         |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  747   * | ------ | ------ | ------ | +----+    | (no change)        |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  748   * +--------+--------+--------+           +--------------------+
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  749   * pp_size = data_size
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  750   *
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  751   * case 1: more than one data disk write:
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  752   *   data0    data1    data2     ppl        parity
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  753   * +--------+--------+--------+           +--------------------+
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  754   * | ------ | ------ | ------ | +----+    | (no change)        |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  755   * | -data- | -data- | ------ | | pp | -> | data0 ^ data1 ^ pp |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  756   * | -data- | -data- | ------ | | pp | -> | data0 ^ data1 ^ pp |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  757   * | ------ | ------ | ------ | +----+    | (no change)        |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  758   * +--------+--------+--------+           +--------------------+
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  759   * pp_size = data_size / modified_data_disks
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  760   *
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  761   * case 2: write to all data disks (also full stripe write):
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  762   *   data0    data1    data2                parity
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  763   * +--------+--------+--------+           +--------------------+
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  764   * | ------ | ------ | ------ |           | (no change)        |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  765   * | -data- | -data- | -data- | --------> | xor all data       |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  766   * | ------ | ------ | ------ | --------> | (no change)        |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  767   * | ------ | ------ | ------ |           | (no change)        |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  768   * +--------+--------+--------+           +--------------------+
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  769   * pp_size = 0
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  770   *
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  771   * The following cases are possible only in other implementations. The recovery
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  772   * code can handle them, but they are not generated at runtime because they can
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  773   * be reduced to cases 0, 1 and 2:
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  774   *
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  775   * case 3:
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  776   *   data0    data1    data2     ppl        parity
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  777   * +--------+--------+--------+ +----+    +--------------------+
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  778   * | ------ | -data- | -data- | | pp |    | data1 ^ data2 ^ pp |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  779   * | ------ | -data- | -data- | | pp | -> | data1 ^ data2 ^ pp |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  780   * | -data- | -data- | -data- | | -- | -> | xor all data       |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  781   * | -data- | -data- | ------ | | pp |    | data0 ^ data1 ^ pp |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  782   * +--------+--------+--------+ +----+    +--------------------+
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  783   * pp_size = chunk_size
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  784   *
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  785   * case 4:
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  786   *   data0    data1    data2     ppl        parity
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  787   * +--------+--------+--------+ +----+    +--------------------+
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  788   * | ------ | -data- | ------ | | pp |    | data1 ^ pp         |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  789   * | ------ | ------ | ------ | | -- | -> | (no change)        |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  790   * | ------ | ------ | ------ | | -- | -> | (no change)        |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  791   * | -data- | ------ | ------ | | pp |    | data0 ^ pp         |
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  792   * +--------+--------+--------+ +----+    +--------------------+
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  793   * pp_size = chunk_size
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  794   */
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  795  static int ppl_recover_entry(struct ppl_log *log, struct ppl_header_entry *e,
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  796  			     sector_t ppl_sector)
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  797  {
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  798  	struct ppl_conf *ppl_conf = log->ppl_conf;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  799  	struct mddev *mddev = ppl_conf->mddev;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  800  	struct r5conf *conf = mddev->private;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  801  	int block_size = ppl_conf->block_size;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  802  	struct page *page1;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  803  	struct page *page2;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  804  	sector_t r_sector_first;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  805  	sector_t r_sector_last;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  806  	int strip_sectors;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  807  	int data_disks;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  808  	int i;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  809  	int ret = 0;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  810  	char b[BDEVNAME_SIZE];
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  811  	unsigned int pp_size = le32_to_cpu(e->pp_size);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  812  	unsigned int data_size = le32_to_cpu(e->data_size);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  813  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  814  	page1 = alloc_page(GFP_KERNEL);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  815  	page2 = alloc_page(GFP_KERNEL);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  816  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  817  	if (!page1 || !page2) {
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  818  		ret = -ENOMEM;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  819  		goto out;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  820  	}
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  821  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  822  	r_sector_first = le64_to_cpu(e->data_sector) * (block_size >> 9);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  823  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  824  	if ((pp_size >> 9) < conf->chunk_sectors) {
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  825  		if (pp_size > 0) {
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  826  			data_disks = data_size / pp_size;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  827  			strip_sectors = pp_size >> 9;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  828  		} else {
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  829  			data_disks = conf->raid_disks - conf->max_degraded;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  830  			strip_sectors = (data_size >> 9) / data_disks;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  831  		}
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  832  		r_sector_last = r_sector_first +
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  833  				(data_disks - 1) * conf->chunk_sectors +
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  834  				strip_sectors;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  835  	} else {
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  836  		data_disks = conf->raid_disks - conf->max_degraded;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  837  		strip_sectors = conf->chunk_sectors;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  838  		r_sector_last = r_sector_first + (data_size >> 9);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  839  	}
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  840  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  841  	pr_debug("%s: array sector first: %llu last: %llu\n", __func__,
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  842  		 (unsigned long long)r_sector_first,
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  843  		 (unsigned long long)r_sector_last);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  844  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  845  	/* if start and end is 4k aligned, use a 4k block */
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  846  	if (block_size == 512 &&
c911c46c017c74 Yufen Yu          2020-07-18  847  	    (r_sector_first & (RAID5_STRIPE_SECTORS(conf) - 1)) == 0 &&
c911c46c017c74 Yufen Yu          2020-07-18  848  	    (r_sector_last & (RAID5_STRIPE_SECTORS(conf) - 1)) == 0)
c911c46c017c74 Yufen Yu          2020-07-18  849  		block_size = RAID5_STRIPE_SIZE(conf);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  850  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  851  	/* iterate through blocks in strip */
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  852  	for (i = 0; i < strip_sectors; i += (block_size >> 9)) {
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  853  		bool update_parity = false;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  854  		sector_t parity_sector;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  855  		struct md_rdev *parity_rdev;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  856  		struct stripe_head sh;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  857  		int disk;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  858  		int indent = 0;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  859  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  860  		pr_debug("%s:%*s iter %d start\n", __func__, indent, "", i);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  861  		indent += 2;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  862  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  863  		memset(page_address(page1), 0, PAGE_SIZE);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  864  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  865  		/* iterate through data member disks */
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  866  		for (disk = 0; disk < data_disks; disk++) {
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  867  			int dd_idx;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  868  			struct md_rdev *rdev;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  869  			sector_t sector;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  870  			sector_t r_sector = r_sector_first + i +
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  871  					    (disk * conf->chunk_sectors);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  872  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  873  			pr_debug("%s:%*s data member disk %d start\n",
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  874  				 __func__, indent, "", disk);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  875  			indent += 2;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  876  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  877  			if (r_sector >= r_sector_last) {
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  878  				pr_debug("%s:%*s array sector %llu doesn't need parity update\n",
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  879  					 __func__, indent, "",
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  880  					 (unsigned long long)r_sector);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  881  				indent -= 2;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  882  				continue;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  883  			}
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  884  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  885  			update_parity = true;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  886  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  887  			/* map raid sector to member disk */
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  888  			sector = raid5_compute_sector(conf, r_sector, 0,
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  889  						      &dd_idx, NULL);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  890  			pr_debug("%s:%*s processing array sector %llu => data member disk %d, sector %llu\n",
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  891  				 __func__, indent, "",
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  892  				 (unsigned long long)r_sector, dd_idx,
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  893  				 (unsigned long long)sector);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  894  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09 @895  			rdev = conf->disks[dd_idx].rdev;
07719ff767dcd8 Artur Paszkiewicz 2017-09-29  896  			if (!rdev || (!test_bit(In_sync, &rdev->flags) &&
07719ff767dcd8 Artur Paszkiewicz 2017-09-29  897  				      sector >= rdev->recovery_offset)) {
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  898  				pr_debug("%s:%*s data member disk %d missing\n",
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  899  					 __func__, indent, "", dd_idx);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  900  				update_parity = false;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  901  				break;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  902  			}
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  903  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  904  			pr_debug("%s:%*s reading data member disk %s sector %llu\n",
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  905  				 __func__, indent, "", bdevname(rdev->bdev, b),
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  906  				 (unsigned long long)sector);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  907  			if (!sync_page_io(rdev, sector, block_size, page2,
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  908  					REQ_OP_READ, 0, false)) {
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  909  				md_error(mddev, rdev);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  910  				pr_debug("%s:%*s read failed!\n", __func__,
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  911  					 indent, "");
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  912  				ret = -EIO;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  913  				goto out;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  914  			}
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  915  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  916  			ppl_xor(block_size, page1, page2);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  917  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  918  			indent -= 2;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  919  		}
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  920  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  921  		if (!update_parity)
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  922  			continue;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  923  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  924  		if (pp_size > 0) {
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  925  			pr_debug("%s:%*s reading pp disk sector %llu\n",
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  926  				 __func__, indent, "",
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  927  				 (unsigned long long)(ppl_sector + i));
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  928  			if (!sync_page_io(log->rdev,
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  929  					ppl_sector - log->rdev->data_offset + i,
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  930  					block_size, page2, REQ_OP_READ, 0,
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  931  					false)) {
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  932  				pr_debug("%s:%*s read failed!\n", __func__,
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  933  					 indent, "");
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  934  				md_error(mddev, log->rdev);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  935  				ret = -EIO;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  936  				goto out;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  937  			}
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  938  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  939  			ppl_xor(block_size, page1, page2);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  940  		}
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  941  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  942  		/* map raid sector to parity disk */
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  943  		parity_sector = raid5_compute_sector(conf, r_sector_first + i,
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  944  				0, &disk, &sh);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  945  		BUG_ON(sh.pd_idx != le32_to_cpu(e->parity_disk));
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09 @946  		parity_rdev = conf->disks[sh.pd_idx].rdev;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  947  
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  948  		BUG_ON(parity_rdev->bdev->bd_dev != log->rdev->bdev->bd_dev);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  949  		pr_debug("%s:%*s write parity at sector %llu, disk %s\n",
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  950  			 __func__, indent, "",
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  951  			 (unsigned long long)parity_sector,
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  952  			 bdevname(parity_rdev->bdev, b));
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  953  		if (!sync_page_io(parity_rdev, parity_sector, block_size,
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  954  				page1, REQ_OP_WRITE, 0, false)) {
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  955  			pr_debug("%s:%*s parity write error!\n", __func__,
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  956  				 indent, "");
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  957  			md_error(mddev, parity_rdev);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  958  			ret = -EIO;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  959  			goto out;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  960  		}
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  961  	}
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  962  out:
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  963  	if (page1)
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  964  		__free_page(page1);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  965  	if (page2)
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  966  		__free_page(page2);
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  967  	return ret;
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  968  }
4536bf9ba2d034 Artur Paszkiewicz 2017-03-09  969  

:::::: The code at line 895 was first introduced by commit
:::::: 4536bf9ba2d03404655586b07f8830b6f2106242 raid5-ppl: load and recover the log

:::::: TO: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
:::::: CC: Shaohua Li <shli@fb.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

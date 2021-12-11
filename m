Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817D247148C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 16:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhLKPmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 10:42:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:24648 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhLKPmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 10:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639237365; x=1670773365;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Wn7cXB5PYR5MH6yVRaYO33Q3Mg8NargGRs55smLpTbI=;
  b=RT6HgJOaermAfc6kPRXgZAN4AET+5s4kbzjJkNymwfQ8JCXpIqhu/zk4
   zyznk56M5aBkp4wSegmmNMMF/YhTZsqRWaS+YjdSfKU9Cu/jXSsfW6S3u
   8eGTU81Z9lepFemg8PJj3VXJ/EgtM4j712Q6wULcdrKcV8dboBvBXPzhH
   VrIDwIJIKjLLSkemWy7+KRm2gtwkATpjE8uO0nGGWHl1qLK71AQcv+Jz5
   +2Ug5r3kLSO46plmq53Yv6ONF5acw611zuowxxn6L0tnsUY+ywjzZNLCM
   4H1QE4xzm/BTKyLRVYHUUDaKyz2ojG8Tmvf/symD4BH1yjTsQOy4TkV9o
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="236060749"
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="236060749"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 07:42:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="517172786"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 11 Dec 2021 07:42:43 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mw4WI-0004iu-Qp; Sat, 11 Dec 2021 15:42:42 +0000
Date:   Sat, 11 Dec 2021 23:42:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [axboe-block:block-5.16 14/19] drivers/mtd/mtd_blkdevs.c:361:30:
 error: 'GENHD_FL_NO_PART' undeclared; did you mean 'GENHD_FL_NO_PART_SCAN'?
Message-ID: <202112112312.TqjBbfUS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git block-5.16
head:   5eff363838654790f67f4bd564c5782967f67bcc
commit: 776b54e97a7d993ba23696e032426d5dea5bbe70 [14/19] mtd_blkdevs: don't scan partitions for plain mtdblock
config: arm-pxa3xx_defconfig (https://download.01.org/0day-ci/archive/20211211/202112112312.TqjBbfUS-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=776b54e97a7d993ba23696e032426d5dea5bbe70
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block block-5.16
        git checkout 776b54e97a7d993ba23696e032426d5dea5bbe70
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the axboe-block/block-5.16 HEAD 5eff363838654790f67f4bd564c5782967f67bcc builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   drivers/mtd/mtd_blkdevs.c: In function 'add_mtd_blktrans_dev':
>> drivers/mtd/mtd_blkdevs.c:361:30: error: 'GENHD_FL_NO_PART' undeclared (first use in this function); did you mean 'GENHD_FL_NO_PART_SCAN'?
     361 |                 gd->flags |= GENHD_FL_NO_PART;
         |                              ^~~~~~~~~~~~~~~~
         |                              GENHD_FL_NO_PART_SCAN
   drivers/mtd/mtd_blkdevs.c:361:30: note: each undeclared identifier is reported only once for each function it appears in


vim +361 drivers/mtd/mtd_blkdevs.c

   274	
   275	int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
   276	{
   277		struct mtd_blktrans_ops *tr = new->tr;
   278		struct mtd_blktrans_dev *d;
   279		int last_devnum = -1;
   280		struct gendisk *gd;
   281		int ret;
   282	
   283		lockdep_assert_held(&mtd_table_mutex);
   284	
   285		list_for_each_entry(d, &tr->devs, list) {
   286			if (new->devnum == -1) {
   287				/* Use first free number */
   288				if (d->devnum != last_devnum+1) {
   289					/* Found a free devnum. Plug it in here */
   290					new->devnum = last_devnum+1;
   291					list_add_tail(&new->list, &d->list);
   292					goto added;
   293				}
   294			} else if (d->devnum == new->devnum) {
   295				/* Required number taken */
   296				return -EBUSY;
   297			} else if (d->devnum > new->devnum) {
   298				/* Required number was free */
   299				list_add_tail(&new->list, &d->list);
   300				goto added;
   301			}
   302			last_devnum = d->devnum;
   303		}
   304	
   305		ret = -EBUSY;
   306		if (new->devnum == -1)
   307			new->devnum = last_devnum+1;
   308	
   309		/* Check that the device and any partitions will get valid
   310		 * minor numbers and that the disk naming code below can cope
   311		 * with this number. */
   312		if (new->devnum > (MINORMASK >> tr->part_bits) ||
   313		    (tr->part_bits && new->devnum >= 27 * 26))
   314			return ret;
   315	
   316		list_add_tail(&new->list, &tr->devs);
   317	 added:
   318	
   319		mutex_init(&new->lock);
   320		kref_init(&new->ref);
   321		if (!tr->writesect)
   322			new->readonly = 1;
   323	
   324		ret = -ENOMEM;
   325		new->tag_set = kzalloc(sizeof(*new->tag_set), GFP_KERNEL);
   326		if (!new->tag_set)
   327			goto out_list_del;
   328	
   329		ret = blk_mq_alloc_sq_tag_set(new->tag_set, &mtd_mq_ops, 2,
   330				BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING);
   331		if (ret)
   332			goto out_kfree_tag_set;
   333	
   334		/* Create gendisk */
   335		gd = blk_mq_alloc_disk(new->tag_set, new);
   336		if (IS_ERR(gd)) {
   337			ret = PTR_ERR(gd);
   338			goto out_free_tag_set;
   339		}
   340	
   341		new->disk = gd;
   342		new->rq = new->disk->queue;
   343		gd->private_data = new;
   344		gd->major = tr->major;
   345		gd->first_minor = (new->devnum) << tr->part_bits;
   346		gd->minors = 1 << tr->part_bits;
   347		gd->fops = &mtd_block_ops;
   348	
   349		if (tr->part_bits) {
   350			if (new->devnum < 26)
   351				snprintf(gd->disk_name, sizeof(gd->disk_name),
   352					 "%s%c", tr->name, 'a' + new->devnum);
   353			else
   354				snprintf(gd->disk_name, sizeof(gd->disk_name),
   355					 "%s%c%c", tr->name,
   356					 'a' - 1 + new->devnum / 26,
   357					 'a' + new->devnum % 26);
   358		} else {
   359			snprintf(gd->disk_name, sizeof(gd->disk_name),
   360				 "%s%d", tr->name, new->devnum);
 > 361			gd->flags |= GENHD_FL_NO_PART;
   362		}
   363	
   364		set_capacity(gd, ((u64)new->size * tr->blksize) >> 9);
   365	
   366		/* Create the request queue */
   367		spin_lock_init(&new->queue_lock);
   368		INIT_LIST_HEAD(&new->rq_list);
   369	
   370		if (tr->flush)
   371			blk_queue_write_cache(new->rq, true, false);
   372	
   373		blk_queue_logical_block_size(new->rq, tr->blksize);
   374	
   375		blk_queue_flag_set(QUEUE_FLAG_NONROT, new->rq);
   376		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, new->rq);
   377	
   378		if (tr->discard) {
   379			blk_queue_flag_set(QUEUE_FLAG_DISCARD, new->rq);
   380			blk_queue_max_discard_sectors(new->rq, UINT_MAX);
   381			new->rq->limits.discard_granularity = tr->blksize;
   382		}
   383	
   384		gd->queue = new->rq;
   385	
   386		if (new->readonly)
   387			set_disk_ro(gd, 1);
   388	
   389		ret = device_add_disk(&new->mtd->dev, gd, NULL);
   390		if (ret)
   391			goto out_cleanup_disk;
   392	
   393		if (new->disk_attributes) {
   394			ret = sysfs_create_group(&disk_to_dev(gd)->kobj,
   395						new->disk_attributes);
   396			WARN_ON(ret);
   397		}
   398		return 0;
   399	
   400	out_cleanup_disk:
   401		blk_cleanup_disk(new->disk);
   402	out_free_tag_set:
   403		blk_mq_free_tag_set(new->tag_set);
   404	out_kfree_tag_set:
   405		kfree(new->tag_set);
   406	out_list_del:
   407		list_del(&new->list);
   408		return ret;
   409	}
   410	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

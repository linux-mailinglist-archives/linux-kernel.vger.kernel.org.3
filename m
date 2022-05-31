Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12213538DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245345AbiEaJlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiEaJlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:41:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D575915A5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653990070; x=1685526070;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=497fF9ScNrzw4WPV8vzdmkPId2YyA+YjS2achugjrCY=;
  b=oArXn7+H+fOvCS7uDN8o5FpP4p0hC0kaffx7SNrPh1N4IO1a6l5hUT57
   oFE93xa+sBcS3h+fovdpLGh0AisQo0PjUGVpsP1NQ5HlHLqHlScpFAJQd
   QtxX5zoQljkgX2hkiq9gBiIiOqQkUZNWdZvQL0igAyb6tPs1+JPSbJm6o
   epF1EYG95/EphhssA3EQsWNXcSkeXqoVmdGMD3CBjFw6gLVW9441fRKRe
   7ny1/772w9c9niFQ8nhX11sS5bwDfNZZXdVCqlOcGhuAXG7CY5dL38A6y
   St5t0dSXo+ceA7Y94Aw3J3Pt+ILKN/AOpEFndO2I0Fap9nQ3UEkldc5t2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="275207993"
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="275207993"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 02:41:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="605586009"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.169.215]) ([10.249.169.215])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 02:41:07 -0700
Subject: Re: [kbuild-all] Re: drivers/md/raid5-ppl.c:632:57: sparse: sparse:
 incorrect type in argument 3 (different base types)
To:     Logan Gunthorpe <logang@deltatee.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <202205280426.NVpnRyuP-lkp@intel.com>
 <9a6005e3-4840-ce3b-9586-99ff74ad9382@deltatee.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <b0eb0463-e32d-f159-d38e-f5e054593207@intel.com>
Date:   Tue, 31 May 2022 17:41:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <9a6005e3-4840-ce3b-9586-99ff74ad9382@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2022 5:18 AM, Logan Gunthorpe wrote:
> 
> 
> On 2022-05-27 14:46, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   7e284070abe53d448517b80493863595af4ab5f0
>> commit: b0920ede081b3f1659872f80ce552305610675a6 md/raid5: Add __rcu annotation to struct disk_info
>> date:   5 weeks ago
>> config: csky-randconfig-s032-20220524 (https://download.01.org/0day-ci/archive/20220528/202205280426.NVpnRyuP-lkp@intel.com/config)
>> compiler: csky-linux-gcc (GCC) 11.3.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # apt-get install sparse
>>          # sparse version: v0.6.4-14-g5a0004b5-dirty
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0920ede081b3f1659872f80ce552305610675a6
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout b0920ede081b3f1659872f80ce552305610675a6
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash drivers/md/
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> sparse warnings: (new ones prefixed by >>)
>>     drivers/md/raid5-ppl.c: note: in included file:
>>     drivers/md/raid5.h:271:14: sparse: sparse: array of flexible structures
>>>> drivers/md/raid5-ppl.c:632:57: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int opf @@     got restricted gfp_t [usertype] @@
>>     drivers/md/raid5-ppl.c:632:57: sparse:     expected unsigned int opf
>>     drivers/md/raid5-ppl.c:632:57: sparse:     got restricted gfp_t [usertype]
>>>> drivers/md/raid5-ppl.c:633:61: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted gfp_t [usertype] gfp_mask @@     got unsigned long long @@
>>     drivers/md/raid5-ppl.c:633:61: sparse:     expected restricted gfp_t [usertype] gfp_mask
>>     drivers/md/raid5-ppl.c:633:61: sparse:     got unsigned long long
>>     drivers/md/raid5-ppl.c:886:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct md_rdev *rdev @@     got struct md_rdev [noderef] __rcu *rdev @@
>>     drivers/md/raid5-ppl.c:886:30: sparse:     expected struct md_rdev *rdev
>>     drivers/md/raid5-ppl.c:886:30: sparse:     got struct md_rdev [noderef] __rcu *rdev
>>     drivers/md/raid5-ppl.c:937:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct md_rdev *parity_rdev @@     got struct md_rdev [noderef] __rcu *rdev @@
>>     drivers/md/raid5-ppl.c:937:29: sparse:     expected struct md_rdev *parity_rdev
>>     drivers/md/raid5-ppl.c:937:29: sparse:     got struct md_rdev [noderef] __rcu *rdev
>>     drivers/md/raid5-ppl.c:1407:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct md_rdev *rdev @@     got struct md_rdev [noderef] __rcu *rdev @@
>>     drivers/md/raid5-ppl.c:1407:54: sparse:     expected struct md_rdev *rdev
>>     drivers/md/raid5-ppl.c:1407:54: sparse:     got struct md_rdev [noderef] __rcu *rdev
>>
>> vim +632 drivers/md/raid5-ppl.c
>>
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  607
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  608  static void ppl_do_flush(struct ppl_io_unit *io)
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  609  {
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  610  	struct ppl_log *log = io->log;
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  611  	struct ppl_conf *ppl_conf = log->ppl_conf;
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  612  	struct r5conf *conf = ppl_conf->mddev->private;
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  613  	int raid_disks = conf->raid_disks;
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  614  	int flushed_disks = 0;
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  615  	int i;
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  616
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  617  	atomic_set(&io->pending_flushes, raid_disks);
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  618
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  619  	for_each_set_bit(i, &log->disk_flush_bitmap, raid_disks) {
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  620  		struct md_rdev *rdev;
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  621  		struct block_device *bdev = NULL;
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  622
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  623  		rcu_read_lock();
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  624  		rdev = rcu_dereference(conf->disks[i].rdev);
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  625  		if (rdev && !test_bit(Faulty, &rdev->flags))
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  626  			bdev = rdev->bdev;
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  627  		rcu_read_unlock();
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  628
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  629  		if (bdev) {
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  630  			struct bio *bio;
>> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  631
>> 609be1066731fe Christoph Hellwig 2022-01-24 @632  			bio = bio_alloc_bioset(bdev, 0, GFP_NOIO,
>> 609be1066731fe Christoph Hellwig 2022-01-24 @633  					       REQ_OP_WRITE | REQ_PREFLUSH,
>> 609be1066731fe Christoph Hellwig 2022-01-24  634  					       &ppl_conf->flush_bs);
> 
> Something is odd about this report. Seems like the new sparse errors
> were caused by this commit, not the one I sent that was noted at the top
> of this email.

Hi Logan,

The bot only compares the errors with the parent commit, so the errors
may not first introduced by the reported commit, for this case:

errors on parent commit (b0920ede08):
../drivers/md/raid5-ppl.c: note: in included file:
../drivers/md/raid5-ppl.c:624:24: sparse: error: incompatible types in 
comparison expression (different address spaces):
../drivers/md/raid5-ppl.c:624:24: sparse:    struct md_rdev [noderef] 
__rcu *
../drivers/md/raid5-ppl.c:624:24: sparse:    struct md_rdev

errors on this commit (3d9a644cf4):

../drivers/md/raid5-ppl.c: note: in included file:
../drivers/md/raid5-ppl.c:632:57: sparse: warning: incorrect type in 
argument 3 (different base types)
../drivers/md/raid5-ppl.c:632:57: sparse:    expected unsigned int opf
../drivers/md/raid5-ppl.c:632:57: sparse:    got restricted gfp_t [usertype]
../drivers/md/raid5-ppl.c:633:61: sparse: warning: incorrect type in 
argument 4 (different base types)
../drivers/md/raid5-ppl.c:633:61: sparse:    expected restricted gfp_t 
[usertype] gfp_mask
../drivers/md/raid5-ppl.c:633:61: sparse:    got unsigned long long
../drivers/md/raid5-ppl.c:886:30: sparse: warning: incorrect type in 
assignment (different address spaces)
../drivers/md/raid5-ppl.c:886:30: sparse:    expected struct md_rdev *rdev
../drivers/md/raid5-ppl.c:886:30: sparse:    got struct md_rdev 
[noderef] __rcu *rdev
../drivers/md/raid5-ppl.c:937:29: sparse: warning: incorrect type in 
assignment (different address spaces)
../drivers/md/raid5-ppl.c:937:29: sparse:    expected struct md_rdev 
*parity_rdev
../drivers/md/raid5-ppl.c:937:29: sparse:    got struct md_rdev 
[noderef] __rcu *rdev
../drivers/md/raid5-ppl.c:1407:54: sparse: warning: incorrect type in 
initializer (different address spaces)
../drivers/md/raid5-ppl.c:1407:54: sparse:    expected struct md_rdev *rdev
../drivers/md/raid5-ppl.c:1407:54: sparse:    got struct md_rdev 
[noderef] __rcu *rdev

Best Regards,
Rong Chen

> 
> Looks like the arguments in bio_alloc_bioset are incorrectly reversed in
> 609be10667 and this hasn't been fixed yet, at least not in Linus's tree.
> 
> The patch I sent (b0920ede081b3f) may have introduced some of the rdev
> sparse warnings in this report, but these were fixed up a couple commits
> later (4f4ee2bf3).
> 
> Logan
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 

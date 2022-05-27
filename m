Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B5453686A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 23:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354707AbiE0VSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 17:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiE0VSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 17:18:30 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1A6344DE
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=O99FaYOLB7MsXQa3iMzC2xEVsgEFVjWYWHz4InXbSvo=; b=HXKzvJ+xwea7+hgScoCr4n6RHT
        E/0MCos7qtPFRZqt9LGNlJCs78nBHSenfsHcRKoN7uPdSxusrFlVBauC6V5fjrODJjfP98kyr5H8z
        S4NNHv0wn517c4iIdSi8tvkSfI5Q5MaZe3YzPE8BsA280ZSau/lx7fumKOBiMeaSz12gu0wpX3BbV
        t1MJ5YJ8XsVbBEqH9LgFcbReSsL4xnkZ2wyq0LvhC3JphmI614tbkGjS2U+fvjCMH/0eN3DvWDkdI
        +YtoPGyXNqiqD3aBfmnO0m9d0l137fBBVeO1bmYzWGOnJKI3wlIci5p2auHOlAkRSmMU2oq+xa7+2
        HYpCptTQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nuhLj-0099V3-86; Fri, 27 May 2022 15:18:24 -0600
Message-ID: <9a6005e3-4840-ce3b-9586-99ff74ad9382@deltatee.com>
Date:   Fri, 27 May 2022 15:18:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-CA
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <202205280426.NVpnRyuP-lkp@intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <202205280426.NVpnRyuP-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: lkp@intel.com, kbuild-all@lists.01.org, linux-kernel@vger.kernel.org, song@kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: drivers/md/raid5-ppl.c:632:57: sparse: sparse: incorrect type in
 argument 3 (different base types)
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-05-27 14:46, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7e284070abe53d448517b80493863595af4ab5f0
> commit: b0920ede081b3f1659872f80ce552305610675a6 md/raid5: Add __rcu annotation to struct disk_info
> date:   5 weeks ago
> config: csky-randconfig-s032-20220524 (https://download.01.org/0day-ci/archive/20220528/202205280426.NVpnRyuP-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 11.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-14-g5a0004b5-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0920ede081b3f1659872f80ce552305610675a6
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout b0920ede081b3f1659872f80ce552305610675a6
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash drivers/md/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
>    drivers/md/raid5-ppl.c: note: in included file:
>    drivers/md/raid5.h:271:14: sparse: sparse: array of flexible structures
>>> drivers/md/raid5-ppl.c:632:57: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int opf @@     got restricted gfp_t [usertype] @@
>    drivers/md/raid5-ppl.c:632:57: sparse:     expected unsigned int opf
>    drivers/md/raid5-ppl.c:632:57: sparse:     got restricted gfp_t [usertype]
>>> drivers/md/raid5-ppl.c:633:61: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted gfp_t [usertype] gfp_mask @@     got unsigned long long @@
>    drivers/md/raid5-ppl.c:633:61: sparse:     expected restricted gfp_t [usertype] gfp_mask
>    drivers/md/raid5-ppl.c:633:61: sparse:     got unsigned long long
>    drivers/md/raid5-ppl.c:886:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct md_rdev *rdev @@     got struct md_rdev [noderef] __rcu *rdev @@
>    drivers/md/raid5-ppl.c:886:30: sparse:     expected struct md_rdev *rdev
>    drivers/md/raid5-ppl.c:886:30: sparse:     got struct md_rdev [noderef] __rcu *rdev
>    drivers/md/raid5-ppl.c:937:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct md_rdev *parity_rdev @@     got struct md_rdev [noderef] __rcu *rdev @@
>    drivers/md/raid5-ppl.c:937:29: sparse:     expected struct md_rdev *parity_rdev
>    drivers/md/raid5-ppl.c:937:29: sparse:     got struct md_rdev [noderef] __rcu *rdev
>    drivers/md/raid5-ppl.c:1407:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct md_rdev *rdev @@     got struct md_rdev [noderef] __rcu *rdev @@
>    drivers/md/raid5-ppl.c:1407:54: sparse:     expected struct md_rdev *rdev
>    drivers/md/raid5-ppl.c:1407:54: sparse:     got struct md_rdev [noderef] __rcu *rdev
> 
> vim +632 drivers/md/raid5-ppl.c
> 
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  607  
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  608  static void ppl_do_flush(struct ppl_io_unit *io)
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  609  {
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  610  	struct ppl_log *log = io->log;
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  611  	struct ppl_conf *ppl_conf = log->ppl_conf;
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  612  	struct r5conf *conf = ppl_conf->mddev->private;
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  613  	int raid_disks = conf->raid_disks;
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  614  	int flushed_disks = 0;
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  615  	int i;
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  616  
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  617  	atomic_set(&io->pending_flushes, raid_disks);
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  618  
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  619  	for_each_set_bit(i, &log->disk_flush_bitmap, raid_disks) {
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  620  		struct md_rdev *rdev;
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  621  		struct block_device *bdev = NULL;
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  622  
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  623  		rcu_read_lock();
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  624  		rdev = rcu_dereference(conf->disks[i].rdev);
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  625  		if (rdev && !test_bit(Faulty, &rdev->flags))
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  626  			bdev = rdev->bdev;
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  627  		rcu_read_unlock();
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  628  
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  629  		if (bdev) {
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  630  			struct bio *bio;
> 1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  631  
> 609be1066731fe Christoph Hellwig 2022-01-24 @632  			bio = bio_alloc_bioset(bdev, 0, GFP_NOIO,
> 609be1066731fe Christoph Hellwig 2022-01-24 @633  					       REQ_OP_WRITE | REQ_PREFLUSH,
> 609be1066731fe Christoph Hellwig 2022-01-24  634  					       &ppl_conf->flush_bs);

Something is odd about this report. Seems like the new sparse errors
were caused by this commit, not the one I sent that was noted at the top
of this email.

Looks like the arguments in bio_alloc_bioset are incorrectly reversed in
609be10667 and this hasn't been fixed yet, at least not in Linus's tree.

The patch I sent (b0920ede081b3f) may have introduced some of the rdev
sparse warnings in this report, but these were fixed up a couple commits
later (4f4ee2bf3).

Logan

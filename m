Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0798651DFAE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352146AbiEFTlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiEFTk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:40:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3238C6A02F
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 12:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651865833; x=1683401833;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Js0iUG43nwjT2l1ljlO/TyXtw5hOt8i2N7aVmr7caJg=;
  b=X8NwboTWCGw/VrUSG4TyBci6qYpqrk6Myc7840BX6p4bQ9FOvGuYSbKW
   rk0yDGoWB4QVafcTvpR7OMyfwxuI7f/ZViEEn7NAX9ja7ED18bpEMFRsL
   DqhLPaviiETmzyGvdVoCxYexdeg5py8iMpe4c/uquxBQOiYv9awgXzMLI
   3Hd/4IC01FfPytP18sLvjcWlFNglQjkAw/3kQnMFEbBtwkfQfHK4Cyabm
   godC01NXc4y2lZHbETOVVX+AM9hLDOyLR5m/XnZ/xa7QeqZMzjQDItfh6
   CWea8QyVJljwAHceezJTwFNZVQdJvIbojtDmpJbOGd6rVdWNqLyGeLkxi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="248463548"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="248463548"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 12:37:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="735899515"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 May 2022 12:37:10 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn3lF-000DoK-Mj;
        Fri, 06 May 2022 19:37:09 +0000
Date:   Sat, 7 May 2022 03:36:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-ufs-opp-cleanups-v2-drv-owner-wip 7/7]
 drivers/scsi/hosts.c:380: warning: expecting prototype for
 scsi_host_alloc(). Prototype was for __scsi_host_alloc() instead
Message-ID: <202205070353.HcyU3yYi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/qcom-ufs-opp-cleanups-v2-drv-owner-wip
head:   17609caecd53df20f631703ea084a70e7735b5d7
commit: 17609caecd53df20f631703ea084a70e7735b5d7 [7/7] WIP
config: m68k-hp300_defconfig (https://download.01.org/0day-ci/archive/20220507/202205070353.HcyU3yYi-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/krzk/linux/commit/17609caecd53df20f631703ea084a70e7735b5d7
        git remote add krzk-github https://github.com/krzk/linux
        git fetch --no-tags krzk-github n/qcom-ufs-opp-cleanups-v2-drv-owner-wip
        git checkout 17609caecd53df20f631703ea084a70e7735b5d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/scsi/hosts.c:380: warning: Function parameter or member 'owner' not described in '__scsi_host_alloc'
>> drivers/scsi/hosts.c:380: warning: expecting prototype for scsi_host_alloc(). Prototype was for __scsi_host_alloc() instead


vim +380 drivers/scsi/hosts.c

b0ed43360fdca22 Hannes Reinecke     2008-03-18  364  
^1da177e4c3f415 Linus Torvalds      2005-04-16  365  /**
^1da177e4c3f415 Linus Torvalds      2005-04-16  366   * scsi_host_alloc - register a scsi host adapter instance.
^1da177e4c3f415 Linus Torvalds      2005-04-16  367   * @sht:	pointer to scsi host template
^1da177e4c3f415 Linus Torvalds      2005-04-16  368   * @privsize:	extra bytes to allocate for driver
^1da177e4c3f415 Linus Torvalds      2005-04-16  369   *
^1da177e4c3f415 Linus Torvalds      2005-04-16  370   * Note:
^1da177e4c3f415 Linus Torvalds      2005-04-16  371   * 	Allocate a new Scsi_Host and perform basic initialization.
^1da177e4c3f415 Linus Torvalds      2005-04-16  372   * 	The host is not published to the scsi midlayer until scsi_add_host
^1da177e4c3f415 Linus Torvalds      2005-04-16  373   * 	is called.
^1da177e4c3f415 Linus Torvalds      2005-04-16  374   *
^1da177e4c3f415 Linus Torvalds      2005-04-16  375   * Return value:
^1da177e4c3f415 Linus Torvalds      2005-04-16  376   * 	Pointer to a new Scsi_Host
^1da177e4c3f415 Linus Torvalds      2005-04-16  377   **/
17609caecd53df2 Krzysztof Kozlowski 2022-05-06  378  struct Scsi_Host *__scsi_host_alloc(struct scsi_host_template *sht, int privsize,
17609caecd53df2 Krzysztof Kozlowski 2022-05-06  379  				    struct module *owner)
^1da177e4c3f415 Linus Torvalds      2005-04-16 @380  {
^1da177e4c3f415 Linus Torvalds      2005-04-16  381  	struct Scsi_Host *shost;
0a84486d6c1da1c Bart Van Assche     2021-11-16  382  	int index;
^1da177e4c3f415 Linus Torvalds      2005-04-16  383  
aaff5ebaa2694f2 Christoph Hellwig   2021-03-31  384  	shost = kzalloc(sizeof(struct Scsi_Host) + privsize, GFP_KERNEL);
^1da177e4c3f415 Linus Torvalds      2005-04-16  385  	if (!shost)
^1da177e4c3f415 Linus Torvalds      2005-04-16  386  		return NULL;
^1da177e4c3f415 Linus Torvalds      2005-04-16  387  
4f777ed26086452 Christoph Hellwig   2006-11-04  388  	shost->host_lock = &shost->default_lock;
4f777ed26086452 Christoph Hellwig   2006-11-04  389  	spin_lock_init(shost->host_lock);
d3301874083874f Mike Anderson       2005-06-16  390  	shost->shost_state = SHOST_CREATED;
^1da177e4c3f415 Linus Torvalds      2005-04-16  391  	INIT_LIST_HEAD(&shost->__devices);
^1da177e4c3f415 Linus Torvalds      2005-04-16  392  	INIT_LIST_HEAD(&shost->__targets);
5ae17501bc62a49 Ewan D. Milne       2021-10-29  393  	INIT_LIST_HEAD(&shost->eh_abort_list);
^1da177e4c3f415 Linus Torvalds      2005-04-16  394  	INIT_LIST_HEAD(&shost->eh_cmd_q);
^1da177e4c3f415 Linus Torvalds      2005-04-16  395  	INIT_LIST_HEAD(&shost->starved_list);
^1da177e4c3f415 Linus Torvalds      2005-04-16  396  	init_waitqueue_head(&shost->host_wait);
0b9506723826c68 Arjan van de Ven    2006-01-11  397  	mutex_init(&shost->scan_mutex);
^1da177e4c3f415 Linus Torvalds      2005-04-16  398  
126a4fe010fd86c Lee Duncan          2016-01-20  399  	index = ida_simple_get(&host_index_ida, 0, 0, GFP_KERNEL);
66a834d092930cf Ming Lei            2021-06-02  400  	if (index < 0) {
66a834d092930cf Ming Lei            2021-06-02  401  		kfree(shost);
66a834d092930cf Ming Lei            2021-06-02  402  		return NULL;
66a834d092930cf Ming Lei            2021-06-02  403  	}
126a4fe010fd86c Lee Duncan          2016-01-20  404  	shost->host_no = index;
126a4fe010fd86c Lee Duncan          2016-01-20  405  
^1da177e4c3f415 Linus Torvalds      2005-04-16  406  	shost->dma_channel = 0xff;
^1da177e4c3f415 Linus Torvalds      2005-04-16  407  
^1da177e4c3f415 Linus Torvalds      2005-04-16  408  	/* These three are default values which can be overridden */
^1da177e4c3f415 Linus Torvalds      2005-04-16  409  	shost->max_channel = 0;
^1da177e4c3f415 Linus Torvalds      2005-04-16  410  	shost->max_id = 8;
^1da177e4c3f415 Linus Torvalds      2005-04-16  411  	shost->max_lun = 8;
^1da177e4c3f415 Linus Torvalds      2005-04-16  412  
^1da177e4c3f415 Linus Torvalds      2005-04-16  413  	/* Give each shost a default transportt */
^1da177e4c3f415 Linus Torvalds      2005-04-16  414  	shost->transportt = &blank_transport_template;
^1da177e4c3f415 Linus Torvalds      2005-04-16  415  
^1da177e4c3f415 Linus Torvalds      2005-04-16  416  	/*
^1da177e4c3f415 Linus Torvalds      2005-04-16  417  	 * All drivers right now should be able to handle 12 byte
^1da177e4c3f415 Linus Torvalds      2005-04-16  418  	 * commands.  Every so often there are requests for 16 byte
^1da177e4c3f415 Linus Torvalds      2005-04-16  419  	 * commands, but individual low-level drivers need to certify that
^1da177e4c3f415 Linus Torvalds      2005-04-16  420  	 * they actually do something sensible with such commands.
^1da177e4c3f415 Linus Torvalds      2005-04-16  421  	 */
^1da177e4c3f415 Linus Torvalds      2005-04-16  422  	shost->max_cmd_len = 12;
17609caecd53df2 Krzysztof Kozlowski 2022-05-06  423  	shost->owner = owner;
^1da177e4c3f415 Linus Torvalds      2005-04-16  424  	shost->hostt = sht;
^1da177e4c3f415 Linus Torvalds      2005-04-16  425  	shost->this_id = sht->this_id;
^1da177e4c3f415 Linus Torvalds      2005-04-16  426  	shost->can_queue = sht->can_queue;
^1da177e4c3f415 Linus Torvalds      2005-04-16  427  	shost->sg_tablesize = sht->sg_tablesize;
13f05c8d8e98bbd Martin K. Petersen  2010-09-10  428  	shost->sg_prot_tablesize = sht->sg_prot_tablesize;
^1da177e4c3f415 Linus Torvalds      2005-04-16  429  	shost->cmd_per_lun = sht->cmd_per_lun;
54b2b50c20a61b5 Martin K. Petersen  2013-10-23  430  	shost->no_write_same = sht->no_write_same;
bdb01301f3ea51a Hannes Reinecke     2020-08-19  431  	shost->host_tagset = sht->host_tagset;
^1da177e4c3f415 Linus Torvalds      2005-04-16  432  
ad469a57643b322 Hannes Reinecke     2014-01-17  433  	if (shost_eh_deadline == -1 || !sht->eh_host_reset_handler)
bb3b621a33d60fc Ren Mingxin         2013-11-11  434  		shost->eh_deadline = -1;
bb3b621a33d60fc Ren Mingxin         2013-11-11  435  	else if ((ulong) shost_eh_deadline * HZ > INT_MAX) {
bb3b621a33d60fc Ren Mingxin         2013-11-11  436  		shost_printk(KERN_WARNING, shost,
bb3b621a33d60fc Ren Mingxin         2013-11-11  437  			     "eh_deadline %u too large, setting to %u\n",
bb3b621a33d60fc Ren Mingxin         2013-11-11  438  			     shost_eh_deadline, INT_MAX / HZ);
bb3b621a33d60fc Ren Mingxin         2013-11-11  439  		shost->eh_deadline = INT_MAX;
bb3b621a33d60fc Ren Mingxin         2013-11-11  440  	} else
bb3b621a33d60fc Ren Mingxin         2013-11-11  441  		shost->eh_deadline = shost_eh_deadline * HZ;
bb3b621a33d60fc Ren Mingxin         2013-11-11  442  
7a39ac3f25bef01 James Bottomley     2007-09-25  443  	if (sht->supported_mode == MODE_UNKNOWN)
7a39ac3f25bef01 James Bottomley     2007-09-25  444  		/* means we didn't set it ... default to INITIATOR */
7a39ac3f25bef01 James Bottomley     2007-09-25  445  		shost->active_mode = MODE_INITIATOR;
7a39ac3f25bef01 James Bottomley     2007-09-25  446  	else
7a39ac3f25bef01 James Bottomley     2007-09-25  447  		shost->active_mode = sht->supported_mode;
7a39ac3f25bef01 James Bottomley     2007-09-25  448  
^1da177e4c3f415 Linus Torvalds      2005-04-16  449  	if (sht->max_host_blocked)
^1da177e4c3f415 Linus Torvalds      2005-04-16  450  		shost->max_host_blocked = sht->max_host_blocked;
^1da177e4c3f415 Linus Torvalds      2005-04-16  451  	else
^1da177e4c3f415 Linus Torvalds      2005-04-16  452  		shost->max_host_blocked = SCSI_DEFAULT_HOST_BLOCKED;
^1da177e4c3f415 Linus Torvalds      2005-04-16  453  
^1da177e4c3f415 Linus Torvalds      2005-04-16  454  	/*
^1da177e4c3f415 Linus Torvalds      2005-04-16  455  	 * If the driver imposes no hard sector transfer limit, start at
^1da177e4c3f415 Linus Torvalds      2005-04-16  456  	 * machine infinity initially.
^1da177e4c3f415 Linus Torvalds      2005-04-16  457  	 */
^1da177e4c3f415 Linus Torvalds      2005-04-16  458  	if (sht->max_sectors)
^1da177e4c3f415 Linus Torvalds      2005-04-16  459  		shost->max_sectors = sht->max_sectors;
^1da177e4c3f415 Linus Torvalds      2005-04-16  460  	else
^1da177e4c3f415 Linus Torvalds      2005-04-16  461  		shost->max_sectors = SCSI_DEFAULT_MAX_SECTORS;
^1da177e4c3f415 Linus Torvalds      2005-04-16  462  
50c2e9107f176a8 Christoph Hellwig   2018-12-13  463  	if (sht->max_segment_size)
50c2e9107f176a8 Christoph Hellwig   2018-12-13  464  		shost->max_segment_size = sht->max_segment_size;
50c2e9107f176a8 Christoph Hellwig   2018-12-13  465  	else
50c2e9107f176a8 Christoph Hellwig   2018-12-13  466  		shost->max_segment_size = BLK_MAX_SEGMENT_SIZE;
50c2e9107f176a8 Christoph Hellwig   2018-12-13  467  
^1da177e4c3f415 Linus Torvalds      2005-04-16  468  	/*
^1da177e4c3f415 Linus Torvalds      2005-04-16  469  	 * assume a 4GB boundary, if not set
^1da177e4c3f415 Linus Torvalds      2005-04-16  470  	 */
^1da177e4c3f415 Linus Torvalds      2005-04-16  471  	if (sht->dma_boundary)
^1da177e4c3f415 Linus Torvalds      2005-04-16  472  		shost->dma_boundary = sht->dma_boundary;
^1da177e4c3f415 Linus Torvalds      2005-04-16  473  	else
^1da177e4c3f415 Linus Torvalds      2005-04-16  474  		shost->dma_boundary = 0xffffffff;
^1da177e4c3f415 Linus Torvalds      2005-04-16  475  
7ad388d8e4c7039 Christoph Hellwig   2019-06-17  476  	if (sht->virt_boundary_mask)
7ad388d8e4c7039 Christoph Hellwig   2019-06-17  477  		shost->virt_boundary_mask = sht->virt_boundary_mask;
7ad388d8e4c7039 Christoph Hellwig   2019-06-17  478  
^1da177e4c3f415 Linus Torvalds      2005-04-16  479  	device_initialize(&shost->shost_gendev);
71610f55fa4db63 Kay Sievers         2008-12-03  480  	dev_set_name(&shost->shost_gendev, "host%d", shost->host_no);
b0ed43360fdca22 Hannes Reinecke     2008-03-18  481  	shost->shost_gendev.bus = &scsi_bus_type;
b0ed43360fdca22 Hannes Reinecke     2008-03-18  482  	shost->shost_gendev.type = &scsi_host_type;
a19a93e4c6a98c9 Bart Van Assche     2021-10-06  483  	scsi_enable_async_suspend(&shost->shost_gendev);
^1da177e4c3f415 Linus Torvalds      2005-04-16  484  
ee959b00c335d77 Tony Jones          2008-02-22  485  	device_initialize(&shost->shost_dev);
ee959b00c335d77 Tony Jones          2008-02-22  486  	shost->shost_dev.parent = &shost->shost_gendev;
ee959b00c335d77 Tony Jones          2008-02-22  487  	shost->shost_dev.class = &shost_class;
71610f55fa4db63 Kay Sievers         2008-12-03  488  	dev_set_name(&shost->shost_dev, "host%d", shost->host_no);
0a84486d6c1da1c Bart Van Assche     2021-11-16  489  	shost->shost_dev.groups = sht->shost_groups;
^1da177e4c3f415 Linus Torvalds      2005-04-16  490  
c5478def7a3a2db Christoph Hellwig   2005-09-06  491  	shost->ehandler = kthread_run(scsi_error_handler, shost,
c5478def7a3a2db Christoph Hellwig   2005-09-06  492  			"scsi_eh_%d", shost->host_no);
c5478def7a3a2db Christoph Hellwig   2005-09-06  493  	if (IS_ERR(shost->ehandler)) {
91921e016a2199e Hannes Reinecke     2014-06-25  494  		shost_printk(KERN_WARNING, shost,
91921e016a2199e Hannes Reinecke     2014-06-25  495  			"error handler thread failed to spawn, error = %ld\n",
91921e016a2199e Hannes Reinecke     2014-06-25  496  			PTR_ERR(shost->ehandler));
93aa71ad7379900 Tyrel Datwyler      2021-07-01  497  		shost->ehandler = NULL;
66a834d092930cf Ming Lei            2021-06-02  498  		goto fail;
c5478def7a3a2db Christoph Hellwig   2005-09-06  499  	}
^1da177e4c3f415 Linus Torvalds      2005-04-16  500  
e494f6a728394ab Hannes Reinecke     2013-11-11  501  	shost->tmf_work_q = alloc_workqueue("scsi_tmf_%d",
6292130093c5d10 Bob Liu             2020-07-01  502  					WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS,
e494f6a728394ab Hannes Reinecke     2013-11-11  503  					   1, shost->host_no);
e494f6a728394ab Hannes Reinecke     2013-11-11  504  	if (!shost->tmf_work_q) {
a222b1e2fe4299a Hannes Reinecke     2014-10-24  505  		shost_printk(KERN_WARNING, shost,
a222b1e2fe4299a Hannes Reinecke     2014-10-24  506  			     "failed to create tmf workq\n");
66a834d092930cf Ming Lei            2021-06-02  507  		goto fail;
e494f6a728394ab Hannes Reinecke     2013-11-11  508  	}
^1da177e4c3f415 Linus Torvalds      2005-04-16  509  	scsi_proc_hostdir_add(shost->hostt);
^1da177e4c3f415 Linus Torvalds      2005-04-16  510  	return shost;
66a834d092930cf Ming Lei            2021-06-02  511   fail:
66a834d092930cf Ming Lei            2021-06-02  512  	/*
66a834d092930cf Ming Lei            2021-06-02  513  	 * Host state is still SHOST_CREATED and that is enough to release
66a834d092930cf Ming Lei            2021-06-02  514  	 * ->shost_gendev. scsi_host_dev_release() will free
66a834d092930cf Ming Lei            2021-06-02  515  	 * dev_name(&shost->shost_dev).
66a834d092930cf Ming Lei            2021-06-02  516  	 */
66a834d092930cf Ming Lei            2021-06-02  517  	put_device(&shost->shost_gendev);
^1da177e4c3f415 Linus Torvalds      2005-04-16  518  
^1da177e4c3f415 Linus Torvalds      2005-04-16  519  	return NULL;
^1da177e4c3f415 Linus Torvalds      2005-04-16  520  }
17609caecd53df2 Krzysztof Kozlowski 2022-05-06  521  EXPORT_SYMBOL(__scsi_host_alloc);
^1da177e4c3f415 Linus Torvalds      2005-04-16  522  

:::::: The code at line 380 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

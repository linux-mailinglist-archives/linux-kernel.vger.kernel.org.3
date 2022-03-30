Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD384ECA68
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348238AbiC3RRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241641AbiC3RRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:17:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9072D2FE7A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648660524; x=1680196524;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LOllQDeH3/BqjzN7xPXL9ZdN1+34m8QFdYvpxzw/BXM=;
  b=QFUa0crEkZggiLbXovCzDc9EIb6iG7RNQvn1hwsRIVo36zc1edcn0FBU
   gRmdHj5GwB7I8QnUSZDKZYtyTDgvrDL1882GhSfy4mY36ACjgNv1plmdE
   6USSwzLC/1b88vgF8iq1r8Eo1M/ceZfvdzWXf4S8lKP10bO39+tcvtOni
   y+PIN/EY0kYL9O4raCtG+wNWGUqxrzcQnskHqD5s7Ggrldh6HFu6KMUu6
   jnCH74GjSsr0C5LF4qCFn9Ym3lrICqdi8wIWz8N8rrg1cSMZ2lD16q3E0
   cJoiElGOmcPhLmRIeiZPI01MEUP6kGc5PUZpxc1GsVjaYWQseqxcOiyKs
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259782233"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="259782233"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 10:15:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="788080026"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2022 10:15:22 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZbuk-0000E3-78;
        Wed, 30 Mar 2022 17:15:22 +0000
Date:   Thu, 31 Mar 2022 01:14:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Garry <john.garry@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: drivers/scsi/hisi_sas/hisi_sas_main.c:445 hisi_sas_task_deliver()
 warn: inconsistent indenting
Message-ID: <202203310159.dWb4ZUaK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d888c83fcec75194a8a48ccd283953bdba7b2550
commit: 095478a6e5bf590f2bbf341569eb25173c9c5f32 scsi: hisi_sas: Use libsas internal abort support
date:   2 weeks ago
config: powerpc64-randconfig-m031-20220330 (https://download.01.org/0day-ci/archive/20220331/202203310159.dWb4ZUaK-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/scsi/hisi_sas/hisi_sas_main.c:445 hisi_sas_task_deliver() warn: inconsistent indenting

vim +445 drivers/scsi/hisi_sas/hisi_sas_main.c

b3cce125cb1e2e Xiang Chen  2019-02-06  393  
dc313f6b125b09 John Garry  2021-12-15  394  static
dc313f6b125b09 John Garry  2021-12-15  395  void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
dc313f6b125b09 John Garry  2021-12-15  396  			   struct hisi_sas_slot *slot,
dc313f6b125b09 John Garry  2021-12-15  397  			   struct hisi_sas_dq *dq,
095478a6e5bf59 John Garry  2022-03-11  398  			   struct hisi_sas_device *sas_dev)
42e7a69368a585 John Garry  2015-11-18  399  {
42e7a69368a585 John Garry  2015-11-18  400  	struct hisi_sas_cmd_hdr *cmd_hdr_base;
dc313f6b125b09 John Garry  2021-12-15  401  	int dlvry_queue_slot, dlvry_queue;
dc313f6b125b09 John Garry  2021-12-15  402  	struct sas_task *task = slot->task;
fa222db0b03689 Xiang Chen  2018-05-09  403  	int wr_q_index;
42e7a69368a585 John Garry  2015-11-18  404  
e9dc5e11c97ee9 Xiang Chen  2020-01-20  405  	spin_lock(&dq->lock);
897cc769bcc092 John Garry  2019-08-05  406  	wr_q_index = dq->wr_point;
897cc769bcc092 John Garry  2019-08-05  407  	dq->wr_point = (dq->wr_point + 1) % HISI_SAS_QUEUE_SLOTS;
fa222db0b03689 Xiang Chen  2018-05-09  408  	list_add_tail(&slot->delivery, &dq->list);
e9dc5e11c97ee9 Xiang Chen  2020-01-20  409  	spin_unlock(&dq->lock);
e9dc5e11c97ee9 Xiang Chen  2020-01-20  410  	spin_lock(&sas_dev->lock);
4fefe5bbf599d6 Xiang Chen  2019-02-06  411  	list_add_tail(&slot->entry, &sas_dev->list);
e9dc5e11c97ee9 Xiang Chen  2020-01-20  412  	spin_unlock(&sas_dev->lock);
42e7a69368a585 John Garry  2015-11-18  413  
b1a49412f0aed7 Xiang Chen  2017-06-14  414  	dlvry_queue = dq->id;
fa222db0b03689 Xiang Chen  2018-05-09  415  	dlvry_queue_slot = wr_q_index;
42e7a69368a585 John Garry  2015-11-18  416  
4fefe5bbf599d6 Xiang Chen  2019-02-06  417  	slot->device_id = sas_dev->device_id;
42e7a69368a585 John Garry  2015-11-18  418  	slot->dlvry_queue = dlvry_queue;
42e7a69368a585 John Garry  2015-11-18  419  	slot->dlvry_queue_slot = dlvry_queue_slot;
42e7a69368a585 John Garry  2015-11-18  420  	cmd_hdr_base = hisi_hba->cmd_hdr[dlvry_queue];
42e7a69368a585 John Garry  2015-11-18  421  	slot->cmd_hdr = &cmd_hdr_base[dlvry_queue_slot];
dc313f6b125b09 John Garry  2021-12-15  422  
42e7a69368a585 John Garry  2015-11-18  423  	task->lldd_task = slot;
42e7a69368a585 John Garry  2015-11-18  424  
42e7a69368a585 John Garry  2015-11-18  425  	memset(slot->cmd_hdr, 0, sizeof(struct hisi_sas_cmd_hdr));
f557e32c0023ea Xiaofei Tan 2017-06-29  426  	memset(hisi_sas_cmd_hdr_addr_mem(slot), 0, HISI_SAS_COMMAND_TABLE_SZ);
d380f55503ed28 Xiang Chen  2019-08-05  427  	memset(hisi_sas_status_buf_addr_mem(slot), 0,
d380f55503ed28 Xiang Chen  2019-08-05  428  	       sizeof(struct hisi_sas_err_record));
42e7a69368a585 John Garry  2015-11-18  429  
42e7a69368a585 John Garry  2015-11-18  430  	switch (task->task_proto) {
66ee999b4e43e1 John Garry  2015-11-18  431  	case SAS_PROTOCOL_SMP:
a2b3820bddfbff Xiang Chen  2018-05-09  432  		hisi_sas_task_prep_smp(hisi_hba, slot);
66ee999b4e43e1 John Garry  2015-11-18  433  		break;
42e7a69368a585 John Garry  2015-11-18  434  	case SAS_PROTOCOL_SSP:
78bd2b4f6e7c05 Xiaofei Tan 2018-05-21  435  		hisi_sas_task_prep_ssp(hisi_hba, slot);
42e7a69368a585 John Garry  2015-11-18  436  		break;
42e7a69368a585 John Garry  2015-11-18  437  	case SAS_PROTOCOL_SATA:
42e7a69368a585 John Garry  2015-11-18  438  	case SAS_PROTOCOL_STP:
095478a6e5bf59 John Garry  2022-03-11  439  	case SAS_PROTOCOL_STP_ALL:
a2b3820bddfbff Xiang Chen  2018-05-09  440  		hisi_sas_task_prep_ata(hisi_hba, slot);
6f2ff1a1311e61 John Garry  2016-01-26  441  		break;
095478a6e5bf59 John Garry  2022-03-11  442  	case SAS_PROTOCOL_INTERNAL_ABORT:
095478a6e5bf59 John Garry  2022-03-11  443  		hisi_sas_task_prep_abort(hisi_hba, slot);
dc313f6b125b09 John Garry  2021-12-15  444  		break;
dc313f6b125b09 John Garry  2021-12-15 @445  	fallthrough;
42e7a69368a585 John Garry  2015-11-18  446  	default:
095478a6e5bf59 John Garry  2022-03-11  447  		return;
42e7a69368a585 John Garry  2015-11-18  448  	}
42e7a69368a585 John Garry  2015-11-18  449  
1c09b663168bb5 Xiaofei Tan 2018-07-18  450  	WRITE_ONCE(slot->ready, 1);
42e7a69368a585 John Garry  2015-11-18  451  
0e4620856b8933 John Garry  2021-12-15  452  	spin_lock(&dq->lock);
0e4620856b8933 John Garry  2021-12-15  453  	hisi_hba->hw->start_delivery(dq);
0e4620856b8933 John Garry  2021-12-15  454  	spin_unlock(&dq->lock);
42e7a69368a585 John Garry  2015-11-18  455  }
42e7a69368a585 John Garry  2015-11-18  456  

:::::: The code at line 445 was first introduced by commit
:::::: dc313f6b125b095d3d2683d94d5f69c8dc9bdc36 scsi: hisi_sas: Factor out task prep and delivery code

:::::: TO: John Garry <john.garry@huawei.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

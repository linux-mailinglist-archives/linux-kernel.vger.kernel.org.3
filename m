Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD14EC260
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344550AbiC3L7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344583AbiC3LxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:53:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CF6264811
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:49:11 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KT4Rq6Qgxz6802Q;
        Wed, 30 Mar 2022 19:47:35 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 30 Mar 2022 13:49:02 +0200
Received: from [10.47.83.59] (10.47.83.59) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 30 Mar
 2022 12:49:02 +0100
Message-ID: <fab277a2-3460-17d2-15ab-e12dea2d5b74@huawei.com>
Date:   Wed, 30 Mar 2022 12:49:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: drivers/scsi/hisi_sas/hisi_sas_main.c:445 hisi_sas_task_deliver()
 warn: inconsistent indenting
To:     kernel test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <202203301533.b4Hty4C7-lkp@intel.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <202203301533.b4Hty4C7-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.59]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2022 08:23, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1c24a186398f59c80adb9a967486b65c1423a59d
> commit: 095478a6e5bf590f2bbf341569eb25173c9c5f32 scsi: hisi_sas: Use libsas internal abort support
> date:   2 weeks ago
> config: powerpc64-randconfig-m031-20220330 (https://download.01.org/0day-ci/archive/20220330/202203301533.b4Hty4C7-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 11.2.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> smatch warnings:
> drivers/scsi/hisi_sas/hisi_sas_main.c:445 hisi_sas_task_deliver() warn: inconsistent indenting
> 
> vim +445 drivers/scsi/hisi_sas/hisi_sas_main.c
> 

...

> 42e7a69368a585 John Garry  2015-11-18  437  	case SAS_PROTOCOL_SATA:
> 42e7a69368a585 John Garry  2015-11-18  438  	case SAS_PROTOCOL_STP:
> 095478a6e5bf59 John Garry  2022-03-11  439  	case SAS_PROTOCOL_STP_ALL:
> a2b3820bddfbff Xiang Chen  2018-05-09  440  		hisi_sas_task_prep_ata(hisi_hba, slot);
> 6f2ff1a1311e61 John Garry  2016-01-26  441  		break;
> 095478a6e5bf59 John Garry  2022-03-11  442  	case SAS_PROTOCOL_INTERNAL_ABORT:
> 095478a6e5bf59 John Garry  2022-03-11  443  		hisi_sas_task_prep_abort(hisi_hba, slot);
> dc313f6b125b09 John Garry  2021-12-15  444  		break;
> dc313f6b125b09 John Garry  2021-12-15 @445  	fallthrough;

This is already queued for removal.

> 42e7a69368a585 John Garry  2015-11-18  446  	default:
> 095478a6e5bf59 John Garry  2022-03-11  447  		return;
> 42e7a69368a585 John Garry  2015-11-18  448  	}
> 42e7a69368a585 John Garry  2015-11-18  449
> 1c09b663168bb5 Xiaofei Tan 2018-07-18  450  	WRITE_ONCE(slot->ready, 1);
> 42e7a69368a585 John Garry  2015-11-18  451
> 0e4620856b8933 John Garry  2021-12-15  452  	spin_lock(&dq->lock);
> 0e4620856b8933 John Garry  2021-12-15  453  	hisi_hba->hw->start_delivery(dq);
> 0e4620856b8933 John Garry  2021-12-15  454  	spin_unlock(&dq->lock);
> 42e7a69368a585 John Garry  2015-11-18  455  }
> 42e7a69368a585 John Garry  2015-11-18  456
> 
> :::::: The code at line 445 was first introduced by commit
> :::::: dc313f6b125b095d3d2683d94d5f69c8dc9bdc36 scsi: hisi_sas: Factor out task prep and delivery code
> 
> :::::: TO: John Garry <john.garry@huawei.com>
> :::::: CC: Martin K. Petersen <martin.petersen@oracle.com>
> 


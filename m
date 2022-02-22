Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E037F4BF769
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiBVLn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiBVLnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:43:25 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFD513775B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:43:00 -0800 (PST)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2y2G5hLkz6H7Mh;
        Tue, 22 Feb 2022 19:42:14 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 12:42:58 +0100
Received: from [10.47.92.123] (10.47.92.123) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Feb
 2022 11:42:57 +0000
Message-ID: <4caa1642-79d6-fcf9-f81e-83feb654afbf@huawei.com>
Date:   Tue, 22 Feb 2022 11:42:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [mkp-scsi:for-next 93/154] hisi_sas_main.c:undefined reference to
 `sas_execute_ata_cmd'
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        kernel test robot <lkp@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        "Christoph Hellwig" <hch@lst.de>
References: <202202221427.OvZeGfzt-lkp@intel.com>
 <59b538b7-b4c5-8111-d2bf-7fb353ecb19b@huawei.com>
 <276308f0-e45e-243a-0058-96c3cf6558f5@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <276308f0-e45e-243a-0058-96c3cf6558f5@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.123]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2022 11:28, Damien Le Moal wrote:
>> I'm not sure where that leaves Damien's series.. it just seems easier to
>> try to take mine again first as Damien's would need to be rebased again
>> (if not based on mine).
> May be just send an incremental patch on top of yours+my series ? But I
> doubt there will be a conflict anyway.
> 

It's actually just the last patch in my series which is the problem, so 
that could make things easier. I have the v3 series ready with the fix 
(apart from more randconfig builds) so I can just send that. Or, if 
Martin, wants an incremental fix, I can send that also.

Thanks,
John

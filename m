Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1234F5CEA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiDFLzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiDFLyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:54:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2FC2DBFE7;
        Wed,  6 Apr 2022 00:16:42 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KYG2L3gttz67tDy;
        Wed,  6 Apr 2022 15:13:30 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 09:16:27 +0200
Received: from [10.47.80.129] (10.47.80.129) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 08:16:26 +0100
Message-ID: <febb03e4-ea1d-c7e1-58a6-fa564c902af0@huawei.com>
Date:   Wed, 6 Apr 2022 08:16:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 2/2] libata: Inline ata_qc_new_init() in
 ata_scsi_qc_new()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-scsi@vger.kernel.org>
References: <1649083990-207133-1-git-send-email-john.garry@huawei.com>
 <1649083990-207133-3-git-send-email-john.garry@huawei.com>
 <20220405055252.GA23698@lst.de>
 <f7bbb09f-562f-fce2-cd16-a1c67fc334b5@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <f7bbb09f-562f-fce2-cd16-a1c67fc334b5@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.129]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2022 02:48, Damien Le Moal wrote:
> On 4/5/22 14:52, Christoph Hellwig wrote:
>> On Mon, Apr 04, 2022 at 10:53:10PM +0800, John Garry wrote:
>>> From: Christoph Hellwig <hch@lst.de>
>>>
>>> It is a bit pointless to have ata_qc_new_init() in libata-core.c 
>>> since it
>>> pokes scsi internals, so inline it in ata_scsi_qc_new() (in 
>>> libata-scsi.c).
>>>
>>> <Christoph, please provide signed-off-by>
>>> [jpg, Take Christoph's change from list and form into a patch]
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> Although I still think merging the two patches into one to avoid all
>> the churn would be much better.
> 
> I agree. Let's merge these 2 patches.

I'd say that they are distinct changes.

Anyway, if that is the preference then who shall be the author? 
Considering I did most effort I will be and add Christoph as 
co-developed-by - please let me know if not ok.

thanks,
John

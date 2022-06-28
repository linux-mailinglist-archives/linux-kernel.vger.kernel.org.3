Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41EF55DDA5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240632AbiF1LeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiF1LeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:34:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8262F2FFD4;
        Tue, 28 Jun 2022 04:34:02 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXMnz3Xjcz686M3;
        Tue, 28 Jun 2022 19:29:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 13:34:00 +0200
Received: from [10.126.174.22] (10.126.174.22) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 12:33:59 +0100
Message-ID: <38ae1cc8-1411-bb54-e082-0f7b91cb9e63@huawei.com>
Date:   Tue, 28 Jun 2022 12:33:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 5/5] libata-scsi: Cap ata_device->max_sectors according
 to shost->max_sectors
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>, <hch@lst.de>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <iommu@lists.linux.dev>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <joro@8bytes.org>, <will@kernel.org>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-6-git-send-email-john.garry@huawei.com>
 <b69c6112-98b7-3890-9d11-bb321a7c877a@opensource.wdc.com>
 <6619638c-52e8-cb67-c56c-9c9d38c18161@huawei.com>
 <ba59a0da-a982-e3eb-1cb7-6e60f80fd319@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <ba59a0da-a982-e3eb-1cb7-6e60f80fd319@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.174.22]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2022 10:14, Damien Le Moal wrote:
>> BTW, this patch has no real dependency on the rest of the series, so
>> could be taken separately if you prefer.
> Sure, you can send it separately. Adding it through the scsi tree is fine too.
> 

Well Christoph originally offered to take this series via the 
dma-mapping tree.

@Christoph, is that still ok with you? If so, would you rather I send 
this libata patch separately?

Thanks,
john

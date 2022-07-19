Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754645795D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbiGSJKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiGSJK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:10:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F9F23BC6;
        Tue, 19 Jul 2022 02:10:27 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnCdL22Bgz67xrt;
        Tue, 19 Jul 2022 17:07:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 19 Jul 2022 11:10:24 +0200
Received: from [10.126.173.247] (10.126.173.247) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 10:10:23 +0100
Message-ID: <1f523333-1de5-2a09-0476-298edcbba413@huawei.com>
Date:   Tue, 19 Jul 2022 10:10:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 4/6] scsi: sd: Allow max_sectors be capped at DMA
 optimal size limit
To:     Christoph Hellwig <hch@lst.de>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <joro@8bytes.org>, <will@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <m.szyprowski@samsung.com>,
        <robin.murphy@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <iommu@lists.linux.dev>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1657797329-98541-1-git-send-email-john.garry@huawei.com>
 <1657797329-98541-5-git-send-email-john.garry@huawei.com>
 <6725df4f-4e27-3320-8b7b-22ba15a07866@opensource.wdc.com>
 <e3dbd78e-95fe-ea61-8bcf-45ea02de1647@huawei.com>
 <20220719071028.GA28633@lst.de>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220719071028.GA28633@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.173.247]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 08:10, Christoph Hellwig wrote:
> On Tue, Jul 19, 2022 at 08:05:30AM +0100, John Garry wrote:
>> Christoph has now applied this (thanks, BTW), so would you like me to
>> follow up with a patch on top with a comment?
> Please do.

ok, fine, I'll do it now.

Just saying in case it's an issue - I was looking at 
http://git.infradead.org/users/hch/dma-mapping.git/log/refs/heads/for-next 
and the order is not the same as this series and would cause an 
intermediate build breakage at 9f5ec52ae501 ("scsi: scsi_transport_sas: 
cap shost opt_sectors according to DMA optimal limit")

Cheers,
John

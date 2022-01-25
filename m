Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D567849B5C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386350AbiAYOK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:10:26 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4511 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386082AbiAYOFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:05:53 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjpSq2Dnpz67ZkT;
        Tue, 25 Jan 2022 22:02:19 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 15:05:44 +0100
Received: from [10.47.95.36] (10.47.95.36) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 25 Jan
 2022 14:05:43 +0000
Subject: Re: [PATCH 05/16] scsi: libsas: Add struct sas_tmf_task
To:     Matthew Wilcox <willy@infradead.org>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <Ajish.Koshy@microchip.com>,
        <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>, <damien.lemoal@opensource.wdc.com>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1643110372-85470-6-git-send-email-john.garry@huawei.com>
 <Ye/9Fs+JrtlMC+Mb@casper.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6b31b15c-98d9-ee07-0092-cbcc5f5c71fe@huawei.com>
Date:   Tue, 25 Jan 2022 14:05:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <Ye/9Fs+JrtlMC+Mb@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.36]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2022 13:37, Matthew Wilcox wrote:
>> Also add an interim force phy id field for hisi_sas driver, which will be
>> removed once the STP "TMF" code is factored out.
>>
>> Even though some LLDDs (pm8001) use a u32 for the tag, u16 should be
>> enough.
> ... because pm8001 limits the number of tags to 1024.
> .

Sure, but the pm8001 HW does has a 32b field, which is strange as the 
SAS spec defines a 16b field in the task management Function information 
unit "tag of task to be managed" field.

Thanks,
John

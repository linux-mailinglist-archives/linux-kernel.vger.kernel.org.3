Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEF949DF9D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiA0KnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:43:16 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4522 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiA0KnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:43:15 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jkxxh3gT4z6H8VV;
        Thu, 27 Jan 2022 18:42:48 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 11:43:13 +0100
Received: from [10.47.26.192] (10.47.26.192) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 27 Jan
 2022 10:43:12 +0000
Subject: Re: [PATCH 01/16] scsi: libsas: Use enum for response frame DATAPRES
 field
To:     Christoph Hellwig <hch@infradead.org>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <Ajish.Koshy@microchip.com>,
        <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>, <damien.lemoal@opensource.wdc.com>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1643110372-85470-2-git-send-email-john.garry@huawei.com>
 <YfJxzi1udZQhAYKW@infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <cb02f6a2-be87-9391-212b-c53d98a80bb2@huawei.com>
Date:   Thu, 27 Jan 2022 10:42:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YfJxzi1udZQhAYKW@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.26.192]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2022 10:19, Christoph Hellwig wrote:
> On Tue, Jan 25, 2022 at 07:32:37PM +0800, John Garry wrote:
>> -	if (iu->datapres == 0)
>> +	if (iu->datapres == NO_DATA)
>>   		tstat->stat = iu->status;
>> -	else if (iu->datapres == 1)
>> +	else if (iu->datapres == RESPONSE_DATA)
>>   		tstat->stat = iu->resp_data[3];
>> -	else if (iu->datapres == 2) {
>> +	else if (iu->datapres == SENSE_DATA) {
> Maybe use a switch here to make it more obvious?
> .

ok, I can include that suggestion.

Thanks,
John

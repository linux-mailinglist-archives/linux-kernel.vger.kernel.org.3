Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404BD483C02
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbiADGqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:46:39 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17320 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiADGqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:46:38 -0500
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JSjmY692mz9s0r;
        Tue,  4 Jan 2022 14:45:33 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 14:46:35 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 14:46:34 +0800
Subject: Re: [PATCH 1/3] Documentation: update debugfs doc for Hisilicon SEC
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20211225062718.41155-1-yekai13@huawei.com>
 <20211225062718.41155-2-yekai13@huawei.com> <YchH4g+mhfRQKXoX@kroah.com>
CC:     <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <xuzaibo@huawei.com>
From:   "yekai(A)" <yekai13@huawei.com>
Message-ID: <1575f22a-f11c-3507-bd32-def3844e9bab@huawei.com>
Date:   Tue, 4 Jan 2022 14:46:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YchH4g+mhfRQKXoX@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/26 18:45, Greg KH wrote:
> On Sat, Dec 25, 2021 at 02:27:16PM +0800, Kai Ye wrote:
>> Update documentation describing DebugFS for function's QoS limiting.
>>
>> Signed-off-by: Kai Ye <yekai13@huawei.com>
>> ---
>>  Documentation/ABI/testing/debugfs-hisi-sec | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/debugfs-hisi-sec b/Documentation/ABI/testing/debugfs-hisi-sec
>> index 85feb4408e0f..9e50ceab94d2 100644
>> --- a/Documentation/ABI/testing/debugfs-hisi-sec
>> +++ b/Documentation/ABI/testing/debugfs-hisi-sec
>> @@ -14,6 +14,16 @@ Description:    One SEC controller has one PF and multiple VFs, each function
>>  		qm refers to.
>>  		Only available for PF.
>>
>> +What:           /sys/kernel/debug/hisi_sec2/<bdf>/alg_qos
>> +Date:           Jun 2021
>> +Contact:        linux-crypto@vger.kernel.org
>
> No tabs?  Why not?
>
> thanks,
>
> greg k-h
> .
>

I'm read the way it was written before，
i will use the tabs on all Hisilicon Accelerator documentation.

thanks
Kai.

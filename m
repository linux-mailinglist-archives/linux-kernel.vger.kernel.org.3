Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80D746E04F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbhLIBjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 20:39:53 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15710 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhLIBjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:39:52 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J8c4R1NyVzZdXL;
        Thu,  9 Dec 2021 09:33:27 +0800 (CST)
Received: from [10.174.176.231] (10.174.176.231) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 09:36:18 +0800
Subject: Re: [PATCH v2 2/2] arm64: mm: Use asid feature macro for cheanup
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wuxu.wu@huawei.com>, Hewenliang <hewenliang4@huawei.com>
References: <506863a9-b934-3af3-c70d-3284e14478de@huawei.com>
 <204aef78-cf5b-a337-af71-5d52ba845aa0@huawei.com>
 <0834bf48-b602-b173-63d5-381a58962b3e@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <c222ba12-6673-0d58-fb2e-9043ce279995@huawei.com>
Date:   Thu, 9 Dec 2021 09:36:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0834bf48-b602-b173-63d5-381a58962b3e@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.231]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/8 17:35, Kefeng Wang wrote:
> Delete the first blank line and add your SOB,
> 
Ok, thanks.

> For series,
> 
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> On 2021/12/8 17:17, Yunfeng Ye wrote:
>> The commit 95b54c3e4c92 ("KVM: arm64: Add feature register flag
>> definitions") introduce the ID_AA64MMFR0_ASID_8 and ID_AA64MMFR0_ASID_16
>> macros.
>>
>> We can use these macros for cheanup in get_cpu_asid_bits().
>>
>> No functional change.
>> ---
>>   arch/arm64/mm/context.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
>> index bbc2708fe928..b8b4cf0bcf39 100644
>> --- a/arch/arm64/mm/context.c
>> +++ b/arch/arm64/mm/context.c
>> @@ -50,10 +50,10 @@ static u32 get_cpu_asid_bits(void)
>>           pr_warn("CPU%d: Unknown ASID size (%d); assuming 8-bit\n",
>>                       smp_processor_id(),  fld);
>>           fallthrough;
>> -    case 0:
>> +    case ID_AA64MMFR0_ASID_8:
>>           asid = 8;
>>           break;
>> -    case 2:
>> +    case ID_AA64MMFR0_ASID_16:
>>           asid = 16;
>>       }
>>
> .
> 

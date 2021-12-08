Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B30B46D02D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhLHJjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:39:22 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29160 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhLHJjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:39:21 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J8Bn24NkNzXdgv;
        Wed,  8 Dec 2021 17:33:42 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 17:35:48 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 17:35:47 +0800
Message-ID: <0834bf48-b602-b173-63d5-381a58962b3e@huawei.com>
Date:   Wed, 8 Dec 2021 17:35:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/2] arm64: mm: Use asid feature macro for cheanup
Content-Language: en-US
To:     Yunfeng Ye <yeyunfeng@huawei.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wuxu.wu@huawei.com>, Hewenliang <hewenliang4@huawei.com>
References: <506863a9-b934-3af3-c70d-3284e14478de@huawei.com>
 <204aef78-cf5b-a337-af71-5d52ba845aa0@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <204aef78-cf5b-a337-af71-5d52ba845aa0@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the first blank line and add your SOB,

For series,

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

On 2021/12/8 17:17, Yunfeng Ye wrote:
> The commit 95b54c3e4c92 ("KVM: arm64: Add feature register flag
> definitions") introduce the ID_AA64MMFR0_ASID_8 and ID_AA64MMFR0_ASID_16
> macros.
>
> We can use these macros for cheanup in get_cpu_asid_bits().
>
> No functional change.
> ---
>   arch/arm64/mm/context.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
> index bbc2708fe928..b8b4cf0bcf39 100644
> --- a/arch/arm64/mm/context.c
> +++ b/arch/arm64/mm/context.c
> @@ -50,10 +50,10 @@ static u32 get_cpu_asid_bits(void)
>   		pr_warn("CPU%d: Unknown ASID size (%d); assuming 8-bit\n",
>   					smp_processor_id(),  fld);
>   		fallthrough;
> -	case 0:
> +	case ID_AA64MMFR0_ASID_8:
>   		asid = 8;
>   		break;
> -	case 2:
> +	case ID_AA64MMFR0_ASID_16:
>   		asid = 16;
>   	}
>

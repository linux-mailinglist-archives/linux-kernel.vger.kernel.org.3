Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C574C46E04B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhLIBjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 20:39:01 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29163 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhLIBjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:39:00 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J8c4J1ntfz8vgT;
        Thu,  9 Dec 2021 09:33:20 +0800 (CST)
Received: from [10.174.176.231] (10.174.176.231) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 09:35:26 +0800
Subject: Re: [PATCH v2 1/2] arm64: mm: Rename asid2idx() to ctxid2asid()
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <wangkefeng.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wuxu.wu@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <506863a9-b934-3af3-c70d-3284e14478de@huawei.com>
 <YbD4hcSWKEXSL1hg@arm.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <e71321dc-862d-82e3-8cfb-a67ff2169024@huawei.com>
Date:   Thu, 9 Dec 2021 09:35:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <YbD4hcSWKEXSL1hg@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.231]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/9 2:25, Catalin Marinas wrote:
> On Wed, Dec 08, 2021 at 05:16:45PM +0800, Yunfeng Ye wrote:
>> The commit 0c8ea531b774 ("arm64: mm: Allocate ASIDs in pairs") introduce
>> the asid2idx and idx2asid macro, but these macros are not really useful
>> after the commit f88f42f853a8 ("arm64: context: Free up kernel ASIDs if
>> KPTI is not in use").
>>
>> The code "(asid & ~ASID_MASK)" can be instead by a macro, which is the
>> same code with asid2idx(). So rename it to ctxid2asid() for a better
>> understanding.
>>
>> Also we add asid2ctxid() macro, the contextid can be generated based on
>> the asid and generation through this macro.
> 
> The changes look fine to me but please repost with your Signed-off-by.
> 
Ok, thanks.

> Thanks.
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FBB4662A3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbhLBLsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:48:01 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16338 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhLBLr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:47:56 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J4Yy70ypLz91XF;
        Thu,  2 Dec 2021 19:43:59 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 19:44:32 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 19:44:32 +0800
Message-ID: <2cb7ef5c-6714-254c-0308-f72f53a6612a@huawei.com>
Date:   Thu, 2 Dec 2021 19:44:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] arm64: Enable KCSAN
Content-Language: en-US
To:     Marco Elver <elver@google.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <joey.gouly@arm.com>
References: <20211129145732.27000-1-wangkefeng.wang@huawei.com>
 <YadiUPpJ0gADbiHQ@FVFF77S0Q05N>
 <811af0bc-0c99-37f6-a39a-095418b10661@huawei.com>
 <Yaic31SbYFJ4zAl0@elver.google.com>
 <b641f1ea-6def-0fe4-d273-03c35c4aa7d6@huawei.com>
 <CANpmjNOOVQjoczanQndUoDRMCOfV4FB6bnezEjskKh3iDzaQVg@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CANpmjNOOVQjoczanQndUoDRMCOfV4FB6bnezEjskKh3iDzaQVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/12/2 18:58, Marco Elver wrote:
> On Thu, 2 Dec 2021 at 11:45, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> [...]
>>>> for now and more explanation into changlog.
>>> So what I gather arm64's final select line may look like:
>>>
>>>        select HAVE_ARCH_KCSAN if EXPERT && (CC_IS_GCC || CLANG_VERSION >= 120000)
>> Yes,  that's what we want now.
> I think we have all the pieces sorted out, so hopefully you have
> everything you need to do v3.
OK, I will resend v3.
>
> [...]
>>> I actually have a "fix" for the data race in rwsem_spin_on_owner, that
>>> also shows where the other racing access comes from... which reminds me:
>>> https://lkml.kernel.org/r/20211202101238.33546-1-elver@google.com
>> There's a owner_on_cpu(),  we could reuse it,
> That looks like a reasonable thing to do, but can't say if it is
> actually the right thing to do. You could suggest it in reply to the
> patch I just sent and see what people say.
Could you cc me, I can't reply email due to no subscribe to mailing 
list, thanks.

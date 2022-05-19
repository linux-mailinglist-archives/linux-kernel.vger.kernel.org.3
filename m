Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1260052C97D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 03:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiESBy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 21:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiESByy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 21:54:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F024C3D38
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 18:54:53 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3XvF2ZMSzgYN7;
        Thu, 19 May 2022 09:53:29 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 09:54:51 +0800
Subject: Re: [PATCH 0/9] A few fixup patches for z3fold
To:     Vitaly Wool <vitaly.wool@konsulko.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220429064051.61552-1-linmiaohe@huawei.com>
 <20220517164553.29d6b76eb0cc656556916372@linux-foundation.org>
 <6f42e812-ab51-9b24-13f2-2493b917cb98@huawei.com>
 <CAM4kBBKicBu-MsJ+=1QRwA4xpOUaz_iRj15+qkK4URyLzVSmCQ@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8aa3786c-19dd-dbe2-384d-125af5d1b44f@huawei.com>
Date:   Thu, 19 May 2022 09:54:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAM4kBBKicBu-MsJ+=1QRwA4xpOUaz_iRj15+qkK4URyLzVSmCQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/18 18:39, Vitaly Wool wrote:
> On Wed, May 18, 2022 at 4:02 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2022/5/18 7:45, Andrew Morton wrote:
>>> On Fri, 29 Apr 2022 14:40:42 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>
>>>> This series contains a few fixup patches to fix sheduling while atomic,
>>>> fix possible null pointer dereferencing, fix various race conditions and
>>>> so on. More details can be found in the respective changelogs.
>>>
>>> We haven't heard from Vitaly but this series has been in mm-unstable
>>
>> I will be really grateful if Vitaly has the time to review. :)
> 
> I absolutely will, sorry for the delay.

That will be really helpful. Thanks!

> 
> ~Vitaly
> 
>>
>>
>>> and linux-next for three weeks, so I plan to move it into mm-stable
>>> later this week.
>>
>> Thanks!
>>
>>> .
>>>
>>
> .
> 


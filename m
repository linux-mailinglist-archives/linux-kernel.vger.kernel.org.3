Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC0950DAFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiDYIVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiDYIVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:21:52 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD03C5DA05;
        Mon, 25 Apr 2022 01:18:41 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 25 Apr
 2022 16:18:40 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 25 Apr
 2022 16:18:39 +0800
Message-ID: <53ac1850-0286-0dc7-4a76-8a0ddee696c0@meizu.com>
Date:   Mon, 25 Apr 2022 16:18:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] docs/zh_CN: sync with original text
 Documentation/vm/page_owner.rst
To:     yanteng si <siyanteng01@gmail.com>
CC:     Alex Shi <seakeel@gmail.com>, Alex Shi <alexs@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Yanteng Si <siyanteng@loongson.cn>
References: <CAEensMzuQ0uAw8_5Xb7u1n685au=DpaJyPevGCT8GCG7xS42ow@mail.gmail.com>
 <1650424016-7225-1-git-send-email-baihaowen@meizu.com>
 <1650424016-7225-2-git-send-email-baihaowen@meizu.com>
 <30d2f96e-99e1-2976-a294-8e112166afff@gmail.com>
 <049ccac8-c394-0cdc-c2ed-4ea91cab6439@meizu.com>
 <c498b2a7-8f0e-4f6d-10ba-49c4c7794ff9@gmail.com>
 <0be9fe6a-b01e-b355-9283-6ad8372932d6@meizu.com>
 <CAEensMzgJ6LmGiJajqwgE3cQCR-pcgr1o35Qf=n1K215BwHLhA@mail.gmail.com>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <CAEensMzgJ6LmGiJajqwgE3cQCR-pcgr1o35Qf=n1K215BwHLhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 4/25/22 11:19 AM, yanteng si 写道:
> baihaowen <baihaowen@meizu.com> 于2022年4月25日周一 09:17写道：
>> 在 4/24/22 11:16 AM, Alex Shi 写道:
>>> On 4/24/22 10:56, baihaowen wrote:
>>>>>> +        ======          ==========      ==================
>>>> hi, Alex
>>>> I can apply local.
>>>> ➜  linux-next git:(heads/next-20220421) ✗ git am doc_pageonwer_patches/0001-docs-zh_CN-sync-with-original-text-Documentation-vm-.patch
>>>> 应用：docs/zh_CN: sync with original text Documentation/vm/page_owner.rst
>>>> ➜  linux-next git:(heads/next-20220421) ✗ git am doc_pageonwer_patches/0002-doc-vm-page_owner.rst-Fix-table-display-confusion.patch
>>>> 应用：doc/vm/page_owner.rst: Fix table display confusion
>>>>
>>>> I think git send-email will change format by my select. I'll try to resend.
>>> Send to yourself only then get it from your email client and try applying.
>>>
>>> Thanks
>>> Alex
>> Hi Alex
>>
>> Could you tell me how do you do when you get a patch from email ?
> $: git clone git://git.kernel.org/pub/scm/utils/b4/b4.git
> $: b4/b4.sh am <message-id>
> ###在你的邮箱里查看原始有邮件，然后找到message-id，贴过来就行，前提是你的补丁系列在lore里是按照前几天我说的那么弄。
> $: vim xxxx.mbx   ### [modify your patch]
> $: git am  xxxx.mbx
>
>
> Thanks,
> Yanteng
>
>> I get my patch from email and then copy-patse to a new file, then git am xx.patch.
>> It will notice 补丁格式检测失败。
>>
>> --
>> Haowen Bai
>>
hi, Yanteng

No matter I select y or N, I could not git am the Chinese translation patch.

    doc_pageonwer_patches/0001-docs-zh_CN-sync-with-original-text-Documentation-vm-.patch
Which 8bit encoding should I declare [UTF-8]? y
Are you sure you want to use <y> [y/N]? y

    doc_pageonwer_patches/0001-docs-zh_CN-sync-with-original-text-Documentation-vm-.patch
Which 8bit encoding should I declare [UTF-8]? N
Are you sure you want to use <N> [y/N]? y

$git am xxx.patch
error: cannot convert from y to UTF-8
fatal: could not parse patch
or
$git am xxx.patch
error: cannot convert from N to UTF-8
fatal: could not parse patch

so, the problem is happening when I did git send-email, and the original zh_CN patch is successful for git am.
Have you ever meet this problem ?

-- 
Haowen Bai


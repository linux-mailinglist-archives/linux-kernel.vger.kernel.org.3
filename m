Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D244D50F3B9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344659AbiDZI1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344067AbiDZI0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:26:43 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9321E3B3F3;
        Tue, 26 Apr 2022 01:23:10 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 26 Apr
 2022 16:23:08 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 26 Apr
 2022 16:23:07 +0800
Message-ID: <68b68f35-86e5-3f3b-ffd0-bea9c952fc66@meizu.com>
Date:   Tue, 26 Apr 2022 16:23:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] docs/zh_CN: sync with original text
 Documentation/vm/page_owner.rst
To:     Alex Shi <seakeel@gmail.com>, <siyanteng01@gmail.com>
CC:     <alexs@kernel.org>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <siyanteng@loongson.cn>
References: <CAEensMzuQ0uAw8_5Xb7u1n685au=DpaJyPevGCT8GCG7xS42ow@mail.gmail.com>
 <1650424016-7225-1-git-send-email-baihaowen@meizu.com>
 <1650424016-7225-2-git-send-email-baihaowen@meizu.com>
 <30d2f96e-99e1-2976-a294-8e112166afff@gmail.com>
 <049ccac8-c394-0cdc-c2ed-4ea91cab6439@meizu.com>
 <c498b2a7-8f0e-4f6d-10ba-49c4c7794ff9@gmail.com>
 <0be9fe6a-b01e-b355-9283-6ad8372932d6@meizu.com>
 <73d2f4cb-9f38-ac33-b4c0-c4d3b465bf8b@gmail.com>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <73d2f4cb-9f38-ac33-b4c0-c4d3b465bf8b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 4/26/22 4:20 PM, Alex Shi 写道:
>
> On 4/25/22 09:17, baihaowen wrote:
>> 在 4/24/22 11:16 AM, Alex Shi 写道:
>>> On 4/24/22 10:56, baihaowen wrote:
>>>>>> +        ======          ==========      ==================
>>>> hi, Alex
>>>> I can apply local.
>>>> ➜  linux-next git:(heads/next-20220421) ✗ git am doc_pageonwer_patches/0001-docs-zh_CN-sync-with-original-text-Documentation-vm-.patch
>>>> 应用：docs/zh_CN: sync with original text Documentation/vm/page_owner.rst
>>>> ➜  linux-next git:(heads/next-20220421) ✗ git am doc_pageonwer_patches/0002-doc-vm-page_owner.rst-Fix-table-display-confusion.patch   
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
>>
>> I get my patch from email and then copy-patse to a new file, then git am xx.patch.
> Don't do it. copy usually mess the format of patch.
>
> Saving the patch email from many kind of email-clients as raw file, like thunderbird etc.
> Then using 'git am xxx.patch'. It will work. In fact, git can handle the plain email patch well.
>
>
>> It will notice 补丁格式检测失败。
>>
hi, Alex
I have sent you an available patch set, plz try to apply.

-- 
Haowen Bai


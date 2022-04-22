Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BDD50AD4F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443133AbiDVBnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiDVBnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:43:35 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7263849C9E;
        Thu, 21 Apr 2022 18:40:42 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 22 Apr
 2022 09:40:42 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 22 Apr
 2022 09:40:39 +0800
Message-ID: <93467d50-8ffb-0fb7-cafb-60eb2dd44130@meizu.com>
Date:   Fri, 22 Apr 2022 09:40:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/2] sync with original text
 Documentation/vm/page_owner.rst
To:     yanteng si <siyanteng01@gmail.com>
CC:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Shi <seakeel@gmail.com>,
        Yanteng Si <siyanteng@loongson.cn>
References: <CAEensMzuQ0uAw8_5Xb7u1n685au=DpaJyPevGCT8GCG7xS42ow@mail.gmail.com>
 <1650424016-7225-1-git-send-email-baihaowen@meizu.com>
 <CAEensMxtk8zJPAM-u7hvYkaNTBrVdmhKA7YzVsKmTw0TcOE=Pw@mail.gmail.com>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <CAEensMxtk8zJPAM-u7hvYkaNTBrVdmhKA7YzVsKmTw0TcOE=Pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-123.meizu.com (172.16.1.123) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 4/21/22 8:26 PM, yanteng si 写道:
> Haowen Bai <baihaowen@meizu.com> 于2022年4月20日周三 11:07写道：
>> This patches series will sync the translation of zh_CN as below:
>>
>> Commit 8bd16bc0a081 ("tools/vm/page_owner_sort.c: support sorting blocks
>> by multiple keys") add sorting blocks by multiple keys usage
>> description.
>>
>> Commit 78a0b94f3829 ("tools/vm/page_owner_sort.c: support for multi-value
>> selection in single argument") add multi-value selection in single
>> argument usage description.
>>
>> Commit c89b3ad2dea2 ("doc/vm/page_owner.rst: remove content related to -c
>> option") remove  -c option usage description.
>>
>> Commit 9c8a0a8e599f ("tools/vm/page_owner_sort.c: support for user-defined
>> culling rules") add user-defined culling rules usage description.
>>
>> Commit 8ea8613a616a ("tools/vm/page_owner_sort.c: support for selecting by
>> PID, TGID or task command name") add selecting by PID, TGID or task
>> command name usage description.
>>
>> Commit 194d52d771b8 ("tools/vm/page_owner_sort: support for sorting by
>> task command name") add sorting by task command name usage description.
>>
>> But the original text table which is made of tab will display all
>> by one line. so we make a standard table for STANDARD FORMAT SPECIFIERS
>> description. I fix it up togeter by this patches series.
>>
>>
>> Haowen Bai (2):
>>   docs/zh_CN: sync with original text Documentation/vm/page_owner.rst
>>   doc/vm/page_owner.rst: Fix table display confusion
> hi haowen,
>
> I'm not sure why, your different versions of the patch are in one
> thread and they look like this inside
> <https://lore.kernel.org/linux-doc/>：
>
> [PATCH V3] docs/zh_CN: sync with original text Documentation/vm/page_owner.rst
>  2022-04-20 12:46 UTC  (22+ messages)
>     ` [PATCH V4] "
>             ` [PATCH V5] "
>                   ` [PATCH V6] "
>                     ` [PATCH V7] "
>                       ` [PATCH V8] "
>                           ` [PATCH 0/2] "
>                             ` [PATCH 1/2] docs/zh_CN: "
>                             ` [PATCH 2/2] doc/vm/page_owner.rst: Fix
> table display confusion

I always reply mail using below method:

  git send-email \
    --in-reply-to='CAEensMxtk8zJPAM-u7hvYkaNTBrVdmhKA7YzVsKmTw0TcOE=Pw@mail.gmail.com' \
    --to=siyanteng01@gmail.com \
    --cc=alexs@kernel.org \
    --cc=baihaowen@meizu.com \
    --cc=corbet@lwn.net \
    --cc=linux-doc@vger.kernel.org \
    --cc=linux-kernel@vger.kernel.org \
    --cc=seakeel@gmail.com \
    --cc=siyanteng@loongson.cn \
    --subject='Re: [PATCH 0/2] sync with original text Documentation/vm/page_owner.rst' \
    /path/to/YOUR_REPLY

link previous

> This will make trouble for the maintainer，Usually, they should look like this：
>
> [PATCH 0/2] docs/zh_CN: add hmm and numa translation
>  2022-04-21 11:59 UTC  (3+ messages)
> ` [PATCH 1/2] docs/zh_CN: add vm hmm translation
> ` [PATCH 2/2] docs/zh_CN: add vm numa translation
>
>
> Thanks,
> Yanteng
>
>>  Documentation/translations/zh_CN/vm/page_owner.rst | 61 +++++++++++++++++++++-
>>  Documentation/vm/page_owner.rst                    | 34 +++++++-----
>>  2 files changed, 80 insertions(+), 15 deletions(-)
>>
>> --
>> 2.7.4
>>

-- 
Haowen Bai


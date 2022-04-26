Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD56250F612
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242370AbiDZIxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345609AbiDZIjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:39:17 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62983BA5E;
        Tue, 26 Apr 2022 01:30:25 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 26 Apr
 2022 16:30:23 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 26 Apr
 2022 16:30:23 +0800
Message-ID: <89f61153-1ef6-df1b-1bf6-90ba853b080b@meizu.com>
Date:   Tue, 26 Apr 2022 16:30:23 +0800
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
 <68b68f35-86e5-3f3b-ffd0-bea9c952fc66@meizu.com>
 <3f93bb0d-5658-f269-f8cc-d0a964ffb68b@gmail.com>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <3f93bb0d-5658-f269-f8cc-d0a964ffb68b@gmail.com>
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

在 4/26/22 4:29 PM, Alex Shi 写道:
>
>
> On 4/26/22 16:23, baihaowen wrote:
>>> Saving the patch email from many kind of email-clients as raw file, like thunderbird etc.
>>> Then using 'git am xxx.patch'. It will work. In fact, git can handle the plain email patch well.
>>>
>>>
>>>> It will notice 补丁格式检测失败。
>>>>
>> hi, Alex
>> I have sent you an available patch set, plz try to apply.
>
>
> Did you try your post by yourself? :)
>
>
>> -- Haowen Bai
YES.

-- 
Haowen Bai


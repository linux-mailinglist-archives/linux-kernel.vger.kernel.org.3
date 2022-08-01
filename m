Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23181586C6E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiHAN6c convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Aug 2022 09:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiHAN62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:58:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E91C28E3E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 06:58:24 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LxKQN39dQzlW9d;
        Mon,  1 Aug 2022 21:55:40 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 21:58:20 +0800
Received: from kwepemi500012.china.huawei.com (7.221.188.12) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 21:58:20 +0800
Received: from kwepemi500012.china.huawei.com ([7.221.188.12]) by
 kwepemi500012.china.huawei.com ([7.221.188.12]) with mapi id 15.01.2375.024;
 Mon, 1 Aug 2022 21:58:20 +0800
From:   "xuqiang (M)" <xuqiang36@huawei.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "elver@google.com" <elver@google.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "tangmeng@uniontech.com" <tangmeng@uniontech.com>,
        "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>,
        "john.ogness@linutronix.de" <john.ogness@linutronix.de>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "weiyongjun (A)" <weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] panic: Add register_panic_notifier and
 unregister_panic_notifier
Thread-Topic: [PATCH -next] panic: Add register_panic_notifier and
 unregister_panic_notifier
Thread-Index: AQHYpZ/egy0qdqWHEES2vQeF021riw==
Date:   Mon, 1 Aug 2022 13:58:20 +0000
Message-ID: <d6ba371d778842bead73e62fc04d612f@huawei.com>
References: <20220801100509.62282-1-xuqiang36@huawei.com>
 <2d4fa03a-f460-d995-88e8-7f0e58e557bd@igalia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.179.28]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/8/1 20:12, Guilherme G. Piccoli 写道:
> On 01/08/2022 07:05, Xu Qiang wrote:
>> Add two methods to manipulate panic_notifier_list and export them.
>> Subsequently, panic_notifier_list is changed to static variable.
>>
>> Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
> Hi Xu Qiang, first of all, thanks for your patch!
> I'd like to mention 2 things about it:
>
> (a) As-is, there's no much use for it - I mean, you're adding a helper
> but you didn't change the uses of such notifier list addition (and there
> are plenty of them). Are you intend to change it, or just use the new
> API in new calls?
After this patch comes in, I will replace all the old interfaces with
the new ones.
>
> (b) Even more important: we are working in a panic notifier refactor
> [0], and that'll add new lists. I'm still working on that, plan to
> submit (relatively) soon. Maybe worth to wait it, if this one is not urgent?
I can wait for your patch to be incorporated before submitting it.
>
> Cheers,
>
>
> Guilherme
>
>
> [0]
> https://lore.kernel.org/lkml/20220427224924.592546-1-gpiccoli@igalia.com/
>
Thanks

Xu



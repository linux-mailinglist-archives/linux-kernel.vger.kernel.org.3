Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DBD5A6266
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiH3LtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH3LtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:49:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525A5A7AAC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:49:05 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MH58j0p05zkWTJ;
        Tue, 30 Aug 2022 19:45:25 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 19:49:03 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 19:49:02 +0800
Subject: Re: [PATCH v2] ARM: Add sanity check for dev->periphid in
 amba_probe()
To:     Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     Saravana Kannan <saravanak@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <patches@armlinux.org.uk>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20220830065413.638-1-thunder.leizhen@huawei.com>
 <CAGETcx8hfzAthF_gCMrmnVOgwgFJEPE=bwRuVeXaiB7ywUkWkg@mail.gmail.com>
 <Yw3cs6wb4PvnDN/7@shell.armlinux.org.uk>
 <b120e94b-4b43-6d8a-a136-41417cb250cc@huawei.com>
 <Yw3hfGV4DYyJ0Gno@shell.armlinux.org.uk>
 <2452e7b0-d4fd-2e27-a336-bf87b85a8d50@huawei.com>
 <Yw3oR6WhM0O5LQX5@shell.armlinux.org.uk>
 <CACRpkdYhx4zT9F1CTEvAPjB1EmBD6CFenTJpwQ-KPg1+zCsYGg@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <81775dd3-d9ef-36d7-bdc7-b578c5d617a5@huawei.com>
Date:   Tue, 30 Aug 2022 19:49:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYhx4zT9F1CTEvAPjB1EmBD6CFenTJpwQ-KPg1+zCsYGg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/30 19:19, Linus Walleij wrote:
> On Tue, Aug 30, 2022 at 12:37 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> 
>>>         ... ...
>>>         driver_probe_device(drv, dev);
>>>              ......
>>>                   dev->bus->probe
>>
>> And that makes no sense, is an already known issue, and there is a patch
>> to fix it:
>>
>> https://lore.kernel.org/all/20220817184026.3468620-1-isaacmanjarres@google.com/
> 
> This patch to the driver core fixes my QEMU issue as well, I'll try
> to reply in-thread. Thanks for pointing this out Russell!

OK, so that my patch can be dropped.

> 
> Yours,
> Linus Walleij
> .
> 

-- 
Regards,
  Zhen Lei

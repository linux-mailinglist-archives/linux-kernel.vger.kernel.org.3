Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD175A4092
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 03:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiH2BPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 21:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiH2BPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 21:15:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B378D21275;
        Sun, 28 Aug 2022 18:15:40 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MGC8L38RZzkWhr;
        Mon, 29 Aug 2022 09:12:02 +0800 (CST)
Received: from [10.174.178.165] (10.174.178.165) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 09:15:37 +0800
Subject: Re: [PATCH -next] gpio: mockup: remove gpio debugfs when remove
 device
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220816145225.84283-1-weiyongjun1@huawei.com>
 <CAMRc=McG5Pf4b5HymV1iaFAGqMMEtyYSQi23z9LmjvzmbF4rYg@mail.gmail.com>
 <7d1b0bb8-838e-1a1e-886f-507b75066df1@huawei.com>
 <CAMRc=McDo2MbebGGueqacEbs11r8c_MHr8WaTktGzkVWZD2K4A@mail.gmail.com>
From:   "weiyongjun (A)" <weiyongjun1@huawei.com>
Message-ID: <81de4aa6-a207-2be8-00c3-7bed0f0b82e4@huawei.com>
Date:   Mon, 29 Aug 2022 09:15:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=McDo2MbebGGueqacEbs11r8c_MHr8WaTktGzkVWZD2K4A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.165]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 2022/8/28 22:00, Bartosz Golaszewski wrote:
> On Mon, Aug 22, 2022 at 3:27 PM weiyongjun (A) <weiyongjun1@huawei.com> wrote:
>>
>> Hi Bart,
>>
>> On 2022/8/19 20:49, Bartosz Golaszewski wrote:
>>> On Tue, Aug 16, 2022 at 4:34 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>>>>
>>>> GPIO mockup debugfs is created in gpio_mockup_probe() but
>>>> forgot to remove when remove device. This patch add a devm
>>>> managed callback for removing them.
>>>>
>>>
>>> The tag -next is for patches that address issues that are in next but
>>> not yet in master.
>>>>
>>
>>
>>>
>>> This isn't very relevant as the module needs to be unloaded anyway in
>>> order to reconfigure the simulated device but I'll apply it as it's
>>> technically correct. Did you see we have a new one - gpio-sim - that
>>> uses configfs?
>>>
>>> Bart
>>>
>>
>>
>> I am using gpio-mockup as a interrupt-controller with the change[1],
>> it works will with overfs dts[2], and can success mockup device and
>> trigger the irq. But when switch to gpio-sim, device can not be created
>> by dts[3]. Not sure what's wrong with it. Any suggestion?
>>
> 
> I see you submitted a patch series for gpio-sim - does it fix this issue?


Yes, after that patch series, gpio-sim works well in my use case.

Thanks,
Wei Yongjun

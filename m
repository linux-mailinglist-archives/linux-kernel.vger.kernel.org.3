Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050B8505C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbiDRQEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiDRQEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:04:37 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F84D1263E;
        Mon, 18 Apr 2022 09:01:56 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.94]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1McZfZ-1oBxc824lh-00d0eK; Mon, 18 Apr 2022 18:01:33 +0200
Message-ID: <6adc9c1c-ec75-b52c-9c44-00296eaa00f6@i2se.com>
Date:   Mon, 18 Apr 2022 18:01:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] clk: bcm2835: Round UART input clock up
Content-Language: en-US
To:     "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Phil Elwell <phil@raspberrypi.org>,
        kernel test robot <lkp@intel.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220404125113.80239-1-iivanov@suse.de>
 <20220414105656.qt52zmr5vjmjdcxc@suse>
 <0b3356c0-b4c8-91ed-dfde-9f50483ec36f@i2se.com>
 <20220418110516.s7jxsfa3jl7aagrf@suse>
 <2a46bd1c-600b-5bd9-1c19-20c809f63945@i2se.com>
 <20220418113801.uree7rvkzxpiwyni@suse>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220418113801.uree7rvkzxpiwyni@suse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:somyTe8OKM+gwMLHE0W9aM3scGr9zISIgwFNXJUxuaeY1grPwQq
 zwe/l9QjjFBVWXHE5RWylPudfTtBVJv+ge88de36wgx1+9qOmOpSfnqOPhY9YL7+/XXXOgR
 WomYlQ5UvWWDQDr1K4TY87GCVGfILbhtzVxUQiVIzLUwj7S27AX3bwRiz56SWiONFtjtI9Q
 QFL3NepSpMQQ60mx6yN/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4RHdFWUUmV4=:tU8hjna7N5CmiJVvNdndmL
 43hLDo7Iy1d6+z1rLM1D+rVHImaV9kuvIX45KHqk6PRuJTEkN01YO5x93bswzPJ9HCU9HLzwf
 wlXwunxAZ3FWtBLf6LLp3R312O1Q8YQlgyyjq0Fb/91tjHWFMdO9soQPLD6C+bc0MjhgVW8Tf
 gi45xDwBUnBzHH2WXVdzhyJGOt9Ur7Xa2bQ4WJiMbKr/+9+v44aH2DIKJTQ21JWgBbGc/OLoL
 PbUHG52dhpSutI/hkdTcPq78YOZyULWNUhWgarCCk2QGhGZHqRnKYa4I6Z+88au6JOcZTDy+u
 5myaIqWJaKvhs5GSnXb5CZ5V9EJCOwnB/y+uHcUYUGKSOtzYAvuesMEstu5nwPhoxBseAMfjW
 c9u9FJBI0pUvdWXO/rHfuQ820tMcV0ir66jo1TcS2dqVoxYwVzqj7AFvDv3E0zfei3tIlgJiL
 Ap5EP1rM5IJkJqB11XUCUo2MhzzbTNnkjnSIaPtLVX0YZvZA3K0u/LeuoDXBYTtIdkICgpjj6
 7Nc4zFnluECn3DKfCXG3bWbNSKxsWV4576hLbKR4czFq+4GZB8c8qCRb25RkJMLnslLbzhh51
 je4mINwWH0u6Jboje0Dl8rLcwUL7DvEPHzZKFOztEex0DvkEGEp5G3g6+G6ShBo7t83aMJwIl
 bzNA+q63ZT0RGt8Wv/kxaMA/ChXI1LzlxYB9l2caIQDnMrx/CfrG5ydGCoGSg4SoEJtgjybus
 sgPNkFK/sAVq7tNg
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.04.22 um 13:38 schrieb Ivan T. Ivanov:
> On 04-18 13:22, Stefan Wahren wrote:
>> Hi Ivan,
>>
>> Am 18.04.22 um 13:05 schrieb Ivan T. Ivanov:
>>> Hi Stefan,
>>>
>>> On 04-15 10:52, Stefan Wahren wrote:
>>>> Hi Ivan,
>>>>
>>>> Am 14.04.22 um 12:56 schrieb Ivan T. Ivanov:
>>>>> Hi Stefan,
>>>>>
>>>>> Please, could you take a look into following patch?
>>>> yes, but i cannot give a technical review. But from my gut feeling this
>>>> doesn't look really elegant to me.
>>>>> Thanks!
>>>>> Ivan
>>>>>
>>>>> On 04-04 15:51, Ivan T. Ivanov wrote:
>>>>>> Subject: [PATCH v2] clk: bcm2835: Round UART input clock up
>>>>>> Message-Id: <20220404125113.80239-1-iivanov@suse.de>
>>>>>>
>>>>>> The UART clock is initialised to be as close to the requested
>>>>>> frequency as possible without exceeding it. Now that there is a
>>>>>> clock manager that returns the actual frequencies, an expected
>>>>>> 48MHz clock is reported as 47999625. If the requested baudrate
>>>>>> == requested clock/16, there is no headroom and the slight
>>>>>> reduction in actual clock rate results in failure.
>>>>>>
>>>>>> If increasing a clock by less than 0.1% changes it from ..999..
>>>>>> to ..000.., round it up.
>>>> Based on this commit message this looks like a fix / workaround for an
>>>> issue. It would be very helpful to know:
>>>>
>>>> What issue should be fixed?
>>>>
>>>> Why is it fixed here and not in the UART driver for instance?
>>> The UART driver is amba-pl011. Original fix, see below Github link,
>>> was inside pl011 module, but somehow it didn't look as the right
>>> place either. Beside that this rounding function is not exactly
>>> perfect for all possible clock values. So I deiced to move the hack
>>> to the platform which actually need it.
>> thanks for your explanation. These are import information which belongs in
>> the commit log, because the motivation and the affected UART is very
>> important.
>>>> In case it fixes a regression, a Fixes tag should be necessary.
>>> I found the issue because it was reported that RPi3[1] and RPi Zero 2W
>>> boards have issues with the Bluetooth. So it turns out that when
>>> switching from initial to operation speed host and device no longer
>>> can talk each other because host uses incorrect baud rate.
>> Now i remember this issue, for the mainline kernel we decide to workaround
>> the issue by lowering the BT baudrate to 2000000 baud.
> I have workaranded this the same, at first, but then decided to look at
> vendor tree and voilà!
>
>> I didn't investigate
>> the issue further, but your approach is a better solution.
>>
>> Do you use the mainline DTS or the vendor DTS to see this issue?
>>
> For (open)SUSE we use downstream DTS.

This is popular and bad at the same time. We as the mainline kernel 
developer cannot guarantee that this works as expected. A lot of issues 
are caused by mixing vendor DTS with mainline kernel, so in general (not 
for this specific issue) you are on your own with this approach.

I know this is a little bit off topic but except from overlay support, 
can you provide a list of most missing features of the mainline kernel / 
DTS?

> Do you think that if I put better description in commit message fix will
> be more acceptable.
At least it would increase the chance to be accepted. This rounding 
behavior looks open coded, maybe there is already a function to achieve 
this.
> Or if someone could suggest anything else I am open
> to discussion.
>
> Regards,
> Ivan
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

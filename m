Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FC3504F59
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiDRLZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiDRLZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:25:50 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BCF1A399;
        Mon, 18 Apr 2022 04:23:11 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.94]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MLzeb-1nOT6l1oQr-00Ht6j; Mon, 18 Apr 2022 13:22:46 +0200
Message-ID: <2a46bd1c-600b-5bd9-1c19-20c809f63945@i2se.com>
Date:   Mon, 18 Apr 2022 13:22:44 +0200
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
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220418110516.s7jxsfa3jl7aagrf@suse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:XYHshlfjxi+RT/GL4GmBwzdxbmRf+BCvlC8OzxwcZuYRIC3lBQI
 mqxuml29UVfMGYn6W49CXof5Dy+d+X8yYAdj1vsVJw6PzIrl7O5u3gmyl06mPy/llHJS7eY
 59Gg+i1kQsezcVP+mkiupAHXyZXw+hBN8/WtDX2jIhQesj7wUAHu43okpBuIC5yaNbs40na
 4bQn7ELtf4LMsB/w/8pHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ysIhcjiCcPc=:lecKA5TUn4TZ3C8GYV0yat
 vpXwBLtY3lN4fhUwDTe5Gtw/OgXHG0nKqHqoJ113yjQ8URE88OwxfLXs9NuvQZZyEefEmQqMG
 byMIZWja/Zitw8pvlKLrI/f/AV77Mb9bAizaH/dLAp91Guh8gf6iTjUp0Oz7VcXRdPz4AZQwr
 XBMQTQRgsoevUofrlnbKZjkrM/Dg0LbDA8aWSpe3aKAKAM1vNJZE6QYTgkWQquCf8z+A5xSru
 twf2L4X3C4KeboWyAmmYWFungkBbSWaZQBTVB8QyBjYYgaTzxOBfZROGOZ1vbsJfUqqnG2eva
 cCODw+RgzCoyFPsYL7SjofaK0H9CPi3xAR3YHOsFwyv53+mkYU/L9W1Y1LYLVG74AlzeVCinM
 GEDEhPdsdrY4AGgGOQiTzoCuGHFdMdc4UQlI8kguLwLOiSxrubY+Q5VboK8/LJ0GxGF9++q31
 n2FBcT3w4jgeOPpGVVaaDylH4uiv92fg8exRtq1ZcuZTJJKhy0gipc3GhgECauvMri1SgYClg
 8pIoTfhPWiCEsSuzbICKI9F/P5TUZgELb0ul4vcyGtkp2l+o8Wf+OngI1PRQyPXvV0IZGAURe
 AShmR+5hr2zfWIbpESZjGMvbdh5e1tH6PIsWs7Lf5OV0C5SFoBwyBqT+Y9O0gbWQTNgA1ZgEo
 8O/P1kpsRbXC9IPXZQpNrzf9NrHgmF6FWbcC5l9fl4JIIfeyxyqB4pVQt1lyokK/Gk6MngVND
 lOkESWV/9nQE/Xqg
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

Am 18.04.22 um 13:05 schrieb Ivan T. Ivanov:
> Hi Stefan,
>
> On 04-15 10:52, Stefan Wahren wrote:
>> Hi Ivan,
>>
>> Am 14.04.22 um 12:56 schrieb Ivan T. Ivanov:
>>> Hi Stefan,
>>>
>>> Please, could you take a look into following patch?
>> yes, but i cannot give a technical review. But from my gut feeling this
>> doesn't look really elegant to me.
>>> Thanks!
>>> Ivan
>>>
>>> On 04-04 15:51, Ivan T. Ivanov wrote:
>>>> Subject: [PATCH v2] clk: bcm2835: Round UART input clock up
>>>> Message-Id: <20220404125113.80239-1-iivanov@suse.de>
>>>>
>>>> The UART clock is initialised to be as close to the requested
>>>> frequency as possible without exceeding it. Now that there is a
>>>> clock manager that returns the actual frequencies, an expected
>>>> 48MHz clock is reported as 47999625. If the requested baudrate
>>>> == requested clock/16, there is no headroom and the slight
>>>> reduction in actual clock rate results in failure.
>>>>
>>>> If increasing a clock by less than 0.1% changes it from ..999..
>>>> to ..000.., round it up.
>> Based on this commit message this looks like a fix / workaround for an
>> issue. It would be very helpful to know:
>>
>> What issue should be fixed?
>>
>> Why is it fixed here and not in the UART driver for instance?
> The UART driver is amba-pl011. Original fix, see below Github link,
> was inside pl011 module, but somehow it didn't look as the right
> place either. Beside that this rounding function is not exactly
> perfect for all possible clock values. So I deiced to move the hack
> to the platform which actually need it.
thanks for your explanation. These are import information which belongs 
in the commit log, because the motivation and the affected UART is very 
important.
>
>> In case it fixes a regression, a Fixes tag should be necessary.
> I found the issue because it was reported that RPi3[1] and RPi Zero 2W
> boards have issues with the Bluetooth. So it turns out that when
> switching from initial to operation speed host and device no longer
> can talk each other because host uses incorrect baud rate.

Now i remember this issue, for the mainline kernel we decide to 
workaround the issue by lowering the BT baudrate to 2000000 baud. I 
didn't investigate the issue further, but your approach is a better 
solution.

Do you use the mainline DTS or the vendor DTS to see this issue?

Best regards

> I open to better solution of the issue.
>
> Thanks,
> Ivan
>
>> In best case this is explained in the commit message.
>>
>> Best regards
>>
>>>> This is reworked version of a downstream fix:
>>>> https://github.com/raspberrypi/linux/commit/ab3f1b39537f6d3825b8873006fbe2fc5ff057b7
>>>>
> [1] https://bugzilla.suse.com/show_bug.cgi?id=1188238
>

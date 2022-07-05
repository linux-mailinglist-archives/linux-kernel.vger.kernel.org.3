Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1FB567173
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiGEOrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGEOrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:47:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4B24E02B;
        Tue,  5 Jul 2022 07:47:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60604D6E;
        Tue,  5 Jul 2022 07:47:32 -0700 (PDT)
Received: from [10.57.8.239] (unknown [10.57.8.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D9943F66F;
        Tue,  5 Jul 2022 07:47:30 -0700 (PDT)
Message-ID: <75eb1aff-6aa9-b393-efe4-c8559d5a2701@arm.com>
Date:   Tue, 5 Jul 2022 15:47:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 05/12] thermal/core: Remove unneeded EXPORT_SYMBOLS
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Todd Kjos <tkjos@google.com>,
        Wei Wang <wvw@google.com>,
        Daniel Lezcano <daniel.lezcano@linexp.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-6-daniel.lezcano@linexp.org>
 <ad8dd950-9260-16b3-2134-72984e2ba261@arm.com>
 <e2d81210-a969-fe9d-a4fb-1826c991fbce@linexp.org>
 <f1cd08de-e8cb-18c2-9f92-01436810bc20@arm.com>
 <CAJZ5v0iKcLM--L4ecoPDWpQ=8zgfeMxCku4zJt7hzVxSszgSNQ@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0iKcLM--L4ecoPDWpQ=8zgfeMxCku4zJt7hzVxSszgSNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/22 15:20, Rafael J. Wysocki wrote:
> On Tue, Jul 5, 2022 at 9:30 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 7/4/22 22:14, Daniel Lezcano wrote:
>>> On 04/07/2022 09:35, Lukasz Luba wrote:
>>>> Hi Daniel,
>>>>
>>>> (+Todd and Wei on CC)
>>>>
>>>>
>>>> On 7/3/22 19:30, Daniel Lezcano wrote:
>>>
>>> [ ... ]
>>>
>>>>>    }
>>>>> -EXPORT_SYMBOL(get_tz_trend);
>>>
>>> [ ... ]
>>>
>>>>>    }
>>>>> -EXPORT_SYMBOL(thermal_cdev_update);
>>>>
>>>> I wouldn't remove that export. I can see in my Pixel6 modules dir, that
>>>> it's called in 7 places.
>>>>
>>>> I assume that in Android world this is common use.
>>>
>>> It is not possible to do changes taking into consideration out of tree
>>> code. Moreover there is logically no good reason to use the
>>> thermal_cdev_update() function from outside of the thermal core code.
>>>
>>
>> I see your point which is 'upstream'. On the other hand the mostly
>> deployed kernel is in Android devices and that brings a lot to the
>> community.
>>
>> This symbol might also be used by other distros which might have
>> modules for some accelerators, which also support tricky cooling.
>>
>> I would keep it as is...
> 
> I think that the long-term goal is to reduce differences between the
> mainline kernel and Android.  From this angle, it would be good if
> Android was aware that the mainline did stuff especially for them and
> making them carry an extra patch would go a long way towards that
> purpose.

It's hard to judge sometimes especially on those small bits.
I've just pointed out and shared the info that this symbol is used.
What you will do with this it's up to you. You and Daniel are the
maintainers of this subsystems and have long-term plans for it.
Todd and Wei are on CC, so they will know about this change.
My job finishes here.

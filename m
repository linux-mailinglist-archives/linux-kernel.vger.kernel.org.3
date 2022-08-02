Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8BE587D16
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbiHBN2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiHBN2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:28:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A71165A7
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 06:28:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j7so17898656wrh.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 06:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=zhQV6KklANoXAExR2SdxpOLIazXCUZND/JNIe+QuHXc=;
        b=Ain8zt4q7eV7NL2VgVzu8tHPSmzLHBe2hlUNvqd30pvxjhbHbgdoyTEdzqnfozWlv1
         8WK3K+/5FS9QkKqUBTR2sjb8MogLMszoK2fpRlRNv78dQ6o9rBDJwdOWwnMBpkKyasg1
         8uGkcJvylDuzhbyBuCDbMdjtnqQVtvKWzGz88Ww1DdQjG7bN3HM9Vy6q1/5NmMMnZ23L
         MQ3fxTgAE2hkUP9fduJHzfRhkUUe/OEQBUVkBjhPWe1dyMWzxgAxWlB/+IZ7lTVW1Q1H
         5TAECFYVlHQC0liH1ZwhF+9qMfQz8nZ1XuIwhjoj5NXbGC1M0Sj/hRZp393I4IiVz2bU
         x6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=zhQV6KklANoXAExR2SdxpOLIazXCUZND/JNIe+QuHXc=;
        b=Pf3PAh3huBA/bJTxnA/xfvnWFWfejkBa1pgmZT9fZxmpMQlSRBJZWsTQe2nYzW6mB5
         c/jJJpeCzudhZtTDrkPCgBpf2wyRmAySHjl77bOi9wEHnScktEF13AckuHeZIBFh+VEA
         +QWL6M5a7HtgL1alCCo+kIsooAkY2SmEB09qjrkzeazuezzMoM4Zilo0g628rOzqgx6q
         hbKnh4C7lOAip6lXWrubMuoMgIYcPMctal4Z145rlt9t0AkF4IYxuv1xInOTv45XGuLc
         /6xRQ4rThsb+khxCPvK/V3xQ6UGbeW3g35L8kYf7Zx6T8+l39LV8PqObCgcwTcPRf8qA
         VIxA==
X-Gm-Message-State: ACgBeo0enYEMqMcNjra+MiimiwsBhiBGrmRs4yWqvwKXNwowGCHrjcWD
        PI05e8lAI7nRER77nnb47/vhxg==
X-Google-Smtp-Source: AA6agR4cSFplWRmJFt46bFuJLRjHgyuj120RsB6jAgbcAkjmDxvGeNISURre7kRy/h6qlASE0FOvUg==
X-Received: by 2002:adf:d1ea:0:b0:220:6334:25e with SMTP id g10-20020adfd1ea000000b002206334025emr6527722wrd.32.1659446891922;
        Tue, 02 Aug 2022 06:28:11 -0700 (PDT)
Received: from [192.168.1.69] (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id i16-20020a05600c401000b003a305c0ab06sm22618640wmm.31.2022.08.02.06.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 06:28:11 -0700 (PDT)
Message-ID: <98d17617-72b5-6330-d4f5-1bece928ceab@baylibre.com>
Date:   Tue, 2 Aug 2022 15:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v3 2/2] iio: time: capture-tiecap: capture driver support
 for ECAP
Content-Language: en-US
From:   Julien Panis <jpanis@baylibre.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com
References: <20220728175124.468461-1-jpanis@baylibre.com>
 <20220728175124.468461-3-jpanis@baylibre.com>
 <20220731164116.30e91f34@jic23-huawei>
 <11b7436b-5c31-671e-ba77-435fe8e3b767@baylibre.com>
In-Reply-To: <11b7436b-5c31-671e-ba77-435fe8e3b767@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/08/2022 16:08, Julien Panis wrote:
>
>
> On 31/07/2022 17:41, Jonathan Cameron wrote:
>> On Thu, 28 Jul 2022 19:51:24 +0200
>> Julien Panis <jpanis@baylibre.com> wrote:
>>
>>> ECAP hardware on AM62x SoC supports capture feature. It can be used
>>> to timestamp events (falling/rising edges) detected on signal input 
>>> pin.
>>>
>>> This commit adds capture driver support for ECAP hardware on AM62x SoC.
>>>
>>> In the ECAP hardware, capture pin can also be configured to be in
>>> PWM mode. Current implementation only supports capture operating mode.
>>> Hardware also supports timebase sync between multiple instances, but
>>> this driver supports simple independent capture functionality.
>>>
>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>> Hi Julien,
>>
>> So this isn't the first ecap driver we've had proposed, but the previous
>> one was a few years ago and never reached v2.
>> https://lore.kernel.org/all/20200818153614.6438-1-dts86@cornell.edu/
>>
>> Honestly I can't remember much about it, but maybe the discussion around
>> that will be worth a reread.
>
> Hi Jonathan, thank you for your review.
>
> I read the discussion about previous attempt, before submitting this 
> patch. There were
> interesting comments indeed.
>
> But in this previous attempt, only one-shot pulses were handled 
> (moreover, global IRQ flag
> was not cleared, so I'm not sure that IRQ could be raised more than 
> once).
>
> However, ECAP can be used to make time measurements for any type of 
> "square waveform".
> That's why I tried to make this event mode configurable. Besides, 
> using a continuous mode allows
> handling much more signal types (not only single pulses).
>
>>
>> The use of ABI here is unusual. So I'd definitely like to see some 
>> documentation
>> probably as a file in the main kernel documentation to explain what 
>> the interface
>> is an how that relates to what is being captured.
>
> OK, I will add some userspace documentation.
>
>>
>> First thing to note here is the channel type of IIO_INDEX is now not 
>> actually
>> used any more because we moved all the relevant drivers over to the 
>> counter
>> subsystem (and we failed to mark it deprecated).
>
> I evaluated this counter subsystem before starting development. 
> Counting events is not "a priori"
> the goal when using ECAP.
>
> Nevertheless, maybe "counter_push_event" function could do the job. If 
> I use counter API :
> # Option 1 : CAP1/2/3/4 registers could be seen as 4 channels of the 
> same counter...
> but there are not channels, there are just sequential timestamps 
> actually. So I'm afraid this leads
> to misunderstanding for the user.
> Moreover, the user will have to read several entries (counts 1/2/3/4) 
> to gather timestamps from
> the same input signal, which is not very convenient.
> # Option 2 : Either CAP 1/2/3/4 events could be gathered in a single 
> channel...but then it will not
> be possible to configure their polarity (rising/falling edge) 
> individually (unless I did
> not understand well counter framework documentation).
>
> So, even with counter framework, it will lead to some diverted use of 
> the framwork, since ECAP
> is a very specific hardware that do not fit 100% counter philosophy.
>
> I admit that ECAP do not fit 100% IIO philosophy either.
>
> Maybe misc API would be more relevant actually. Any opinion about it 
> will be welcome. :-)

[Answering my own mail]

I got a closer look at counter framework. It is not suitable at all for 
ECAP. Initially, I thought that
"counter_push_event" function could be used, but the only timestamp 
handled by this function
is a software timestamp. I strongly doubt that counter framework 
maintainer would accept
some modification here to support hardware timestamp : a patch rejection 
would be
legitimate, since a counter is dedicated to "event counting". Whereas 
ECAP is dedicated to
"event timestamping".

Beside, ECAP has 4 timestamp registers but they are used to capture 
timestamps for a
single input pin (only 1 channel). In ECAP context, 'index X" is used to 
identify CAP X
(used to capture event X detected on a single pin, with X = 0/1/2/3/0...).
In counter framework, "index X" is used to identify channel X (among 
several pins).
So, the word "index" has not the same meaning in counter framework than 
in ECAP device.
Somehow, this ECAP index (0/1/2/3 for CAP1/2/3/4 registers) must be 
logged with timestamp
because it is an important part of signal info for the user (raw 
consecutive timestamps
are not enough).

So, here is my proposal for my next version :
(1) Replace IIO_INDEX by IIO_COUNT channel (already used in 
"stm32-timer-trigger.c" driver)
# In ECAP documentation, the word "index" is not used. The word used to 
speak about this
0->1->2->3->0 sequenced counter is "Mod4 counter".
(2) Configure event mode with 4 sysfs entries (to remove the mix of 
buffers and events interfaces)
# User will see 4 files (1 file for each CAP timestamp) named 
"falling_edge_active_0/1/2/3".
Writing 1 will select falling edge/ Writing 0 will select rising edge.

Would it be an acceptable alternative for you, Jonathan ? Would either 
(1) and/or (2) be a "no-go" ?

>
>>
>> Anyhow, I've reviewed below, but need docs to discuss this in depth.  
>> In particular
>> the mix of buffers and events interfaces is unlikely to be an 
>> acceptable path
>> forwards.
>
> OK, I will consider alternatives.
>
>>
>> Jonathan


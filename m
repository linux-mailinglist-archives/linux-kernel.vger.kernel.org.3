Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D312E583ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbiG1Ixo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbiG1Ixj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:53:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF3C655AD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:53:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k11so1309413wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DKQ0uiAhHEj5rPSCLVtiu1ddFQFOymPB/HshHkjwW4o=;
        b=lmyJRyRdOIzd6r7FfTVyoxA4BbcI8gkgFLb6R2RQR6AfxKyjl6CZu8IVdu5GJL5R8c
         mZWZ21mBEfLw/QazpTZ7gwBintF6/WwFgrNPD8ouh+Bjeu3ft08/VEUZSGLp9WkpsoPq
         RlYuSo5LIR+IRaA6Om9ANfgxt/BZqIt8DuT8xuBOQCRpi5NqwBg0HLA91IuVK6fXYDaS
         0xi7elTMf+mthzw24dntaDbvQcoVyBVCb1vKjl/xCMcNtHcnZZntijEh1XwnUjTIJJOS
         Piz4snRmn1UD7dAm2+CkCYPgVEDqKnbroAh/IAFt2PLm5ie56M0g4fNC+Shd2hPADHVs
         Bumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DKQ0uiAhHEj5rPSCLVtiu1ddFQFOymPB/HshHkjwW4o=;
        b=cKdfoFSNglsUTQNtkcki4eRQckzG8YOb5ZYV87ZOXNGL45kQgceLUJ3eutNduofCAn
         8VFKiugmL5DSQ07y+/Sh920gYJpqzMz/h3qnil27l2GoUJTzczl/M1baGdcmV68Gjxih
         O4YjMVs+spGwqsuqEb3ZysWIPdiaf4j7zGdAh362sZRfLFjFHukadGn/ZNk96HScMM3i
         tHiSTyin0GRwnFy+1wunLlI8UnY/27hEM69TDeoJJbFApBM9luHweHwlKFj9rqktoDT6
         iMxPbgjddCWSKBTfFRdsCYftYc0S0sbSB6y6X3bOnEHQZ0K8t0Wd96BZ2fplzkXxemlA
         C/Og==
X-Gm-Message-State: AJIora8LNCYVcW0xEwTK/uElclhDiC+Sm4VXEUmRheb1ziO7jy2AMdw5
        VysirVDZeWAFn8KbW4S8liLXJA==
X-Google-Smtp-Source: AGRyM1uY6i0/z9UNt4vPhLZFwJ2v7vJdjW5cSaAWVSrELo2mA/ch292sjdVdA9ywEp/ICseO/6wqew==
X-Received: by 2002:a05:6000:1241:b0:21e:f1e1:2ca2 with SMTP id j1-20020a056000124100b0021ef1e12ca2mr1761007wrx.122.1658998414507;
        Thu, 28 Jul 2022 01:53:34 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id s16-20020a5d4250000000b0021edf1c18b5sm310457wrr.93.2022.07.28.01.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 01:53:34 -0700 (PDT)
Message-ID: <4d010f40-6c4c-32c7-2772-1bbfa02c03b7@linaro.org>
Date:   Thu, 28 Jul 2022 09:53:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] arm64 defconfig: Get faddr2line working
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, John Garry <john.garry@huawei.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>
References: <1658681004-132191-1-git-send-email-john.garry@huawei.com>
 <CAK8P3a0umWWic6LAzxXJ7BACYVE--m-wbynh7Z8F+pGoUBxGTA@mail.gmail.com>
 <25237c44-ebc4-fc9a-7c6f-3e990f968038@huawei.com>
 <CAK8P3a2+0EwSJ=fRBL2JCGypJRL-qE4rEiXYnJbqhZ=weethdQ@mail.gmail.com>
 <b39bf8c4-c702-8f49-12aa-d3ac05889b80@huawei.com>
 <CAK8P3a0w+_MLOjJAKMENe6MYvBcXWXSir47Hz34WbtdEeAmaBw@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <CAK8P3a0w+_MLOjJAKMENe6MYvBcXWXSir47Hz34WbtdEeAmaBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/07/2022 09:23, Arnd Bergmann wrote:
> On Thu, Jul 28, 2022 at 10:06 AM John Garry <john.garry@huawei.com> wrote:
>>
>> trim list
> 
> Adding a few other people for slimbus.
> 
>> On 25/07/2022 13:51, Arnd Bergmann wrote:
>>>>> CONFIG_SLIMBUS=m
>>>> Config 5bd773242f75 added a kconfig "imply" on config SLIMBUS from
>>>> config SOUNDWIRE_QCOM, and this happens to mean that we don't explicitly
>>>> require config SLIMBUS enabled in the defconfig.
>>> That 'imply' looks like it was added to solve a problem using the old 'imply'
>>> semantics that are not what this keyword does today. I suspect it's still
>>> broken when CONFIG=SOUNDWIRE_QCOM=y and CONFIG_SLIBMUS=m,
>>> and the correct fix is to use a dependency like
>>>
>>>         depends on SLIMBUS || !SLIMBUS
>>>
>>> so the defconfig symbol should stay.
>>>
>>
>> JFYI, building for CONFIG_SOUNDWIRE_QCOM=y and CONFIG_SLIBMUS=m is ok.
>> The driver has a runtime check for CONFIG_SLIMBUS in qcom_swrm_probe().
>>
>> That implementation seems consistent with guidance in
>> kconfig-language.rst - so do you think that there is still a problem?
> 
> I see Vinod added the IS_REACHABLE() check, which makes it build, but
> I think both the 'imply' and the IS_REACHABLE() are mistakes here, as they
> are almost everywhere else.
> 
>  From what I understand, the driver can actually use two different
> back-ends, with slimbus being one of them. In the configuration
> with CONFIG_SOUNDWIRE_QCOM=y and CONFIG_SLIBMUS=m,

w.r.t Qualcomm SoundWire Controller.

There are two types of integrations at IP level.
1> SoundWire Controller is part of Codec which is connected over 
SlimBus. ex: SoCs SDM845 and older ones
	All the read writes have to go via SlimBus physical layer.

2> SoundWire Controller is part of Codec which is MMIO,ex: SM8250 and 
newer SoCs. No SlimBus dependency.

As we are using a common driver for this, we wanted to check if the 
parent was a slimbus or not, to be able to select correct read/write 
interfaces.

rethinking about this approach, It should be doable to also derive this 
information from compatible strings, Soundwire controller versions 1.3.0 
and below are always of type 1 and the newer ones are type 2.

So this could get rid of IS_REACHABLE check along with references to 
slimbus_bus from driver.

expressing the SlimBus dependency for type 1 should be either captured 
using imply SLIMBUS or depends in Kconfig.


> I think you can end up with a slimbus device being detected at
> runtime, which gets passed to the built-in qcom driver, but that driver
> then misdetects the bus because it is not linked against the
> slimbus module. It then uses the incorrect code path, causing
> unintended behavior.
> 
> The 'depends on SLIMBUS || !SLIMBUS' dependency would completely
> avoid this issue and make the driver work correctly in each configuration.
> 
>          Arnd


Thanks,
Srini


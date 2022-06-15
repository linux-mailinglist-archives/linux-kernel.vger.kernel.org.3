Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E025C54CF96
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349538AbiFORT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiFORT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:19:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB7B1C92D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:19:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso2760200pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=N8MeUCxkN/driIBOzauf+scZ7RKLz2Mt8aZBA30VF2A=;
        b=fm/Qpz4nICRi8zlUx7DOcrSsaAoGrD2oOQNn+SRQmpZ8qB2dusHM0blFir8HqLlbIE
         Av1XiLVLmVXB0ObDMddprXovZiJUVrxiyUPlpJ0ZhcqWhX6YgTdj0x7x6LzMMs7qC7t+
         nVsedfeI4PBqrRxPfYS9smLHv3yZwK3zTt3oIJBNkqPDvKYUomnWkjmxyziscQSn6oiN
         ir1dk7fyGifjnn0QLU/GTmXPvYPS30h54S4wvZUPjHS1JSIkgxXVpAIJHhuhTHT3G+6F
         4ziU5b6ZbCEEJb6uvY5dpRfuhNaFN6Zz2naVCcVYQ0rtFSsAAcsvJ+Ja9D+F6fvHP5A5
         MYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N8MeUCxkN/driIBOzauf+scZ7RKLz2Mt8aZBA30VF2A=;
        b=lB/6J7c5ezPjkZsNJejDczsbx/kWV9V6FlMz4pN6pxUuRo67etAVmu9um5W8UewZCg
         Z6x3ZLfip1so2L9AOdMiirKT/DV2JJbs55xym4CDWK65TvM988He7uwS5eHME8eO7ZHV
         dedJ6U08kkKQUdD++ABDLu7GaFjkPDc/74+UoVXEEUZmDiQMlgLPBgse1Zto6Khy7qnm
         TZC1AnmrcVi6ih73f4y48RhkSh8wDcUBdzknko6a+n6zzYeScwxfjKP6+S6Sgf+VihsT
         WZPQOKzBV2VfoauFv6YYSuvKujgK3jWmYFeXsuREgCCNqGQUNZoj2gIhAz8QwnNzTHmj
         mraQ==
X-Gm-Message-State: AJIora/MD6jD47u6iphjAYodvDdS30w7iV1tz+v62TH68l9IMaa98Zgx
        EGI460M+nLhT1Ly3LKPDv/A=
X-Google-Smtp-Source: AGRyM1ub4ixb7O9aDNAn3sy9QV4CJSnU4oyYwtR7YjA//FmlRZx787o86B/f+nltQaF8t4al3O0Pbg==
X-Received: by 2002:a17:90b:3142:b0:1e3:1253:be27 with SMTP id ip2-20020a17090b314200b001e31253be27mr526127pjb.44.1655313596001;
        Wed, 15 Jun 2022 10:19:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id cf6-20020a17090aebc600b001e2da6766ecsm2073106pjb.31.2022.06.15.10.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 10:19:55 -0700 (PDT)
Message-ID: <f194f9b6-578d-ae08-16c3-6d464da10452@gmail.com>
Date:   Wed, 15 Jun 2022 10:19:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 11/22] firmware: arm_scmi: Add SCMIv3.1 extended names
 protocols support
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
 <20220330150551.2573938-12-cristian.marussi@arm.com>
 <6f865d7f-fde8-d923-3c7e-d12bfbc370a6@gmail.com>
 <YqmVsMGgxKuIT5rx@e120937-lin> <Yqmo/BiIR4gku0Y+@e120937-lin>
 <c787dfe6-9639-8797-d07a-048c5ec69ddf@gmail.com>
 <YqoI5hYa97nZwUjl@e120937-lin>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <YqoI5hYa97nZwUjl@e120937-lin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 09:29, Cristian Marussi wrote:
> On Wed, Jun 15, 2022 at 09:10:03AM -0700, Florian Fainelli wrote:
>> On 6/15/22 02:40, Cristian Marussi wrote:
>>> On Wed, Jun 15, 2022 at 09:18:03AM +0100, Cristian Marussi wrote:
>>>> On Wed, Jun 15, 2022 at 05:45:11AM +0200, Florian Fainelli wrote:
>>>>>
>>>>>
>>>>> On 3/30/2022 5:05 PM, Cristian Marussi wrote:
>>>>>> Using the common protocol helper implementation add support for all new
>>>>>> SCMIv3.1 extended names commands related to all protocols with the
>>>>>> exception of SENSOR_AXIS_GET_NAME.
>>>>>>
>>>>>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>>>>>
>>>>> This causes the following splat on a platform where regulators fail to
>>>>> initialize:
>>>>>
>>>>
>>>> Hi Florian,
>>>>
>>>> thanks for the report.
>>>>
>>>> It seems a memory error while allocating so it was not meant to be
>>>> solved by the fixes, anyway, I've never seen this splat in my testing
>>>> and at first sight I cannot see anything wrong in the devm_k* calls
>>>> inside scmi_voltage_protocol_init...is there any particular config in
>>>> your setup ?
>>>>
>>>> Moreover, the WARNING line 5402 seems to match v5.19-rc1 and it has
>>>> slightly changed with -rc-1, so I'll try rebasing on that at first and
>>>> see if I can reproduce the issue locally.
>>>>
>>>
>>> I just re-tested the series rebased on v519-rc1 plus fixes and I cannot
>>> reproduce in my setup with a few (~9) good and bad voltage domains.
>>>
>>> How many voltage domains are advertised by the platform in your setup ?
>>
>> There are 11 voltage regulators on this platform, and of course, now that I
>> am trying to reproduce the splat I reported I just cannot anymore... I will
>> let you know if there is anything that needs to be done. Thanks for being
>> responsive as usual!
> 
> ... you're welcome...
> 
> I'm trying to figure out where an abnormal mem request could happen...

I think the problem is/was with the number of voltage domains being 
reported which was way too big and passed directly, without any clamping 
to devm_kcalloc() resulting the splat indicating that the allocation was 
beyond the MAX_ORDER. The specification allows for up to 2^16 domains 
which would still be way too much to allocate using kmalloc() so we 
could/should consider vmalloc() here eventually?

In all likelihood though we probably won't find a system with 65k 
voltage domains.

> 
> can you try adding this (for brutal debugging) when you try ?
> (...just to rule out funny fw replies.... :D)

Sure, nothing weird coming out and it succeeded in enumerating all of 
the regulators, I smell a transient issue with our firmware 
implementation, maybe...

[    0.560544] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
[    0.560617] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
[    0.560673] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
[    0.560730] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
[    0.560881] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
[    0.560940] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
[    0.560996] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
[    0.561054] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
[    0.561110] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
[    0.561168] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
[    0.561225] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
[    0.561652] scmi-regulator scmi_dev.2: Regulator stb_vreg_2 
registered for domain [2]
[    0.561858] scmi-regulator scmi_dev.2: Regulator stb_vreg_3 
registered for domain [3]
[    0.562030] scmi-regulator scmi_dev.2: Regulator stb_vreg_4 
registered for domain [4]
[    0.562190] scmi-regulator scmi_dev.2: Regulator stb_vreg_5 
registered for domain [5]
[    0.564427] scmi-regulator scmi_dev.2: Regulator stb_vreg_6 
registered for domain [6]
[    0.564638] scmi-regulator scmi_dev.2: Regulator stb_vreg_7 
registered for domain [7]
[    0.564817] scmi-regulator scmi_dev.2: Regulator stb_vreg_8 
registered for domain [8]
[    0.565030] scmi-regulator scmi_dev.2: Regulator stb_vreg_9 
registered for domain [9]
[    0.565191] scmi-regulator scmi_dev.2: Regulator stb_vreg_10 
registered for domain [10]

-- 
Florian
